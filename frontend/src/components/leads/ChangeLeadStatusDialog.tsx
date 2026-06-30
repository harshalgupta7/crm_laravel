import { useEffect } from 'react'
import { Controller, useForm } from 'react-hook-form'
import { toast } from 'sonner'
import { Loader2 } from 'lucide-react'
import { Button } from '@/components/ui/button'
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogFooter,
  DialogHeader,
  DialogTitle,
} from '@/components/ui/dialog'
import { Label } from '@/components/ui/label'
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select'
import { StatusDot } from '@/components/ui/status-dot'
import { updateLeadStatus } from '@/api/leads'
import { applyServerValidationErrors, getApiErrorMessage } from '@/lib/api-error'
import { LEAD_STATUS_DOT_CLASSES, LEAD_STATUSES } from '@/lib/lead-status'
import type { Lead, LeadStatus } from '@/types/lead'

interface StatusFormValues {
  status: LeadStatus
}

interface ChangeLeadStatusDialogProps {
  lead: Lead | null
  open: boolean
  onOpenChange: (open: boolean) => void
  onSuccess: () => void
}

export function ChangeLeadStatusDialog({ lead, open, onOpenChange, onSuccess }: ChangeLeadStatusDialogProps) {
  const {
    control,
    handleSubmit,
    reset,
    setError,
    formState: { errors, isSubmitting },
  } = useForm<StatusFormValues>({ defaultValues: { status: 'new' } })

  useEffect(() => {
    if (open && lead) reset({ status: lead.status })
  }, [open, lead, reset])

  const onSubmit = async (values: StatusFormValues) => {
    if (!lead) return

    try {
      await updateLeadStatus(lead.id, values.status)
      toast.success('Lead status updated.')
      onOpenChange(false)
      onSuccess()
    } catch (error) {
      const hadFieldErrors = applyServerValidationErrors<StatusFormValues>(error, setError)

      if (!hadFieldErrors) {
        toast.error(getApiErrorMessage(error, 'Unable to update lead status.'))
      }
    }
  }

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent>
        <DialogHeader>
          <DialogTitle>Change Status</DialogTitle>
          <DialogDescription>
            Update the pipeline status for {lead ? `${lead.first_name} ${lead.last_name}` : 'this lead'}.
          </DialogDescription>
        </DialogHeader>

        <form onSubmit={handleSubmit(onSubmit)}>
          <div className="space-y-2">
            <Label>Status</Label>
            <Controller
              name="status"
              control={control}
              render={({ field }) => (
                <Select value={field.value} onValueChange={field.onChange}>
                  <SelectTrigger className="w-full" aria-invalid={!!errors.status}>
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent>
                    {LEAD_STATUSES.map((leadStatus) => (
                      <SelectItem key={leadStatus.value} value={leadStatus.value}>
                        <StatusDot className={LEAD_STATUS_DOT_CLASSES[leadStatus.value]} />
                        {leadStatus.label}
                      </SelectItem>
                    ))}
                  </SelectContent>
                </Select>
              )}
            />
            {errors.status && <p className="text-sm text-destructive">{errors.status.message}</p>}
          </div>

          <DialogFooter className="mt-4">
            <Button type="button" variant="outline" onClick={() => onOpenChange(false)}>
              Cancel
            </Button>
            <Button type="submit" disabled={isSubmitting}>
              {isSubmitting && <Loader2 className="animate-spin" />}
              Save
            </Button>
          </DialogFooter>
        </form>
      </DialogContent>
    </Dialog>
  )
}
