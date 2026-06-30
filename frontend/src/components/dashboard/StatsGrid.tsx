import { Users, Building2, CalendarCheck, AlertTriangle } from 'lucide-react'
import { StatCard } from '@/components/dashboard/StatCard'
import { useDashboardStats } from '@/hooks/useDashboardStats'

export function StatsGrid() {
  const { stats, isLoading, error } = useDashboardStats()

  const cards = [
    { title: 'Total Leads', value: stats?.total_leads ?? null, icon: Users, tone: 'blue' as const },
    { title: 'Total Customers', value: stats?.total_customers ?? null, icon: Building2, tone: 'emerald' as const },
    { title: "Today's Follow-ups", value: stats?.todays_follow_ups ?? null, icon: CalendarCheck, tone: 'amber' as const },
    { title: 'Overdue Tasks', value: stats?.overdue_tasks ?? null, icon: AlertTriangle, tone: 'rose' as const },
  ]

  return (
    <div className="grid grid-cols-1 gap-5 sm:grid-cols-2 lg:grid-cols-4">
      {cards.map((card) => (
        <StatCard
          key={card.title}
          title={card.title}
          value={card.value}
          icon={card.icon}
          isLoading={isLoading}
          error={error}
          tone={card.tone}
        />
      ))}
    </div>
  )
}
