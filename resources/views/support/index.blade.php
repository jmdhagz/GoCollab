@extends('layouts.app')

@section('content')
<div id="home">
	<support :boardlist="{{ $board_list }}" :ticketlist="{{ $ticket_list }}"></support>
</div>
@endsection