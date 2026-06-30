<?php

namespace App\Services;

use App\Enums\LeadStatus;
use App\Models\Customer;
use App\Models\Lead;
use App\Models\Note;
use App\Models\User;
use App\Support\Search;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\ValidationException;

class CustomerService
{
    public function __construct(private readonly ActivityService $activityService)
    {
    }

    /**
     * Convert a lead into a customer.
     */
    public function convertLead(Lead $lead, User $actor): Customer
    {
        return DB::transaction(function () use ($lead, $actor) {
            $lead = Lead::query()->lockForUpdate()->findOrFail($lead->id);

            if ($lead->customer()->exists()) {
                throw ValidationException::withMessages([
                    'lead' => 'This lead has already been converted.',
                ]);
            }

            $customer = Customer::create([
                'lead_id' => $lead->id,
                'company' => $lead->company,
                'contact_name' => trim("{$lead->first_name} {$lead->last_name}"),
                'email' => $lead->email,
                'phone' => $lead->phone,
            ]);

            $lead->update(['status' => LeadStatus::WON]);

            $this->activityService->log($actor, 'lead.converted', $customer, "Converted lead {$lead->first_name} {$lead->last_name} into a customer");

            return $customer->load(['lead', 'notes']);
        });
    }

    /**
     * Get a paginated list of customers.
     *
     * @param  array<string, mixed>  $filters
     */
    public function list(array $filters): LengthAwarePaginator
    {
        $query = Customer::query()->with(['lead', 'notes']);

        if ($search = $filters['search'] ?? null) {
            $operator = Search::operator();
            $query->where(function ($query) use ($search, $operator) {
                $query->where('contact_name', $operator, "%{$search}%")
                    ->orWhere('company', $operator, "%{$search}%")
                    ->orWhere('email', $operator, "%{$search}%")
                    ->orWhere('phone', $operator, "%{$search}%");
            });
        }

        return $query->latest()->paginate($filters['per_page'] ?? 15);
    }

    /**
     * Get the notes for a customer.
     *
     * @return Collection<int, Note>
     */
    public function listNotes(Customer $customer): Collection
    {
        return $customer->notes()->with('user')->latest()->get();
    }

    /**
     * Add a note to a customer.
     *
     * @param  array<string, mixed>  $data
     */
    public function addNote(Customer $customer, array $data, User $user): Note
    {
        $note = $customer->notes()->create([
            ...$data,
            'user_id' => $user->id,
        ]);

        $this->activityService->log($user, 'customer.note_added', $customer, "Added a note to customer {$customer->contact_name}");

        return $note->load('user');
    }
}
