import { useEffect, useState } from 'react'
import { useParams, Link } from 'react-router-dom'
import { ArrowLeft, Building2, ListChecks, Users } from 'lucide-react'
import { Badge } from '@/components/ui/badge'
import { Button } from '@/components/ui/button'
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card'
import { Skeleton } from '@/components/ui/skeleton'
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from '@/components/ui/table'
import { LeadFormDialog } from '@/components/leads/LeadFormDialog'
import { AssignLeadDialog } from '@/components/leads/AssignLeadDialog'
import { ChangeLeadStatusDialog } from '@/components/leads/ChangeLeadStatusDialog'
import { ConvertLeadDialog } from '@/components/leads/ConvertLeadDialog'
import { useAuth } from '@/context/AuthContext'
import { useLead } from '@/hooks/useLead'
import { fetchTasks } from '@/api/tasks'
import { LEAD_STATUS_BADGE_CLASSES, LEAD_STATUS_LABELS } from '@/lib/lead-status'
import { TASK_STATUS_BADGE_CLASSES, TASK_STATUS_LABELS } from '@/lib/task-status'
import { formatDueDate, formatExactDate, formatExactTimestamp, formatRelativeTime } from '@/lib/format'
import { cn } from '@/lib/utils'
import type { Task } from '@/types/task'

const MANAGE_ROLES = ['admin', 'sales-manager']

function LeadDetailSkeleton() {
  return (
    <div className="space-y-6">
      <div className="flex items-center gap-3">
        <Skeleton className="size-10 shrink-0 rounded-lg" />
        <div className="space-y-2">
          <Skeleton className="h-7 w-48" />
          <Skeleton className="h-4 w-32" />
        </div>
      </div>

      <div className="grid gap-6 md:grid-cols-2">
        <Card>
          <CardHeader>
            <Skeleton className="h-5 w-36" />
            <Skeleton className="h-4 w-56" />
          </CardHeader>
          <CardContent className="space-y-3">
            {Array.from({ length: 7 }).map((_, index) => (
              <div key={index} className="flex justify-between gap-4">
                <Skeleton className="h-4 w-24" />
                <Skeleton className="h-4 w-32" />
              </div>
            ))}
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <Skeleton className="h-5 w-28" />
            <Skeleton className="h-4 w-56" />
          </CardHeader>
          <CardContent className="space-y-4">
            <div className="flex flex-wrap gap-2">
              {Array.from({ length: 3 }).map((_, index) => (
                <Skeleton key={index} className="h-7 w-20" />
              ))}
            </div>
            <Skeleton className="h-14 w-full" />
          </CardContent>
        </Card>
      </div>

      <Card>
        <CardHeader>
          <Skeleton className="h-5 w-32" />
          <Skeleton className="h-4 w-56" />
        </CardHeader>
        <CardContent className="space-y-3">
          {Array.from({ length: 3 }).map((_, index) => (
            <Skeleton key={index} className="h-4 w-full" />
          ))}
        </CardContent>
      </Card>
    </div>
  )
}

export function LeadDetailPage() {
  const params = useParams<{ id: string }>()
  const leadId = Number(params.id)
  const { user } = useAuth()
  const canManage = !!user && MANAGE_ROLES.includes(user.role.slug)

  const { lead, isLoading, error, refetch } = useLead(leadId)

  const [tasks, setTasks] = useState<Task[]>([])
  const [isTasksLoading, setIsTasksLoading] = useState(true)

  const [isEditOpen, setIsEditOpen] = useState(false)
  const [isAssignOpen, setIsAssignOpen] = useState(false)
  const [isStatusOpen, setIsStatusOpen] = useState(false)
  const [isConvertOpen, setIsConvertOpen] = useState(false)

  useEffect(() => {
    if (!leadId) return

    let active = true
    setIsTasksLoading(true)

    fetchTasks({ lead_id: leadId, per_page: 50 })
      .then(({ data }) => {
        if (active) setTasks(data.data)
      })
      .catch(() => {
        if (active) setTasks([])
      })
      .finally(() => {
        if (active) setIsTasksLoading(false)
      })

    return () => {
      active = false
    }
  }, [leadId])

  return (
    <div className="space-y-6">
      <div>
        <Button variant="ghost" size="sm" asChild>
          <Link to="/leads">
            <ArrowLeft className="size-4" />
            Back to Leads
          </Link>
        </Button>
      </div>

      {isLoading ? (
        <LeadDetailSkeleton />
      ) : error ? (
        <p className="rounded-xl border border-border py-10 text-center text-sm text-destructive">{error}</p>
      ) : !lead ? (
        <p className="rounded-xl border border-border py-10 text-center text-sm text-muted-foreground">
          Lead not found.
        </p>
      ) : (
        <>
          <div className="flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
            <div className="flex items-center gap-3">
              <div className="flex size-10 shrink-0 items-center justify-center rounded-lg bg-blue-50 text-blue-600 dark:bg-blue-500/15 dark:text-blue-400">
                <Users className="size-5" />
              </div>
              <div>
                <h1 className="text-2xl font-semibold tracking-tight text-foreground sm:text-3xl">
                  {lead.first_name} {lead.last_name}
                </h1>
                <p className="mt-1 text-sm text-muted-foreground">{lead.company || 'No company on file'}</p>
              </div>
            </div>
            <Badge className={cn('font-normal', LEAD_STATUS_BADGE_CLASSES[lead.status])}>
              {LEAD_STATUS_LABELS[lead.status]}
            </Badge>
          </div>

          <div className="grid gap-6 md:grid-cols-2">
            <Card>
              <CardHeader>
                <CardTitle>Lead Information</CardTitle>
                <CardDescription>Contact and ownership details for this lead.</CardDescription>
              </CardHeader>
              <CardContent className="space-y-3 text-sm">
                <div className="flex justify-between gap-4">
                  <span className="text-muted-foreground">Email</span>
                  <span className="text-foreground">{lead.email}</span>
                </div>
                <div className="flex justify-between gap-4">
                  <span className="text-muted-foreground">Phone</span>
                  <span className="text-foreground">{lead.phone || '—'}</span>
                </div>
                <div className="flex justify-between gap-4">
                  <span className="text-muted-foreground">Company</span>
                  <span className="text-foreground">{lead.company || '—'}</span>
                </div>
                <div className="flex justify-between gap-4">
                  <span className="text-muted-foreground">Assigned User</span>
                  <span className="text-foreground">{lead.assigned_user?.name || 'Unassigned'}</span>
                </div>
                <div className="flex justify-between gap-4">
                  <span className="text-muted-foreground">Created By</span>
                  <span className="text-foreground">{lead.creator?.name || '—'}</span>
                </div>
                <div className="flex justify-between gap-4">
                  <span className="text-muted-foreground">Created Date</span>
                  <span className="text-foreground" title={formatExactTimestamp(lead.created_at)}>
                    {formatRelativeTime(lead.created_at) || '—'}
                  </span>
                </div>
                <div className="flex justify-between gap-4">
                  <span className="text-muted-foreground">Last Updated</span>
                  <span className="text-foreground" title={formatExactTimestamp(lead.updated_at)}>
                    {formatRelativeTime(lead.updated_at) || '—'}
                  </span>
                </div>
              </CardContent>
            </Card>

            <Card>
              <CardHeader>
                <CardTitle>Quick Actions</CardTitle>
                <CardDescription>Manage this lead's pipeline status and ownership.</CardDescription>
              </CardHeader>
              <CardContent className="space-y-4">
                <div className="flex flex-wrap gap-2">
                  <Button size="sm" variant="outline" onClick={() => setIsEditOpen(true)}>
                    Edit
                  </Button>
                  <Button size="sm" variant="outline" onClick={() => setIsStatusOpen(true)}>
                    Change Status
                  </Button>
                  {canManage && (
                    <>
                      <Button size="sm" variant="outline" onClick={() => setIsAssignOpen(true)}>
                        Assign
                      </Button>
                      {!lead.customer && (
                        <Button size="sm" variant="outline" onClick={() => setIsConvertOpen(true)}>
                          Convert
                        </Button>
                      )}
                    </>
                  )}
                </div>

                {lead.customer && (
                  <div className="rounded-lg border border-border p-3">
                    <p className="text-xs font-medium tracking-wide text-muted-foreground uppercase">
                      Converted Customer
                    </p>
                    <Link
                      to={`/customers/${lead.customer.id}`}
                      className="mt-1 flex items-center gap-2 text-sm font-medium text-foreground underline-offset-2 hover:underline"
                    >
                      <Building2 className="size-4 text-emerald-600 dark:text-emerald-400" />
                      {lead.customer.company || lead.customer.contact_name}
                    </Link>
                  </div>
                )}
              </CardContent>
            </Card>
          </div>

          <Card>
            <CardHeader>
              <CardTitle>Related Tasks</CardTitle>
              <CardDescription>Follow-up tasks linked to this lead.</CardDescription>
            </CardHeader>
            <CardContent className="px-0 pt-0">
              {isTasksLoading ? (
                <div className="space-y-3 px-6 pb-6">
                  {Array.from({ length: 3 }).map((_, index) => (
                    <Skeleton key={index} className="h-4 w-full" />
                  ))}
                </div>
              ) : tasks.length === 0 ? (
                <div className="flex flex-col items-center gap-3 px-6 py-10 text-center">
                  <div className="flex size-12 items-center justify-center rounded-full bg-amber-50 text-amber-600 dark:bg-amber-500/15 dark:text-amber-400">
                    <ListChecks className="size-5" />
                  </div>
                  <div className="space-y-1">
                    <p className="text-sm font-medium text-foreground">No tasks yet</p>
                    <p className="text-sm text-muted-foreground">Follow-up tasks for this lead will show up here.</p>
                  </div>
                </div>
              ) : (
                <Table>
                  <TableHeader>
                    <TableRow>
                      <TableHead>Title</TableHead>
                      <TableHead>Assigned User</TableHead>
                      <TableHead>Status</TableHead>
                      <TableHead>Due Date</TableHead>
                    </TableRow>
                  </TableHeader>
                  <TableBody>
                    {tasks.map((task) => (
                      <TableRow key={task.id}>
                        <TableCell className="font-medium text-foreground">{task.title}</TableCell>
                        <TableCell className="text-muted-foreground">{task.user?.name || 'Unassigned'}</TableCell>
                        <TableCell>
                          <Badge className={cn('font-normal', TASK_STATUS_BADGE_CLASSES[task.status])}>
                            {TASK_STATUS_LABELS[task.status]}
                          </Badge>
                        </TableCell>
                        <TableCell className="text-muted-foreground" title={formatExactDate(task.due_date)}>
                          {formatDueDate(task.due_date) || '—'}
                        </TableCell>
                      </TableRow>
                    ))}
                  </TableBody>
                </Table>
              )}
            </CardContent>
          </Card>

          <LeadFormDialog mode="edit" lead={lead} open={isEditOpen} onOpenChange={setIsEditOpen} onSuccess={refetch} />
          <AssignLeadDialog lead={lead} open={isAssignOpen} onOpenChange={setIsAssignOpen} onSuccess={refetch} />
          <ChangeLeadStatusDialog
            lead={lead}
            open={isStatusOpen}
            onOpenChange={setIsStatusOpen}
            onSuccess={refetch}
          />
          <ConvertLeadDialog lead={lead} open={isConvertOpen} onOpenChange={setIsConvertOpen} onSuccess={refetch} />
        </>
      )}
    </div>
  )
}
