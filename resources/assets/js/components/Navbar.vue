<template>
	<div>
		<nav class="navbar navbar-light">
			<span class="navbar-brand mb-0 h1" style="color: white;">
				<b-icon-layout-text-sidebar-reverse style="margin-top: -5px;"></b-icon-layout-text-sidebar-reverse>&nbsp;&nbsp;{{ board_info.board_name }}
			</span>
			<span class="navbar-text">
				<b-button style="background-color: #1D1E3D !important; border: #1D1E3D !important;" size="md" v-b-modal.membersModal v-b-tooltip.hover title="Members">
					<b-icon-people></b-icon-people>
				</b-button>
				<b-button style="background-color: #1D1E3D !important; border: #1D1E3D !important;" size="md" v-b-tooltip.hover title="Archived Items" @click="goArchive()">
					<b-icon-archive></b-icon-archive>
				</b-button>
				<b-button style="background-color: #1D1E3D !important; border: #1D1E3D !important;" v-b-tooltip.hover title="Home" @click="goDashboard()">
					<b-icon-grid></b-icon-grid>
				</b-button>
			</span>
		</nav>

		<b-modal id="membersModal" centered ref="membersModal" size="md" title="Board Members" hide-footer>
			<div class="row">
				<div class="col-md-12">
					<div style="margin-top: 20px;">
						<label>Search</label>
						<autocomplete ref="autocomplete" :source="user_list" input-class="form-control" @selected="selectedUser" />
					</div>
				</div>
				<div class="col-md-12" style="margin-top: 8px;">
					<b-button variant="secondary" size="md" @click="addMember()">Add to board</b-button>
				</div>
				<div class="col-md-12">
					<div style="margin-top: 20px;">
						<h5>Members List</h5>
						<template v-for="board_member in board_member_list">
							<template v-if="board_member.is_owner === 1">
								<div class="row" style="margin-bottom: 10px;">
									<div class="col-md-6">
										<p style="margin-bottom: 0px;">{{ board_member.name }}</p>
									</div>
									<div class="col-md-6">
										<b style="color: #7a7a7a;">Owner</b>
									</div>
								</div>
							</template>		
							<template v-else>
								<div class="row" style="margin-bottom: 15px;">
									<div class="col-md-6">
										<p style="margin-bottom: 0px;">{{ board_member.name }}</p>
										<p style="margin-bottom: 0px; font-size: 12px;"><b>Date Joined: </b>{{ board_member.date_joined | moment('MMMM Do') }}</p>
									</div>
									<div class="col-md-6" style="margin: auto;">
										<template v-if="user_info.id === board_member.id">
											<template v-if="board_member.is_owner === 1">
												<b-button size="sm" variant="danger" @click="removeUser(board_member.board_members_id)">Remove</b-button>
											</template>
										</template>
									</div>
								</div>
							</template>
						</template>


						<!-- <template v-for="board_member in board_member_list">
							<p>{{user_info.id}} {{board_member.id}} {{board_member.is_owner}}</p>
							<template v-if="user_info.id === board_member.id">
								
							</template>

							<template v-else>
								<div class="row" style="margin-bottom: 15px;">
									<div class="col-md-6">
										<p style="margin-bottom: 0px;">{{ board_member.name }}</p>
										<p style="margin-bottom: 0px; font-size: 12px;"><b>Date Joined: </b>{{ board_member.date_joined | moment('MMMM Do') }}</p>
									</div>
									<div class="col-md-6" style="margin: auto;">
										<template v-if="user_info.id === board_member.id">
											<template v-if="board_member.is_owner === 1">
												<b-button size="sm" variant="danger" @click="removeUser(board_member.board_members_id)">Remove</b-button>
											</template>
										</template>
									</div>
								</div>
							</template>		
						</template> -->
					</div>
				</div>
			</div>
		</b-modal>
	</div>
</template>

<script>
	export default {
		props: ['boardinfo', 'id', 'boardmemberlist', 'permissionlist', 'userlist', 'userinfo'],
		data() {
			return {
				board_info: this.boardinfo,
				board_member_list: this.boardmemberlist,
				permission_list: this.permissionlist,
				query: '',
				userArr: '',
				user_list: this.userlist,
				user_info: this.userinfo,
				permission_id: ''
				// user_list: ['Canada', 'USA', 'Brazil']
			}
		},
		methods: {
			getBoardMemberList() {
				axios.get('../board/'+ this.id +'/getBoardMember', {
					params: {
						boardId: this.id
					}
				})
				.then((response) => {
					this.user_list = response.data.user_list;
					this.board_member_list = response.data.board_member_list;
				});
			},

			goArchive() {
				window.open('../board/'+ this.id +'/archive', '_self');
			},

			getResponse: function (response) {
				console.log(response)
				// return response.data.items
			},

			goDashboard() {
				window.open('../', '_self');
			},

			selectedUser(user) {
				this.userArr = user.value
				console.log(user.value)
				console.log(user.display)
			},

			addMember() {
				axios.post('../board/'+ this.id +'/addBoardMember', {
					boardId: this.id,
					userId: this.userArr
					// permissionId: this.permission_id
				})
				.then((response) => {
					this.user_list = response.data.user_list;
					this.board_member_list = response.data.board_member_list;
					this.$refs.autocomplete.clear(); // to clear the autocomplete input after submit using ref
					this.userArr = '';
					// this.permission_id = '';
				});
			},

			removeUser(id) {
				// this.$swal('test')
				this.$swal({
					title: 'Remove this user?',
					icon: 'warning',
					showCancelButton: true,
					confirmButtonColor: '#3085d6',
					cancelButtonColor: '#DC3545',
					confirmButtonText: 'Yes, remove it!'
				}).then((result) => {
					if (result.value) {
						axios.post('../board/removeUser', {
							boardId: this.id,
							boardMemberId: id
						})
						.then((response) => {
							this.$swal({
								icon: 'success',
								title: 'Successfully Removed!',
								showConfirmButton: false,
								timer: 1000
							})
							this.user_list = response.data.user_list;
							this.board_member_list = response.data.board_member_list;
						});
					}
				})
			}

			// editUserPermission(event, id) {
			// 	axios.post('../board/editUserPermission', {
			// 		boardMemberId: id,
			// 		permissionId: event.target.value
			// 	})
			// 	.then((response) => {

			// 	});
			// }
		}
	};
</script>

<style>
	nav {
		background-color: #373972 !important;
	}

	.autocomplete__icon {
		height: 28px !important;
	}
</style>