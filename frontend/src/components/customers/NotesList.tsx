import { Inbox } from 'lucide-react'
import { Skeleton } from '@/components/ui/skeleton'
import { formatRelativeTime } from '@/lib/format'
import type { Note } from '@/types/note'

interface NotesListProps {
  notes: Note[]
  isLoading: boolean
  error: string | null
}

export function NotesList({ notes, isLoading, error }: NotesListProps) {
  if (isLoading) {
    return (
      <div className="space-y-4">
        {Array.from({ length: 3 }).map((_, index) => (
          <div key={index} className="space-y-2">
            <Skeleton className="h-4 w-1/3" />
            <Skeleton className="h-4 w-full" />
          </div>
        ))}
      </div>
    )
  }

  if (error) {
    return <p className="py-6 text-center text-sm text-destructive">{error}</p>
  }

  if (notes.length === 0) {
    return (
      <div className="flex flex-col items-center gap-2 py-10 text-center">
        <div className="flex size-12 items-center justify-center rounded-full bg-brand/10 text-brand">
          <Inbox className="size-5" />
        </div>
        <p className="text-sm text-muted-foreground">No notes yet.</p>
      </div>
    )
  }

  return (
    <ul className="divide-y divide-border">
      {notes.map((note) => (
        <li key={note.id} className="space-y-1 py-4 first:pt-0 last:pb-0">
          <div className="flex items-center justify-between gap-4">
            <p className="text-sm font-medium text-foreground">{note.user?.name ?? 'Unknown user'}</p>
            <span className="shrink-0 text-xs text-muted-foreground">
              {formatRelativeTime(note.created_at)}
            </span>
          </div>
          <p className="text-sm text-muted-foreground">{note.note}</p>
        </li>
      ))}
    </ul>
  )
}
