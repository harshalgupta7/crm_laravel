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

/**
 * The /api/tasks endpoint does not support a title search filter, so
 * the search term is applied client-side against the current page of results.
 */
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
  }, [status, priority, overdue, page, reloadToken])

  const refetch = useCallback(() => setReloadToken((token) => token + 1), [])

  const normalizedSearch = search.trim().toLowerCase()
  const filteredTasks = normalizedSearch
    ? tasks.filter((task) => task.title.toLowerCase().includes(normalizedSearch))
    : tasks

  return { tasks: filteredTasks, meta, isLoading, error, refetch }
}
