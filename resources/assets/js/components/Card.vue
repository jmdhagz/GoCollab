<template>
	<div>
		<ul class="list-group list-group-flush">
			<draggable v-model="card_lists" :options="{animation: 200, group: 'card_lists'}" @add="onAdd($event, lists)">
				<li class="list-group-item" v-for="(card, index) of card_lists" v-if="card.board_lists_id === lists.id" :key="card.id" :cardId="card.id">{{ card.card_name }}</li>
			</draggable>
		</ul>
	</div>
</template>

<script>
	import draggable from 'vuedraggable';
	export default {
		props: ['lists', 'cardlists'],
		data() {
			return {
				card_lists: this.cardlists
			}
		},
		components: {
			draggable
		},

		created() {
			this.getCards();
		},

		methods: {
			changeMove(event) {
				console.log(event.draggedContext.element.assignment_name);
			},

			getCards() {
				axios.get('get_cards')
				.then((response) => {
					this.card_lists = response.data.card_lists;
				});
			},

			onAdd(evt, lists) {
				console.log(evt);
				let cardId = evt.item.getAttribute('cardId');
				let listId = lists.id;
				axios.post('change_list', {
					cardId: cardId,
					listId: listId
				})
				.then((response) => {
					alert();
				});
			}
		}

	};
</script>