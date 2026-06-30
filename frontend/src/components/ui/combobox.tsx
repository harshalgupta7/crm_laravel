import { useEffect, useRef, useState } from 'react'
import { Check, ChevronsUpDown, Loader2, X } from 'lucide-react'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import { useDebouncedValue } from '@/hooks/useDebouncedValue'
import { cn } from '@/lib/utils'

interface ComboboxProps<T> {
  value: T | null
  onChange: (item: T | null) => void
  fetchItems: (search: string) => Promise<T[]>
  getId: (item: T) => number
  getLabel: (item: T) => string
  getSecondaryLabel?: (item: T) => string | null | undefined
  placeholder?: string
  searchPlaceholder?: string
  emptyLabel?: string
  unassignedLabel?: string
  invalid?: boolean
  disabled?: boolean
}

/**
 * Generic searchable, debounced, keyboard-navigable autocomplete used to pick
 * a single related entity (user, lead, or customer) by free-text search.
 * Stores only the selected item via onChange — callers decide what id to send.
 */
export function Combobox<T>({
  value,
  onChange,
  fetchItems,
  getId,
  getLabel,
  getSecondaryLabel,
  placeholder = 'Search...',
  searchPlaceholder = 'Type to search...',
  emptyLabel = 'No results found.',
  unassignedLabel,
  invalid,
  disabled,
}: ComboboxProps<T>) {
  const [open, setOpen] = useState(false)
  const [search, setSearch] = useState('')
  const debouncedSearch = useDebouncedValue(search, 300)
  const [items, setItems] = useState<T[]>([])
  const [isLoading, setIsLoading] = useState(false)
  const [highlightedIndex, setHighlightedIndex] = useState(-1)
  const containerRef = useRef<HTMLDivElement>(null)

  useEffect(() => {
    if (!open) return

    let active = true
    setIsLoading(true)

    fetchItems(debouncedSearch)
      .then((results) => {
        if (active) {
          setItems(results)
          setHighlightedIndex(results.length > 0 ? 0 : -1)
        }
      })
      .catch(() => {
        if (active) setItems([])
      })
      .finally(() => {
        if (active) setIsLoading(false)
      })

    return () => {
      active = false
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [open, debouncedSearch])

  useEffect(() => {
    function handleClickOutside(event: MouseEvent) {
      if (containerRef.current && !containerRef.current.contains(event.target as Node)) {
        setOpen(false)
      }
    }

    function handleEscape(event: KeyboardEvent) {
      if (event.key === 'Escape') setOpen(false)
    }

    if (open) {
      document.addEventListener('mousedown', handleClickOutside)
      document.addEventListener('keydown', handleEscape)
    }

    return () => {
      document.removeEventListener('mousedown', handleClickOutside)
      document.removeEventListener('keydown', handleEscape)
    }
  }, [open])

  function selectItem(item: T) {
    onChange(item)
    setOpen(false)
    setSearch('')
  }

  function handleKeyDown(event: React.KeyboardEvent) {
    if (event.key === 'ArrowDown') {
      event.preventDefault()
      setHighlightedIndex((index) => Math.min(index + 1, items.length - 1))
    } else if (event.key === 'ArrowUp') {
      event.preventDefault()
      setHighlightedIndex((index) => Math.max(index - 1, 0))
    } else if (event.key === 'Enter') {
      event.preventDefault()
      const item = items[highlightedIndex]
      if (item) selectItem(item)
    }
  }

  return (
    <div ref={containerRef} className="relative">
      <Button
        type="button"
        variant="outline"
        disabled={disabled}
        aria-invalid={invalid}
        className="w-full justify-between font-normal"
        onClick={() => setOpen((isOpen) => !isOpen)}
      >
        <span className={cn('truncate', !value && 'text-muted-foreground')}>
          {value ? getLabel(value) : (unassignedLabel ?? placeholder)}
        </span>
        <span className="flex items-center gap-1">
          {value && (
            <X
              className="size-3.5 text-muted-foreground hover:text-foreground"
              onClick={(event) => {
                event.stopPropagation()
                onChange(null)
              }}
            />
          )}
          <ChevronsUpDown className="size-3.5 text-muted-foreground" />
        </span>
      </Button>

      {open && (
        <div className="absolute z-50 mt-1 w-full overflow-hidden rounded-lg border border-border bg-popover shadow-md">
          <div className="border-b border-border p-1.5">
            <Input
              autoFocus
              value={search}
              onChange={(event) => setSearch(event.target.value)}
              onKeyDown={handleKeyDown}
              placeholder={searchPlaceholder}
            />
          </div>
          <div className="max-h-56 overflow-y-auto p-1">
            {isLoading ? (
              <div className="flex items-center justify-center py-4">
                <Loader2 className="size-4 animate-spin text-muted-foreground" />
              </div>
            ) : items.length === 0 ? (
              <p className="px-2 py-3 text-center text-sm text-muted-foreground">{emptyLabel}</p>
            ) : (
              items.map((item, index) => (
                <button
                  key={getId(item)}
                  type="button"
                  className={cn(
                    'flex w-full items-center justify-between gap-2 rounded-md px-2 py-1.5 text-left text-sm hover:bg-accent hover:text-accent-foreground',
                    index === highlightedIndex && 'bg-accent text-accent-foreground',
                  )}
                  onMouseEnter={() => setHighlightedIndex(index)}
                  onClick={() => selectItem(item)}
                >
                  <span className="min-w-0">
                    <span className="block truncate">{getLabel(item)}</span>
                    {getSecondaryLabel?.(item) && (
                      <span className="block truncate text-xs text-muted-foreground">{getSecondaryLabel(item)}</span>
                    )}
                  </span>
                  {value && getId(value) === getId(item) && <Check className="size-4 shrink-0" />}
                </button>
              ))
            )}
          </div>
        </div>
      )}
    </div>
  )
}
