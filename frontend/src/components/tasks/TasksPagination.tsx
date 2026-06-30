import { ChevronLeft, ChevronRight } from 'lucide-react'
import { Button } from '@/components/ui/button'
import type { PaginationMeta } from '@/types/pagination'

interface TasksPaginationProps {
  meta: PaginationMeta
  onPageChange: (page: number) => void
}

export function TasksPagination({ meta, onPageChange }: TasksPaginationProps) {
  if (meta.last_page <= 1) return null

  return (
    <div className="flex flex-col gap-3 sm:flex-row sm:items-center sm:justify-between">
      <p className="text-sm text-muted-foreground">
        Showing <span className="font-medium text-foreground">{meta.from ?? 0}</span>–
        <span className="font-medium text-foreground">{meta.to ?? 0}</span> of{' '}
        <span className="font-medium text-foreground">{meta.total}</span>
      </p>
      <div className="flex items-center gap-1.5">
        <Button
          variant="outline"
          size="icon-sm"
          aria-label="Previous page"
          disabled={meta.current_page <= 1}
          onClick={() => onPageChange(meta.current_page - 1)}
        >
          <ChevronLeft className="size-4" />
        </Button>
        <span className="min-w-24 text-center text-sm font-medium text-foreground tabular-nums">
          Page {meta.current_page} of {meta.last_page}
        </span>
        <Button
          variant="outline"
          size="icon-sm"
          aria-label="Next page"
          disabled={meta.current_page >= meta.last_page}
          onClick={() => onPageChange(meta.current_page + 1)}
        >
          <ChevronRight className="size-4" />
        </Button>
      </div>
    </div>
  )
}
