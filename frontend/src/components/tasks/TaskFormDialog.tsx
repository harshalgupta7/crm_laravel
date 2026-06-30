import { useEffect, useState } from 'react'
import { Controller, useForm } from 'react-hook-form'
import { toast } from 'sonner'
import { Loader2 } from 'lucide-react'
import { Button } from '@/components/ui/button'
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogFooter,
  DialogHeader,
  DialogTitle,
} from '@/components/ui/dialog'
import { Input } from '@/components/ui/input'
import { Label } from '@/components/ui/label'
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select'
import { StatusDot } from '@/components/ui/status-dot'
import { createTask, updateTask } from '@/api/tasks'
import { fetchLeads } from '@/api/leads'
import { applyServerValidationErrors, getApiErrorMessage } from '@/lib/api-error'
import {
  TASK_PRIORITIES,
  TASK_PRIORITY_DOT_CLASSES,
  TASK_STATUS_DOT_CLASSES,
  TASK_STATUSES,
} from '@/lib/task-status'
import { useAuth } from '@/context/AuthContext'
import { cn } from '@/lib/utils'
import type { Task, TaskPriority, TaskStatus } from '@/types/task'
import type { Lead } from '@/types/lead'

interface TaskFormValues {
  title: string
  description: string
  lead_id: string
  user_id: string
  priority: TaskPriority
  status: TaskStatus
  due_date: string
}

function emptyValues(defaultUserId: number | null): TaskFormValues {
  return {
    title: '',
    description: '',
    lead_id: '',
    user_id: defaultUserId ? String(defaultUserId) : '',
    priority: 'medium',
    status: 'pending',
    due_date: '',
  }
}

function taskToFormValues(task: Task): TaskFormValues {
  return {
    title: task.title,
    description: task.description ?? '',
    lead_id: task.lead ? String(task.lead.id) : '',
    user_id: task.user ? String(task.user.id) : '',
    priority: task.priority,
    status: task.status,
    due_date: task.due_date ?? '',
  }
}

interface TaskFormDialogProps {
  mode: 'create' | 'edit'
  task?: Task | null
  open: boolean
  onOpenChange: (open: boolean) => void
  onSuccess: () => void
}

export function TaskFormDialog({ mode, task, open, onOpenChange, onSuccess }: TaskFormDialogProps) {
  const { user } = useAuth()
  const [leads, setLeads] = useState<Lead[]>([])

  const {
    register,
    control,
    handleSubmit,
    reset,
    setError,
    formState: { errors, isSubmitting },
  } = useForm<TaskFormValues>({ defaultValues: emptyValues(user?.id ?? null) })

  useEffect(() => {
    if (open) {
      reset(task ? taskToFormValues(task) : emptyValues(user?.id ?? null))
      fetchLeads({ per_page: 100 })
        .then(({ data }) => setLeads(data.data))
        .catch(() => setLeads([]))
    }
  }, [open, task, user, reset])

  const onSubmit = async (values: TaskFormValues) => {
    const payload = {
      title: values.title,
      description: values.description || null,
      lead_id: values.lead_id ? Number(values.lead_id) : null,
      user_id: Number(values.user_id),
      priority: values.priority,
      status: values.status,
      due_date: values.due_date,
    }

    try {
      if (mode === 'create') {
        await createTask(payload)
        toast.success('Task created successfully.')
      } else if (task) {
        await updateTask(task.id, payload)
        toast.success('Task updated successfully.')
      }

      onOpenChange(false)
      onSuccess()
    } catch (error) {
      const hadFieldErrors = applyServerValidationErrors<TaskFormValues>(error, setError)

      if (!hadFieldErrors) {
        toast.error(getApiErrorMessage(error, 'Unable to save task.'))
      }
    }
  }

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="sm:max-w-lg">
        <DialogHeader>
          <DialogTitle>{mode === 'create' ? 'New Task' : 'Edit Task'}</DialogTitle>
          <DialogDescription>
            {mode === 'create' ? 'Add a new task to your pipeline.' : 'Update the details for this task.'}
          </DialogDescription>
        </DialogHeader>

        <form onSubmit={handleSubmit(onSubmit)} className="space-y-4" noValidate>
          <div className="space-y-1.5">
            <Label htmlFor="title">Title</Label>
            <Input
              id="title"
              aria-invalid={!!errors.title}
              {...register('title', { required: 'Title is required.' })}
            />
            {errors.title && <p className="text-sm text-destructive">{errors.title.message}</p>}
          </div>

          <div className="space-y-1.5">
            <Label htmlFor="description">Description</Label>
            <textarea
              id="description"
              rows={3}
              className={cn(
                'w-full min-w-0 rounded-lg border border-input bg-transparent px-2.5 py-1.5 text-base transition-colors outline-none placeholder:text-muted-foreground focus-visible:border-ring focus-visible:ring-3 focus-visible:ring-ring/50 md:text-sm dark:bg-input/30',
              )}
              aria-invalid={!!errors.description}
              {...register('description')}
            />
            {errors.description && <p className="text-sm text-destructive">{errors.description.message}</p>}
          </div>

          <div className="grid grid-cols-2 gap-4">
            <div className="space-y-1.5">
              <Label>Related Lead</Label>
              <Controller
                name="lead_id"
                control={control}
                rules={{ required: 'A related lead is required.' }}
                render={({ field }) => (
                  <Select value={field.value} onValueChange={field.onChange}>
                    <SelectTrigger aria-invalid={!!errors.lead_id}>
                      <SelectValue placeholder="Select a lead" />
                    </SelectTrigger>
                    <SelectContent>
                      {leads.map((lead) => (
                        <SelectItem key={lead.id} value={String(lead.id)}>
                          {lead.first_name} {lead.last_name}
                        </SelectItem>
                      ))}
                    </SelectContent>
                  </Select>
                )}
              />
              {errors.lead_id && <p className="text-sm text-destructive">{errors.lead_id.message}</p>}
            </div>
            <div className="space-y-1.5">
              <Label htmlFor="user_id">Assigned User ID</Label>
              <Input
                id="user_id"
                type="number"
                aria-invalid={!!errors.user_id}
                {...register('user_id', { required: 'Assigned user is required.' })}
              />
              {errors.user_id && <p className="text-sm text-destructive">{errors.user_id.message}</p>}
            </div>
          </div>

          <div className="grid grid-cols-3 gap-4">
            <div className="space-y-1.5">
              <Label>Priority</Label>
              <Controller
                name="priority"
                control={control}
                render={({ field }) => (
                  <Select value={field.value} onValueChange={field.onChange}>
                    <SelectTrigger aria-invalid={!!errors.priority}>
                      <SelectValue />
                    </SelectTrigger>
                    <SelectContent>
                      {TASK_PRIORITIES.map((priority) => (
                        <SelectItem key={priority.value} value={priority.value}>
                          <StatusDot className={TASK_PRIORITY_DOT_CLASSES[priority.value]} />
                          {priority.label}
                        </SelectItem>
                      ))}
                    </SelectContent>
                  </Select>
                )}
              />
              {errors.priority && <p className="text-sm text-destructive">{errors.priority.message}</p>}
            </div>
            <div className="space-y-1.5">
              <Label>Status</Label>
              <Controller
                name="status"
                control={control}
                render={({ field }) => (
                  <Select value={field.value} onValueChange={field.onChange}>
                    <SelectTrigger aria-invalid={!!errors.status}>
                      <SelectValue />
                    </SelectTrigger>
                    <SelectContent>
                      {TASK_STATUSES.map((status) => (
                        <SelectItem key={status.value} value={status.value}>
                          <StatusDot className={TASK_STATUS_DOT_CLASSES[status.value]} />
                          {status.label}
                        </SelectItem>
                      ))}
                    </SelectContent>
                  </Select>
                )}
              />
              {errors.status && <p className="text-sm text-destructive">{errors.status.message}</p>}
            </div>
            <div className="space-y-1.5">
              <Label htmlFor="due_date">Due Date</Label>
              <Input
                id="due_date"
                type="date"
                aria-invalid={!!errors.due_date}
                {...register('due_date', { required: 'Due date is required.' })}
              />
              {errors.due_date && <p className="text-sm text-destructive">{errors.due_date.message}</p>}
            </div>
          </div>

          <DialogFooter>
            <Button type="button" variant="outline" onClick={() => onOpenChange(false)}>
              Cancel
            </Button>
            <Button type="submit" disabled={isSubmitting}>
              {isSubmitting && <Loader2 className="animate-spin" />}
              {mode === 'create' ? 'Create Task' : 'Save Changes'}
            </Button>
          </DialogFooter>
        </form>
      </DialogContent>
    </Dialog>
  )
}
