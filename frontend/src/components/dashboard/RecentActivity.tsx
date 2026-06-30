import { Inbox } from 'lucide-react'
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card'
import { Skeleton } from '@/components/ui/skeleton'
import { useRecentActivities } from '@/hooks/useRecentActivities'
import { formatAction, formatRelativeTime, getInitials } from '@/lib/format'

const ACTIVITY_LIMIT = 10

export function RecentActivity() {
  const { activities, isLoading, error } = useRecentActivities(ACTIVITY_LIMIT)

  return (
    <Card>
      <CardHeader className="border-b border-border pb-4">
        <CardTitle className="text-base font-semibold tracking-tight">Recent Activity</CardTitle>
        <CardDescription>Latest actions across your CRM.</CardDescription>
      </CardHeader>
      <CardContent className="pt-4">
        {isLoading ? (
          <div className="space-y-5">
            {Array.from({ length: 5 }).map((_, index) => (
              <div key={index} className="flex items-center gap-3">
                <Skeleton className="size-9 shrink-0 rounded-full" />
                <div className="flex-1 space-y-2">
                  <Skeleton className="h-4 w-1/2" />
                  <Skeleton className="h-3 w-1/3" />
                </div>
              </div>
            ))}
          </div>
        ) : error ? (
          <p className="text-sm text-destructive">{error}</p>
        ) : activities.length === 0 ? (
          <div className="flex flex-col items-center gap-2 py-10 text-center">
            <div className="flex size-12 items-center justify-center rounded-full bg-brand/10 text-brand">
              <Inbox className="size-5" />
            </div>
            <p className="text-sm text-muted-foreground">No recent activity yet.</p>
          </div>
        ) : (
          <ul className="divide-y divide-border">
            {activities.map((activity) => (
              <li key={activity.id} className="flex items-start justify-between gap-4 py-4 first:pt-0 last:pb-0">
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
                      <p className="truncate text-sm text-muted-foreground">{activity.description}</p>
                    )}
                  </div>
                </div>
                <span className="shrink-0 text-xs text-muted-foreground">
                  {formatRelativeTime(activity.created_at)}
                </span>
              </li>
            ))}
          </ul>
        )}
      </CardContent>
    </Card>
  )
}
