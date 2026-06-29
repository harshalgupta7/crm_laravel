<?php

namespace App\Services;

use App\Enums\LeadStatus;
use App\Enums\TaskStatus;
use App\Models\Customer;
use App\Models\Task;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\DB;

class DashboardService
{
    /**
     * Build the aggregated dashboard statistics.
     *
     * @return array<string, mixed>
     */
    public function getStats(): array
    {
        $leadsByStatus = DB::table('leads')
            ->selectRaw('status, count(*) as total')
            ->groupBy('status')
            ->pluck('total', 'status');

        $totalLeads = $leadsByStatus->sum();
        $totalCustomers = Customer::query()->count();

        $today = Carbon::today()->toDateString();

        $taskStats = Task::query()
            ->selectRaw(
                "sum(case when due_date = ? and status != ? then 1 else 0 end) as todays_follow_ups,
                sum(case when due_date < ? and status != ? then 1 else 0 end) as overdue_tasks",
                [$today, TaskStatus::COMPLETED->value, $today, TaskStatus::COMPLETED->value]
            )
            ->first();

        return [
            'total_leads' => $totalLeads,
            'total_customers' => $totalCustomers,
            'todays_follow_ups' => (int) $taskStats->todays_follow_ups,
            'overdue_tasks' => (int) $taskStats->overdue_tasks,
            'leads_by_status' => $this->formatLeadsByStatus($leadsByStatus),
            'conversion_rate' => $this->calculateConversionRate($totalLeads, $totalCustomers),
        ];
    }

    /**
     * Ensure every LeadStatus case is represented, defaulting missing ones to zero.
     *
     * @param  \Illuminate\Support\Collection<string, int>  $leadsByStatus
     * @return array<string, int>
     */
    private function formatLeadsByStatus($leadsByStatus): array
    {
        return collect(LeadStatus::cases())
            ->mapWithKeys(fn (LeadStatus $status) => [
                $status->value => (int) ($leadsByStatus[$status->value] ?? 0),
            ])
            ->all();
    }

    private function calculateConversionRate(int $totalLeads, int $totalCustomers): float
    {
        if ($totalLeads === 0) {
            return 0;
        }

        return round(($totalCustomers / $totalLeads) * 100, 2);
    }
}
