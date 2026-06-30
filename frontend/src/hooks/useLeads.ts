import { useCallback, useEffect, useState } from 'react'
import { fetchLeads } from '@/api/leads'
import { getApiErrorMessage } from '@/lib/api-error'
import type { Lead } from '@/types/lead'
import type { PaginationMeta } from '@/types/pagination'

interface UseLeadsResult {
  leads: Lead[]
  meta: PaginationMeta | null
  isLoading: boolean
  error: string | null
  refetch: () => void
}

export function useLeads(search: string, status: string, page: number): UseLeadsResult {
  const [leads, setLeads] = useState<Lead[]>([])
  const [meta, setMeta] = useState<PaginationMeta | null>(null)
  const [isLoading, setIsLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)
  const [reloadToken, setReloadToken] = useState(0)

  useEffect(() => {
    let active = true
    setIsLoading(true)
    setError(null)

    fetchLeads({ search: search || undefined, status: status || undefined, page })
      .then(({ data }) => {
        if (!active) return
        setLeads(data.data)
        setMeta(data.meta)
      })
      .catch((err: unknown) => {
        if (active) setError(getApiErrorMessage(err, 'Unable to load leads.'))
      })
      .finally(() => {
        if (active) setIsLoading(false)
      })

    return () => {
      active = false
    }
  }, [search, status, page, reloadToken])

  const refetch = useCallback(() => setReloadToken((token) => token + 1), [])

  return { leads, meta, isLoading, error, refetch }
}
