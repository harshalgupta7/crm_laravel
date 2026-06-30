import { createContext, useContext, useEffect, useState, type ReactNode } from 'react'
import { apiClient, setAuthFailureCallback } from '@/api/client'
import type { AuthUser } from '@/types/auth'

interface LoginCredentials {
  email: string
  password: string
}

interface AuthContextValue {
  user: AuthUser | null
  isLoading: boolean
  isAuthenticated: boolean
  login: (credentials: LoginCredentials) => Promise<void>
  logout: () => Promise<void>
  refetch: () => Promise<void>
}

const AuthContext = createContext<AuthContextValue | undefined>(undefined)

export function AuthProvider({ children }: { children: ReactNode }) {
  const [user, setUser] = useState<AuthUser | null>(null)
  const [isLoading, setIsLoading] = useState(true)

  const fetchUser = async () => {
    try {
      const { data } = await apiClient.get<{ user: AuthUser }>('/api/auth/me')
      setUser(data.user)
    } catch {
      setUser(null)
    } finally {
      setIsLoading(false)
    }
  }

  useEffect(() => {
    // When the token refresh fails the interceptor calls this to clear
    // auth state, causing ProtectedRoute to redirect to /login.
    setAuthFailureCallback(() => setUser(null))
    fetchUser()
  }, [])

  const login = async (credentials: LoginCredentials) => {
    const { data } = await apiClient.post<{ user: AuthUser }>('/api/auth/login', credentials)
    setUser(data.user)
  }

  const logout = async () => {
    try {
      await apiClient.post('/api/auth/logout')
    } finally {
      setUser(null)
    }
  }

  return (
    <AuthContext.Provider
      value={{ user, isLoading, isAuthenticated: user !== null, login, logout, refetch: fetchUser }}
    >
      {children}
    </AuthContext.Provider>
  )
}

export function useAuth() {
  const context = useContext(AuthContext)
  if (!context) {
    throw new Error('useAuth must be used within an AuthProvider')
  }
  return context
}
