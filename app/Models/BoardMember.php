<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class BoardMember extends Model
{
    protected $table = "board_members";

    public function board() {
    	return $this->belongsTo('App\Models\Board', 'boards_id', 'id');
    }
}

