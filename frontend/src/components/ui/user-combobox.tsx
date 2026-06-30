import { Combobox } from '@/components/ui/combobox'
import { fetchUsers } from '@/api/users'
import type { UserSummary } from '@/types/user'

interface UserComboboxProps {
  value: UserSummary | null
  onChange: (user: UserSummary | null) => void
  placeholder?: string
  unassignedLabel?: string
  invalid?: boolean
  disabled?: boolean
}

/**
 * Searchable user picker backed by GET /users. Stores only the selected
 * user's id (via onChange), shared between task assignment and lead assignment.
 */
export function UserCombobox({
  value,
  onChange,
  placeholder = 'Search users...',
  unassignedLabel,
  invalid,
  disabled,
}: UserComboboxProps) {
  return (
    <Combobox<UserSummary>
      value={value}
      onChange={onChange}
      fetchItems={(search) => fetchUsers({ search: search || undefined }).then(({ data }) => data.data)}
      getId={(user) => user.id}
      getLabel={(user) => user.name}
      placeholder={placeholder}
      searchPlaceholder="Search by name..."
      emptyLabel="No users found."
      unassignedLabel={unassignedLabel}
      invalid={invalid}
      disabled={disabled}
    />
  )
}
