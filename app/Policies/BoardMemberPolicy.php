<?php

namespace App\Policies;

use App\User;
use App\Models\BoardMember;
use Illuminate\Auth\Access\HandlesAuthorization;

class BoardMemberPolicy
{
    use HandlesAuthorization;

    /**
     * Determine whether the user can view the boardMember.
     *
     * @param  \App\User  $user
     * @param  \App\BoardMember  $boardMember
     * @return mixed
     */
    public function view(User $user, BoardMember $boardMember, $id)
    {
        $boardMember = BoardMember::where('boards_id', '=', $id)
                                ->where('board_members.users_id', '=', $user->id)
                                ->select('users_id')->get()->last();
        return $user->id == $boardMember->users_id;
    }

    /**
     * Determine whether the user can create boardMembers.
     *
     * @param  \App\User  $user
     * @return mixed
     */
    public function create(User $user)
    {
        //
    }

    /**
     * Determine whether the user can update the boardMember.
     *
     * @param  \App\User  $user
     * @param  \App\BoardMember  $boardMember
     * @return mixed
     */
    public function update(User $user, BoardMember $boardMember)
    {
        //
    }

    /**
     * Determine whether the user can delete the boardMember.
     *
     * @param  \App\User  $user
     * @param  \App\BoardMember  $boardMember
     * @return mixed
     */
    public function delete(User $user, BoardMember $boardMember)
    {
        //
    }
}
