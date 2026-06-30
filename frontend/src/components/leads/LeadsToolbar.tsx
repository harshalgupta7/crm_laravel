import { Search, RefreshCw, Plus } from 'lucide-react'
import { Button } from '@/components/ui/button'
import { Card, CardContent } from '@/components/ui/card'
import { Input } from '@/components/ui/input'
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select'
import { StatusDot } from '@/components/ui/status-dot'
import { LEAD_STATUS_DOT_CLASSES, LEAD_STATUSES } from '@/lib/lead-status'
import { cn } from '@/lib/utils'

const ALL_STATUSES_VALUE = 'all'

interface LeadsToolbarProps {
  search: string
  onSearchChange: (value: string) => void
  status: string
  onStatusChange: (value: string) => void
  onRefresh: () => void
  isLoading: boolean
  onCreate: () => void
}

export function LeadsToolbar({
  search,
  onSearchChange,
  status,
  onStatusChange,
  onRefresh,
  isLoading,
  onCreate,
}: LeadsToolbarProps) {
  return (
    <Card size="sm">
      <CardContent className="flex flex-col gap-3 sm:flex-row sm:items-center sm:justify-between">
        <div className="flex flex-1 flex-col gap-3 sm:flex-row sm:items-center">
          <div className="relative w-full sm:max-w-xs">
            <Search className="pointer-events-none absolute left-2.5 top-1/2 size-4 -translate-y-1/2 text-muted-foreground" />
            <Input
              value={search}
              onChange={(event) => onSearchChange(event.target.value)}
              placeholder="Search leads..."
              className="pl-8"
            />
          </div>

          <Select
            value={status || ALL_STATUSES_VALUE}
            onValueChange={(value) => onStatusChange(value === ALL_STATUSES_VALUE ? '' : value)}
          >
            <SelectTrigger className="w-full sm:w-44">
              <SelectValue placeholder="All statuses" />
            </SelectTrigger>
            <SelectContent>
              <SelectItem value={ALL_STATUSES_VALUE}>
                <StatusDot className="bg-muted-foreground/40" />
                All statuses
              </SelectItem>
              {LEAD_STATUSES.map((leadStatus) => (
                <SelectItem key={leadStatus.value} value={leadStatus.value}>
                  <StatusDot className={LEAD_STATUS_DOT_CLASSES[leadStatus.value]} />
                  {leadStatus.label}
                </SelectItem>
              ))}
            </SelectContent>
          </Select>
        </div>

        <div className="flex items-center gap-2">
          <Button variant="outline" size="sm" onClick={onRefresh} disabled={isLoading}>
            <RefreshCw className={cn('size-4', isLoading && 'animate-spin')} />
            Refresh
          </Button>
          <Button size="sm" onClick={onCreate}>
            <Plus className="size-4" />
            New Lead
          </Button>
        </div>
      </CardContent>
    </Card>
  )
}
