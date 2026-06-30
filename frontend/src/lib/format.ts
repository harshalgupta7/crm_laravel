export function getInitials(name?: string | null): string {
  if (!name) return '?'

  const initials = name
    .trim()
    .split(/\s+/)
    .slice(0, 2)
    .map((part) => part[0]?.toUpperCase() ?? '')
    .join('')

  return initials || '?'
}

export function formatAction(action: string): string {
  return action
    .split(/[._]/)
    .filter(Boolean)
    .map((word) => word.charAt(0).toUpperCase() + word.slice(1))
    .join(' ')
}

const relativeTimeFormatter = new Intl.RelativeTimeFormat('en', { numeric: 'auto' })

const TIME_DIVISIONS: { amount: number; unit: Intl.RelativeTimeFormatUnit }[] = [
  { amount: 60, unit: 'seconds' },
  { amount: 60, unit: 'minutes' },
  { amount: 24, unit: 'hours' },
  { amount: 7, unit: 'days' },
  { amount: 4.34524, unit: 'weeks' },
  { amount: 12, unit: 'months' },
  { amount: Number.POSITIVE_INFINITY, unit: 'years' },
]

export function formatRelativeTime(dateString: string | null): string {
  if (!dateString) return ''

  let duration = (new Date(dateString).getTime() - Date.now()) / 1000

  for (const division of TIME_DIVISIONS) {
    if (Math.abs(duration) < division.amount) {
      return relativeTimeFormatter.format(Math.round(duration), division.unit)
    }
    duration /= division.amount
  }

  return ''
}

const exactTimestampFormatter = new Intl.DateTimeFormat('en', {
  dateStyle: 'medium',
  timeStyle: 'short',
})

export function formatExactTimestamp(dateString: string | null): string {
  if (!dateString) return ''
  return exactTimestampFormatter.format(new Date(dateString))
}

const exactDateFormatter = new Intl.DateTimeFormat('en', { dateStyle: 'medium' })

/** Same as formatExactTimestamp but omits the time, for date-only fields like due_date. */
export function formatExactDate(dateString: string | null): string {
  if (!dateString) return ''
  return exactDateFormatter.format(new Date(dateString))
}

const shortDateFormatter = new Intl.DateTimeFormat('en', { month: 'short', day: 'numeric' })

function startOfDay(date: Date): Date {
  const copy = new Date(date)
  copy.setHours(0, 0, 0, 0)
  return copy
}

function daysBetween(from: Date, to: Date): number {
  const msPerDay = 24 * 60 * 60 * 1000
  return Math.round((startOfDay(to).getTime() - startOfDay(from).getTime()) / msPerDay)
}

/**
 * Formats a due date relative to today: "Today"/"Tomorrow"/"Yesterday" for
 * adjacent days, "In N days"/"N days overdue" within a week, and a short
 * date like "Jul 8" beyond that.
 */
export function formatDueDate(dateString: string | null): string {
  if (!dateString) return ''

  const diff = daysBetween(new Date(), new Date(dateString))

  if (diff === 0) return 'Today'
  if (diff === 1) return 'Tomorrow'
  if (diff === -1) return 'Yesterday'
  if (diff > 1 && diff <= 7) return `In ${diff} days`
  if (diff < -1 && diff >= -7) return `${Math.abs(diff)} days overdue`

  return shortDateFormatter.format(new Date(dateString))
}

export function isOverdueDate(dateString: string | null): boolean {
  if (!dateString) return false
  return daysBetween(new Date(), new Date(dateString)) < 0
}
