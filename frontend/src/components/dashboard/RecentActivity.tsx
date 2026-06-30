import { Inbox } from 'lucide-react'
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card'
import { Skeleton } from '@/components/ui/skeleton'
import { ActivityRow } from '@/components/activities/ActivityRow'
import { useRecentActivities } from '@/hooks/useRecentActivities'

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
          <div className="flex flex-col items-center gap-3 py-10 text-center">
            <div className="flex size-12 items-center justify-center rounded-full bg-brand/10 text-brand">
              <Inbox className="size-5" />
            </div>
            <div className="space-y-1">
              <p className="text-sm font-medium text-foreground">No recent activity</p>
              <p className="text-sm text-muted-foreground">Actions across your CRM will appear here.</p>
            </div>
          </div>
        ) : (
          <ul className="divide-y divide-border">
            {activities.map((activity) => (
              <ActivityRow key={activity.id} activity={activity} />
            ))}
          </ul>
        )}
      </CardContent>
    </Card>
  )
}
