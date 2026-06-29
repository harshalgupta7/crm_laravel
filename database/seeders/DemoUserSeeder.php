<?php

namespace Database\Seeders;

use App\Models\Role;
use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class DemoUserSeeder extends Seeder
{
    /**
     * Seed one demo user per role so evaluators can log in immediately.
     */
    public function run(): void
    {
        $accounts = [
            ['name' => 'Alice Admin', 'email' => 'admin@example.com', 'role' => Role::ADMIN],
            ['name' => 'Mark Manager', 'email' => 'manager@example.com', 'role' => Role::SALES_MANAGER],
            ['name' => 'Eve Executive', 'email' => 'executive@example.com', 'role' => Role::SALES_EXECUTIVE],
        ];

        foreach ($accounts as $account) {
            $role = Role::where('slug', $account['role'])->firstOrFail();

            User::updateOrCreate(
                ['email' => $account['email']],
                [
                    'name' => $account['name'],
                    'password' => Hash::make('password'),
                    'role_id' => $role->id,
                    'email_verified_at' => now(),
                ],
            );
        }
    }
}
