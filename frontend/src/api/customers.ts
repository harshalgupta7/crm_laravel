import { apiClient } from '@/api/client'
import type { Customer } from '@/types/customer'
import type { PaginatedResponse } from '@/types/pagination'

export interface CustomerListParams {
  page?: number
  per_page?: number
}

export function fetchCustomers(params: CustomerListParams) {
  return apiClient.get<PaginatedResponse<Customer>>('/api/customers', { params })
}

export function fetchCustomer(id: number) {
  return apiClient.get<{ data: Customer }>(`/api/customers/${id}`)
}
