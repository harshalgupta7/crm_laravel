import { createBrowserRouter } from 'react-router-dom'
import { AppLayout } from '@/components/layout/AppLayout'
import { ProtectedRoute } from '@/components/auth/ProtectedRoute'
import { LoginPage } from '@/pages/LoginPage'
import { DashboardPage } from '@/pages/DashboardPage'
import { LeadsPage } from '@/pages/LeadsPage'
import { LeadDetailPage } from '@/pages/LeadDetailPage'
import { ActivitiesPage } from '@/pages/ActivitiesPage'
import { TasksPage } from '@/pages/TasksPage'
import { CustomersPage } from '@/pages/CustomersPage'
import { CustomerDetailPage } from '@/pages/CustomerDetailPage'

export const router = createBrowserRouter([
  {
    path: '/login',
    element: <LoginPage />,
  },
  {
    path: '/',
    element: (
      <ProtectedRoute>
        <AppLayout />
      </ProtectedRoute>
    ),
    children: [
      { index: true, element: <DashboardPage /> },
      { path: 'leads', element: <LeadsPage /> },
      { path: 'leads/:id', element: <LeadDetailPage /> },
      { path: 'tasks', element: <TasksPage /> },
      { path: 'customers', element: <CustomersPage /> },
      { path: 'customers/:id', element: <CustomerDetailPage /> },
      { path: 'activities', element: <ActivitiesPage /> },
    ],
  },
])
