<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Ticket extends Model
{
    protected $table = "tickets";

    public function boardlist() {
    	return $this->belongsTo(BoardList::class, 'board_list_id', 'id');
    }

    public function card() {
    	return $this->hasMany(Card::class, 'ticket_id');
    }
}
