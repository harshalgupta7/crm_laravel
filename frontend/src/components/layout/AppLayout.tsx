import { Outlet } from 'react-router-dom'
import { Sidebar } from '@/components/layout/Sidebar'
import { Navbar } from '@/components/layout/Navbar'

export function AppLayout() {
  return (
    <div className="flex h-screen gap-3 bg-background p-3">
      <Sidebar />
      <div className="flex flex-1 flex-col overflow-hidden rounded-2xl shadow-xs ring-1 ring-border">
        <Navbar />
        <main className="flex-1 overflow-y-auto bg-background p-6 md:p-8">
          <Outlet />
        </main>
      </div>
    </div>
  )
}
