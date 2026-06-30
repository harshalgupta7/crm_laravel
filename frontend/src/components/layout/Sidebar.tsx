import { NavLink } from 'react-router-dom'
import { Activity, Building2, LayoutDashboard, ListChecks, Users } from 'lucide-react'
import { cn } from '@/lib/utils'

const NAV_ITEMS = [
  { to: '/', label: 'Dashboard', icon: LayoutDashboard, end: true },
  { to: '/leads', label: 'Leads', icon: Users, end: false },
  { to: '/tasks', label: 'Tasks', icon: ListChecks, end: false },
  { to: '/customers', label: 'Customers', icon: Building2, end: false },
  { to: '/activities', label: 'Activities', icon: Activity, end: false },
]

export function Sidebar() {
  return (
    <aside className="hidden w-64 shrink-0 flex-col border-r border-sidebar-border bg-sidebar md:flex">
      <div className="flex h-14 items-center gap-2 border-b border-sidebar-border px-5">
        <div className="flex size-7 shrink-0 items-center justify-center rounded-md bg-brand text-sm font-semibold text-brand-foreground">
          C
        </div>
        <span className="text-sm font-semibold tracking-tight text-sidebar-foreground">CRM</span>
      </div>
      <nav className="flex-1 space-y-0.5 p-3">
        {NAV_ITEMS.map((item) => (
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
      </nav>
    </aside>
  )
}
