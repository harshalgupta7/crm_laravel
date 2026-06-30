import { Inbox } from 'lucide-react'
import { Skeleton } from '@/components/ui/skeleton'
import { formatAction, formatRelativeTime, getInitials } from '@/lib/format'
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
      <div className="flex flex-col items-center gap-2 rounded-xl border border-border py-10 text-center">
        <div className="flex size-12 items-center justify-center rounded-full bg-brand/10 text-brand">
          <Inbox className="size-5" />
        </div>
        <p className="text-sm text-muted-foreground">No activity found.</p>
      </div>
    )
  }

  return (
    <ul className="divide-y divide-border rounded-xl border border-border">
      {activities.map((activity) => (
        <li key={activity.id} className="flex items-start justify-between gap-4 p-4">
          <div className="flex min-w-0 items-start gap-3">
            <div className="flex size-9 shrink-0 items-center justify-center rounded-full bg-muted text-xs font-medium text-foreground">
              {getInitials(activity.user?.name)}
            </div>
            <div className="min-w-0 space-y-0.5">
              <p className="text-sm font-medium text-foreground">
                {activity.user?.name ?? 'System'}{' '}
                <span className="font-normal text-muted-foreground">
                  {formatAction(activity.action)}
                </span>
              </p>
              {activity.description && (
                <p className="text-sm text-muted-foreground">{activity.description}</p>
              )}
            </div>
          </div>
          <span className="shrink-0 text-xs text-muted-foreground">
            {formatRelativeTime(activity.created_at)}
          </span>
        </li>
      ))}
    </ul>
  )
}
