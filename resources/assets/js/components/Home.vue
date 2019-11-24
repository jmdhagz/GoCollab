<template>
	<div>
		<div class="container" style="margin-top: 40px;">
			<div class="row">
				<template v-for="lists of board_lists">
					<div class="col-md-4">
						<h6>{{ lists.list_name }}</h6>
						<div class="card">
							<ul class="list-group list-group-flush">
								<draggable v-model="card_lists" :options="{animation: 200, group: 'card_lists'}" @add="onAdd">
									<li class="list-group-item" v-for="(card, index) of card_lists" v-if="card.board_list_id === lists.id" :key="card.id" :cardId="card.id" :listsId="lists.id">{{ card.card_name }}</li>
								</draggable>
							</ul>
						</div>
					</div>
				</template>
			</div>
		</div>
	</div>
</template>

<script>
	import draggable from 'vuedraggable';
	export default {
		props: ['boardlists', 'cardlists'],
		data() {
			return {
				board_lists: this.boardlists,
				card_lists: this.cardlists
			}
		},
		components: {
			draggable
		},
		methods: {
			changeMove(event) {
				console.log(event.draggedContext.element.assignment_name);
			},

			onAdd(evt) {
				console.log(evt);
				let cardId = evt.item.getAttribute('cardId');
				alert(cardId);
			}
		}
	};
</script>