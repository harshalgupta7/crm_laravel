import { apiClient } from '@/api/client'
import type { Customer } from '@/types/customer'
import type { Lead } from '@/types/lead'
import type { Task } from '@/types/task'

export interface GlobalSearchResults {
  leads: Lead[]
  customers: Customer[]
  tasks: Task[]
}

export function searchGlobal(query: string) {
  return apiClient.get<GlobalSearchResults>('/api/search', { params: { q: query } })
}
