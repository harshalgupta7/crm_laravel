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
import { deleteTask } from '@/api/tasks'
import { getApiErrorMessage } from '@/lib/api-error'
import type { Task } from '@/types/task'

interface DeleteTaskDialogProps {
  task: Task | null
  open: boolean
  onOpenChange: (open: boolean) => void
  onSuccess: () => void
}

export function DeleteTaskDialog({ task, open, onOpenChange, onSuccess }: DeleteTaskDialogProps) {
  const [isDeleting, setIsDeleting] = useState(false)

  const handleDelete = async (event: MouseEvent<HTMLButtonElement>) => {
    event.preventDefault()
    if (!task) return

    setIsDeleting(true)
    try {
      await deleteTask(task.id)
      toast.success('Task deleted successfully.')
      onOpenChange(false)
      onSuccess()
    } catch (error) {
      toast.error(getApiErrorMessage(error, 'Unable to delete task.'))
    } finally {
      setIsDeleting(false)
    }
  }

  return (
    <AlertDialog open={open} onOpenChange={onOpenChange}>
      <AlertDialogContent>
        <AlertDialogHeader>
          <AlertDialogTitle>Delete task?</AlertDialogTitle>
          <AlertDialogDescription>
            This will permanently delete{' '}
            {task ? <strong>{task.title}</strong> : 'this task'}. This action cannot be undone.
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
