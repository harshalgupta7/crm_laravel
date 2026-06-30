import { useEffect, useState } from 'react'
import { Building2 } from 'lucide-react'
import { CustomersTable } from '@/components/customers/CustomersTable'
import { CustomersToolbar } from '@/components/customers/CustomersToolbar'
import { CustomersPagination } from '@/components/customers/CustomersPagination'
import { useCustomers } from '@/hooks/useCustomers'
import { useDebouncedValue } from '@/hooks/useDebouncedValue'

export function CustomersPage() {
  const [searchInput, setSearchInput] = useState('')
  const debouncedSearch = useDebouncedValue(searchInput, 400)
  const [page, setPage] = useState(1)

  useEffect(() => {
    setPage(1)
  }, [debouncedSearch])

  const { customers, meta, isLoading, error, refetch } = useCustomers(debouncedSearch, page)

  return (
    <div className="space-y-6">
      <div className="flex items-start justify-between gap-4">
        <div className="flex items-center gap-3">
          <div className="flex size-10 shrink-0 items-center justify-center rounded-lg bg-emerald-50 text-emerald-600 dark:bg-emerald-500/15 dark:text-emerald-400">
            <Building2 className="size-5" />
          </div>
          <div>
            <h1 className="text-2xl font-semibold tracking-tight text-foreground sm:text-3xl">Customers</h1>
            <p className="mt-1 text-sm text-muted-foreground">Customers converted from your leads.</p>
          </div>
        </div>
      </div>

      <CustomersToolbar
        search={searchInput}
        onSearchChange={setSearchInput}
        onRefresh={refetch}
        isLoading={isLoading}
      />

      <CustomersTable
        customers={customers}
        isLoading={isLoading}
        error={error}
        hasActiveFilters={debouncedSearch.trim().length > 0}
        onClearFilters={() => setSearchInput('')}
      />

      {meta && <CustomersPagination meta={meta} onPageChange={setPage} />}
    </div>
  )
}
