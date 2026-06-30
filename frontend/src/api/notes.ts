import { apiClient } from '@/api/client'
import type { Note } from '@/types/note'

export function fetchNotes(customerId: number) {
  return apiClient.get<{ data: Note[] }>(`/api/customers/${customerId}/notes`)
}

export function createNote(customerId: number, note: string) {
  return apiClient.post<{ data: Note }>(`/api/customers/${customerId}/notes`, { note })
}
