import { Link } from 'react-router-dom'
import { getActivityIcon, getSubjectPath, getSubjectTypeLabel } from '@/lib/activity-icons'
import { formatAction, formatExactTimestamp, formatRelativeTime } from '@/lib/format'
import { cn } from '@/lib/utils'
import type { Activity } from '@/types/activity'

const ACTIVITY_VERBS: Record<string, string> = {
  'lead.created': 'created',
  'lead.assigned': 'assigned',
  'lead.status_updated': 'updated the status of',
  'lead.converted': 'converted',
  'task.created': 'created',
  'task.updated': 'updated',
  'task.deleted': 'deleted',
  'customer.note_added': 'added a note to',
}

function describeActivity(activity: Activity): string {
  return ACTIVITY_VERBS[activity.action] ?? formatAction(activity.action).toLowerCase()
}

interface ActivityRowProps {
  activity: Activity
}

/** A single activity timeline row: icon, user, action, clickable entity, and timestamp. */
export function ActivityRow({ activity }: ActivityRowProps) {
  const { icon: ActivityIcon, className } = getActivityIcon(activity.action)
  const subject = activity.subject
  const subjectPath = subject ? getSubjectPath(subject) : null

  return (
    <li className="flex items-start justify-between gap-4 py-4 first:pt-0 last:pb-0">
      <div className="flex min-w-0 items-start gap-3">
        <div className={cn('flex size-9 shrink-0 items-center justify-center rounded-full', className)}>
          <ActivityIcon className="size-4" />
        </div>
        <div className="min-w-0 space-y-0.5">
          <p className="text-sm text-foreground">
            <span className="font-medium">{activity.user?.name ?? 'System'}</span>{' '}
            <span className="text-muted-foreground">{describeActivity(activity)}</span>
            {subject && (
              <>
                {' '}
                <span className="text-muted-foreground">{getSubjectTypeLabel(subject)}</span>{' '}
                {subjectPath ? (
                  <Link to={subjectPath} className="font-medium text-foreground underline-offset-2 hover:underline">
                    &ldquo;{subject.label}&rdquo;
                  </Link>
                ) : (
                  <span className="font-medium text-foreground">&ldquo;{subject.label}&rdquo;</span>
                )}
              </>
            )}
          </p>
          {!subject && activity.description && (
            <p className="text-sm text-muted-foreground">{activity.description}</p>
          )}
        </div>
      </div>
      <span className="shrink-0 text-xs text-muted-foreground" title={formatExactTimestamp(activity.created_at)}>
        {formatRelativeTime(activity.created_at)}
      </span>
    </li>
  )
}
