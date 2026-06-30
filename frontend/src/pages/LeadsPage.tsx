import { useEffect, useState } from 'react'
import { Users } from 'lucide-react'
import { LeadsToolbar } from '@/components/leads/LeadsToolbar'
import { LeadsTable } from '@/components/leads/LeadsTable'
import { LeadsPagination } from '@/components/leads/LeadsPagination'
import { LeadFormDialog } from '@/components/leads/LeadFormDialog'
import { useDebouncedValue } from '@/hooks/useDebouncedValue'
import { useLeads } from '@/hooks/useLeads'

export function LeadsPage() {
  const [searchInput, setSearchInput] = useState('')
  const debouncedSearch = useDebouncedValue(searchInput, 400)
  const [status, setStatus] = useState('')
  const [page, setPage] = useState(1)
  const [isCreateOpen, setIsCreateOpen] = useState(false)

  useEffect(() => {
    setPage(1)
  }, [debouncedSearch, status])

  const { leads, meta, isLoading, error, refetch } = useLeads(debouncedSearch, status, page)

  return (
    <div className="space-y-6">
      <div className="flex items-center gap-3">
        <div className="flex size-10 shrink-0 items-center justify-center rounded-lg bg-blue-50 text-blue-600 dark:bg-blue-500/15 dark:text-blue-400">
          <Users className="size-5" />
        </div>
        <div>
          <h1 className="text-2xl font-semibold tracking-tight text-foreground sm:text-3xl">Leads</h1>
          <p className="mt-1 text-sm text-muted-foreground">Manage and track your sales leads.</p>
        </div>
      </div>

      <LeadsToolbar
        search={searchInput}
        onSearchChange={setSearchInput}
        status={status}
        onStatusChange={setStatus}
        onRefresh={refetch}
        isLoading={isLoading}
        onCreate={() => setIsCreateOpen(true)}
      />

      <LeadsTable leads={leads} isLoading={isLoading} error={error} onChanged={refetch} />

      {meta && <LeadsPagination meta={meta} onPageChange={setPage} />}

      <LeadFormDialog
        mode="create"
        open={isCreateOpen}
        onOpenChange={setIsCreateOpen}
        onSuccess={refetch}
      />
    </div>
  )
}
