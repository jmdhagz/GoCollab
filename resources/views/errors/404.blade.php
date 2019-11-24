<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>Document</title>
	<style>
		.outer {
			display: table;
			position: absolute;
			top: 0;
			left: 0;
			height: 100%;
			width: 100%;
		}

		.middle {
			display: table-cell;
			vertical-align: middle;
		}

		.inner {
			margin-left: auto;
			margin-right: auto;
			text-align: center;
		}

		@font-face {
            font-family: OverpassBold;
            src: url('http://localhost/trello-vue/public/fonts/overpass-bold-webfont.woff');
        }
	</style>
</head>
<body>
	<div class="outer">
		<div class="middle">
			<div class="inner">
				<h1 style="color: #E74C3C; font-family: OverpassBold; font-size: 5rem; margin-bottom: 10px;">ERROR 404</h1>
				<h3 style="color: #E74C3C; font-family: OverpassBold; font-size: 3rem; margin-top: 10px;">Page not found.</h3>
			</div>
		</div>
	</div>
</body>
</html>