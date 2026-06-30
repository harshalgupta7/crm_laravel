import { isAxiosError } from 'axios'
import type { FieldValues, Path, UseFormSetError } from 'react-hook-form'

interface ApiErrorBody {
  message?: string
  errors?: Record<string, string[]>
}

export function getApiErrorMessage(error: unknown, fallback: string): string {
  if (!isAxiosError<ApiErrorBody>(error)) {
    return fallback
  }

  const body = error.response?.data
  const firstFieldError = body?.errors && Object.values(body.errors)[0]?.[0]

  return firstFieldError ?? body?.message ?? fallback
}

/**
 * Maps a Laravel 422 { errors: { field: [message] } } payload onto react-hook-form
 * fields via setError, so each field shows its own server-side message inline.
 * Returns true if at least one field error was applied — callers should skip the
 * generic toast in that case and only fall back to it when this returns false
 * (e.g. non-validation failures like 401/403/500/network errors).
 */
export function applyServerValidationErrors<T extends FieldValues>(
  error: unknown,
  setError: UseFormSetError<T>,
): boolean {
  if (!isAxiosError<ApiErrorBody>(error)) return false

  const errors = error.response?.data?.errors
  if (!errors) return false

  let applied = false

  for (const [field, messages] of Object.entries(errors)) {
    if (!messages?.[0]) continue
    setError(field as Path<T>, { type: 'server', message: messages[0] })
    applied = true
  }

  return applied
}
