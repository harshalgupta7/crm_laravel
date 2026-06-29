<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

/**
 * @mixin \App\Models\Customer
 */
class CustomerResource extends JsonResource
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
            'lead_id' => $this->lead_id,
            'company' => $this->company,
            'contact_name' => $this->contact_name,
            'email' => $this->email,
            'phone' => $this->phone,
            'lead' => $this->whenLoaded('lead', fn () => new LeadResource($this->lead)),
            'notes' => $this->whenLoaded('notes', fn () => NoteResource::collection($this->notes)),
            'created_at' => $this->created_at,
            'updated_at' => $this->updated_at,
        ];
    }
}
