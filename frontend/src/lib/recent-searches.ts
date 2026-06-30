const STORAGE_KEY = 'crm:recent-searches'
const MAX_RECENT = 5

export function getRecentSearches(): string[] {
  try {
    const raw = localStorage.getItem(STORAGE_KEY)
    const parsed = raw ? JSON.parse(raw) : []
    return Array.isArray(parsed) ? parsed.filter((item): item is string => typeof item === 'string') : []
  } catch {
    return []
  }
}

export function addRecentSearch(term: string): string[] {
  const trimmed = term.trim()
  if (!trimmed) return getRecentSearches()

  const existing = getRecentSearches().filter((item) => item.toLowerCase() !== trimmed.toLowerCase())
  const updated = [trimmed, ...existing].slice(0, MAX_RECENT)

  try {
    localStorage.setItem(STORAGE_KEY, JSON.stringify(updated))
  } catch {
    // localStorage unavailable (e.g. private browsing); recent searches just won't persist.
  }

  return updated
}
