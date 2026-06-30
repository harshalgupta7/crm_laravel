import { Search, RefreshCw, Plus } from 'lucide-react'
import { Button } from '@/components/ui/button'
import { Card, CardContent } from '@/components/ui/card'
import { Checkbox } from '@/components/ui/checkbox'
import { Input } from '@/components/ui/input'
import { Label } from '@/components/ui/label'
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select'
import { StatusDot } from '@/components/ui/status-dot'
import {
  TASK_PRIORITIES,
  TASK_PRIORITY_DOT_CLASSES,
  TASK_STATUS_DOT_CLASSES,
  TASK_STATUSES,
} from '@/lib/task-status'
import { cn } from '@/lib/utils'

const ALL_STATUSES_VALUE = 'all'
const ALL_PRIORITIES_VALUE = 'all'

interface TasksToolbarProps {
  search: string
  onSearchChange: (value: string) => void
  status: string
  onStatusChange: (value: string) => void
  priority: string
  onPriorityChange: (value: string) => void
  overdue: boolean
  onOverdueChange: (value: boolean) => void
  onRefresh: () => void
  isLoading: boolean
  onCreate: () => void
}

export function TasksToolbar({
  search,
  onSearchChange,
  status,
  onStatusChange,
  priority,
  onPriorityChange,
  overdue,
  onOverdueChange,
  onRefresh,
  isLoading,
  onCreate,
}: TasksToolbarProps) {
  return (
    <Card size="sm">
      <CardContent className="flex flex-col gap-3 sm:flex-row sm:items-center sm:justify-between">
        <div className="flex flex-1 flex-col gap-3 sm:flex-row sm:flex-wrap sm:items-center">
          <div className="relative w-full sm:max-w-xs">
            <Search className="pointer-events-none absolute left-2.5 top-1/2 size-4 -translate-y-1/2 text-muted-foreground" />
            <Input
              value={search}
              onChange={(event) => onSearchChange(event.target.value)}
              placeholder="Search tasks..."
              className="pl-8"
            />
          </div>

          <Select
            value={status || ALL_STATUSES_VALUE}
            onValueChange={(value) => onStatusChange(value === ALL_STATUSES_VALUE ? '' : value)}
          >
            <SelectTrigger className="w-full sm:w-40">
              <SelectValue placeholder="All statuses" />
            </SelectTrigger>
            <SelectContent>
              <SelectItem value={ALL_STATUSES_VALUE}>
                <StatusDot className="bg-muted-foreground/40" />
                All statuses
              </SelectItem>
              {TASK_STATUSES.map((taskStatus) => (
                <SelectItem key={taskStatus.value} value={taskStatus.value}>
                  <StatusDot className={TASK_STATUS_DOT_CLASSES[taskStatus.value]} />
                  {taskStatus.label}
                </SelectItem>
              ))}
            </SelectContent>
          </Select>

          <Select
            value={priority || ALL_PRIORITIES_VALUE}
            onValueChange={(value) => onPriorityChange(value === ALL_PRIORITIES_VALUE ? '' : value)}
          >
            <SelectTrigger className="w-full sm:w-40">
              <SelectValue placeholder="All priorities" />
            </SelectTrigger>
            <SelectContent>
              <SelectItem value={ALL_PRIORITIES_VALUE}>
                <StatusDot className="bg-muted-foreground/40" />
                All priorities
              </SelectItem>
              {TASK_PRIORITIES.map((taskPriority) => (
                <SelectItem key={taskPriority.value} value={taskPriority.value}>
                  <StatusDot className={TASK_PRIORITY_DOT_CLASSES[taskPriority.value]} />
                  {taskPriority.label}
                </SelectItem>
              ))}
            </SelectContent>
          </Select>

          <Label className="flex items-center gap-2 text-sm font-normal text-muted-foreground">
            <Checkbox checked={overdue} onCheckedChange={(checked) => onOverdueChange(checked === true)} />
            Overdue only
          </Label>
        </div>

        <div className="flex items-center gap-2">
          <Button variant="outline" size="sm" onClick={onRefresh} disabled={isLoading}>
            <RefreshCw className={cn('size-4', isLoading && 'animate-spin')} />
            Refresh
          </Button>
          <Button size="sm" onClick={onCreate}>
            <Plus className="size-4" />
            New Task
          </Button>
        </div>
      </CardContent>
    </Card>
  )
}
