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
import { useAuth } from '@/context/AuthContext'
import { LEAD_STATUS_BADGE_CLASSES, LEAD_STATUS_LABELS, LEAD_STATUS_ROW_CLASSES } from '@/lib/lead-status'
import { cn } from '@/lib/utils'
import type { Lead } from '@/types/lead'
import { LeadFormDialog } from '@/components/leads/LeadFormDialog'
import { DeleteLeadDialog } from '@/components/leads/DeleteLeadDialog'
import { ConvertLeadDialog } from '@/components/leads/ConvertLeadDialog'
import { AssignLeadDialog } from '@/components/leads/AssignLeadDialog'
import { ChangeLeadStatusDialog } from '@/components/leads/ChangeLeadStatusDialog'

const MANAGE_ROLES = ['admin', 'sales-manager']
const COLUMN_COUNT = 8

interface LeadsTableProps {
  leads: Lead[]
  isLoading: boolean
  error: string | null
  onChanged: () => void
}

export function LeadsTable({ leads, isLoading, error, onChanged }: LeadsTableProps) {
  const { user } = useAuth()
  const canManage = !!user && MANAGE_ROLES.includes(user.role.slug)

  const [editingLead, setEditingLead] = useState<Lead | null>(null)
  const [deletingLead, setDeletingLead] = useState<Lead | null>(null)
  const [convertingLead, setConvertingLead] = useState<Lead | null>(null)
  const [assigningLead, setAssigningLead] = useState<Lead | null>(null)
  const [statusLead, setStatusLead] = useState<Lead | null>(null)

  return (
    <Card className="overflow-hidden py-0">
      <CardContent className="min-w-0 overflow-x-auto px-0 py-0">
        <Table>
          <TableHeader>
            <TableRow>
              <TableHead>Name</TableHead>
              <TableHead>Company</TableHead>
              <TableHead>Email</TableHead>
              <TableHead>Phone</TableHead>
              <TableHead>Status</TableHead>
              <TableHead>Assigned User</TableHead>
              <TableHead>Created By</TableHead>
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
            ) : leads.length === 0 ? (
              <TableRow>
                <TableCell colSpan={COLUMN_COUNT} className="py-10">
                  <div className="flex flex-col items-center gap-2 text-center">
                    <div className="flex size-12 items-center justify-center rounded-full bg-brand/10 text-brand">
                      <Inbox className="size-5" />
                    </div>
                    <p className="text-sm text-muted-foreground">No leads found.</p>
                  </div>
                </TableCell>
              </TableRow>
            ) : (
              leads.map((lead) => (
                <TableRow key={lead.id} className={LEAD_STATUS_ROW_CLASSES[lead.status]}>
                  <TableCell className="font-medium text-foreground">
                    {lead.first_name} {lead.last_name}
                  </TableCell>
                  <TableCell className="text-muted-foreground">{lead.company || '—'}</TableCell>
                  <TableCell className="text-muted-foreground">{lead.email}</TableCell>
                  <TableCell className="text-muted-foreground">{lead.phone || '—'}</TableCell>
                  <TableCell>
                    <Badge className={cn('font-normal', LEAD_STATUS_BADGE_CLASSES[lead.status])}>
                      {LEAD_STATUS_LABELS[lead.status]}
                    </Badge>
                  </TableCell>
                  <TableCell className="text-muted-foreground">
                    {lead.assigned_user?.name || 'Unassigned'}
                  </TableCell>
                  <TableCell className="text-muted-foreground">{lead.creator?.name || '—'}</TableCell>
                  <TableCell className="text-right">
                    <DropdownMenu>
                      <DropdownMenuTrigger asChild>
                        <Button variant="ghost" size="icon-sm">
                          <MoreHorizontal className="size-4" />
                          <span className="sr-only">Open actions</span>
                        </Button>
                      </DropdownMenuTrigger>
                      <DropdownMenuContent align="end">
                        <DropdownMenuItem onSelect={() => setEditingLead(lead)}>Edit</DropdownMenuItem>
                        <DropdownMenuItem onSelect={() => setStatusLead(lead)}>
                          Change Status
                        </DropdownMenuItem>
                        {canManage && (
                          <>
                            <DropdownMenuItem onSelect={() => setAssigningLead(lead)}>
                              Assign
                            </DropdownMenuItem>
                            <DropdownMenuItem onSelect={() => setConvertingLead(lead)}>
                              Convert
                            </DropdownMenuItem>
                            <DropdownMenuItem
                              variant="destructive"
                              onSelect={() => setDeletingLead(lead)}
                            >
                              Delete
                            </DropdownMenuItem>
                          </>
                        )}
                      </DropdownMenuContent>
                    </DropdownMenu>
                  </TableCell>
                </TableRow>
              ))
            )}
          </TableBody>
        </Table>
      </CardContent>

      <LeadFormDialog
        mode="edit"
        lead={editingLead}
        open={!!editingLead}
        onOpenChange={(open) => !open && setEditingLead(null)}
        onSuccess={onChanged}
      />
      <DeleteLeadDialog
        lead={deletingLead}
        open={!!deletingLead}
        onOpenChange={(open) => !open && setDeletingLead(null)}
        onSuccess={onChanged}
      />
      <ConvertLeadDialog
        lead={convertingLead}
        open={!!convertingLead}
        onOpenChange={(open) => !open && setConvertingLead(null)}
        onSuccess={onChanged}
      />
      <AssignLeadDialog
        lead={assigningLead}
        open={!!assigningLead}
        onOpenChange={(open) => !open && setAssigningLead(null)}
        onSuccess={onChanged}
      />
      <ChangeLeadStatusDialog
        lead={statusLead}
        open={!!statusLead}
        onOpenChange={(open) => !open && setStatusLead(null)}
        onSuccess={onChanged}
      />
    </Card>
  )
}
