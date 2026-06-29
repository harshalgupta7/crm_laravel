<?php

namespace App\Http\Requests\Task;

use App\Enums\TaskPriority;
use App\Enums\TaskStatus;
use App\Models\Task;
use Illuminate\Contracts\Validation\ValidationRule;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;
use Illuminate\Validation\Validator;

class UpdateTaskRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
        return [
            'user_id' => ['sometimes', 'integer', 'exists:users,id'],
            'customer_id' => ['sometimes', 'nullable', 'integer', 'exists:customers,id'],
            'lead_id' => ['sometimes', 'nullable', 'integer', 'exists:leads,id'],
            'title' => ['sometimes', 'string', 'max:255'],
            'description' => ['sometimes', 'nullable', 'string'],
            'priority' => ['sometimes', Rule::enum(TaskPriority::class)],
            'status' => ['sometimes', Rule::enum(TaskStatus::class)],
            'due_date' => ['sometimes', 'date'],
            'reminder_at' => ['sometimes', 'nullable', 'date'],
        ];
    }

    /**
     * Configure the validator instance.
     */
    public function withValidator(Validator $validator): void
    {
        $validator->after(function (Validator $validator) {
            /** @var Task $task */
            $task = $this->route('task');

            $leadId = $this->has('lead_id') ? $this->input('lead_id') : $task->lead_id;
            $customerId = $this->has('customer_id') ? $this->input('customer_id') : $task->customer_id;

            if (! $leadId && ! $customerId) {
                $validator->errors()->add('lead_id', 'A task must belong to either a lead or a customer.');
            }
        });
    }
}
