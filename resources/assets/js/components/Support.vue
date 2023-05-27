<template>
	<div>
		<div class="container" style="margin-top: 20px;">
			<div class="row">
				<div class="col-md-12">
					<h1>Ticket List</h1>
					<b-button v-b-modal.newTicketModal variant="primary" size="sm">New Ticket</b-button>

					<b-modal id="newTicketModal" centered ref="newTicketModal" size="sm" title="Ticket Details" hide-footer>
						<div class="row">
							<div class="col-md-12">
								<form @submit.prevent="saveNewTicket()">
									<div class="form-group">
										<h6 style="font-family: OpenSansRegular; font-weight: 900;">Ticket Name</h6>
										<input type="text" class="form-control" v-model="newTicket.name">
									</div>
									<div class="form-group">
										<h6 style="font-family: OpenSansRegular; font-weight: 900;">Description</h6>
										<input type="text" class="form-control" v-model="newTicket.description">
									</div>
									<div class="form-group">
										<h6 style="font-family: OpenSansRegular; font-weight: 900;">Board</h6>
										<select class="form-control" @change="selectBoard" v-model="newTicket.board_id">
											<option v-for="board of board_list" :value="board.id">{{ board.board_name }}</option>
										</select>
									</div>
									<div class="form-group">
										<h6 style="font-family: OpenSansRegular; font-weight: 900;">Board List</h6>
										<select class="form-control" v-model="newTicket.list_id">
											<option v-for="list of lists" :value="list.id">{{ list.list_name }}</option>
										</select>
									</div>
									<div class="form-group">
										<b-button type="submit" variant="primary" size="md" block>Save Ticket</b-button>
									</div>	
								</form>
							</div>
						</div>
					</b-modal>
				</div>
			</div>

			<div class="row mt-3">
				<div class="col-md-12">
					<b-list-group>
						<template v-for="ticket of ticket_list">
							<b-list-group-item button v-b-modal="'editTicketModal'+ticket.id">
								<div class="d-flex w-100 justify-content-between">
									<h5 class="mb-1">{{ ticket.name }}</h5>
									<small class="text-muted">{{ ticket.date | moment('MMMM D, YYYY') }}</small>
								</div>

								<p class="mb-1">
									{{ ticket.description }}
								</p>
							</b-list-group-item>

							<b-modal :id="'editTicketModal'+ticket.id" centered ref="editTicketModal" size="sm" title="Ticket Details" hide-footer>
								<div class="row">
									<div class="col-md-12">
										<form @submit.prevent="updateTicket(ticket)">
											<div class="form-group">
												<h6 style="font-family: OpenSansRegular; font-weight: 900;">Ticket Name</h6>
												<input type="text" class="form-control" v-model="ticket.name">
											</div>
											<div class="form-group">
												<h6 style="font-family: OpenSansRegular; font-weight: 900;">Description</h6>
												<input type="text" class="form-control" v-model="ticket.description">
											</div>
											<div class="form-group">
												<b-button type="submit" variant="primary" size="md" block>Update</b-button>
												<b-button type="button" variant="danger" size="md" block @click="deleteTicket(ticket)">Delete</b-button>
											</div>	
										</form>
									</div>
								</div>
							</b-modal>
						</template>
					</b-list-group>


				</div>
			</div>
		</div>
	</div>
</template>

<script>
	export default {
		props: ['boardlist', 'ticketlist'],
		data() {
			return {
				board_list: this.boardlist,
				ticket_list: this.ticketlist,
				newTicket: { 'name': '', 'description': '', 'board_id' : '', 'list_id': '' },
				editTicket: { 'name': '', 'description': '' },
				boardId: '',
				selectedBoard: [],
				lists: []
			}
		},
		created() {
			console.log(this.ticket_list)
		},
		methods: {
			selectBoard(event) {
				this.lists = [];
				this.board_list.filter((board) => {
					if (board.id == this.newTicket.board_id) {
						this.lists = board.lists;
					}
				})
			},
			saveNewTicket() {
				axios.post('support/new_ticket', {
					ticket: this.newTicket
				})
				.then((response) => {
					this.ticket_list = response.data;
					this.newTicket = { 'name': '', 'description': '', 'board_id' : '', 'list_id': '' };
					this.$refs.newTicketModal.hide();
				});
			},
			updateTicket(ticket) {
				axios.post('support/update_ticket', {
					ticket: ticket,
					card: ticket.card
				})
				.then((response) => {
					this.ticket_list = response.data;
					this.$bvModal.hide('editTicketModal'+ticket.id);
				});
			},
			deleteTicket(ticket) {
				axios.post('support/delete_ticket', {
					ticket: ticket,
					card: ticket.card,
				})
				.then((response) => {
					this.$bvModal.hide('editTicketModal'+ticket.id);
					this.ticket_list = response.data;
				});
			}
		}
	}
</script>