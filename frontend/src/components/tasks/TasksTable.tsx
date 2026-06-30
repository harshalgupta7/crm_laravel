import { useState } from 'react'
import { MoreHorizontal, Inbox } from 'lucide-react'
import { Badge } from '@/components/ui/badge'
import { Button } from '@/components/ui/button'
import { Card, CardContent } from '@/components/ui/card'
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuTrigger,
} from '@/components/ui/dropdown-menu'
import { Skeleton } from '@/components/ui/skeleton'
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from '@/components/ui/table'
import {
  TASK_PRIORITY_BADGE_CLASSES,
  TASK_PRIORITY_LABELS,
  TASK_STATUS_BADGE_CLASSES,
  TASK_STATUS_LABELS,
  TASK_STATUS_ROW_CLASSES,
} from '@/lib/task-status'
import { cn } from '@/lib/utils'
import type { Task } from '@/types/task'
import { TaskFormDialog } from '@/components/tasks/TaskFormDialog'
import { DeleteTaskDialog } from '@/components/tasks/DeleteTaskDialog'

const COLUMN_COUNT = 7

interface TasksTableProps {
  tasks: Task[]
  isLoading: boolean
  error: string | null
  onChanged: () => void
}

function relatedToLabel(task: Task): string {
  if (task.lead) return `${task.lead.first_name} ${task.lead.last_name}`
  if (task.customer) return task.customer.company || task.customer.contact_name || '—'
  return '—'
}

export function TasksTable({ tasks, isLoading, error, onChanged }: TasksTableProps) {
  const [editingTask, setEditingTask] = useState<Task | null>(null)
  const [deletingTask, setDeletingTask] = useState<Task | null>(null)

  return (
    <Card className="overflow-hidden py-0">
      <CardContent className="min-w-0 overflow-x-auto px-0 py-0">
        <Table>
          <TableHeader>
            <TableRow>
              <TableHead>Title</TableHead>
              <TableHead>Related Lead/Customer</TableHead>
              <TableHead>Assigned User</TableHead>
              <TableHead>Priority</TableHead>
              <TableHead>Status</TableHead>
              <TableHead>Due Date</TableHead>
              <TableHead className="text-right">Actions</TableHead>
            </TableRow>
          </TableHeader>
          <TableBody>
            {isLoading ? (
              Array.from({ length: 5 }).map((_, index) => (
                <TableRow key={index}>
                  {Array.from({ length: COLUMN_COUNT }).map((__, cellIndex) => (
                    <TableCell key={cellIndex}>
                      <Skeleton className="h-4 w-full max-w-28" />
                    </TableCell>
                  ))}
                </TableRow>
              ))
            ) : error ? (
              <TableRow>
                <TableCell colSpan={COLUMN_COUNT} className="py-10 text-center text-sm text-destructive">
                  {error}
                </TableCell>
              </TableRow>
            ) : tasks.length === 0 ? (
              <TableRow>
                <TableCell colSpan={COLUMN_COUNT} className="py-10">
                  <div className="flex flex-col items-center gap-2 text-center">
                    <div className="flex size-12 items-center justify-center rounded-full bg-brand/10 text-brand">
                      <Inbox className="size-5" />
                    </div>
                    <p className="text-sm text-muted-foreground">No tasks found.</p>
                  </div>
                </TableCell>
              </TableRow>
            ) : (
              tasks.map((task) => (
                <TableRow key={task.id} className={TASK_STATUS_ROW_CLASSES[task.status]}>
                  <TableCell className="font-medium text-foreground">{task.title}</TableCell>
                  <TableCell className="text-muted-foreground">{relatedToLabel(task)}</TableCell>
                  <TableCell className="text-muted-foreground">{task.user?.name || 'Unassigned'}</TableCell>
                  <TableCell>
                    <Badge className={cn('font-normal', TASK_PRIORITY_BADGE_CLASSES[task.priority])}>
                      {TASK_PRIORITY_LABELS[task.priority]}
                    </Badge>
                  </TableCell>
                  <TableCell>
                    <Badge className={cn('font-normal', TASK_STATUS_BADGE_CLASSES[task.status])}>
                      {TASK_STATUS_LABELS[task.status]}
                    </Badge>
                  </TableCell>
                  <TableCell className="text-muted-foreground">{task.due_date || '—'}</TableCell>
                  <TableCell className="text-right">
                    <DropdownMenu>
                      <DropdownMenuTrigger asChild>
                        <Button variant="ghost" size="icon-sm">
                          <MoreHorizontal className="size-4" />
                          <span className="sr-only">Open actions</span>
                        </Button>
                      </DropdownMenuTrigger>
                      <DropdownMenuContent align="end">
                        <DropdownMenuItem onSelect={() => setEditingTask(task)}>Edit</DropdownMenuItem>
                        <DropdownMenuItem variant="destructive" onSelect={() => setDeletingTask(task)}>
                          Delete
                        </DropdownMenuItem>
                      </DropdownMenuContent>
                    </DropdownMenu>
                  </TableCell>
                </TableRow>
              ))
            )}
          </TableBody>
        </Table>
      </CardContent>

      <TaskFormDialog
        mode="edit"
        task={editingTask}
        open={!!editingTask}
        onOpenChange={(open) => !open && setEditingTask(null)}
        onSuccess={onChanged}
      />
      <DeleteTaskDialog
        task={deletingTask}
        open={!!deletingTask}
        onOpenChange={(open) => !open && setDeletingTask(null)}
        onSuccess={onChanged}
      />
    </Card>
  )
}
