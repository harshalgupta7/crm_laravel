import type { TaskPriority, TaskStatus } from '@/types/task'

export const TASK_STATUSES: { value: TaskStatus; label: string }[] = [
  { value: 'pending', label: 'Pending' },
  { value: 'in_progress', label: 'In Progress' },
  { value: 'completed', label: 'Completed' },
]

export const TASK_STATUS_LABELS: Record<TaskStatus, string> = TASK_STATUSES.reduce(
  (labels, status) => ({ ...labels, [status.value]: status.label }),
  {} as Record<TaskStatus, string>,
)

export const TASK_STATUS_BADGE_CLASSES: Record<TaskStatus, string> = {
  pending: 'bg-gray-100 text-gray-700 ring-1 ring-inset ring-gray-600/20 dark:bg-gray-500/15 dark:text-gray-400 dark:ring-gray-400/30',
  in_progress: 'bg-blue-50 text-blue-700 ring-1 ring-inset ring-blue-600/20 dark:bg-blue-500/15 dark:text-blue-400 dark:ring-blue-400/30',
  completed: 'bg-emerald-50 text-emerald-700 ring-1 ring-inset ring-emerald-600/20 dark:bg-emerald-500/15 dark:text-emerald-400 dark:ring-emerald-400/30',
}

/** Solid dot color used next to the label in status dropdowns/selects. */
export const TASK_STATUS_DOT_CLASSES: Record<TaskStatus, string> = {
  pending: 'bg-gray-400',
  in_progress: 'bg-blue-500',
  completed: 'bg-emerald-500',
}

/** Very soft row tint applied to table rows, matching each status's hue. */
export const TASK_STATUS_ROW_CLASSES: Record<TaskStatus, string> = {
  pending: 'bg-gray-50/50 hover:bg-gray-50/80 dark:bg-gray-500/[0.04] dark:hover:bg-gray-500/[0.08]',
  in_progress: 'bg-blue-50/40 hover:bg-blue-50/70 dark:bg-blue-500/[0.04] dark:hover:bg-blue-500/[0.08]',
  completed: 'bg-emerald-50/40 hover:bg-emerald-50/70 dark:bg-emerald-500/[0.04] dark:hover:bg-emerald-500/[0.08]',
}

export const TASK_PRIORITIES: { value: TaskPriority; label: string }[] = [
  { value: 'low', label: 'Low' },
  { value: 'medium', label: 'Medium' },
  { value: 'high', label: 'High' },
]

export const TASK_PRIORITY_LABELS: Record<TaskPriority, string> = TASK_PRIORITIES.reduce(
  (labels, priority) => ({ ...labels, [priority.value]: priority.label }),
  {} as Record<TaskPriority, string>,
)

export const TASK_PRIORITY_BADGE_CLASSES: Record<TaskPriority, string> = {
  low: 'bg-slate-100 text-slate-700 ring-1 ring-inset ring-slate-600/20 dark:bg-slate-500/15 dark:text-slate-400 dark:ring-slate-400/30',
  medium: 'bg-amber-50 text-amber-700 ring-1 ring-inset ring-amber-600/20 dark:bg-amber-500/15 dark:text-amber-400 dark:ring-amber-400/30',
  high: 'bg-rose-50 text-rose-700 ring-1 ring-inset ring-rose-600/20 dark:bg-rose-500/15 dark:text-rose-400 dark:ring-rose-400/30',
}

/** Solid dot color used next to the label in priority dropdowns/selects. */
export const TASK_PRIORITY_DOT_CLASSES: Record<TaskPriority, string> = {
  low: 'bg-slate-400',
  medium: 'bg-amber-500',
  high: 'bg-rose-500',
}
