<?php

namespace App\Support;

use Illuminate\Support\Facades\DB;

class Search
{
    /**
     * Returns the case-insensitive LIKE operator for the active database driver.
     * PostgreSQL's LIKE is case-sensitive, so ILIKE is used there; MySQL and
     * SQLite already compare LIKE case-insensitively for ASCII text.
     */
    public static function operator(): string
    {
        return DB::getDriverName() === 'pgsql' ? 'ilike' : 'like';
    }
}
