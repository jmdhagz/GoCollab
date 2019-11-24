<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\BoardList;
use App\Models\Card;

class HomeController extends Controller
{
    public function index()
    {   
    	$board_lists = BoardList::all();
    	$card_lists = Card::all();
        return view('home.index', compact('board_lists', 'card_lists'));
    }

    public function getCards()
    {
    	$card_lists = Card::all();
    	return response()->json(['card_lists' => $card_lists]);
    }

    public function changeList(Request $request)
    {
    	$update_card = Card::find($request -> cardId);
    	$update_card -> board_lists_id = $request -> listId;
    	$update_card -> save();

    	return response()->json($update_card);
    }
}
