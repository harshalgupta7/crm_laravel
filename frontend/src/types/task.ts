export type TaskStatus = 'pending' | 'in_progress' | 'completed'
export type TaskPriority = 'low' | 'medium' | 'high'

export interface TaskUserSummary {
  id: number
  name: string
  email: string
}

export interface TaskLeadSummary {
  id: number
  first_name: string
  last_name: string
}

export interface TaskCustomerSummary {
  id: number
  company: string | null
  contact_name: string | null
}

export interface Task {
  id: number
  title: string
  description: string | null
  priority: TaskPriority
  status: TaskStatus
  due_date: string | null
  reminder_at: string | null
  user: TaskUserSummary | null
  lead: TaskLeadSummary | null
  customer: TaskCustomerSummary | null
  created_at: string | null
  updated_at: string | null
}
