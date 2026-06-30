import { apiClient } from '@/api/client'
import type { Task, TaskPriority, TaskStatus } from '@/types/task'
import type { PaginatedResponse } from '@/types/pagination'

export interface TaskListParams {
  search?: string
  status?: string
  priority?: string
  user_id?: number
  lead_id?: number
  customer_id?: number
  overdue?: boolean
  page?: number
  per_page?: number
}

export interface TaskPayload {
  user_id: number
  lead_id?: number | null
  customer_id?: number | null
  title: string
  description?: string | null
  priority?: TaskPriority
  status?: TaskStatus
  due_date: string
  reminder_at?: string | null
}

export function fetchTasks(params: TaskListParams) {
  return apiClient.get<PaginatedResponse<Task>>('/api/tasks', { params })
}

export function createTask(payload: TaskPayload) {
  return apiClient.post<{ data: Task }>('/api/tasks', payload)
}

export function updateTask(id: number, payload: Partial<TaskPayload>) {
  return apiClient.put<{ data: Task }>(`/api/tasks/${id}`, payload)
}

export function deleteTask(id: number) {
  return apiClient.delete(`/api/tasks/${id}`)
}
