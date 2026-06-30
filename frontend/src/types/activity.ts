export interface ActivityUser {
  id: number
  name: string
  email: string
}

export interface ActivitySubject {
  type: 'lead' | 'customer' | 'task'
  id: number
  label: string
}

export interface Activity {
  id: number
  action: string
  subject_type: string
  subject_id: number
  subject: ActivitySubject | null
  description: string | null
  user: ActivityUser | null
  created_at: string | null
}
