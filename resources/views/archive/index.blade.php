@extends('layouts.app')

@section('content')
<div id="archive">
	<archivenavbar :id="{{ $id }}"></archivenavbar>
	<archive :id="{{ $id }}" :boardlists="{{ $board_lists }}" :cardlists="{{ $card_lists }}" :labellists="{{ $label_lists }}" :colorlists="{{ $color_lists }}" :checklists="{{ $check_lists }}" :checklistitems="{{ $checklist_items }}" :cardattachment="{{ $card_attachment }}"></archive>
</div>
@endsection