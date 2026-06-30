import { useState } from 'react'
import { NavLink, useNavigate } from 'react-router-dom'
import { toast } from 'sonner'
import {
  Activity,
  Building2,
  Calendar,
  GitBranch,
  LayoutDashboard,
  ListChecks,
  LogOut,
  Loader2,
  Users,
} from 'lucide-react'
import { useAuth } from '@/context/AuthContext'
import { getApiErrorMessage } from '@/lib/api-error'
import { getInitials } from '@/lib/format'
import { cn } from '@/lib/utils'

const MAIN_NAV_ITEMS = [
  { to: '/', label: 'Dashboard', icon: LayoutDashboard, end: true },
  { to: '/leads', label: 'Leads', icon: Users, end: false },
  { to: '/customers', label: 'Customers', icon: Building2, end: false },
  { to: '/tasks', label: 'Tasks', icon: ListChecks, end: false },
  { to: '/activities', label: 'Activities', icon: Activity, end: false },
]

const WORKSPACE_NAV_ITEMS = [
  { label: 'Calendar', icon: Calendar },
  { label: 'Pipeline', icon: GitBranch },
]

export function Sidebar() {
  const { user, logout } = useAuth()
  const navigate = useNavigate()
  const [isLoggingOut, setIsLoggingOut] = useState(false)

  const handleLogout = async () => {
    setIsLoggingOut(true)

    try {
      await logout()
      toast.success('Logged out successfully.')
    } catch (error) {
      toast.error(getApiErrorMessage(error, 'Unable to log out. Please try again.'))
    } finally {
      setIsLoggingOut(false)
      navigate('/login', { replace: true })
    }
  }

  return (
    <aside className="hidden w-72 shrink-0 flex-col rounded-2xl bg-sidebar shadow-xs ring-1 ring-sidebar-border md:flex">
      <div className="flex h-16 items-center gap-2.5 px-5">
        <div className="flex size-8 shrink-0 items-center justify-center rounded-lg bg-brand text-sm font-semibold text-brand-foreground">
          C
        </div>
        <div className="min-w-0 leading-tight">
          <p className="truncate text-sm font-semibold tracking-tight text-sidebar-foreground">CRM</p>
          <p className="truncate text-xs text-sidebar-muted-foreground">Sales Workspace</p>
        </div>
      </div>

      <nav className="flex-1 space-y-6 overflow-y-auto px-3 pb-3">
        <div className="space-y-0.5">
          <p className="px-3 pb-1.5 text-[11px] font-semibold tracking-wider text-sidebar-muted-foreground/80 uppercase">
            Main
          </p>
          {MAIN_NAV_ITEMS.map((item) => (
            <NavLink
              key={item.to}
              to={item.to}
              end={item.end}
              className={({ isActive }) =>
                cn(
                  'relative flex items-center gap-2.5 rounded-lg px-3 py-2 text-sm font-medium text-sidebar-muted-foreground transition-colors duration-150 before:absolute before:inset-y-1.5 before:-left-3 before:w-1 before:rounded-full before:bg-transparent before:transition-colors before:duration-150 hover:bg-sidebar-foreground/5 hover:text-sidebar-foreground',
                  isActive &&
                    'bg-brand text-brand-foreground shadow-sm before:bg-brand-foreground/70 hover:bg-brand hover:text-brand-foreground [&_svg]:text-brand-foreground',
                )
              }
            >
              <item.icon className="size-4 shrink-0" />
              {item.label}
            </NavLink>
          ))}
        </div>

        <div className="space-y-0.5">
          <p className="px-3 pb-1.5 text-[11px] font-semibold tracking-wider text-sidebar-muted-foreground/80 uppercase">
            Workspace
          </p>
          {WORKSPACE_NAV_ITEMS.map((item) => (
            <div
              key={item.label}
              aria-disabled="true"
              className="flex cursor-not-allowed items-center gap-2.5 rounded-lg px-3 py-2 text-sm font-medium text-sidebar-muted-foreground/60"
            >
              <item.icon className="size-4 shrink-0" />
              <span className="flex-1">{item.label}</span>
              <span className="rounded-full bg-sidebar-foreground/5 px-1.5 py-0.5 text-[10px] font-medium text-sidebar-muted-foreground/80">
                Soon
              </span>
            </div>
          ))}
        </div>
      </nav>

      <div className="border-t border-sidebar-border p-3">
        <div className="flex items-center gap-2.5 rounded-lg px-2 py-2">
          <div className="flex size-8 shrink-0 items-center justify-center rounded-full bg-brand/10 text-xs font-semibold text-brand">
            {getInitials(user?.name)}
          </div>
          <div className="min-w-0 flex-1 leading-tight">
            <p className="truncate text-sm font-medium text-sidebar-foreground">{user?.name ?? 'Loading…'}</p>
            <p className="truncate text-xs text-sidebar-muted-foreground">{user?.role.name ?? '—'}</p>
          </div>
        </div>
        <button
          type="button"
          onClick={handleLogout}
          disabled={isLoggingOut}
          className="mt-1 flex w-full cursor-pointer items-center gap-2.5 rounded-lg px-3 py-2 text-sm font-medium text-sidebar-muted-foreground transition-colors duration-150 hover:bg-rose-50 hover:text-rose-600 disabled:pointer-events-none disabled:opacity-50 dark:hover:bg-rose-500/15 dark:hover:text-rose-400"
        >
          {isLoggingOut ? <Loader2 className="size-4 shrink-0 animate-spin" /> : <LogOut className="size-4 shrink-0" />}
          Logout
        </button>
      </div>
    </aside>
  )
}
