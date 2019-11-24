<template>
	<div>
		<nav class="navbar navbar-light">
			<span class="navbar-brand mb-0 h1" style="color: white;">
				<font-awesome-icon icon="archive"></font-awesome-icon> Archive
			</span>
			<span class="navbar-text">
				<b-button style="background-color: #b63c30 !important; border: #b63c30 !important;" v-b-tooltip.hover title="Board List" @click="goBoardList()">
					<font-awesome-icon icon="long-arrow-alt-left" /> Back
				</b-button>
			</span>
		</nav>
	</div>
</template>

<script>
	export default {
		props: ['id'],
		data() {
			return {
				
			}
		},

		methods: {
			goBoardList() {
				window.open('../../board/'+this.id, '_self');
			}
		}
	};
</script>

<style>
	nav {
		background-color: #E74C3C !important;
	}
</style>