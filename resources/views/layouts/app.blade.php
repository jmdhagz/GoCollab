<!DOCTYPE html>
<html lang="{{ app()->getLocale() }}">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- CSRF Token -->
    <meta name="csrf-token" content="{{ csrf_token() }}">

    <title>{{ config('app.name', 'Laravel') }}</title>

    <!-- Styles -->
    <link href="{{ asset('css/bootstrap.css') }}" rel="stylesheet">
    <link href="{{ asset('css/bootstrap.min.css') }}" rel="stylesheet">
    <style>
        /* width */
        ::-webkit-scrollbar {
            width: 3px;
            height: 5px;
        }

        /* Track */
        ::-webkit-scrollbar-track {
            /*background: #f1f1f1; */
        }
         
        /* Handle */
        ::-webkit-scrollbar-thumb {
            background: #d3d1d1; 
            border-radius: 20px;
        }

        /* Handle on hover */
        ::-webkit-scrollbar-thumb:hover {
            background: #555; 
        }

        @font-face {
            font-family: Gudea;
            src: url('http://localhost/trello-vue/public/fonts/gudea-regular-webfont.woff');
        }

        @font-face {
            font-family: OpenSansLight;
            src: url('http://localhost/trello-vue/public/fonts/opensans-light-webfont.woff');
        }

        @font-face {
            font-family: OpenSansRegular;
            src: url('http://localhost/trello-vue/public/fonts/opensans-regular-webfont.woff');
        }

        @font-face {
            font-family: OverpassRegular;
            src: url('http://localhost/trello-vue/public/fonts/overpass-regular-webfont.woff');
        }

        @font-face {
            font-family: OverpassBold;
            src: url('http://localhost/trello-vue/public/fonts/overpass-bold-webfont.woff');
        }

        @font-face {
            font-family: RobotoSlabBold;
            src: url('http://localhost/trello-vue/public/fonts/robotoslab-bold-webfont.woff');
        }

        @font-face {
            font-family: AileronLight;
            src: url('http://localhost/trello-vue/public/fonts/aileron-light-webfont.woff');
        }

        @font-face {
            font-family: AileronRegular;
            src: url('http://localhost/trello-vue/public/fonts/aileron-regular-webfont.woff');
        }

        @font-face {
            font-family: AileronUltraLight;
            src: url('http://localhost/trello-vue/public/fonts/aileron-ultralight-webfont.woff');
        }
    </style>
    @yield('styles')
</head>
<body>

    @yield('content')

    <!-- Scripts -->
    @yield('scripts')
    <script src="{{asset('js/jquery-2.1.1.min.js')}}"></script>
    <script src="{{asset('js/popper/popper.min.js')}}"></script>
    <script src="{{ asset('js/bootstrap.js') }}"></script>
    <script src="{{ asset('js/bootstrap.min.js') }}"></script>
    <script src="{{ asset('js/app.js') }}"></script>
</body>
</html>
