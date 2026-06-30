<?php

namespace App\Http\Resources;

use App\Models\Customer;
use App\Models\Lead;
use App\Models\Task;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

/**
 * @mixin \App\Models\Activity
 */
class ActivityResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'id' => $this->id,
            'action' => $this->action,
            'subject_type' => $this->subject_type,
            'subject_id' => $this->subject_id,
            'subject' => $this->resolveSubject(),
            'description' => $this->description,
            'user' => $this->whenLoaded('user', fn () => [
                'id' => $this->user->id,
                'name' => $this->user->name,
                'email' => $this->user->email,
            ]),
            'created_at' => $this->created_at,
        ];
    }

    /**
     * Resolve a lightweight, clickable reference to the activity's subject.
     *
     * @return array<string, mixed>|null
     */
    private function resolveSubject(): ?array
    {
        $modelClass = $this->subject_type;

        if (! in_array($modelClass, [Lead::class, Customer::class, Task::class], true)) {
            return null;
        }

        $model = $modelClass::find($this->subject_id);

        if (! $model) {
            return null;
        }

        return match ($modelClass) {
            Lead::class => self::leadSubject($model),
            Customer::class => self::customerSubject($model),
            Task::class => self::taskSubject($model),
        };
    }

    /**
     * @return array<string, mixed>
     */
    private static function leadSubject(Lead $lead): array
    {
        return ['type' => 'lead', 'id' => $lead->id, 'label' => trim("{$lead->first_name} {$lead->last_name}")];
    }

    /**
     * @return array<string, mixed>
     */
    private static function customerSubject(Customer $customer): array
    {
        return ['type' => 'customer', 'id' => $customer->id, 'label' => $customer->company ?: $customer->contact_name];
    }

    /**
     * @return array<string, mixed>
     */
    private static function taskSubject(Task $task): array
    {
        return ['type' => 'task', 'id' => $task->id, 'label' => $task->title];
    }
}
