import { Combobox } from '@/components/ui/combobox'
import { fetchLeads } from '@/api/leads'
import type { Lead } from '@/types/lead'

export interface LeadComboboxItem {
  id: number
  first_name: string
  last_name: string
  company: string | null
  email: string
}

interface LeadComboboxProps {
  value: LeadComboboxItem | null
  onChange: (lead: LeadComboboxItem | null) => void
  placeholder?: string
  invalid?: boolean
  disabled?: boolean
}

function toComboboxItem(lead: Lead): LeadComboboxItem {
  return { id: lead.id, first_name: lead.first_name, last_name: lead.last_name, company: lead.company, email: lead.email }
}

/**
 * Searchable lead picker backed by GET /leads?search= (matches name, company, or email).
 */
export function LeadCombobox({ value, onChange, placeholder = 'Search leads...', invalid, disabled }: LeadComboboxProps) {
  return (
    <Combobox<LeadComboboxItem>
      value={value}
      onChange={onChange}
      fetchItems={(search) =>
        fetchLeads({ search: search || undefined, per_page: 20 }).then(({ data }) => data.data.map(toComboboxItem))
      }
      getId={(lead) => lead.id}
      getLabel={(lead) => `${lead.first_name} ${lead.last_name}`}
      getSecondaryLabel={(lead) => lead.company || lead.email}
      placeholder={placeholder}
      searchPlaceholder="Search by name, company or email..."
      emptyLabel="No leads found."
      invalid={invalid}
      disabled={disabled}
    />
  )
}
