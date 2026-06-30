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
import { UserCombobox } from '@/components/ui/user-combobox'
import { assignLead } from '@/api/leads'
import { applyServerValidationErrors, getApiErrorMessage } from '@/lib/api-error'
import type { Lead } from '@/types/lead'
import type { UserSummary } from '@/types/user'

interface AssignFormValues {
  assigned_to: UserSummary | null
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
  } = useForm<AssignFormValues>({ defaultValues: { assigned_to: null } })

  useEffect(() => {
    if (open) {
      reset({ assigned_to: lead?.assigned_user ? { id: lead.assigned_user.id, name: lead.assigned_user.name } : null })
    }
  }, [open, lead, reset])

  const onSubmit = async (values: AssignFormValues) => {
    if (!lead) return

    try {
      await assignLead(lead.id, values.assigned_to ? values.assigned_to.id : null)
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
                <UserCombobox
                  value={field.value}
                  onChange={field.onChange}
                  placeholder="Search users by name..."
                  unassignedLabel="Unassigned"
                  invalid={!!errors.assigned_to}
                />
              )}
            />
            {errors.assigned_to && <p className="text-sm text-destructive">{errors.assigned_to.message}</p>}
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
