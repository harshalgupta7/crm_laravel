import type { LucideIcon } from 'lucide-react'
import { Card, CardContent } from '@/components/ui/card'
import { Skeleton } from '@/components/ui/skeleton'
import { cn } from '@/lib/utils'

export type StatCardTone = 'blue' | 'emerald' | 'amber' | 'rose'

const TONE_CLASSES: Record<StatCardTone, string> = {
  blue: 'bg-blue-50 text-blue-600 dark:bg-blue-500/15 dark:text-blue-400',
  emerald: 'bg-emerald-50 text-emerald-600 dark:bg-emerald-500/15 dark:text-emerald-400',
  amber: 'bg-amber-50 text-amber-600 dark:bg-amber-500/15 dark:text-amber-400',
  rose: 'bg-rose-50 text-rose-600 dark:bg-rose-500/15 dark:text-rose-400',
}

interface StatCardProps {
  title: string
  value: number | null
  icon: LucideIcon
  isLoading: boolean
  error: string | null
  tone: StatCardTone
}

export function StatCard({ title, value, icon: Icon, isLoading, error, tone }: StatCardProps) {
  return (
    <Card className="transition-shadow duration-150 hover:shadow-md">
      <CardContent className="flex items-start justify-between gap-4">
        <div className="min-w-0 flex-1 space-y-2">
          <p className="text-xs font-medium tracking-wide text-muted-foreground uppercase">{title}</p>
          {isLoading ? (
            <Skeleton className="h-8 w-16" />
          ) : error ? (
            <p className="text-sm text-destructive">{error}</p>
          ) : (
            <p className="text-3xl font-semibold tracking-tight text-foreground tabular-nums">{value}</p>
          )}
        </div>
        <div className={cn('flex size-9 shrink-0 items-center justify-center rounded-lg', TONE_CLASSES[tone])}>
          <Icon className="size-4.5" />
        </div>
      </CardContent>
    </Card>
  )
}
