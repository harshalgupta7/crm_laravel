import type { Note } from '@/types/note'

export interface CustomerLeadSummary {
  id: number
  first_name: string
  last_name: string
  email: string
  phone: string | null
  company: string | null
  status: string
  source: string | null
  created_at: string | null
  updated_at: string | null
}

export interface Customer {
  id: number
  lead_id: number | null
  company: string | null
  contact_name: string
  email: string
  phone: string | null
  lead: CustomerLeadSummary | null
  notes: Note[] | null
  created_at: string | null
  updated_at: string | null
}
