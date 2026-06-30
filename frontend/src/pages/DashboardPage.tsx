import { LayoutDashboard } from 'lucide-react'
import { StatsGrid } from '@/components/dashboard/StatsGrid'
import { RecentActivity } from '@/components/dashboard/RecentActivity'

export function DashboardPage() {
  return (
    <div className="space-y-8">
      <div className="flex items-center gap-3">
        <div className="flex size-10 shrink-0 items-center justify-center rounded-lg bg-blue-50 text-blue-600 dark:bg-blue-500/15 dark:text-blue-400">
          <LayoutDashboard className="size-5" />
        </div>
        <div>
          <h1 className="text-2xl font-semibold tracking-tight text-foreground sm:text-3xl">Dashboard</h1>
          <p className="mt-1 text-sm text-muted-foreground">Overview of your CRM activity.</p>
        </div>
      </div>

      <StatsGrid />

      <RecentActivity />
    </div>
  )
}
