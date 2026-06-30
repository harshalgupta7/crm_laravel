import { useCallback, useEffect, useState } from 'react'
import { fetchTasks } from '@/api/tasks'
import { getApiErrorMessage } from '@/lib/api-error'
import type { Task } from '@/types/task'
import type { PaginationMeta } from '@/types/pagination'

interface UseTasksFilters {
  search: string
  status: string
  priority: string
  overdue: boolean
  page: number
}

interface UseTasksResult {
  tasks: Task[]
  meta: PaginationMeta | null
  isLoading: boolean
  error: string | null
  refetch: () => void
}

export function useTasks({ search, status, priority, overdue, page }: UseTasksFilters): UseTasksResult {
  const [tasks, setTasks] = useState<Task[]>([])
  const [meta, setMeta] = useState<PaginationMeta | null>(null)
  const [isLoading, setIsLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)
  const [reloadToken, setReloadToken] = useState(0)

  useEffect(() => {
    let active = true
    setIsLoading(true)
    setError(null)

    fetchTasks({
      search: search || undefined,
      status: status || undefined,
      priority: priority || undefined,
      overdue: overdue || undefined,
      page,
    })
      .then(({ data }) => {
        if (!active) return
        setTasks(data.data)
        setMeta(data.meta)
      })
      .catch((err: unknown) => {
        if (active) setError(getApiErrorMessage(err, 'Unable to load tasks.'))
      })
      .finally(() => {
        if (active) setIsLoading(false)
      })

    return () => {
      active = false
    }
  }, [search, status, priority, overdue, page, reloadToken])

  const refetch = useCallback(() => setReloadToken((token) => token + 1), [])

  return { tasks, meta, isLoading, error, refetch }
}
