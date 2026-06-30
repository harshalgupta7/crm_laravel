import { useCallback, useEffect, useState } from 'react'
import { fetchCustomers } from '@/api/customers'
import { getApiErrorMessage } from '@/lib/api-error'
import type { Customer } from '@/types/customer'
import type { PaginationMeta } from '@/types/pagination'

interface UseCustomersResult {
  customers: Customer[]
  meta: PaginationMeta | null
  isLoading: boolean
  error: string | null
  refetch: () => void
}

export function useCustomers(page: number): UseCustomersResult {
  const [customers, setCustomers] = useState<Customer[]>([])
  const [meta, setMeta] = useState<PaginationMeta | null>(null)
  const [isLoading, setIsLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)
  const [reloadToken, setReloadToken] = useState(0)

  useEffect(() => {
    let active = true
    setIsLoading(true)
    setError(null)

    fetchCustomers({ page })
      .then(({ data }) => {
        if (!active) return
        setCustomers(data.data)
        setMeta(data.meta)
      })
      .catch((err: unknown) => {
        if (active) setError(getApiErrorMessage(err, 'Unable to load customers.'))
      })
      .finally(() => {
        if (active) setIsLoading(false)
      })

    return () => {
      active = false
    }
  }, [page, reloadToken])

  const refetch = useCallback(() => setReloadToken((token) => token + 1), [])

  return { customers, meta, isLoading, error, refetch }
}
