@extends('layouts.app')

@section('content')
<div id="home">
	<navbar :boardinfo="{{ $board_info }}" :id="{{ $id }}" :boardmemberlist="{{ $board_member_list }}" :permissionlist="{{ $permission_list }}" :userlist="{{ $user_list }}" :userinfo="{{ $user_info }}"></navbar>
	<boardlist :id="{{ $id }}" :boardlists="{{ $board_lists }}" :cardlists="{{ $card_lists }}" :labellists="{{ $label_lists }}" :colorlists="{{ $color_lists }}" :checklists="{{ $check_lists }}" :checklistitems="{{ $checklist_items }}" :cardattachment="{{ $card_attachment }}"></boardlist>
</div>
@endsection