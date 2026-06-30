export type LeadStatus = 'new' | 'contacted' | 'qualified' | 'proposal_sent' | 'won' | 'lost'

export interface LeadUserSummary {
  id: number
  name: string
  email: string
}

export interface LeadCustomerSummary {
  id: number
  company: string | null
  contact_name: string | null
}

export interface Lead {
  id: number
  first_name: string
  last_name: string
  email: string
  phone: string | null
  company: string | null
  status: LeadStatus
  source: string | null
  assigned_user: LeadUserSummary | null
  creator: LeadUserSummary | null
  customer: LeadCustomerSummary | null
  created_at: string | null
  updated_at: string | null
}
