import { useState } from 'react'
import { Building2, RefreshCw } from 'lucide-react'
import { Button } from '@/components/ui/button'
import { CustomersTable } from '@/components/customers/CustomersTable'
import { CustomersPagination } from '@/components/customers/CustomersPagination'
import { useCustomers } from '@/hooks/useCustomers'
import { cn } from '@/lib/utils'

export function CustomersPage() {
  const [page, setPage] = useState(1)
  const { customers, meta, isLoading, error, refetch } = useCustomers(page)

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
        <Button variant="outline" size="sm" onClick={refetch} disabled={isLoading}>
          <RefreshCw className={cn('size-4', isLoading && 'animate-spin')} />
          Refresh
        </Button>
      </div>

      <CustomersTable customers={customers} isLoading={isLoading} error={error} />

      {meta && <CustomersPagination meta={meta} onPageChange={setPage} />}
    </div>
  )
}
