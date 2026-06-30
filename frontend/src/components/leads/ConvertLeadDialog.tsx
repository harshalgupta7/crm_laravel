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
import { convertLead } from '@/api/leads'
import { getApiErrorMessage } from '@/lib/api-error'
import type { Lead } from '@/types/lead'

interface ConvertLeadDialogProps {
  lead: Lead | null
  open: boolean
  onOpenChange: (open: boolean) => void
  onSuccess: () => void
}

export function ConvertLeadDialog({ lead, open, onOpenChange, onSuccess }: ConvertLeadDialogProps) {
  const [isConverting, setIsConverting] = useState(false)

  const handleConvert = async (event: MouseEvent<HTMLButtonElement>) => {
    event.preventDefault()
    if (!lead) return

    setIsConverting(true)
    try {
      await convertLead(lead.id)
      toast.success('Lead converted to customer.')
      onOpenChange(false)
      onSuccess()
    } catch (error) {
      toast.error(getApiErrorMessage(error, 'Unable to convert lead.'))
    } finally {
      setIsConverting(false)
    }
  }

  return (
    <AlertDialog open={open} onOpenChange={onOpenChange}>
      <AlertDialogContent>
        <AlertDialogHeader>
          <AlertDialogTitle>Convert lead to customer?</AlertDialogTitle>
          <AlertDialogDescription>
            This will create a new customer record from{' '}
            {lead ? <strong>{`${lead.first_name} ${lead.last_name}`}</strong> : 'this lead'}.
          </AlertDialogDescription>
        </AlertDialogHeader>
        <AlertDialogFooter>
          <AlertDialogCancel disabled={isConverting}>Cancel</AlertDialogCancel>
          <AlertDialogAction onClick={handleConvert} disabled={isConverting}>
            {isConverting ? 'Converting...' : 'Convert'}
          </AlertDialogAction>
        </AlertDialogFooter>
      </AlertDialogContent>
    </AlertDialog>
  )
}
