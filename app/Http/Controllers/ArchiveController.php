<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Board;
use App\Models\BoardMember;
use App\Models\BoardList;
use App\Models\Card;
use App\Models\Checklist;
use App\Models\ChecklistItem;
use App\Models\Color;
use App\Models\Label;
use Auth;

class ArchiveController extends Controller
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

    public function index(BoardMember $boardMember, $id)
    {
        $this->authorize('view', [$boardMember, $id]);
    	$card_lists = Card::leftJoin('labels', 'cards.labels_id', '=','labels.id')
    						->leftJoin('colors', 'labels.colors_id', 'colors.id')
                            ->where('cards.archived', '=', 1)
    						->select(['cards.id', 'cards.board_lists_id', 'cards.card_name', 'cards.description', 'cards.date_created', 'colors.color_name', 'cards.labels_id', 'labels.name', 'cards.due_date', 'cards.attachment'])->get();

    	$board_list_arr = [];
    	foreach ($card_lists as $card) {
    		$board_list_arr[] = $card -> board_lists_id;
    	}
        $board_lists = BoardList::where('boards_id', '=', $id)
                                ->whereIn('id', array_unique($board_list_arr))->get();
    	$label_lists = Label::join('colors', 'labels.colors_id', 'colors.id')
    						->select(['labels.id', 'labels.name', 'colors.color_name'])->get();
    	$color_lists = Color::all();
        $check_lists = Checklist::all();
        $checklist_items = ChecklistItem::all();
        $card_attachment = Card::where('archived', '=', 1)
                                ->select(['id', 'attachment'])->get();

    	return view('archive.index', compact('card_lists', 'label_lists', 'color_lists', 'check_lists', 'checklist_items', 'board_lists', 'id', 'card_attachment', 'card_attachment'));
    }

    public function getArchiveCards($id)
    {
        $board_info = Board::where('id', '=', $id)->get()->last();
    	$card_lists = Card::leftJoin('labels', 'cards.labels_id', '=','labels.id')
                            ->leftJoin('colors', 'labels.colors_id', 'colors.id')
                            ->where('cards.archived', '=', 1)
                            ->select(['cards.id', 'cards.board_lists_id', 'cards.card_name', 'cards.description', 'cards.date_created', 'colors.color_name', 'cards.labels_id', 'labels.name', 'cards.due_date', 'cards.attachment'])->get();

    	$board_list_arr = [];
    	foreach ($card_lists as $card) {
    		$board_list_arr[] = $card -> board_lists_id;
    	}

    	$board_lists = BoardList::where('boards_id', '=', $id)
                                ->whereIn('id', array_unique($board_list_arr))->get();

    	$label_lists = Label::join('colors', 'labels.colors_id', 'colors.id')
    						->select(['labels.id', 'labels.name', 'colors.color_name'])->get();
		$color_lists = Color::all();
        $check_lists = Checklist::all();
        $checklist_items = ChecklistItem::all();
        $card_attachment = Card::where('archived', '=', 1)
                                ->select(['id', 'attachment'])->get();

    	return response()->json(['card_lists' => $card_lists, 'board_lists' => $board_lists, 'label_lists' => $label_lists, 'color_lists' => $color_lists, 'check_lists' => $check_lists, 'checklist_items' => $checklist_items, 'board_info' => $board_info, 'card_attachment' => $card_attachment]);
    }

    public function sendToBoard(Request $request)
    {
        $board_list_id = $request -> boardListId;
        $check_board_list = BoardList::where('id', '=', $board_list_id)->get()->last();

        if ($check_board_list -> archived == 0) {
            $update_card = Card::find($request -> cardId);
            $update_card -> archived = 0;
            $update_card -> save();
        }
        else {
            $board_list = BoardList::find($board_list_id);
            $board_list -> archived = 0;
            $board_list -> save();

            $update_card = Card::find($request -> cardId);
            $update_card -> archived = 0;
            $update_card -> save();
        }

    	return response()->json($update_card);
    }

    public function sendToArchive(Request $request)
    {
    	$update_card = Card::find($request -> cardId);
    	$update_card -> archived = 1;
    	$update_card -> save();

    	return $this->getCards($request->boardId);
    }

    private function getCards($id)
    {
        $board_info = Board::find($id);
        $board_lists = BoardList::where('boards_id', '=', $id)
                                ->where('archived', '=', 0)->orderBy('id', 'DESC')->get();

        foreach ($board_lists as $list) {
            $list->card_lists = Card::leftJoin('labels', 'cards.labels_id', '=','labels.id')
                            ->leftJoin('colors', 'labels.colors_id', 'colors.id')
                            ->where('cards.board_lists_id', $list->id)
                            ->where('cards.archived', '=', 0)
                            ->select(['cards.id', 'cards.board_lists_id', 'cards.card_name', 'cards.description', 'cards.date_created', 'colors.color_name', 'cards.labels_id', 'labels.name', 'cards.due_date', 'cards.attachment'])->get();

            foreach ($list->card_lists as $card) {
                $card->checklists = Checklist::where('cards_id', $card->id)->get();
                foreach ($card->checklists as $checklist) {
                    $checklist->lists = ChecklistItem::where('checklists_id', $checklist->id)->get();
                }
            }
        }

        return $board_lists;
    }

    public function newAttachment(Request $request)
    {
        if ($request -> hasFile('image')) {
            $destination_path = public_path('/images');
            $uploadedImage = $request -> image;

            $file_name = $uploadedImage->getClientOriginalName(); 
            $uploadedImage->move($destination_path, $file_name);

            $put_image = Card::find($request -> card_id);
            $put_image -> attachment = 'images/'.$file_name;
            $put_image -> save();
        }

        return response()->json($put_image);
    }

    public function removeAttachment(Request $request) 
    {
        $remove_attachment = Card::find($request -> cardId);
        $remove_attachment -> attachment = '';
        $remove_attachment -> save();

        return response()->json($remove_attachment);
    }

    public function sendToBoardList(Request $request)
    {
        $board_id = $request -> boardId;

        $edit_board = BoardList::find($board_id);
        $edit_board -> archived = 0;
        $edit_board -> save();

        $check_board_card_list = Card::where('board_lists_id', '=', $board_id)
                                    ->select(['id'])->get();

        foreach ($check_board_card_list as $check_board_card) {
            $edit_card = Card::find($check_board_card -> id);
            $edit_card -> archived = 0;
            $edit_card -> save();
        }

        return response()->json($edit_board);
    }

    public function deleteArchivedBoardList(Request $request)
    {
        $board_id = $request -> boardId;
        $card_lists = Card::where('board_lists_id', '=', $board_id)
                            ->select(['id'])->get();

        $delete_board = BoardList::find($board_id);
        $delete_board -> delete();

        foreach ($card_lists as $card) {
            $delete_cards = Card::find($card -> id);
            $delete_cards -> delete();
        }

        return response()->json($delete_board);
    }
}
