import { useCallback, useEffect, useState } from 'react'
import { fetchLead } from '@/api/leads'
import { getApiErrorMessage } from '@/lib/api-error'
import type { Lead } from '@/types/lead'

interface UseLeadResult {
  lead: Lead | null
  isLoading: boolean
  error: string | null
  refetch: () => void
}

export function useLead(id: number): UseLeadResult {
  const [lead, setLead] = useState<Lead | null>(null)
  const [isLoading, setIsLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)
  const [reloadToken, setReloadToken] = useState(0)

  useEffect(() => {
    let active = true
    setIsLoading(true)
    setError(null)

    fetchLead(id)
      .then(({ data }) => {
        if (active) setLead(data.data)
      })
      .catch((err: unknown) => {
        if (active) setError(getApiErrorMessage(err, 'Unable to load lead.'))
      })
      .finally(() => {
        if (active) setIsLoading(false)
      })

    return () => {
      active = false
    }
  }, [id, reloadToken])

  const refetch = useCallback(() => setReloadToken((token) => token + 1), [])

  return { lead, isLoading, error, refetch }
}
