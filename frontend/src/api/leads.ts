import { apiClient } from '@/api/client'
import type { Lead, LeadStatus } from '@/types/lead'
import type { PaginatedResponse } from '@/types/pagination'

export interface LeadListParams {
  search?: string
  status?: string
  page?: number
  per_page?: number
}

export interface LeadPayload {
  first_name: string
  last_name: string
  email: string
  phone?: string | null
  company?: string | null
  source?: string | null
  status?: LeadStatus
}

export function fetchLeads(params: LeadListParams) {
  return apiClient.get<PaginatedResponse<Lead>>('/api/leads', { params })
}

export function createLead(payload: LeadPayload) {
  return apiClient.post<{ data: Lead }>('/api/leads', payload)
}

export function updateLead(id: number, payload: LeadPayload) {
  return apiClient.put<{ data: Lead }>(`/api/leads/${id}`, payload)
}

export function deleteLead(id: number) {
  return apiClient.delete(`/api/leads/${id}`)
}

export function assignLead(id: number, assignedTo: number | null) {
  return apiClient.patch<{ data: Lead }>(`/api/leads/${id}/assign`, { assigned_to: assignedTo })
}

export function updateLeadStatus(id: number, status: LeadStatus) {
  return apiClient.patch<{ data: Lead }>(`/api/leads/${id}/status`, { status })
}

export function convertLead(id: number) {
  return apiClient.post(`/api/leads/${id}/convert`)
}
