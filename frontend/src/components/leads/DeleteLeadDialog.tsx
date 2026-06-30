import { useState, type MouseEvent } from 'react'
import { toast } from 'sonner'
import {
  AlertDialog,
  AlertDialogAction,
  AlertDialogCancel,
  AlertDialogContent,
  AlertDialogDescription,
  AlertDialogFooter,
  AlertDialogHeader,
  AlertDialogTitle,
} from '@/components/ui/alert-dialog'
import { deleteLead } from '@/api/leads'
import { getApiErrorMessage } from '@/lib/api-error'
import type { Lead } from '@/types/lead'

interface DeleteLeadDialogProps {
  lead: Lead | null
  open: boolean
  onOpenChange: (open: boolean) => void
  onSuccess: () => void
}

export function DeleteLeadDialog({ lead, open, onOpenChange, onSuccess }: DeleteLeadDialogProps) {
  const [isDeleting, setIsDeleting] = useState(false)

  const handleDelete = async (event: MouseEvent<HTMLButtonElement>) => {
    event.preventDefault()
    if (!lead) return

    setIsDeleting(true)
    try {
      await deleteLead(lead.id)
      toast.success('Lead deleted successfully.')
      onOpenChange(false)
      onSuccess()
    } catch (error) {
      toast.error(getApiErrorMessage(error, 'Unable to delete lead.'))
    } finally {
      setIsDeleting(false)
    }
  }

  return (
    <AlertDialog open={open} onOpenChange={onOpenChange}>
      <AlertDialogContent>
        <AlertDialogHeader>
          <AlertDialogTitle>Delete lead?</AlertDialogTitle>
          <AlertDialogDescription>
            This will permanently delete{' '}
            {lead ? <strong>{`${lead.first_name} ${lead.last_name}`}</strong> : 'this lead'}. This action
            cannot be undone.
          </AlertDialogDescription>
        </AlertDialogHeader>
        <AlertDialogFooter>
          <AlertDialogCancel disabled={isDeleting}>Cancel</AlertDialogCancel>
          <AlertDialogAction variant="destructive" onClick={handleDelete} disabled={isDeleting}>
            {isDeleting ? 'Deleting...' : 'Delete'}
          </AlertDialogAction>
        </AlertDialogFooter>
      </AlertDialogContent>
    </AlertDialog>
  )
}
