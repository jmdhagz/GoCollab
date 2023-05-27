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
use Auth;

class BoardController extends Controller
{
    protected $users_id;
    public function __construct()
    {
        $this->middleware('auth');
        // To get the authenticated users ID
        $this->middleware(function ($request, $next) {
            $this->users_id = Auth::user()->id;

            return $next($request);
        });
    }

    public function index()
    {
        $board_list = BoardMember::where('users_id', Auth::user()->id)->with(['board'])->get();
    	return view('board.index', compact('board_list'));
    }

    public function saveNewBoard(Request $request)
    {
    	$new_board = new Board();
    	$new_board -> board_name = $request -> boardInfo['name'];
    	$new_board -> description = $request -> boardInfo['description'];
    	$new_board -> starred = 0;
    	$new_board -> save();

        $board_member = new BoardMember();
        $board_member -> boards_id = $new_board -> id;
        $board_member -> users_id = $this->users_id;
        $board_member -> date_joined = date('Y-m-d');
        $board_member -> starred = 0;
        $board_member -> is_owner = 1;
        $board_member -> save();
    	
    	return $this->getBoardList();
    }

    public function boardStatus(Request $request)
    {
        $user_board = BoardMember::find($request->boardId);
        $user_board -> starred = $request->status;
        $user_board -> save();

        return $this->getBoardList();
    }

    private function getBoardList()
    {
        $board_list = BoardMember::where('users_id', Auth::user()->id)->with(['board'])->get();
        return $board_list;
    }
}
