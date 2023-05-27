<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Board extends Model
{
    protected $table = "boards";

    public function lists() {
    	return $this->hasMany(BoardList::class, 'boards_id');
    }
}
