import { useEffect, useState } from 'react'
import { apiClient } from '@/api/client'
import { getApiErrorMessage } from '@/lib/api-error'
import type { DashboardStats } from '@/types/dashboard'

interface UseDashboardStatsResult {
  stats: DashboardStats | null
  isLoading: boolean
  error: string | null
}

export function useDashboardStats(): UseDashboardStatsResult {
  const [stats, setStats] = useState<DashboardStats | null>(null)
  const [isLoading, setIsLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)

  useEffect(() => {
    let active = true

    apiClient
      .get<DashboardStats>('/api/dashboard')
      .then(({ data }) => {
        if (active) setStats(data)
      })
      .catch((err: unknown) => {
        if (active) setError(getApiErrorMessage(err, 'Unable to load dashboard statistics.'))
      })
      .finally(() => {
        if (active) setIsLoading(false)
      })

    return () => {
      active = false
    }
  }, [])

  return { stats, isLoading, error }
}
