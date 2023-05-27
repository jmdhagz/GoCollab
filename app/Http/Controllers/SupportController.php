<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Board;
use App\Models\BoardList;
use App\Models\BoardMember;
use App\Models\Card;
use App\Models\CardAssignee;
use App\Models\Checklist;
use App\Models\ChecklistItem;
use App\Models\Color;
use App\Models\Label;
use App\Models\Ticket;
use App\User;

class SupportController extends Controller
{
	public function index()
	{
		$board_list = Board::with('lists')->get();
		$ticket_list = Ticket::with('boardlist', 'card')->get();
		return view('support/index', compact('board_list', 'ticket_list'));
	}

	public function postTicket(Request $request)
	{
		$ticket = new Ticket();
		$ticket -> name = $request->ticket['name'];
		$ticket -> description = $request->ticket['description'];
		$ticket -> board_list_id = $request->ticket['list_id'];
		$ticket -> date = date('Y-m-d');
		$ticket -> save();

		$card = new Card();
		$card -> board_lists_id = $request->ticket['list_id'];
		$card -> card_name = $request->ticket['name'];
		$card -> description = $request->ticket['description'];
		$card -> date_created = date('Y-m-d');
		$card -> labels_id = 8;
		$card -> ticket_id = $ticket->id;
		$card -> save();

		return $this->getTickets();
	}

	public function updateTicket(Request $request)
	{
		$ticket = Ticket::find($request->ticket['id']);
		$ticket -> name = $request->ticket['name'];
		$ticket -> description = $request->ticket['description'];
		$ticket -> save();

		$card = Card::find($request->card[0]['id']);
		$card -> card_name = $request->ticket['name'];
		$card -> description = $request->ticket['description'];
		$card -> save();

		return $this->getTickets();
	}

	public function deleteTicket(Request $request)
	{
		$ticket = Ticket::find($request->ticket['id']);
		$ticket -> delete();

		$card = Card::find($request->card[0]['id']);
		$card -> delete();

		return $this->getTickets();
	}

	private function getTickets()
	{
		$ticket_list = Ticket::with('boardlist', 'card')->get();
		return $ticket_list;
	}
}
