import { Building2, Eye, SearchX } from 'lucide-react'
import { Link } from 'react-router-dom'
import { Button } from '@/components/ui/button'
import { Card, CardContent } from '@/components/ui/card'
import { Skeleton } from '@/components/ui/skeleton'
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from '@/components/ui/table'
import { formatExactTimestamp, formatRelativeTime } from '@/lib/format'
import type { Customer } from '@/types/customer'

const COLUMN_COUNT = 8

interface CustomersTableProps {
  customers: Customer[]
  isLoading: boolean
  error: string | null
  hasActiveFilters?: boolean
  onClearFilters?: () => void
}

export function CustomersTable({
  customers,
  isLoading,
  error,
  hasActiveFilters,
  onClearFilters,
}: CustomersTableProps) {
  return (
    <Card className="overflow-hidden py-0">
      <CardContent className="min-w-0 overflow-x-auto px-0 py-0">
        <Table>
          <TableHeader>
            <TableRow>
              <TableHead>Customer</TableHead>
              <TableHead>Company</TableHead>
              <TableHead>Email</TableHead>
              <TableHead>Phone</TableHead>
              <TableHead>Converted From Lead</TableHead>
              <TableHead>Converted Date</TableHead>
              <TableHead>Notes Count</TableHead>
              <TableHead className="text-right">Actions</TableHead>
            </TableRow>
          </TableHeader>
          <TableBody>
            {isLoading ? (
              Array.from({ length: 5 }).map((_, index) => (
                <TableRow key={index}>
                  {Array.from({ length: COLUMN_COUNT }).map((__, cellIndex) => (
                    <TableCell key={cellIndex}>
                      <Skeleton className="h-4 w-full max-w-28" />
                    </TableCell>
                  ))}
                </TableRow>
              ))
            ) : error ? (
              <TableRow>
                <TableCell colSpan={COLUMN_COUNT} className="py-10 text-center text-sm text-destructive">
                  {error}
                </TableCell>
              </TableRow>
            ) : customers.length === 0 ? (
              <TableRow>
                <TableCell colSpan={COLUMN_COUNT} className="py-14">
                  {hasActiveFilters ? (
                    <div className="flex flex-col items-center gap-3 text-center">
                      <div className="flex size-12 items-center justify-center rounded-full bg-muted text-muted-foreground">
                        <SearchX className="size-5" />
                      </div>
                      <div className="space-y-1">
                        <p className="text-sm font-medium text-foreground">No results match your filters.</p>
                      </div>
                      {onClearFilters && (
                        <Button size="sm" variant="outline" onClick={onClearFilters}>
                          Clear filters
                        </Button>
                      )}
                    </div>
                  ) : (
                    <div className="flex flex-col items-center gap-3 text-center">
                      <div className="flex size-12 items-center justify-center rounded-full bg-emerald-50 text-emerald-600 dark:bg-emerald-500/15 dark:text-emerald-400">
                        <Building2 className="size-5" />
                      </div>
                      <div className="space-y-1">
                        <p className="text-sm font-medium text-foreground">No customers yet</p>
                        <p className="text-sm text-muted-foreground">
                          Convert a won lead to see it appear here.
                        </p>
                      </div>
                      <Button variant="outline" size="sm" asChild>
                        <Link to="/leads">
                          <Eye className="size-4" />
                          Go to Leads
                        </Link>
                      </Button>
                    </div>
                  )}
                </TableCell>
              </TableRow>
            ) : (
              customers.map((customer) => (
                <TableRow key={customer.id}>
                  <TableCell className="font-medium text-foreground">{customer.contact_name}</TableCell>
                  <TableCell className="text-muted-foreground">{customer.company || '—'}</TableCell>
                  <TableCell className="text-muted-foreground">{customer.email}</TableCell>
                  <TableCell className="text-muted-foreground">{customer.phone || '—'}</TableCell>
                  <TableCell className="text-muted-foreground">
                    {customer.lead ? (
                      <Link
                        to={`/leads/${customer.lead.id}`}
                        className="text-foreground underline-offset-2 hover:underline"
                      >
                        {customer.lead.first_name} {customer.lead.last_name}
                      </Link>
                    ) : (
                      '—'
                    )}
                  </TableCell>
                  <TableCell className="text-muted-foreground" title={formatExactTimestamp(customer.created_at)}>
                    {formatRelativeTime(customer.created_at) || '—'}
                  </TableCell>
                  <TableCell className="text-muted-foreground">{customer.notes?.length ?? 0}</TableCell>
                  <TableCell className="text-right">
                    <Button variant="ghost" size="sm" asChild>
                      <Link to={`/customers/${customer.id}`}>
                        <Eye className="size-4" />
                        View
                      </Link>
                    </Button>
                  </TableCell>
                </TableRow>
              ))
            )}
          </TableBody>
        </Table>
      </CardContent>
    </Card>
  )
}
