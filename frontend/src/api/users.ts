import { apiClient } from '@/api/client'
import type { UserSummary } from '@/types/user'

export interface UserListParams {
  search?: string
}

export function fetchUsers(params: UserListParams) {
  return apiClient.get<{ data: UserSummary[] }>('/api/users', { params })
}
