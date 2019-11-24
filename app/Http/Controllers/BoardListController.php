<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\user;
use App\Models\Board;
use App\Models\BoardMember;
use App\Models\BoardList;
use App\Models\Card;
use App\Models\Checklist;
use App\Models\ChecklistItem;
use App\Models\Color;
use App\Models\Label;
use App\Models\Permission;
use Auth;

class BoardListController extends Controller
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
        $board_info = Board::where('id', '=', $id)->get()->last();
        $board_lists = BoardList::where('boards_id', '=', $id)
                                ->where('archived', '=', 0)->orderBy('id', 'DESC')->get();
    	$card_lists = Card::leftJoin('labels', 'cards.labels_id', '=','labels.id')
    						->leftJoin('colors', 'labels.colors_id', 'colors.id')
                            ->where('cards.archived', '=', 0)
    						->select(['cards.id', 'cards.board_lists_id', 'cards.card_name', 'cards.description', 'cards.date_created', 'colors.color_name', 'cards.labels_id', 'labels.name', 'cards.due_date', 'cards.attachment'])->get();
    	$label_lists = Label::join('colors', 'labels.colors_id', 'colors.id')
    						->select(['labels.id', 'labels.name', 'colors.color_name'])->get();
    	$color_lists = Color::all();
        $check_lists = Checklist::all();
        $checklist_items = ChecklistItem::all();
        $card_attachment = Card::where('archived', '=', 0)
                                ->select(['id', 'attachment'])->get();
        $board_member_list = BoardMember::join('users', 'board_members.users_id', '=', 'users.id')
                                        ->where('board_members.boards_id', '=', $id)
                                        ->select(['users.id', 'board_members.id as board_members_id', 'users.name', 'board_members.permissions_id', 'board_members.is_owner', 'board_members.date_joined'])->get();
        $members_arr = [];
        foreach ($board_member_list as $board_member) {
            $members_arr[] = $board_member -> id;
        }
        $user_list = User::whereNotIn('id', $members_arr)->select(['id', 'name'])->get();
        $permission_list = Permission::all();
        return view('home.index', compact('board_lists', 'card_lists', 'label_lists', 'color_lists', 'check_lists', 'checklist_items', 'board_info', 'id', 'card_attachment', 'board_member_list', 'permission_list', 'user_list'));
    }

    public function getCards($id)
    {
        $board_info = Board::where('id', '=', $id)->get()->last();
    	$board_lists = BoardList::where('boards_id', '=', $id)
                                ->where('archived', '=', 0)->orderBy('id', 'DESC')->get();
    	$card_lists = Card::leftJoin('labels', 'cards.labels_id', '=','labels.id')
                            ->leftJoin('colors', 'labels.colors_id', 'colors.id')
                            ->where('cards.archived', '=', 0)
                            ->select(['cards.id', 'cards.board_lists_id', 'cards.card_name', 'cards.description', 'cards.date_created', 'colors.color_name', 'cards.labels_id', 'labels.name', 'cards.due_date', 'cards.attachment'])->get();
    	$label_lists = Label::join('colors', 'labels.colors_id', 'colors.id')
    						->select(['labels.id', 'labels.name', 'colors.color_name'])->get();
		$color_lists = Color::all();
        $check_lists = Checklist::all();
        $checklist_items = ChecklistItem::all();
        $card_attachment = Card::where('archived', '=', 0)
                                ->select(['id', 'attachment'])->get();
    	return response()->json(['card_lists' => $card_lists, 'board_lists' => $board_lists, 'label_lists' => $label_lists, 'color_lists' => $color_lists, 'check_lists' => $check_lists, 'checklist_items' => $checklist_items, 'board_info' => $board_info, 'card_attachment' => $card_attachment]);
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

    public function changeList(Request $request)
    {
    	$update_card = Card::find($request -> cardId);
    	$update_card -> board_lists_id = $request -> listId;
    	$update_card -> save();

    	return response()->json($update_card);
    }

    public function newList(Request $request)
    {
    	$new_list = new BoardList();
    	$new_list -> boards_id = $request -> id;
        $new_list -> list_name = $request -> listName;
    	$new_list -> date_created = date('Y-m-d');
    	$new_list -> archived = 0;
    	$new_list -> save();

    	return response()->json($new_list);
    }

    public function newCard(Request $request)
    {
    	$new_card = new Card();
    	$new_card -> board_lists_id = $request -> listId;
    	$new_card -> card_name = $request -> cardName;
    	$new_card -> description = $request -> cardDesc;
    	$new_card -> date_created = date('Y-m-d');
    	$new_card -> due_date = NULL;
    	$new_card -> labels_id = 0;
    	$new_card -> archived = 0;
    	$new_card -> save();

    	return response()->json($new_card);
    }

    public function addLabel(Request $request)
    {
    	$card_label = Card::find($request -> cardId);
    	$card_label -> labels_id = $request -> labelId;
    	$card_label -> save();

    	$card_info = Card::leftJoin('labels', 'cards.labels_id', '=','labels.id')
    						->leftJoin('colors', 'labels.colors_id', 'colors.id')
    						->where('cards.id', '=', $card_label -> id)
    						->select(['cards.id', 'cards.board_lists_id', 'cards.card_name', 'cards.description', 'cards.date_created', 'colors.color_name', 'cards.labels_id', 'labels.name', 'cards.due_date'])->get()->last();

    	$list_info = Card::join('board_lists', 'cards.board_lists_id', '=', 'board_lists.id')
    					->where('board_lists.id', '=', $card_label -> board_lists_id)
    					->select(['board_lists.list_name'])->get()->last();

    	return response()->json(['card_label' => $card_label, 'card_info' => $card_info, 'list_name' => $list_info -> list_name]);
    }

    public function newLabel(Request $request)
    {
    	$new_label = new Label();
    	$new_label -> name = $request -> labelName;
    	$new_label -> colors_id = $request -> labelColorId;
    	$new_label -> save();

    	return response()->json($new_label);
    }

    public function editedLabel(Request $request)
    {
    	$modified_label = Label::find($request -> labelId);
    	$modified_label -> name = $request -> newLabelName;
    	$modified_label -> save();

    	return response()->json($modified_label);
    }

    public function deleteLabel(Request $request)
    {
    	$delete_label = Label::find($request -> labelId);
    	$delete_label -> delete();

    	return response()->json($delete_label);
    }

    public function editedCardDesc(Request $request)
    {
    	$edit_card_desc = Card::find($request -> cardId);
    	$edit_card_desc -> description = $request -> cardNewDesc;
    	$edit_card_desc -> save();

    	return response()->json($edit_card_desc);
    }

    public function saveEditedDueDate(Request $request)
    {
    	$edit_card_due_date = Card::find($request -> cardId);
    	$edit_card_due_date -> due_date = date('Y-m-d', strtotime($request -> cardNewDueDate));
    	$edit_card_due_date -> save();

    	return response()->json($edit_card_due_date);
    }

    public function saveNewDueDate(Request $request)
    {
    	$new_card_due_date = Card::find($request -> cardId);
    	$new_card_due_date -> due_date = date('Y-m-d', strtotime($request -> dueDate));
    	$new_card_due_date -> save();

    	return response()->json($new_card_due_date);
    }

    public function newChecklist(Request $request)
    {
        $new_checklist = new Checklist();
        $new_checklist -> cards_id = $request -> cardId;
        $new_checklist -> description = $request -> checkListName;
        $new_checklist -> save();

        return response()->json($new_checklist);
    }

    public function newChecklistItem(Request $request)
    {
        $new_checklist_item = new ChecklistItem();
        $new_checklist_item -> checklists_id = $request -> checklistId;
        $new_checklist_item -> description = $request -> itemName;
        $new_checklist_item -> completed = 0;
        $new_checklist_item -> date_finished = NULL;
        $new_checklist_item -> save();

        return response()->json($new_checklist_item);
    }

    public function changeListItem(Request $request)
    {
        if ($request -> status == 'checked') {
            $update_list_item = ChecklistItem::find($request -> itemId);
            $update_list_item -> completed = 1;
            $update_list_item -> date_finished = date('Y-m-d');
            $update_list_item -> save();
        }
        else {
            $update_list_item = ChecklistItem::find($request -> itemId);
            $update_list_item -> completed = 0;
            $update_list_item -> date_finished = date('Y-m-d');
            $update_list_item -> save();
        }

        return response()->json($update_list_item);
    }

    public function renameChecklist(Request $request)
    {
        $rename_checklist = Checklist::find($request -> checklistId);
        $rename_checklist -> description = $request -> newDesc;
        $rename_checklist -> save();

        return response()->json($rename_checklist);
    }

    public function modifyChecklistItem(Request $request)
    {
        $modify_checklist_item = ChecklistItem::find($request -> listItemId);
        $modify_checklist_item -> description = $request -> newListDesc;
        $modify_checklist_item -> save();

        return response()->json($modify_checklist_item);
    }

    public function deleteChecklistItem(Request $request)
    {
        $delete_checklist_item = ChecklistItem::find($request -> listItemId);
        $delete_checklist_item -> delete();

        return response()->json($delete_checklist_item);
    }

    public function deleteChecklist(Request $request)
    {
        $delete_checklist = Checklist::find($request -> checklistId);
        $delete_checklist -> delete();

        $checklist_items = ChecklistItem::where('checklists_id', '=', $request -> checklistId)
                                        ->get();

        foreach ($checklist_items as $items) {
            $remove_items = ChecklistItem::find($items -> id);
            $remove_items -> delete();
        }

        return response()->json($delete_checklist);
    }

    public function boardNewName(Request $request)
    {
        $board = BoardList::find($request -> boardId);
        $board -> list_name = $request -> boardNewName;
        $board -> save();

        return response()->json($board);
    }

    public function archiveBoard(Request $request)
    {
        $board_id = $request -> boardId;

        $edit_board = BoardList::find($board_id);
        $edit_board -> archived = 1;
        $edit_board -> save();

        $check_board_card_list = Card::where('board_lists_id', '=', $board_id)
                                    ->select(['id'])->get();

        foreach ($check_board_card_list as $check_board_card) {
            $edit_card = Card::find($check_board_card -> id);
            $edit_card -> archived = 1;
            $edit_card -> save();
        }

        return response()->json($edit_board);
    }

    public function deleteBoardList(Request $request)
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

    public function addBoardMember(Request $request)
    {
        $board_id = $request -> boardId;
        $user_id = $request -> userId;

        $new_board_member = new BoardMember();
        $new_board_member -> boards_id = $board_id;
        $new_board_member -> users_id = $user_id;
        $new_board_member -> date_joined = date('Y-m-d');
        $new_board_member -> starred = 0;
        $new_board_member -> is_owner = 0;
        $new_board_member -> save();

        $board_member_list = BoardMember::join('users', 'board_members.users_id', '=', 'users.id')
                                        ->where('board_members.boards_id', '=', $board_id)
                                        ->select(['users.id', 'board_members.id as board_members_id', 'users.name', 'board_members.permissions_id', 'board_members.is_owner', 'board_members.date_joined'])->get();
        $members_arr = [];
        foreach ($board_member_list as $board_member) {
            $members_arr[] = $board_member -> id;
        }
        $user_list = User::whereNotIn('id', $members_arr)->select(['id', 'name'])->get();

        return response()->json(['board_member_list' => $board_member_list, 'user_list' => $user_list]);
    }

    public function getBoardMember(Request $request)
    {
        $board_id = $request -> boardId;
        $board_member_list = BoardMember::join('users', 'board_members.users_id', '=', 'users.id')
                                        ->where('board_members.boards_id', '=', $board_id)
                                        ->select(['users.id', 'board_members.id as board_members_id', 'users.name', 'board_members.permissions_id', 'board_members.is_owner', 'board_members.date_joined'])->get();
        $members_arr = [];
        foreach ($board_member_list as $board_member) {
            $members_arr[] = $board_member -> id;
        }
        $user_list = User::whereNotIn('id', $members_arr)->select(['id', 'name'])->get();

        return response()->json(['board_member_list' => $board_member_list, 'user_list' => $user_list]);
    }

    public function removeUser(Request $request)
    {
        $board_id = $request -> boardId;
        $board_member_id = $request -> boardMemberId;

        $remove_board_member = BoardMember::find($board_member_id);
        $remove_board_member -> delete();

        $board_member_list = BoardMember::join('users', 'board_members.users_id', '=', 'users.id')
                                        ->where('board_members.boards_id', '=', $board_id)
                                        ->select(['users.id', 'board_members.id as board_members_id', 'users.name', 'board_members.permissions_id', 'board_members.is_owner', 'board_members.date_joined'])->get();
        $members_arr = [];
        foreach ($board_member_list as $board_member) {
            $members_arr[] = $board_member -> id;
        }
        $user_list = User::whereNotIn('id', $members_arr)->select(['id', 'name'])->get();

        return response()->json(['board_member_list' => $board_member_list, 'user_list' => $user_list]);
    }

    // public function editUserPermission(Request $request)
    // {
    //     $board_member_id = $request -> boardMemberId;
    //     $permission_id = $request -> permissionId;

    //     $board_member = BoardMember::find($board_member_id);
    //     $board_member -> permissions_id = $permission_id;
    //     $board_member -> save();

    //     return response()->json($board_member);
    // }

}
