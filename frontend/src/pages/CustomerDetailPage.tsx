import { useState } from 'react'
import { useParams, Link } from 'react-router-dom'
import { ArrowLeft, Building2, Plus } from 'lucide-react'
import { Button } from '@/components/ui/button'
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card'
import { Skeleton } from '@/components/ui/skeleton'
import { NotesList } from '@/components/customers/NotesList'
import { AddNoteDialog } from '@/components/customers/AddNoteDialog'
import { LEAD_STATUS_LABELS } from '@/lib/lead-status'
import { useCustomer } from '@/hooks/useCustomer'
import { useNotes } from '@/hooks/useNotes'
import type { LeadStatus } from '@/types/lead'

export function CustomerDetailPage() {
  const params = useParams<{ id: string }>()
  const customerId = Number(params.id)
  const [isAddNoteOpen, setIsAddNoteOpen] = useState(false)

  const { customer, isLoading, error } = useCustomer(customerId)
  const { notes, isLoading: isNotesLoading, error: notesError, refetch: refetchNotes } = useNotes(customerId)

  return (
    <div className="space-y-6">
      <div>
        <Button variant="ghost" size="sm" asChild>
          <Link to="/customers">
            <ArrowLeft className="size-4" />
            Back to Customers
          </Link>
        </Button>
      </div>

      {isLoading ? (
        <div className="space-y-4">
          <Skeleton className="h-7 w-64" />
          <Skeleton className="h-40 w-full" />
        </div>
      ) : error ? (
        <p className="rounded-xl border border-border py-10 text-center text-sm text-destructive">{error}</p>
      ) : !customer ? (
        <p className="rounded-xl border border-border py-10 text-center text-sm text-muted-foreground">
          Customer not found.
        </p>
      ) : (
        <>
          <div className="flex items-center gap-3">
            <div className="flex size-10 shrink-0 items-center justify-center rounded-lg bg-emerald-50 text-emerald-600 dark:bg-emerald-500/15 dark:text-emerald-400">
              <Building2 className="size-5" />
            </div>
            <div>
              <h1 className="text-2xl font-semibold tracking-tight text-foreground sm:text-3xl">{customer.contact_name}</h1>
              <p className="mt-1 text-sm text-muted-foreground">{customer.company || 'No company on file'}</p>
            </div>
          </div>

          <div className="grid gap-6 md:grid-cols-2">
            <Card>
              <CardHeader>
                <CardTitle>Customer Information</CardTitle>
                <CardDescription>Contact details for this customer.</CardDescription>
              </CardHeader>
              <CardContent className="space-y-3 text-sm">
                <div className="flex justify-between gap-4">
                  <span className="text-muted-foreground">Email</span>
                  <span className="text-foreground">{customer.email}</span>
                </div>
                <div className="flex justify-between gap-4">
                  <span className="text-muted-foreground">Phone</span>
                  <span className="text-foreground">{customer.phone || '—'}</span>
                </div>
                <div className="flex justify-between gap-4">
                  <span className="text-muted-foreground">Company</span>
                  <span className="text-foreground">{customer.company || '—'}</span>
                </div>
              </CardContent>
            </Card>

            <Card>
              <CardHeader>
                <CardTitle>Related Lead</CardTitle>
                <CardDescription>The lead this customer was converted from.</CardDescription>
              </CardHeader>
              <CardContent className="space-y-3 text-sm">
                {customer.lead ? (
                  <>
                    <div className="flex justify-between gap-4">
                      <span className="text-muted-foreground">Name</span>
                      <span className="text-foreground">
                        {customer.lead.first_name} {customer.lead.last_name}
                      </span>
                    </div>
                    <div className="flex justify-between gap-4">
                      <span className="text-muted-foreground">Status</span>
                      <span className="text-foreground">
                        {LEAD_STATUS_LABELS[customer.lead.status as LeadStatus] ?? customer.lead.status}
                      </span>
                    </div>
                    <div className="flex justify-between gap-4">
                      <span className="text-muted-foreground">Source</span>
                      <span className="text-foreground">{customer.lead.source || '—'}</span>
                    </div>
                  </>
                ) : (
                  <p className="text-muted-foreground">No related lead on file.</p>
                )}
              </CardContent>
            </Card>
          </div>

          <Card>
            <CardHeader className="flex-row items-center justify-between">
              <div>
                <CardTitle>Notes</CardTitle>
                <CardDescription>Internal notes for this customer.</CardDescription>
              </div>
              <Button size="sm" onClick={() => setIsAddNoteOpen(true)}>
                <Plus className="size-4" />
                Add Note
              </Button>
            </CardHeader>
            <CardContent>
              <NotesList notes={notes} isLoading={isNotesLoading} error={notesError} />
            </CardContent>
          </Card>

          <AddNoteDialog
            customerId={customer.id}
            open={isAddNoteOpen}
            onOpenChange={setIsAddNoteOpen}
            onSuccess={refetchNotes}
          />
        </>
      )}
    </div>
  )
}
