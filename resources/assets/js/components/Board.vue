<template>
	<div>
		<div class="container" style="margin-top: 50px;">
			<div class="row">
				<div class="col-md-12">
					<div class="float-right">
						<b-button variant="secondary" size="md" v-b-modal.newBoardModal>New Board</b-button>
					</div>
				</div>
				<div class="col-md-12">
					<template v-if="starred_board_list.length != 0">
						<h4 style="font-family: AileronRegular;"><font-awesome-icon icon="star"></font-awesome-icon>&nbsp;&nbsp;&nbsp;Starred Boards</h4>
						<div class="row" style="margin-top: 20px;">
							<template v-for="(starredboard, starredIndex) of starred_board_list">
								<div class="col-md-3" style="margin-bottom: 20px;">
									<div class="card" style="box-shadow: 0 8px 8px -5px rgba(0, 0, 0, 0.2);">
										<div class="card-body">
											<h6 class="card-title" style="font-family: OpenSansRegular; font-weight: 900;">
												{{ starredboard.board_name }}
											</h6>
											<b-button variant="secondary" size="sm" @click="visitBoard(starredboard.id)">
												View
											</b-button>
											<div class="float-right">
												<font-awesome-icon class="float-right" style="color: gold; font-size: 25px;" icon="star" @click="removeStar(starredboard.id)"></font-awesome-icon>
											</div>
										</div>
									</div>
								</div>
							</template>
						</div>
					</template>
					<div style="margin-top: 50px;">
						<h4 style="font-family: AileronRegular;"><font-awesome-icon icon="id-badge"></font-awesome-icon>&nbsp;&nbsp;&nbsp;Personal Boards</h4>
						<div class="row" style="margin-top: 20px;">
							<template v-for="(board, index) of board_list">
								<div class="col-md-3" style="margin-bottom: 20px;" v-if="board.starred == 0" @mouseover="starToggle(index)" @mouseleave="starLeaveToggle(index)">
									<div class="card" style="box-shadow: 0 8px 8px -5px rgba(0, 0, 0, 0.2);">
										<div class="card-body">
											<h6 class="card-title" style="font-family: OpenSansRegular; font-weight: 900;">
												{{ board.board_name }}
											</h6>
											<b-button class="col-3" variant="secondary" size="sm" @click="visitBoard(board.id)">
												View
											</b-button>
											<div class="float-right">
												<font-awesome-icon v-show="hiddenStarIcon[index]" class="float-right" style="color: gold; font-size: 25px;" @click="starBoard(board.id)" icon="star"></font-awesome-icon>
											</div>
										</div>
									</div>
								</div>
							</template>
						</div>
					</div>
				</div>
			</div>
		</div>
			
		<b-modal id="newBoardModal" centered ref="newBoardModal" size="sm" title="New Board" hide-footer>
			<div class="row">
				<div class="col-md-12">
					<form @submit.prevent="saveNewBoard()">
						<div class="form-group">
							<h6 style="font-family: OpenSansRegular; font-weight: 900;">Board Name</h6>
							<input type="text" class="form-control" v-model="newBoard.name">
						</div>
						<div class="form-group">
							<h6 style="font-family: OpenSansRegular; font-weight: 900;">Description</h6>
							<textarea cols="10" rows="3" class="form-control" v-model="newBoard.description"></textarea>
						</div>
						<div class="form-group">
							<b-button type="submit" variant="primary" size="md" block>Create</b-button>
						</div>	
					</form>
				</div>
			</div>
		</b-modal>
	</div>
</template>

<script>
export default {
	props: ['boardlist', 'starredboardlist'],
	data() {
		return {
			board_list: this.boardlist,
			starred_board_list: this.starredboardlist,
			newBoard: {
				name: '',
				description: ''
			},
			hiddenStarIcon: {}
		}
	},

	created() {
		this.getBoardList();
		console.log(this.boardlist);
	},

	methods: {
		visitBoard(id) {
			window.open("http://localhost/trello-vue/public/board/" + id);
		},

		getBoardList() {
			axios.get('get_board_list')
			.then((response) => {
				this.board_list = response.data.board_list;
				this.starred_board_list = response.data.starred_board_list;
			});
		},

		starToggle(index) {
			this.hiddenStarIcon = {index: true};
			this.hiddenStarIcon[index] = !this.hiddenStarIcon[index];
		},

		starLeaveToggle(index) {
			this.hiddenStarIcon = {index: false};
			this.hiddenStarIcon[index] = false;
		},

		starBoard(id) {
			axios.post('star_board', {
				boardId: id
			})
			.then((response) => {
				this.getBoardList();
			});
		},

		removeStar(id) {
			axios.post('unstar_board', {
				boardId: id
			})
			.then((response) => {
				this.getBoardList();
			});
		},

		saveNewBoard() {
			axios.post('new_board', {
				boardInfo: this.newBoard
			})
			.then((response) => {
				this.newBoard.name = '';
				this.newBoard.description = '';
				this.getBoardList();
				this.$refs.newBoardModal.hide();
			});
		},

		testing() {
			alert('haha')
		}
	}
};
</script>

<style>
body {
	background-color: #F8F9F9;
}
</style>