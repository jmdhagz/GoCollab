<template>
	<div>
		<nav class="navbar navbar-light">
			<a class="navbar-brand h1" href="#" style="color: white; margin-bottom: 0px !important;">
				<img :src="iconImg" width="30" height="30" alt="" class="d-inline-block align-top">
				GoCollab
			</a>
		</nav>
	</div>
</template>

<script>
	export default {
		data() {
			return {
				iconImg: 'images/icon.png'
			}
		}
	};
</script>

<style>
	nav {
		background-color: #384c60 !important;
	}
</style>

