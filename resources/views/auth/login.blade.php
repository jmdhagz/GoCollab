@extends('layouts.login')

@section('content')
<div class="container">
    <div class="row">
        <div class="outer">
            <div class="middle">
                <div class="inner">
                    <div class="col-md-6" style="margin: auto;">
                        <div class="card" style="border-radius: 1rem; box-shadow: 0 8px 8px -5px rgba(0, 0, 0, 0.2);">
                            <div class="row no-gutters">
                                <div class="col-md-6" style="background-color: #536674; padding: 10px; border-radius: 1rem 0px 0px 1rem;">
                                    <img src="{{ asset('images/icon.png') }}" class="card-img" alt="...">
                                    <h2 style="color: white;">GoCollab</h2>
                                </div>
                                <div class="col-md-6">
                                    <div class="card-body">
                                        <div style="margin-top: 2rem">
                                            <form class="form-horizontal" method="POST" action="{{ route('login') }}">
                                                {{ csrf_field() }}
                                                <div class="form-group{{ $errors->has('email') ? ' has-error' : '' }}">
                                                    <label for="email" class="control-label" style="color: #536674; font-weight: 600;">E-Mail Address</label>
                                                    <input id="email" type="email" class="form-control" name="email" value="{{ old('email') }}" required autofocus>
                                                    @if ($errors->has('email'))
                                                    <span class="help-block">
                                                        <strong>{{ $errors->first('email') }}</strong>
                                                    </span>
                                                    @endif
                                                </div>

                                                <div class="form-group{{ $errors->has('password') ? ' has-error' : '' }}">
                                                    <label for="password" class="control-label" style="color: #536674; font-weight: 600;">Password</label>
                                                    <input id="password" type="password" class="form-control" name="password" required>
                                                    @if ($errors->has('password'))
                                                    <span class="help-block">
                                                        <strong>{{ $errors->first('password') }}</strong>
                                                    </span>
                                                    @endif
                                                </div>
                                                <br>
                                                <div class="form-group">
                                                    <button type="submit" style="border-radius: 2.3rem !important; background-color: #536674 !important;" class="btn btn-lg btn-secondary btn-block">
                                                        Login
                                                    </button>
                                                </div>

                                                <div class="form-group">
                                                    <p>No account yet? <a href="{{ URL::to('register') }}"><b style="color: #536674">Register</b></a></p>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection
