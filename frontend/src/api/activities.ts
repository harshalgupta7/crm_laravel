import { apiClient } from '@/api/client'
import type { Activity } from '@/types/activity'
import type { PaginatedResponse } from '@/types/pagination'

export interface ActivityListParams {
  page?: number
  per_page?: number
}

export function fetchActivities(params: ActivityListParams) {
  return apiClient.get<PaginatedResponse<Activity>>('/api/activities', { params })
}
