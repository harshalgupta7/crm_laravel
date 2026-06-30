import type { LeadStatus } from '@/types/lead'

export const LEAD_STATUSES: { value: LeadStatus; label: string }[] = [
  { value: 'new', label: 'New' },
  { value: 'contacted', label: 'Contacted' },
  { value: 'qualified', label: 'Qualified' },
  { value: 'proposal_sent', label: 'Proposal Sent' },
  { value: 'won', label: 'Won' },
  { value: 'lost', label: 'Lost' },
]

export const LEAD_STATUS_LABELS: Record<LeadStatus, string> = LEAD_STATUSES.reduce(
  (labels, status) => ({ ...labels, [status.value]: status.label }),
  {} as Record<LeadStatus, string>,
)

export const LEAD_STATUS_BADGE_CLASSES: Record<LeadStatus, string> = {
  new: 'bg-blue-50 text-blue-700 ring-1 ring-inset ring-blue-600/20 dark:bg-blue-500/15 dark:text-blue-400 dark:ring-blue-400/30',
  contacted: 'bg-violet-50 text-violet-700 ring-1 ring-inset ring-violet-600/20 dark:bg-violet-500/15 dark:text-violet-400 dark:ring-violet-400/30',
  qualified: 'bg-amber-50 text-amber-700 ring-1 ring-inset ring-amber-600/20 dark:bg-amber-500/15 dark:text-amber-400 dark:ring-amber-400/30',
  proposal_sent: 'bg-orange-50 text-orange-700 ring-1 ring-inset ring-orange-600/20 dark:bg-orange-500/15 dark:text-orange-400 dark:ring-orange-400/30',
  won: 'bg-emerald-50 text-emerald-700 ring-1 ring-inset ring-emerald-600/20 dark:bg-emerald-500/15 dark:text-emerald-400 dark:ring-emerald-400/30',
  lost: 'bg-rose-50 text-rose-700 ring-1 ring-inset ring-rose-600/20 dark:bg-rose-500/15 dark:text-rose-400 dark:ring-rose-400/30',
}

/** Solid dot color used next to the label in status dropdowns/selects. */
export const LEAD_STATUS_DOT_CLASSES: Record<LeadStatus, string> = {
  new: 'bg-blue-500',
  contacted: 'bg-violet-500',
  qualified: 'bg-amber-500',
  proposal_sent: 'bg-orange-500',
  won: 'bg-emerald-500',
  lost: 'bg-rose-500',
}

/** Very soft row tint applied to table rows, matching each status's hue. */
export const LEAD_STATUS_ROW_CLASSES: Record<LeadStatus, string> = {
  new: 'bg-blue-50/40 hover:bg-blue-50/70 dark:bg-blue-500/[0.04] dark:hover:bg-blue-500/[0.08]',
  contacted: 'bg-violet-50/40 hover:bg-violet-50/70 dark:bg-violet-500/[0.04] dark:hover:bg-violet-500/[0.08]',
  qualified: 'bg-amber-50/40 hover:bg-amber-50/70 dark:bg-amber-500/[0.04] dark:hover:bg-amber-500/[0.08]',
  proposal_sent: 'bg-orange-50/40 hover:bg-orange-50/70 dark:bg-orange-500/[0.04] dark:hover:bg-orange-500/[0.08]',
  won: 'bg-emerald-50/40 hover:bg-emerald-50/70 dark:bg-emerald-500/[0.04] dark:hover:bg-emerald-500/[0.08]',
  lost: 'bg-rose-50/40 hover:bg-rose-50/70 dark:bg-rose-500/[0.04] dark:hover:bg-rose-500/[0.08]',
}
