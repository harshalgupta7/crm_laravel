export interface AuthRole {
  id: number
  name: string
  slug: string
}

export interface AuthUser {
  id: number
  name: string
  email: string
  role: AuthRole
  created_at: string
  updated_at: string
}
