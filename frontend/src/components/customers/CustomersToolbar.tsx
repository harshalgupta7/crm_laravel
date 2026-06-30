import { Search, RefreshCw } from 'lucide-react'
import { Button } from '@/components/ui/button'
import { Card, CardContent } from '@/components/ui/card'
import { Input } from '@/components/ui/input'
import { cn } from '@/lib/utils'

interface CustomersToolbarProps {
  search: string
  onSearchChange: (value: string) => void
  onRefresh: () => void
  isLoading: boolean
}

export function CustomersToolbar({ search, onSearchChange, onRefresh, isLoading }: CustomersToolbarProps) {
  return (
    <Card size="sm">
      <CardContent className="flex flex-col gap-3 sm:flex-row sm:items-center sm:justify-between">
        <div className="relative w-full sm:max-w-xs">
          <Search className="pointer-events-none absolute left-2.5 top-1/2 size-4 -translate-y-1/2 text-muted-foreground" />
          <Input
            value={search}
            onChange={(event) => onSearchChange(event.target.value)}
            placeholder="Search by name, company or email..."
            className="pl-8"
          />
        </div>

        <Button variant="outline" size="sm" onClick={onRefresh} disabled={isLoading}>
          <RefreshCw className={cn('size-4', isLoading && 'animate-spin')} />
          Refresh
        </Button>
      </CardContent>
    </Card>
  )
}
