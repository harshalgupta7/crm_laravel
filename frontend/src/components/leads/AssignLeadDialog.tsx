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
import { assignLead } from '@/api/leads'
import { applyServerValidationErrors, getApiErrorMessage } from '@/lib/api-error'
import type { Lead } from '@/types/lead'

const UNASSIGNED_VALUE = 'unassigned'

interface AssignFormValues {
  assigned_to: string
}

interface AssignLeadDialogProps {
  lead: Lead | null
  open: boolean
  onOpenChange: (open: boolean) => void
  onSuccess: () => void
}

export function AssignLeadDialog({ lead, open, onOpenChange, onSuccess }: AssignLeadDialogProps) {
  const {
    control,
    handleSubmit,
    reset,
    setError,
    formState: { errors, isSubmitting },
  } = useForm<AssignFormValues>({ defaultValues: { assigned_to: UNASSIGNED_VALUE } })

  useEffect(() => {
    if (open) {
      reset({ assigned_to: lead?.assigned_user ? String(lead.assigned_user.id) : UNASSIGNED_VALUE })
    }
  }, [open, lead, reset])

  const onSubmit = async (values: AssignFormValues) => {
    if (!lead) return

    try {
      const assignedTo = values.assigned_to === UNASSIGNED_VALUE ? null : Number(values.assigned_to)
      await assignLead(lead.id, assignedTo)
      toast.success('Lead assignment updated.')
      onOpenChange(false)
      onSuccess()
    } catch (error) {
      const hadFieldErrors = applyServerValidationErrors<AssignFormValues>(error, setError)

      if (!hadFieldErrors) {
        toast.error(getApiErrorMessage(error, 'Unable to assign lead.'))
      }
    }
  }

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent>
        <DialogHeader>
          <DialogTitle>Assign Lead</DialogTitle>
          <DialogDescription>
            Choose who should own {lead ? `${lead.first_name} ${lead.last_name}` : 'this lead'}.
          </DialogDescription>
        </DialogHeader>

        <form onSubmit={handleSubmit(onSubmit)}>
          <div className="space-y-2">
            <Label>Assigned to</Label>
            <Controller
              name="assigned_to"
              control={control}
              render={({ field }) => (
                <Select value={field.value} onValueChange={field.onChange}>
                  <SelectTrigger className="w-full" aria-invalid={!!errors.assigned_to}>
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value={UNASSIGNED_VALUE}>Unassigned</SelectItem>
                    {lead?.assigned_user && (
                      <SelectItem value={String(lead.assigned_user.id)}>{lead.assigned_user.name}</SelectItem>
                    )}
                  </SelectContent>
                </Select>
              )}
            />
            {errors.assigned_to && <p className="text-sm text-destructive">{errors.assigned_to.message}</p>}
            <p className="text-xs text-muted-foreground">
              No user directory endpoint is available yet, so only the currently assigned user and unassigning
              are supported here.
            </p>
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
