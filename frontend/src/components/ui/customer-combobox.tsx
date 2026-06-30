import { Combobox } from '@/components/ui/combobox'
import { fetchCustomers } from '@/api/customers'
import type { Customer } from '@/types/customer'

export interface CustomerComboboxItem {
  id: number
  company: string | null
  contact_name: string
  email: string
}

interface CustomerComboboxProps {
  value: CustomerComboboxItem | null
  onChange: (customer: CustomerComboboxItem | null) => void
  placeholder?: string
  invalid?: boolean
  disabled?: boolean
}

function toComboboxItem(customer: Customer): CustomerComboboxItem {
  return { id: customer.id, company: customer.company, contact_name: customer.contact_name, email: customer.email }
}

/**
 * Searchable customer picker backed by GET /customers?search= (matches name, company, email, or phone).
 */
export function CustomerCombobox({
  value,
  onChange,
  placeholder = 'Search customers...',
  invalid,
  disabled,
}: CustomerComboboxProps) {
  return (
    <Combobox<CustomerComboboxItem>
      value={value}
      onChange={onChange}
      fetchItems={(search) =>
        fetchCustomers({ search: search || undefined, per_page: 20 }).then(({ data }) => data.data.map(toComboboxItem))
      }
      getId={(customer) => customer.id}
      getLabel={(customer) => customer.company || customer.contact_name}
      getSecondaryLabel={(customer) => (customer.company ? customer.contact_name : customer.email)}
      placeholder={placeholder}
      searchPlaceholder="Search by name, company or email..."
      emptyLabel="No customers found."
      invalid={invalid}
      disabled={disabled}
    />
  )
}
