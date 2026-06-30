import axios from 'axios'

export const apiClient = axios.create({
  baseURL: import.meta.env.VITE_API_URL,
  withCredentials: true,
})

// Registered by AuthContext so the interceptor can force logout without
// needing access to React state directly.
let onAuthFailure: (() => void) | null = null

export function setAuthFailureCallback(cb: () => void) {
  onAuthFailure = cb
}

let isRefreshing = false
let refreshQueue: Array<(error: unknown) => void> = []

function processQueue(error: unknown) {
  refreshQueue.forEach((cb) => cb(error))
  refreshQueue = []
}

apiClient.interceptors.response.use(
  (response) => response,
  async (error) => {
    const originalRequest = error.config

    // Skip non-401s, already-retried requests, and the refresh endpoint
    // itself — otherwise a failed refresh would loop forever.
    if (
      error.response?.status !== 401 ||
      originalRequest._retry ||
      originalRequest.url?.includes('/api/auth/refresh')
    ) {
      return Promise.reject(error)
    }

    // A refresh is already in-flight — queue this request until it resolves.
    if (isRefreshing) {
      return new Promise((resolve, reject) => {
        refreshQueue.push((refreshError) => {
          if (refreshError) {
            reject(refreshError)
          } else {
            resolve(apiClient(originalRequest))
          }
        })
      })
    }

    originalRequest._retry = true
    isRefreshing = true

    try {
      // The backend sets a new access-token cookie via Set-Cookie.
      // withCredentials: true ensures it is stored and sent on the retry.
      await apiClient.post('/api/auth/refresh')
      processQueue(null)
      return apiClient(originalRequest)
    } catch (refreshError) {
      processQueue(refreshError)
      onAuthFailure?.()
      return Promise.reject(refreshError)
    } finally {
      isRefreshing = false
    }
  },
)
