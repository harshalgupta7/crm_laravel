import { useEffect } from 'react'
import { useForm } from 'react-hook-form'
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
import { createNote } from '@/api/notes'
import { applyServerValidationErrors, getApiErrorMessage } from '@/lib/api-error'
import { cn } from '@/lib/utils'

interface NoteFormValues {
  note: string
}

const EMPTY_VALUES: NoteFormValues = { note: '' }

interface AddNoteDialogProps {
  customerId: number
  open: boolean
  onOpenChange: (open: boolean) => void
  onSuccess: () => void
}

export function AddNoteDialog({ customerId, open, onOpenChange, onSuccess }: AddNoteDialogProps) {
  const {
    register,
    handleSubmit,
    reset,
    setError,
    formState: { errors, isSubmitting },
  } = useForm<NoteFormValues>({ defaultValues: EMPTY_VALUES })

  useEffect(() => {
    if (open) reset(EMPTY_VALUES)
  }, [open, reset])

  const onSubmit = async (values: NoteFormValues) => {
    try {
      await createNote(customerId, values.note)
      toast.success('Note added successfully.')
      onOpenChange(false)
      onSuccess()
    } catch (error) {
      const hadFieldErrors = applyServerValidationErrors<NoteFormValues>(error, setError)

      if (!hadFieldErrors) {
        toast.error(getApiErrorMessage(error, 'Unable to add note.'))
      }
    }
  }

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent>
        <DialogHeader>
          <DialogTitle>Add Note</DialogTitle>
          <DialogDescription>Add a new note to this customer.</DialogDescription>
        </DialogHeader>

        <form onSubmit={handleSubmit(onSubmit)} className="space-y-4" noValidate>
          <div className="space-y-1.5">
            <Label htmlFor="note">Note</Label>
            <textarea
              id="note"
              rows={4}
              aria-invalid={!!errors.note}
              className={cn(
                'w-full min-w-0 rounded-lg border border-input bg-transparent px-2.5 py-1.5 text-base transition-colors outline-none placeholder:text-muted-foreground focus-visible:border-ring focus-visible:ring-3 focus-visible:ring-ring/50 md:text-sm dark:bg-input/30',
                errors.note && 'border-destructive',
              )}
              {...register('note', { required: 'Note is required.' })}
            />
            {errors.note && <p className="text-sm text-destructive">{errors.note.message}</p>}
          </div>

          <DialogFooter>
            <Button type="button" variant="outline" onClick={() => onOpenChange(false)}>
              Cancel
            </Button>
            <Button type="submit" disabled={isSubmitting}>
              {isSubmitting && <Loader2 className="animate-spin" />}
              Add Note
            </Button>
          </DialogFooter>
        </form>
      </DialogContent>
    </Dialog>
  )
}
