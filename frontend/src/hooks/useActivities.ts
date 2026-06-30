import { useCallback, useEffect, useState } from 'react'
import { isAxiosError } from 'axios'
import { fetchActivities } from '@/api/activities'
import { getApiErrorMessage } from '@/lib/api-error'
import type { Activity } from '@/types/activity'
import type { PaginationMeta } from '@/types/pagination'

interface UseActivitiesResult {
  activities: Activity[]
  meta: PaginationMeta | null
  isLoading: boolean
  error: string | null
  isForbidden: boolean
  refetch: () => void
}

export function useActivities(page: number): UseActivitiesResult {
  const [activities, setActivities] = useState<Activity[]>([])
  const [meta, setMeta] = useState<PaginationMeta | null>(null)
  const [isLoading, setIsLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)
  const [isForbidden, setIsForbidden] = useState(false)
  const [reloadToken, setReloadToken] = useState(0)

  useEffect(() => {
    let active = true
    setIsLoading(true)
    setError(null)
    setIsForbidden(false)

    fetchActivities({ page })
      .then(({ data }) => {
        if (!active) return
        setActivities(data.data)
        setMeta(data.meta)
      })
      .catch((err: unknown) => {
        if (!active) return
        if (isAxiosError(err) && err.response?.status === 403) {
          setIsForbidden(true)
          return
        }
        setError(getApiErrorMessage(err, 'Unable to load activities.'))
      })
      .finally(() => {
        if (active) setIsLoading(false)
      })

    return () => {
      active = false
    }
  }, [page, reloadToken])

  const refetch = useCallback(() => setReloadToken((token) => token + 1), [])

  return { activities, meta, isLoading, error, isForbidden, refetch }
}
