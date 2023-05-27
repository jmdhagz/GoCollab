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
					<template v-if="board_list.length != 0">
						<h4 style="font-family: AileronRegular;"><b-icon-star-fill></b-icon-star-fill> Starred Boards</h4>
						<div class="row" style="margin-top: 20px;">
							<template v-for="(starredboard, starredIndex) of board_list" v-if="starredboard.starred === 1">
								<div class="col-md-3" style="margin-bottom: 20px;">
									<div class="card" style="box-shadow: 0 8px 8px -5px rgba(0, 0, 0, 0.2);">
										<div class="card-body">
											<h6 class="card-title" style="font-family: OpenSansRegular; font-weight: 900;">
												{{ starredboard.board.board_name }}
											</h6>
											<b-button variant="secondary" size="sm" @click="visitBoard(starredboard.boards_id)">
												View
											</b-button>
											<div class="float-right">
												<b-icon-star-fill @click="removeStar(starredboard.boards_id)"></b-icon-star-fill>
											</div>
										</div>
									</div>
								</div>
							</template>
						</div>
					</template>
					<div style="margin-top: 50px;">
						<h4 style="font-family: AileronRegular;">Personal Boards</h4>
						<div class="row" style="margin-top: 20px;">
							<template v-for="(board, index) of board_list">
								<div class="col-md-3" style="margin-bottom: 20px;" v-if="board.starred == 0" @mouseover="starToggle(index)" @mouseleave="starLeaveToggle(index)">
									<div class="card" style="box-shadow: 0 8px 8px -5px rgba(0, 0, 0, 0.2);">
										<div class="card-body">
											<h6 class="card-title" style="font-family: OpenSansRegular; font-weight: 900;">
												{{ board.board.board_name }}
											</h6>
											<b-button class="col-3" variant="secondary" size="sm" @click="visitBoard(board.boards_id)">
												View
											</b-button>
											<div class="float-right">
												<b-icon-star-fill v-show="hiddenStarIcon[index]" @click="starBoard(board.boards_id)"></b-icon-star-fill>
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
	props: ['boardlist'],
	data() {
		return {
			board_list: this.boardlist,
			newBoard: {
				name: '',
				description: ''
			},
			hiddenStarIcon: {}
		}
	},

	methods: {
		visitBoard(id) {
			window.open("http://localhost/trello-vue/public/board/" + id);
		},

		getBoardList() {
			axios.get('get_board_list')
			.then((response) => {
				this.board_list = response.data.board_list;
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
			axios.post('update_board_status', {
				boardId: id,
				status: 1
			})
			.then((response) => {
				this.board_list = response.data;
			});
		},

		removeStar(id) {
			axios.post('update_board_status', {
				boardId: id,
				status: 0
			})
			.then((response) => {
				this.board_list = response.data;
			});
		},

		saveNewBoard() {
			axios.post('new_board', {
				boardInfo: this.newBoard
			})
			.then((response) => {
				this.board_list = response.data;
				this.newBoard = { 'name': '', 'description': '' };
				this.$refs.newBoardModal.hide();
			});
		},
	}
};
</script>

<style>
body {
	background-color: #F8F9F9;
}
</style>
