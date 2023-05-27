<?php

use App\Http\Middleware\SupportMiddleware;
use App\Http\Middleware\KanbanMiddleware;
/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

# BOARD

Route::middleware([KanbanMiddleware::class])->group(function() {
	Route::get('/', 'BoardController@index');
	Route::post('new_board/', 'BoardController@saveNewBoard');
	Route::post('update_board_status/', 'BoardController@boardStatus');
	Route::get('get_board_list/', 'BoardController@getBoardList');

	Route::get('board/{id}', 'BoardListController@index');
	Route::get('board/{id}/get_cards', 'BoardListController@getCards');
	Route::post('board/{id}/change_list', 'BoardListController@changeList');
	Route::post('board/{id}/new_list', 'BoardListController@newList');
	Route::post('board/{id}/new_card', 'BoardListController@newCard');
	Route::post('board/{id}/add_label', 'BoardListController@addLabel');
	Route::post('board/{id}/new_label', 'BoardListController@newLabel');
	Route::post('board/{id}/edited_label', 'BoardListController@editedLabel');
	Route::post('board/{id}/delete_label', 'BoardListController@deleteLabel');
	Route::post('board/{id}/edited_card_desc', 'BoardListController@editedCardDesc');
	Route::post('board/{id}/save_edited_due_date', 'BoardListController@saveEditedDueDate');
	Route::post('board/{id}/save_new_due_date', 'BoardListController@saveNewDueDate');
	Route::post('board/archiveBoard', 'BoardListController@archiveBoard');
	Route::post('board/deleteCard', 'BoardListController@deleteCard');
	Route::post('board/deleteBoardList', 'BoardListController@deleteBoardList');

	# Board Member
	Route::get('board/{id}/getBoardMember', 'BoardListController@getBoardMember');
	Route::post('board/{id}/addBoardMember', 'BoardListController@addBoardMember');
	Route::post('board/removeUser', 'BoardListController@removeUser');
	Route::post('board/editUserPermission', 'BoardListController@editUserPermission');

	# Checklist
	Route::post('board/{id}/new_checklist', 'BoardListController@newChecklist');
	Route::post('board/{id}/new_checklist_item', 'BoardListController@newChecklistItem');
	Route::post('board/{id}/change_list_item', 'BoardListController@changeListItem');
	Route::post('board/{id}/rename_checklist', 'BoardListController@renameChecklist');
	Route::post('board/{id}/modify_checklist_item', 'BoardListController@modifyChecklistItem');
	Route::post('board/{id}/delete_checklist_item', 'BoardListController@deleteChecklistItem');
	Route::post('board/{id}/delete_checklist', 'BoardListController@deleteChecklist');
	Route::post('board/board_new_name', 'BoardListController@boardNewName');

	# Attachment
	Route::post('board/newAttachment', 'BoardListController@newAttachment');
	Route::post('board/{id}/removeAttachment', 'BoardListController@removeAttachment');

	# Archive
	Route::get('board/{id}/archive', 'ArchiveController@index');
	Route::get('board/{id}/getArchiveCards', 'ArchiveController@getArchiveCards');
	Route::post('board/{id}/sendToBoard', 'ArchiveController@sendToBoard');
	Route::post('board/{id}/sendToArchive', 'ArchiveController@sendToArchive');
	Route::post('board/newArchiveAttachment', 'ArchiveController@newAttachment');
	Route::post('board/{id}/archive/removeAttachment', 'ArchiveController@removeAttachment');
	Route::post('board/archive/sendToBoardList', 'ArchiveController@sendToBoardList');
	Route::post('board/archive/deleteArchivedBoardList', 'ArchiveController@deleteArchivedBoardList');
});



# Support
Route::middleware([SupportMiddleware::class])->group(function() {
	Route::get('support', 'SupportController@index');
	Route::post('support/new_ticket', 'SupportController@postTicket');
	Route::post('support/update_ticket', 'SupportController@updateTicket');
	Route::post('support/delete_ticket', 'SupportController@deleteTicket');
});

Auth::routes();
Route::get('logout', '\App\Http\Controllers\Auth\LoginController@logout');

