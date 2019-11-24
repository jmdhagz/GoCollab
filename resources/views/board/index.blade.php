@extends('layouts.app')

@section('content')
<div id="board">
	<nav class="navbar navbar-light" style="background-color: #384c60 !important;">
		<a class="navbar-brand h1" href="#" style="color: white; margin-bottom: 0px !important;">
			<img src="{{ asset('images/icon.png') }}" width="30" height="30" alt="" class="d-inline-block align-top">
			GoCollab
		</a>
		<span class="navbar-text" style="color: white;">
			Welcome, {{ Auth::user()->name }}!
		</span>
	</nav>
	<board :boardlist="{{ $board_list }}" :starredboardlist="{{ $starred_board_list }}"></board>
</div>
@endsection