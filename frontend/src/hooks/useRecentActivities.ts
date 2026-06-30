import { useEffect, useState } from 'react'
import { apiClient } from '@/api/client'
import { getApiErrorMessage } from '@/lib/api-error'
import type { Activity } from '@/types/activity'
import type { PaginatedResponse } from '@/types/pagination'

interface UseRecentActivitiesResult {
  activities: Activity[]
  isLoading: boolean
  error: string | null
}

export function useRecentActivities(limit: number): UseRecentActivitiesResult {
  const [activities, setActivities] = useState<Activity[]>([])
  const [isLoading, setIsLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)

  useEffect(() => {
    let active = true

    apiClient
      .get<PaginatedResponse<Activity>>('/api/activities', { params: { per_page: limit } })
      .then(({ data }) => {
        if (active) setActivities(data.data)
      })
      .catch((err: unknown) => {
        if (active) setError(getApiErrorMessage(err, 'Unable to load recent activity.'))
      })
      .finally(() => {
        if (active) setIsLoading(false)
      })

    return () => {
      active = false
    }
  }, [limit])

  return { activities, isLoading, error }
}
