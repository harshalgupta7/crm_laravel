import { useEffect, useState } from 'react'
import { ListChecks } from 'lucide-react'
import { TasksToolbar } from '@/components/tasks/TasksToolbar'
import { TasksTable } from '@/components/tasks/TasksTable'
import { TasksPagination } from '@/components/tasks/TasksPagination'
import { TaskFormDialog } from '@/components/tasks/TaskFormDialog'
import { useDebouncedValue } from '@/hooks/useDebouncedValue'
import { useTasks } from '@/hooks/useTasks'

export function TasksPage() {
  const [searchInput, setSearchInput] = useState('')
  const debouncedSearch = useDebouncedValue(searchInput, 400)
  const [status, setStatus] = useState('')
  const [priority, setPriority] = useState('')
  const [overdue, setOverdue] = useState(false)
  const [page, setPage] = useState(1)
  const [isCreateOpen, setIsCreateOpen] = useState(false)

  useEffect(() => {
    setPage(1)
  }, [debouncedSearch, status, priority, overdue])

  const { tasks, meta, isLoading, error, refetch } = useTasks({
    search: debouncedSearch,
    status,
    priority,
    overdue,
    page,
  })

  return (
    <div className="space-y-6">
      <div className="flex items-center gap-3">
        <div className="flex size-10 shrink-0 items-center justify-center rounded-lg bg-amber-50 text-amber-600 dark:bg-amber-500/15 dark:text-amber-400">
          <ListChecks className="size-5" />
        </div>
        <div>
          <h1 className="text-2xl font-semibold tracking-tight text-foreground sm:text-3xl">Tasks</h1>
          <p className="mt-1 text-sm text-muted-foreground">Track and manage your follow-up tasks.</p>
        </div>
      </div>

      <TasksToolbar
        search={searchInput}
        onSearchChange={setSearchInput}
        status={status}
        onStatusChange={setStatus}
        priority={priority}
        onPriorityChange={setPriority}
        overdue={overdue}
        onOverdueChange={setOverdue}
        onRefresh={refetch}
        isLoading={isLoading}
        onCreate={() => setIsCreateOpen(true)}
      />

      <TasksTable tasks={tasks} isLoading={isLoading} error={error} onChanged={refetch} />

      {meta && <TasksPagination meta={meta} onPageChange={setPage} />}

      <TaskFormDialog
        mode="create"
        open={isCreateOpen}
        onOpenChange={setIsCreateOpen}
        onSuccess={refetch}
      />
    </div>
  )
}
