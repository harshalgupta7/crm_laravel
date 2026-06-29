<?php

namespace Database\Seeders;

use App\Models\Role;
use Illuminate\Database\Seeder;

class RoleSeeder extends Seeder
{
    /**
     * Seed the application's roles.
     */
    public function run(): void
    {
        $roles = [
            ['name' => 'Admin', 'slug' => Role::ADMIN],
            ['name' => 'Sales Manager', 'slug' => Role::SALES_MANAGER],
            ['name' => 'Sales Executive', 'slug' => Role::SALES_EXECUTIVE],
        ];

        foreach ($roles as $role) {
            Role::updateOrCreate(['slug' => $role['slug']], $role);
        }
    }
}
