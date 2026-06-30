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
import { Input } from '@/components/ui/input'
import { Label } from '@/components/ui/label'
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select'
import { StatusDot } from '@/components/ui/status-dot'
import { createLead, updateLead } from '@/api/leads'
import { applyServerValidationErrors, getApiErrorMessage } from '@/lib/api-error'
import { LEAD_STATUS_DOT_CLASSES, LEAD_STATUSES } from '@/lib/lead-status'
import type { Lead, LeadStatus } from '@/types/lead'

interface LeadFormValues {
  first_name: string
  last_name: string
  email: string
  phone: string
  company: string
  source: string
  status: LeadStatus
}

const EMPTY_VALUES: LeadFormValues = {
  first_name: '',
  last_name: '',
  email: '',
  phone: '',
  company: '',
  source: '',
  status: 'new',
}

function leadToFormValues(lead: Lead): LeadFormValues {
  return {
    first_name: lead.first_name,
    last_name: lead.last_name,
    email: lead.email,
    phone: lead.phone ?? '',
    company: lead.company ?? '',
    source: lead.source ?? '',
    status: lead.status,
  }
}

interface LeadFormDialogProps {
  mode: 'create' | 'edit'
  lead?: Lead | null
  open: boolean
  onOpenChange: (open: boolean) => void
  onSuccess: () => void
}

export function LeadFormDialog({ mode, lead, open, onOpenChange, onSuccess }: LeadFormDialogProps) {
  const {
    register,
    control,
    handleSubmit,
    reset,
    setError,
    formState: { errors, isSubmitting },
  } = useForm<LeadFormValues>({ defaultValues: EMPTY_VALUES })

  useEffect(() => {
    if (open) {
      reset(lead ? leadToFormValues(lead) : EMPTY_VALUES)
    }
  }, [open, lead, reset])

  const onSubmit = async (values: LeadFormValues) => {
    const payload = {
      first_name: values.first_name,
      last_name: values.last_name,
      email: values.email,
      phone: values.phone || null,
      company: values.company || null,
      source: values.source || null,
      status: values.status,
    }

    try {
      if (mode === 'create') {
        await createLead(payload)
        toast.success('Lead created successfully.')
      } else if (lead) {
        await updateLead(lead.id, payload)
        toast.success('Lead updated successfully.')
      }

      onOpenChange(false)
      onSuccess()
    } catch (error) {
      const hadFieldErrors = applyServerValidationErrors<LeadFormValues>(error, setError)

      if (!hadFieldErrors) {
        toast.error(getApiErrorMessage(error, 'Unable to save lead.'))
      }
    }
  }

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="sm:max-w-lg">
        <DialogHeader>
          <DialogTitle>{mode === 'create' ? 'New Lead' : 'Edit Lead'}</DialogTitle>
          <DialogDescription>
            {mode === 'create' ? 'Add a new lead to your pipeline.' : 'Update the details for this lead.'}
          </DialogDescription>
        </DialogHeader>

        <form onSubmit={handleSubmit(onSubmit)} className="space-y-4" noValidate>
          <div className="grid grid-cols-2 gap-4">
            <div className="space-y-1.5">
              <Label htmlFor="first_name">First name</Label>
              <Input
                id="first_name"
                aria-invalid={!!errors.first_name}
                {...register('first_name', { required: 'First name is required.' })}
              />
              {errors.first_name && <p className="text-sm text-destructive">{errors.first_name.message}</p>}
            </div>
            <div className="space-y-1.5">
              <Label htmlFor="last_name">Last name</Label>
              <Input
                id="last_name"
                aria-invalid={!!errors.last_name}
                {...register('last_name', { required: 'Last name is required.' })}
              />
              {errors.last_name && <p className="text-sm text-destructive">{errors.last_name.message}</p>}
            </div>
          </div>

          <div className="space-y-1.5">
            <Label htmlFor="email">Email</Label>
            <Input
              id="email"
              type="email"
              aria-invalid={!!errors.email}
              {...register('email', {
                required: 'Email is required.',
                pattern: { value: /^[^\s@]+@[^\s@]+\.[^\s@]+$/, message: 'Enter a valid email address.' },
              })}
            />
            {errors.email && <p className="text-sm text-destructive">{errors.email.message}</p>}
          </div>

          <div className="grid grid-cols-2 gap-4">
            <div className="space-y-1.5">
              <Label htmlFor="phone">Phone</Label>
              <Input id="phone" aria-invalid={!!errors.phone} {...register('phone')} />
              {errors.phone && <p className="text-sm text-destructive">{errors.phone.message}</p>}
            </div>
            <div className="space-y-1.5">
              <Label htmlFor="company">Company</Label>
              <Input id="company" aria-invalid={!!errors.company} {...register('company')} />
              {errors.company && <p className="text-sm text-destructive">{errors.company.message}</p>}
            </div>
          </div>

          <div className="grid grid-cols-2 gap-4">
            <div className="space-y-1.5">
              <Label htmlFor="source">Source</Label>
              <Input
                id="source"
                placeholder="e.g. website"
                aria-invalid={!!errors.source}
                {...register('source')}
              />
              {errors.source && <p className="text-sm text-destructive">{errors.source.message}</p>}
            </div>
            <div className="space-y-1.5">
              <Label>Status</Label>
              <Controller
                name="status"
                control={control}
                render={({ field }) => (
                  <Select value={field.value} onValueChange={field.onChange}>
                    <SelectTrigger aria-invalid={!!errors.status}>
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
          </div>

          <DialogFooter>
            <Button type="button" variant="outline" onClick={() => onOpenChange(false)}>
              Cancel
            </Button>
            <Button type="submit" disabled={isSubmitting}>
              {isSubmitting && <Loader2 className="animate-spin" />}
              {mode === 'create' ? 'Create Lead' : 'Save Changes'}
            </Button>
          </DialogFooter>
        </form>
      </DialogContent>
    </Dialog>
  )
}
