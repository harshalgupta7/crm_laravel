import { useEffect, useRef, useState } from 'react'
import { useNavigate } from 'react-router-dom'
import { Clock, Loader2, Search } from 'lucide-react'
import { Input } from '@/components/ui/input'
import { searchGlobal, type GlobalSearchResults } from '@/api/search'
import { useDebouncedValue } from '@/hooks/useDebouncedValue'
import { addRecentSearch, getRecentSearches } from '@/lib/recent-searches'

const EMPTY_RESULTS: GlobalSearchResults = { leads: [], customers: [], tasks: [] }

export function GlobalSearch() {
  const navigate = useNavigate()
  const [query, setQuery] = useState('')
  const [open, setOpen] = useState(false)
  const [results, setResults] = useState<GlobalSearchResults>(EMPTY_RESULTS)
  const [isLoading, setIsLoading] = useState(false)
  const [recentSearches, setRecentSearches] = useState<string[]>(() => getRecentSearches())
  const debouncedQuery = useDebouncedValue(query, 350)
  const containerRef = useRef<HTMLDivElement>(null)

  useEffect(() => {
    const trimmed = debouncedQuery.trim()

    if (!trimmed) {
      setResults(EMPTY_RESULTS)
      setIsLoading(false)
      return
    }

    let active = true
    setIsLoading(true)

    searchGlobal(trimmed)
      .then(({ data }) => {
        if (active) {
          setResults(data)
          setRecentSearches(addRecentSearch(trimmed))
        }
      })
      .catch(() => {
        if (active) setResults(EMPTY_RESULTS)
      })
      .finally(() => {
        if (active) setIsLoading(false)
      })

    return () => {
      active = false
    }
  }, [debouncedQuery])

  useEffect(() => {
    function handleClickOutside(event: MouseEvent) {
      if (containerRef.current && !containerRef.current.contains(event.target as Node)) {
        setOpen(false)
      }
    }

    function handleEscape(event: KeyboardEvent) {
      if (event.key === 'Escape') setOpen(false)
    }

    document.addEventListener('mousedown', handleClickOutside)
    document.addEventListener('keydown', handleEscape)

    return () => {
      document.removeEventListener('mousedown', handleClickOutside)
      document.removeEventListener('keydown', handleEscape)
    }
  }, [])

  const hasQuery = query.trim().length > 0
  const hasResults = results.leads.length > 0 || results.customers.length > 0 || results.tasks.length > 0

  function go(path: string) {
    navigate(path)
    setOpen(false)
    setQuery('')
  }

  return (
    <div ref={containerRef} className="relative max-w-sm">
      <Search className="pointer-events-none absolute left-2.5 top-1/2 size-4 -translate-y-1/2 text-muted-foreground" />
      <Input
        value={query}
        onChange={(event) => {
          setQuery(event.target.value)
          setOpen(true)
        }}
        onFocus={() => {
          setRecentSearches(getRecentSearches())
          setOpen(true)
        }}
        placeholder="Search leads, customers and tasks..."
        className="pl-8"
      />

      {open && !hasQuery && recentSearches.length > 0 && (
        <div className="absolute z-50 mt-1 w-full min-w-72 overflow-hidden rounded-lg border border-border bg-popover shadow-md">
          <div className="p-1">
            <p className="px-2 py-1 text-xs font-medium text-muted-foreground">Recent Searches</p>
            {recentSearches.map((term) => (
              <button
                key={term}
                type="button"
                className="flex w-full items-center gap-2 rounded-md px-2 py-1.5 text-left text-sm hover:bg-accent hover:text-accent-foreground"
                onClick={() => setQuery(term)}
              >
                <Clock className="size-3.5 text-muted-foreground" />
                {term}
              </button>
            ))}
          </div>
        </div>
      )}

      {open && hasQuery && (
        <div className="absolute z-50 mt-1 w-full min-w-72 overflow-hidden rounded-lg border border-border bg-popover shadow-md">
          <div className="max-h-96 overflow-y-auto p-1">
            {isLoading ? (
              <div className="flex items-center justify-center py-6">
                <Loader2 className="size-4 animate-spin text-muted-foreground" />
              </div>
            ) : !hasResults ? (
              <p className="px-2 py-4 text-center text-sm text-muted-foreground">No matching results.</p>
            ) : (
              <>
                {results.leads.length > 0 && (
                  <div className="py-1">
                    <p className="px-2 py-1 text-xs font-medium text-muted-foreground">Leads</p>
                    {results.leads.map((lead) => (
                      <button
                        key={lead.id}
                        type="button"
                        className="block w-full rounded-md px-2 py-1.5 text-left text-sm hover:bg-accent hover:text-accent-foreground"
                        onClick={() => go(`/leads/${lead.id}`)}
                      >
                        {lead.first_name} {lead.last_name}
                      </button>
                    ))}
                  </div>
                )}

                {results.customers.length > 0 && (
                  <div className="py-1">
                    <p className="px-2 py-1 text-xs font-medium text-muted-foreground">Customers</p>
                    {results.customers.map((customer) => (
                      <button
                        key={customer.id}
                        type="button"
                        className="block w-full rounded-md px-2 py-1.5 text-left text-sm hover:bg-accent hover:text-accent-foreground"
                        onClick={() => go(`/customers/${customer.id}`)}
                      >
                        {customer.company || customer.contact_name}
                      </button>
                    ))}
                  </div>
                )}

                {results.tasks.length > 0 && (
                  <div className="py-1">
                    <p className="px-2 py-1 text-xs font-medium text-muted-foreground">Tasks</p>
                    {results.tasks.map((task) => (
                      <button
                        key={task.id}
                        type="button"
                        className="block w-full rounded-md px-2 py-1.5 text-left text-sm hover:bg-accent hover:text-accent-foreground"
                        onClick={() => go('/tasks')}
                      >
                        {task.title}
                      </button>
                    ))}
                  </div>
                )}
              </>
            )}
          </div>
        </div>
      )}
    </div>
  )
}
