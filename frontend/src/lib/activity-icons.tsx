import { Flag, Pencil, Plus, RefreshCw, Trash2, UserPlus, type LucideIcon } from 'lucide-react'
import type { ActivitySubject } from '@/types/activity'

interface ActivityIconInfo {
  icon: LucideIcon
  className: string
}

const ACTIVITY_ICON_RULES: { test: (action: string) => boolean; icon: LucideIcon; className: string }[] = [
  {
    test: (action) => action.includes('status'),
    icon: Flag,
    className: 'bg-orange-50 text-orange-600 dark:bg-orange-500/15 dark:text-orange-400',
  },
  {
    test: (action) => action.includes('assign'),
    icon: UserPlus,
    className: 'bg-violet-50 text-violet-600 dark:bg-violet-500/15 dark:text-violet-400',
  },
  {
    test: (action) => action.includes('convert'),
    icon: RefreshCw,
    className: 'bg-emerald-50 text-emerald-600 dark:bg-emerald-500/15 dark:text-emerald-400',
  },
  {
    test: (action) => action.includes('delete'),
    icon: Trash2,
    className: 'bg-rose-50 text-rose-600 dark:bg-rose-500/15 dark:text-rose-400',
  },
  {
    test: (action) => action.includes('update') || action.includes('note'),
    icon: Pencil,
    className: 'bg-amber-50 text-amber-600 dark:bg-amber-500/15 dark:text-amber-400',
  },
  {
    test: (action) => action.includes('create'),
    icon: Plus,
    className: 'bg-blue-50 text-blue-600 dark:bg-blue-500/15 dark:text-blue-400',
  },
]

const DEFAULT_ICON_INFO: ActivityIconInfo = {
  icon: Pencil,
  className: 'bg-muted text-foreground',
}

export function getActivityIcon(action: string): ActivityIconInfo {
  const rule = ACTIVITY_ICON_RULES.find(({ test }) => test(action))
  return rule ? { icon: rule.icon, className: rule.className } : DEFAULT_ICON_INFO
}

const SUBJECT_LABELS: Record<ActivitySubject['type'], string> = {
  lead: 'Lead',
  customer: 'Customer',
  task: 'Task',
}

/** Path to navigate to for a clickable activity subject, or null if there's no detail page for it. */
export function getSubjectPath(subject: ActivitySubject): string | null {
  if (subject.type === 'lead') return `/leads/${subject.id}`
  if (subject.type === 'customer') return `/customers/${subject.id}`
  return null
}

export function getSubjectTypeLabel(subject: ActivitySubject): string {
  return SUBJECT_LABELS[subject.type]
}
