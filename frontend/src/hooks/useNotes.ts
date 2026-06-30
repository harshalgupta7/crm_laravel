import { useCallback, useEffect, useState } from 'react'
import { fetchNotes } from '@/api/notes'
import { getApiErrorMessage } from '@/lib/api-error'
import type { Note } from '@/types/note'

interface UseNotesResult {
  notes: Note[]
  isLoading: boolean
  error: string | null
  refetch: () => void
}

export function useNotes(customerId: number): UseNotesResult {
  const [notes, setNotes] = useState<Note[]>([])
  const [isLoading, setIsLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)
  const [reloadToken, setReloadToken] = useState(0)

  useEffect(() => {
    let active = true
    setIsLoading(true)
    setError(null)

    fetchNotes(customerId)
      .then(({ data }) => {
        if (active) setNotes(data.data)
      })
      .catch((err: unknown) => {
        if (active) setError(getApiErrorMessage(err, 'Unable to load notes.'))
      })
      .finally(() => {
        if (active) setIsLoading(false)
      })

    return () => {
      active = false
    }
  }, [customerId, reloadToken])

  const refetch = useCallback(() => setReloadToken((token) => token + 1), [])

  return { notes, isLoading, error, refetch }
}
