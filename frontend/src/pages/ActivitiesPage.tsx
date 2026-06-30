import { useState } from 'react'
import { Activity as ActivityIcon, Lock } from 'lucide-react'
import { ActivitiesList } from '@/components/activities/ActivitiesList'
import { ActivitiesPagination } from '@/components/activities/ActivitiesPagination'
import { useActivities } from '@/hooks/useActivities'

export function ActivitiesPage() {
  const [page, setPage] = useState(1)
  const { activities, meta, isLoading, error, isForbidden } = useActivities(page)

  if (isForbidden) {
    return (
      <div className="flex flex-col items-center justify-center gap-3 rounded-xl border border-border py-20 text-center">
        <div className="flex size-12 items-center justify-center rounded-full bg-rose-50 text-rose-600 dark:bg-rose-500/15 dark:text-rose-400">
          <Lock className="size-5" />
        </div>
        <p className="text-sm text-muted-foreground">
          You don&apos;t have permission to view organization activity.
        </p>
      </div>
    )
  }

  return (
    <div className="space-y-6">
      <div className="flex items-center gap-3">
        <div className="flex size-10 shrink-0 items-center justify-center rounded-lg bg-violet-50 text-violet-600 dark:bg-violet-500/15 dark:text-violet-400">
          <ActivityIcon className="size-5" />
        </div>
        <div>
          <h1 className="text-2xl font-semibold tracking-tight text-foreground sm:text-3xl">Activities</h1>
          <p className="mt-1 text-sm text-muted-foreground">A log of recent actions across your CRM.</p>
        </div>
      </div>

      <ActivitiesList activities={activities} isLoading={isLoading} error={error} />

      {meta && <ActivitiesPagination meta={meta} onPageChange={setPage} />}
    </div>
  )
}
