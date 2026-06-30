export interface NoteUserSummary {
  id: number
  name: string
  email: string
}

export interface Note {
  id: number
  customer_id: number
  note: string
  user: NoteUserSummary | null
  created_at: string | null
  updated_at: string | null
}
