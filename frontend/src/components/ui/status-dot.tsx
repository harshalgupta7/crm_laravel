import { cn } from "@/lib/utils"

function StatusDot({ className }: { className?: string }) {
  return <span className={cn("size-2 shrink-0 rounded-full", className)} />
}

export { StatusDot }
