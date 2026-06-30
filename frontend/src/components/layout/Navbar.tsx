import { useState } from 'react'
import { NavLink, useNavigate } from 'react-router-dom'
import { toast } from 'sonner'
import {
  Activity,
  Bell,
  Building2,
  LayoutDashboard,
  ListChecks,
  LogOut,
  Loader2,
  Menu,
  Users,
} from 'lucide-react'
import { Button } from '@/components/ui/button'
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuSeparator,
  DropdownMenuTrigger,
} from '@/components/ui/dropdown-menu'
import { GlobalSearch } from '@/components/layout/GlobalSearch'
import { useAuth } from '@/context/AuthContext'
import { getApiErrorMessage } from '@/lib/api-error'
import { cn } from '@/lib/utils'

const NAV_ITEMS = [
  { to: '/', label: 'Dashboard', icon: LayoutDashboard, end: true },
  { to: '/leads', label: 'Leads', icon: Users, end: false },
  { to: '/customers', label: 'Customers', icon: Building2, end: false },
  { to: '/tasks', label: 'Tasks', icon: ListChecks, end: false },
  { to: '/activities', label: 'Activities', icon: Activity, end: false },
]

export function Navbar() {
  const { logout } = useAuth()
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
    <header className="flex h-16 shrink-0 items-center gap-3 border-b border-border bg-card px-4 md:px-6">
      <div className="flex items-center gap-2 md:hidden">
        <DropdownMenu>
          <DropdownMenuTrigger asChild>
            <Button variant="ghost" size="icon-sm" aria-label="Open navigation menu">
              <Menu className="size-4" />
            </Button>
          </DropdownMenuTrigger>
          <DropdownMenuContent align="start">
            {NAV_ITEMS.map((item) => (
              <DropdownMenuItem key={item.to} asChild>
                <NavLink
                  to={item.to}
                  end={item.end}
                  className={({ isActive }) => cn(isActive && 'bg-brand/10 text-brand')}
                >
                  <item.icon className="size-4" />
                  {item.label}
                </NavLink>
              </DropdownMenuItem>
            ))}
            <DropdownMenuSeparator />
            <DropdownMenuItem variant="destructive" onSelect={handleLogout} disabled={isLoggingOut}>
              {isLoggingOut ? <Loader2 className="animate-spin" /> : <LogOut />}
              Logout
            </DropdownMenuItem>
          </DropdownMenuContent>
        </DropdownMenu>
        <span className="text-sm font-semibold text-foreground">CRM</span>
      </div>

      <div className="hidden flex-1 md:block">
        <GlobalSearch />
      </div>

      <div className="ml-auto flex items-center gap-3">
        <Button variant="ghost" size="icon-sm" aria-label="Notifications" className="relative">
          <Bell className="size-4" />
          <span className="absolute top-1.5 right-1.5 size-1.5 rounded-full bg-rose-500" />
        </Button>
      </div>
    </header>
  )
}
