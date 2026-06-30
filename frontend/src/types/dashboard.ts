export interface DashboardStats {
  total_leads: number
  total_customers: number
  todays_follow_ups: number
  overdue_tasks: number
  leads_by_status: Record<string, number>
  conversion_rate: number
}
