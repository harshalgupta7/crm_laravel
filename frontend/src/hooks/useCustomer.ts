import { useCallback, useEffect, useState } from 'react'
import { fetchCustomer } from '@/api/customers'
import { getApiErrorMessage } from '@/lib/api-error'
import type { Customer } from '@/types/customer'

interface UseCustomerResult {
  customer: Customer | null
  isLoading: boolean
  error: string | null
  refetch: () => void
}

export function useCustomer(id: number): UseCustomerResult {
  const [customer, setCustomer] = useState<Customer | null>(null)
  const [isLoading, setIsLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)
  const [reloadToken, setReloadToken] = useState(0)

  useEffect(() => {
    let active = true
    setIsLoading(true)
    setError(null)

    fetchCustomer(id)
      .then(({ data }) => {
        if (active) setCustomer(data.data)
      })
      .catch((err: unknown) => {
        if (active) setError(getApiErrorMessage(err, 'Unable to load customer.'))
      })
      .finally(() => {
        if (active) setIsLoading(false)
      })

    return () => {
      active = false
    }
  }, [id, reloadToken])

  const refetch = useCallback(() => setReloadToken((token) => token + 1), [])

  return { customer, isLoading, error, refetch }
}
