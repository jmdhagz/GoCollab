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
        $starred_board_list = BoardMember::join('boards', 'board_members.boards_id', '=', 'boards.id')
                                ->where('board_members.users_id', '=', Auth::user()->id)
                                ->where('board_members.starred', '=', 1)
                                ->select(['boards.id', 'boards.board_name', 'boards.description', 'board_members.starred'])
                                ->get();
        $board_list = BoardMember::join('boards', 'board_members.boards_id', '=', 'boards.id')
                                ->where('board_members.users_id', '=', Auth::user()->id)
                                ->select(['boards.id', 'boards.board_name', 'boards.description', 'board_members.starred'])
                                ->get();
    	return view('board.index', compact('board_list', 'starred_board_list'));
    }

    public function getBoardList()
    {
        $starred_board_list = BoardMember::join('boards', 'board_members.boards_id', '=', 'boards.id')
                                ->where('board_members.users_id', '=', Auth::user()->id)
                                ->where('board_members.starred', '=', 1)
                                ->select(['boards.id', 'boards.board_name', 'boards.description', 'board_members.starred'])
                                ->get();
    	$board_list = BoardMember::join('boards', 'board_members.boards_id', '=', 'boards.id')
                                ->where('board_members.users_id', '=', Auth::user()->id)
                                ->select(['boards.id', 'boards.board_name', 'boards.description', 'board_members.starred'])
                                ->get();
    	return response()->json(['starred_board_list' => $starred_board_list, 'board_list' => $board_list]);
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
        // $board_member -> permissions_id = 1;
        $board_member -> date_joined = date('Y-m-d');
        $board_member -> starred = 0;
        $board_member -> is_owner = 1;
        $board_member -> save();
    	
    	return response()->json($new_board);
    }

    public function starBoard(Request $request)
    {
        $board = BoardMember::join('boards', 'board_members.boards_id', '=', 'boards.id')
                                ->where('board_members.users_id', '=', Auth::user()->id)
                                ->where('board_members.boards_id', '=', $request -> boardId)
                                ->select(['board_members.id'])->get()->last();
    	$add_star = BoardMember::find($board -> id);
    	$add_star -> starred = 1;
    	$add_star -> save();

    	return response()->json($add_star);
    }

    public function unstarBoard(Request $request)
    {
        $board = BoardMember::join('boards', 'board_members.boards_id', '=', 'boards.id')
                                ->where('board_members.users_id', '=', Auth::user()->id)
                                ->where('board_members.boards_id', '=', $request -> boardId)
                                ->select(['board_members.id'])->get()->last();
    	$remove_star = BoardMember::find($board -> id);
    	$remove_star -> starred = 0;
    	$remove_star -> save();

    	return response()->json($remove_star);
    }
}
