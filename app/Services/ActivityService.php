<?php

namespace App\Services;

use App\Models\Activity;
use App\Models\User;
use Illuminate\Database\Eloquent\Model;

class ActivityService
{
    /**
     * Log an activity performed by a user on a subject model.
     */
    public function log(User $user, string $action, Model $subject, string $description): Activity
    {
        return Activity::create([
            'user_id' => $user->id,
            'action' => $action,
            'subject_type' => $subject->getMorphClass(),
            'subject_id' => $subject->getKey(),
            'description' => $description,
        ]);
    }
}
