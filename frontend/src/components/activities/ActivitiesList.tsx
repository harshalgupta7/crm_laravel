import { Inbox } from 'lucide-react'
import { Skeleton } from '@/components/ui/skeleton'
import { ActivityRow } from '@/components/activities/ActivityRow'
import type { Activity } from '@/types/activity'

interface ActivitiesListProps {
  activities: Activity[]
  isLoading: boolean
  error: string | null
}

export function ActivitiesList({ activities, isLoading, error }: ActivitiesListProps) {
  if (isLoading) {
    return (
      <div className="divide-y divide-border rounded-xl border border-border">
        {Array.from({ length: 5 }).map((_, index) => (
          <div key={index} className="flex items-center gap-3 p-4">
            <Skeleton className="size-9 shrink-0 rounded-full" />
            <div className="flex-1 space-y-2">
              <Skeleton className="h-4 w-1/2" />
              <Skeleton className="h-3 w-1/3" />
            </div>
          </div>
        ))}
      </div>
    )
  }

  if (error) {
    return (
      <div className="rounded-xl border border-border py-10 text-center text-sm text-destructive">
        {error}
      </div>
    )
  }

  if (activities.length === 0) {
    return (
      <div className="flex flex-col items-center gap-3 rounded-xl border border-border py-14 text-center">
        <div className="flex size-12 items-center justify-center rounded-full bg-brand/10 text-brand">
          <Inbox className="size-5" />
        </div>
        <div className="space-y-1">
          <p className="text-sm font-medium text-foreground">No activity yet</p>
          <p className="text-sm text-muted-foreground">Actions across your CRM will be logged here.</p>
        </div>
      </div>
    )
  }

  return (
    <ul className="divide-y divide-border rounded-xl border border-border px-4">
      {activities.map((activity) => (
        <ActivityRow key={activity.id} activity={activity} />
      ))}
    </ul>
  )
}
