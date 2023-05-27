<template>
	<div>
		<div class="container-fluid" style="margin-top: 20px;">
			<div class="row">
				<div class="col-md-12">
					<div class="scroll-wrapper">
						<div class="modified-card col-md-2">
							<div class="card" style="background-color: #DFE3E6;">
								<div class="card-body">
									<h5 class="card-title" style="font-family: AileronRegular;"><strong>New Card</strong></h5>
									<form @submit.prevent="newList()">
										<div class="form-group">
											<input type="text" class="form-control" v-model="new_list">
											<button class="btn btn-outline-primary col-md-12" style="margin-top: 10px;">Save</button>
										</div>
									</form>
								</div>
							</div>
						</div>
						<div class="modified-card col-md-2" v-for="lists of board_lists">
							<div class="card card_scroll">
								<div class="card-body">
									<h5 class="card-title" style="font-family: AileronRegular;">
										<strong>{{ lists.list_name }}</strong>
										<b-icon-gear class="float-right" v-b-modal.listSettingModal @click="selectedList(lists)"></b-icon-gear>
									</h5>
									<draggable :card_lists="lists.card_lists" animation="200" group="card_lists" @add="onAdd($event, lists)">
										<div class="card" v-for="card of lists.card_lists" :key="card.id" :cardId="card.id" style="margin-bottom: 10px; border-radius: 0.5rem; box-shadow: 0 8px 8px -5px rgba(0, 0, 0, 0.2);" @click="selectedCard(card, lists.list_name)" v-b-modal.visitcardmodal>
											<img :src="'../' +card.attachment" class="card-img-top" alt="" style="box-shadow: rgba(0, 0, 0, 0.5) 0px 3px 8px -8px">
											<div class="card-body">
												<template v-if="card.labels_id != 0">
													<div :style="{ 'background-color': card.color_name }" class="labelStyle">&nbsp;</div>	
												</template>
												<p class="cardText">{{ card.card_name }}</p>
												<template v-if="card.due_date != null">
													<p style="font-family: AileronRegular; margin-bottom: 0px; font-size: 15px; color: #798D99;">
														{{ card.due_date | moment('MMMM Do') }}
													</p>
												</template>
											</div>
										</div>
									</draggable>
									<div style="margin-top: 20px;">
										<b-button v-b-modal.newcardmodal @click="selectedListId(lists.id)" variant="secondary" class="col-md-12">Add a card</b-button>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<b-modal id="listSettingModal" centered ref="listSettingModal" size="sm" title="Edit Board" hide-footer>
			<div class="row">
				<div class="col-md-12" style="margin-top: 20px;">
					<div class="form-group">
						<input type="text" class="form-control" v-model="selected_list.list_name" @change="changeName(selected_list.id, selected_list.list_name)">
						<hr>
						<p style="margin-bottom: 0px; font-weight: 600;">ACTIONS</p>
						<b-button variant="warning" size="sm" style="margin-top: 5px;" @click="archiveBoardList(selected_list.id)" block>Archive Board</b-button>
						<b-button variant="danger" size="sm" style="margin-top: 5px;" @click="deleteBoardList(selected_list.id)" block>Delete Board</b-button>
					</div>
				</div>
			</div>
		</b-modal>
		
		<!-- New card Modal -->
		<b-modal id="newcardmodal" centered ref="newcardmodal" title="New card" hide-footer>
			<form @submit.prevent="newCard()">
				<div class="form-group" style="margin-top: 10px;">
					<label>Card Name</label>
					<input type="text" class="form-control" v-model="new_card.name" required>
				</div>
				<div class="form-group">
					<label>Description</label>
					<textarea cols="10" rows="5" v-model="new_card.description" class="form-control" required></textarea>
				</div>
				<div class="form-group">
					<b-btn variant="primary" type="submit" style="margin-top: 10px;" block>Save</b-btn>
				</div>
			</form>
		</b-modal>
		
		<!-- Visited Card Modal -->
		<b-modal id="visitcardmodal" centered ref="visitcardmodal" size="xl" hide-header hide-footer>
			<div class="row p-4 mt-4">
				<div class="col-md-9">
					<div style="width: 100%;">
						<table width="100%">	
							<tr>
								<td>
									<small>{{ selected_card_name }}</small>
									<h2 style="font-family: AileronRegular;">{{ selected_card.card_name }}</h2>
								</td>
							</tr>
						</table>
						<hr>
					</div>
					<!-- Description -->
					<div style="width: 100%;">
						<table width="100%">	
							<tr>
								<td>
									<h5 style="font-family: AileronRegular;">
										<strong>Description</strong> 
										<button class="btn btn-sm btn-outline-secondary float-right" v-show="modifyDescBtn" @click="hiddenEditDesc = !hiddenEditDesc, cancelDescBtn = !cancelDescBtn, modifyDescBtn = !modifyDescBtn">Modify</button>
										<button class="btn btn-sm btn-outline-danger float-right" v-show="cancelDescBtn" @click="cancelDescBtn = !cancelDescBtn, hiddenEditDesc = !hiddenEditDesc, modifyDescBtn = !modifyDescBtn">Cancel</button>
									</h5>
								</td>
							</tr>
							<tr>
								<td>
									<template v-if="selected_card.description != ''">
										<div style="margin-top: 20px;">
											<p style="font-family: AileronRegular;" v-show="!hiddenEditDesc">{{ selected_card.description }}</p>
										</div>
									</template>
									<template v-else>
										<div style="margin-top: 20px;">
											<b-alert v-show="!hiddenEditDesc" show variant="dark">Add a detailed description</b-alert>
										</div>
									</template>
									<div v-show="hiddenEditDesc" style="width: 100%;">
										<div class="form-group">
											<textarea class="form-control" cols="10" rows="3" v-model="selected_card.description"></textarea>
										</div>
										<div class="form-group">
											<b-button variant="success" size="sm" @click="saveEditedDesc()">Save Changes</b-button>
										</div>
									</div>
								</td>
							</tr>
						</table>
					</div>
					<!-- Attachment -->
					<template v-if="selected_card.attachment == null || selected_card.attachment == ''">
					</template>

					<template v-else>
						<table width="100%">	
							<tr>
								<td>
									<h5 style="font-family: AileronRegular;">
										<strong>Attachment</strong> 
									</h5>
								</td>
							</tr>
							<tr>
								<td>
									<div class="card">
										<img :src="'../' + selected_card.attachment" class="card-img-top">
									</div>
								</td>
							</tr>
						</table>
					</template>
					<!-- End of Description -->
					<!-- Checklist -->
					<div style="width: 100%;" class="mt-5">
						<template v-if="selected_card.checklists">
							<h5 style="font-family: AileronRegular;"><strong>Checklist</strong></h5>
							<template v-for="(checklist, index) in selected_card.checklists">
								<!-- Checlist Name -->
								<table width="100%" style="margin-top: 20px;">
									<tr>
										<td>
											<p style="font-family: AileronRegular;" class="mb-2" @click="toggleChecklistDesc(index)">
												<strong>{{ checklist.description }}</strong>
											</p>
											<div v-show="hiddenEditChecklistDesc[index]">
												<div class="form-group">
													<input type="text" class="form-control" v-model="checklist.description">
												</div>
												<div class="form-group">
													<b-button variant="success" size="sm" @click="renameChecklist(checklist, index)">Save Changes</b-button>
													<b-button variant="outline-secondary" size="sm" @click="closeEditListDesc(index)">Cancel</b-button>
												</div>
											</div>
										</td>
									</tr>
								</table>

								<!-- Checklist Item -->
								<table width="100%" style="margin-top: 20px;">
									<tr v-for="(list, listIndex) of checklist.lists">
										<td width="5%" style="padding-left: 8px; padding-bottom: 20px; padding-top: 6px; vertical-align: top;">
											<label class="checkboxContainer">
												<input type="checkbox" v-if="list.completed == 1" @click="checkBoxToogle(list.id, $event)" checked>
												<input type="checkbox" v-else @click="checkBoxToogle(list.id, $event)">
												<span class="checkmark"></span>
											</label>
										</td>
										<td v-show="!hiddenEditItemItem[listIndex]" width="90%" style="padding-bottom: 20px;" @mouseover="listMouseOver(listIndex)" @click="listItemEdit(listIndex)">
											<p :class="completed" v-if="list.completed == 1" style="font-family: AileronRegular; margin-bottom: 0px;">{{ list.description }}</p>
											<p v-else style="font-family: AileronRegular; margin-bottom: 0px;">{{ list.description }}</p>
										</td>
										<td width="90%" style="padding-bottom: 20px;" v-show="hiddenEditItemItem[listIndex]">
											<div class="form-group">
												<textarea class="form-control" cols="10" rows="5" v-model="list.description"></textarea>
											</div>
											<div class="form-group">
												<b-button variant="success" size="sm" @click="saveEditedItemDesc(list, listIndex)">Save Changes</b-button>
												<b-button variant="outline-secondary" size="sm" @click="closeEditItemList(listIndex)">Cancel</b-button>
											</div>
										</td>
										<td width="5%" style="vertical-align: top;">
											<b-button @click="deleteListItem(list.id)" size="sm" variant="danger" v-show="hiddenEditItemBtn[listIndex]"><b-icon-trash2></b-icon-trash2></b-button>
										</td>
									</tr>
								</table>

								<!-- Add Item to checlist -->
								<table v-show="!newChecklistItemHidden[index]" width="100%" style="margin-top: 20px; margin-bottom: 50px;">
									<tr>
										<td>
											<b-button variant="outline-primary" size="sm" @click="newListItemToggle(index)">Add item</b-button>
											<button v-show="!deleteChecklist[index]" class="btn btn-sm btn-danger" @click="deleteChecklistToggle(index)">Delete checklist</button>
										</td>
									</tr>
								</table>
								<!-- End of adding item to checlist -->
								
								<!-- Hidden add item form -->
								<table v-show="newChecklistItemHidden[index]" width="100%" style="margin-top: 20px;">
									<tr>
										<td>
											<div class="form-group">
												<textarea class="form-control" cols="5" rows="3" v-model="new_checklist_item"></textarea>
											</div>
											<div class="form-group">
												<b-button variant="success" size="sm" @click="saveNewItem(checklist.id)">
													 Save item
												</b-button>
												<b-button variant="outline-secondary" size="sm" @click="closeListItemToggle(index)">Cancel</b-button>
											</div>
										</td>
									</tr>
								</table>
								<!-- End of hidden add item form -->

								<!-- Hidden delete checklist container -->
								<table v-show="deleteChecklist[index]" width="100%" style="margin-top: 20px;">
									<tr>
										<td>
											<div class="card border-danger">
												<div class="card-body text-danger">
													<h5 class="card-title">Are you sure to delete this checklist?</h5>
													<button class="btn btn-danger btn-sm" @click="confirmDeleteChecklist(checklist.id, index)">Delete Checklist</button>
													<button class="btn btn-outline-secondary btn-sm" @click="cancelDeleteList(index)">Cancel</button>
												</div>
											</div>
										</td>
									</tr>
								</table>
								<!-- End of hidden delete checklist container -->
							</template>
						</template>
					</div>
					<!-- End of Checklist -->
				</div>
				<!-- Right Side functionalities -->
				<div class="col-md-3" style="margin-top: 20px;">
					<h6 style="font-family: AileronRegular;"><strong>ADD TO CARD</strong></h6>
					<!-- Label Area -->
					<div>
						<strong>
							<p style="font-family: AileronRegular; margin: 0px; padding-bottom: 10px;">
								Label
							</p>
						</strong>
						<div v-if="selected_card.labels_id != 0" :style="{ 'background-color': selected_card.color_name }" class="visitedLabelStyle" v-b-modal.labelsmodal>
							{{ selected_card.name }}
						</div>
						<div v-if="selected_card.labels_id == 0" style="background-color: #aeafb0; text-align: center;" class="visitedLabelStyle" v-b-modal.labelsmodal>
							Add label
						</div>
					</div>
					<hr>
					<!-- Due Date Area -->
					<div style="margin-top: 20px;">
						<strong>
							<p style="font-family: AileronRegular; margin: 0px; padding-bottom: 10px;">
								Due Date
							</p>
						</strong>
						<template v-if="selected_card.due_date">
							<p style="font-family: AileronRegular;">
								{{ selected_card.due_date | moment('MMMM Do YYYY') }} 
								<b-button class="float-right" variant="secondary" v-show="editDueDateHidden" size="sm" @click="editDueDateHidden = !editDueDateHidden, cancelDueDateBtn = !cancelDueDateBtn">Edit</b-button>
								<b-button class="float-right" variant="outline-danger" v-show="cancelDueDateBtn" size="sm" @click="cancelDueDateBtn = !cancelDueDateBtn, editDueDateHidden = !editDueDateHidden">Cancel</b-button>
							</p>
						</template>
						<template v-else>
							<b-button variant="secondary" block v-show="createNewDueDateBtn" @click="newDueDateHidden = !newDueDateHidden, createNewDueDateBtn = !createNewDueDateBtn">
								Add Due Date
							</b-button>
						</template>
						<div v-show="!editDueDateHidden">
							<div class="form-group">
								<date-picker v-model="selected_card.due_date" :config="options"></date-picker>
							</div>
							<div class="form-group">
								<b-button variant="success" size="sm" @click="saveEditedDueDate()">
									Save Changes
								</b-button>
							</div>
						</div>
						<div v-show="newDueDateHidden">
							<div class="form-group">
								<date-picker v-model="selected_card.due_date" :config="options"></date-picker>
							</div>
							<div class="form-group">
								<b-button variant="success" size="sm" @click="saveNewDueDate()">
									Save Changes
								</b-button>
								<b-button variant="outline-danger" size="sm" @click="createNewDueDateBtn = !createNewDueDateBtn, newDueDateHidden = !newDueDateHidden">
									Cancel
								</b-button>
							</div>
						</div>
					</div>
					<hr>
					<!-- Checklists -->
					<div style="margin-top: 20px;">
						<strong>
							<p style="font-family: AileronRegular; margin: 0px; padding-bottom: 10px;">
								Checklist
							</p>
						</strong>
						<b-button variant='secondary' block v-b-modal.newChecklistModal>
							New Checklist
						</b-button>
					</div>
					<hr>
					<div style="margin-top: 20px;">
						<h6 style="font-family: AileronRegular;"><strong>Cover</strong></h6>
						<div class="custom-file">
							<input type="file" class="custom-file-input" @change="fileChange" id="customFile">
							<label class="custom-file-label" for="customFile">{{ cardImgPreview }}</label>
						</div>

						<template v-if="selected_card.attachment == null || selected_card.attachment == ''">
							<b-button variant="primary" block @click="uploadAttachment()" style="margin-top: 10px;">Save</b-button>
						</template>

						<template v-else>
							<b-button variant="secondary" block @click="uploadAttachment()" style="margin-top: 10px;">Save</b-button>
							<b-button variant="danger" block @click="removeAttachment()" style="margin-top: 5px;">Remove</b-button>
						</template>
					</div>
					<hr>
					<div style="margin-top: 20px;">
						<h6 style="font-family: AileronRegular;"><strong>ACTIONS</strong></h6>
					</div>
					<div>
						<div class="form-group">
							<b-button variant="secondary" block @click="sendToArchive()">
								Archive Card
							</b-button>
						</div>
						<div class="form-group">
							<b-button variant="outline-danger" block @click="deleteCard()">
								Delete Card
							</b-button>
						</div>
					</div>
				</div>
			</div>
		</b-modal>

		<!-- Label Modal -->
		<b-modal id="labelsmodal" centered ref="labelsmodal" size="sm" title="Labels" hide-footer>
			<div class="row">
				<div class="col-md-12" style="margin-top: 15px;">
					<table width="100%">
						<template v-for="label of label_lists">
							<tr>
								<td width="80%" style="padding-bottom: 10px;">
									<template v-if="selected_card.labels_id != 0">
										<template v-if="label.id === selected_card.labels_id">
											<p style="margin: auto; padding: 10px; border-radius: 5px; color: white;" :style="{ 'background-color': label.color_name }" @click="addLabel(label.id)">{{ label.name }}</p>
										</template>
										<template v-else>
											<p style="margin: auto; padding: 10px; border-radius: 5px; color: white;" :style="{ 'background-color': label.color_name }" @click="addLabel(label.id)">{{ label.name }}</p>
										</template>
									</template>
									<template v-else>
										<p style="margin: auto; padding: 10px; border-radius: 5px; color: white;" :style="{ 'background-color': label.color_name }" @click="addLabel(label.id)">{{ label.name }}</p>
									</template>
								</td>
								<td width="10%" v-show="hiddenEditIcons">
									<button class="btn" @click="selectLabel(label)">edit</button>
									<button class="btn" @click="deleteLabel(label.id)">delete</button>
								</td>
								<td width="10%" v-show="hiddenEditIcons">
									<button class="btn" @click="deleteLabel(label.id)">delete</button>
								</td>
							</tr>
						</template>
					</table>
				</div>
			</div>
			<div class="row" style="margin-top: 20px;">
				<div class="col-md-12">
					<div v-show="editLabelHidden" style="margin-top: 10px;">
						<p style="margin: auto;">Edit label</p>
						<div class="form-group">
							<input type="text" class="form-control" v-model="selected_label.name">

							<b-btn variant="outline-primary" @click="saveEditedLabel()" style="margin-top: 5px;">
								Save Changes
							</b-btn>
							<b-btn variant="outline-danger" @click="editLabelHidden = !editLabelHidden, hiddenEditIcons = !hiddenEditIcons" style="margin-top: 5px;">
								Cancel
							</b-btn>
						</div>
					</div>
					<div v-show="!editLabelHidden"> 
						<b-btn variant="outline-secondary" @click="editLabelHidden = !editLabelHidden, hiddenEditIcons = !hiddenEditIcons" block>Edit Label</b-btn>
					</div>
					<hr>
					<div v-show="!newLabelHidden" style="margin-top: 5px;">
						<b-btn variant="primary" @click="newLabelHidden = !newLabelHidden" block>
							New Label
						</b-btn>
					</div>
					<div v-show="newLabelHidden" style="margin-top: 5px;">
						<b-btn variant="outline-danger" @click="newLabelHidden = !newLabelHidden" block>
							Cancel
						</b-btn>
					</div>
					<div v-show="newLabelHidden" style="margin-top: 20px;">
						<p style="margin: auto;">New label</p>
						<div class="form-group">
							<input type="text" class="form-control" v-model="new_label">
						</div>
						<div class="form-group">
							<div class="row">
								<div class="col-md-3" v-for="color of color_lists">
									<button type="button" class="btn" :style="{ 'background-color': color.color_name }" style="width: 100%; margin-bottom: 10px;" @click="selectLabelColor(color.id)">&nbsp;</button>
								</div>
							</div>
						</div>
						<div class="form-group">
							<b-btn variant="outline-primary" @click="saveNewLabel()" style="margin-top: 10px;" block>Save</b-btn>
						</div>
					</div>
				</div>
			</div>
		</b-modal>

		<b-modal id="newChecklistModal" ref="newChecklistModal" size="sm" title="New Checklist" hide-footer>
			<div class="row">
				<div class="col-md-12">
					<div class="form-group" style="margin-top: 20px;">
						<label>Name:</label>
						<input type="text" class="form-control" v-model="new_checklist">
					</div>
					<div class="form-group">
						<b-button variant="success" @click="newChecklist()">
							Save
						</b-button>
					</div>
				</div>
			</div>
		</b-modal>
	</div>
</template>

<script>
import draggable from 'vuedraggable';
import VueBootstrapTypeahead from 'vue-bootstrap-typeahead';
export default {
	props: ['id', 'boardlists', 'cardlists', 'labellists', 'colorlists', 'checklists', 'checklistitems', 'cardattachment', 'boardmemberlist'],
	data() {
		return {
			testImg: '../images/marvelphase4jpg.jpeg',
			board_id: this.id,
			board_lists: this.boardlists,
			card_lists: this.cardlists,
			label_lists: this.labellists,
			color_lists: this.colorlists,
			check_lists: this.checklists,
			checklist_items: this.checklistitems,
			card_attachment_list: this.cardattachment,
			new_list: '',
			new_card: {'name' : '', 'description': ''},
			new_checklist: '',
			new_checklist_item: '',
			selected_list_id: '',
			selected_card: [],
			selected_list: [],
			selected_card_name: '',
			completed: 'completed',
			selected_label: [],
			new_due_date: new Date(),
			options: {
				format: 'YYYY-MM-DD',
				useCurrent: false,
			},
			new_label: '',
			new_label_color: '',
			newLabelHidden: false,
			editLabelHidden: false,
			hiddenEditIcons: false,
			hiddenEditDesc: false,
			modifyDescBtn: true,
			cancelDescBtn: false,
			editDueDateHidden: true,
			cancelDueDateBtn: false,
			newDueDateHidden: false,
			hasAttachment: false,
			createNewDueDateBtn: true,
			newChecklistItemHidden: {},
			hiddenEditChecklistDesc: {},
			hiddenEditItemBtn: {},
			hiddenEditItemItem: {},
			deleteChecklist: {},
			popoverShow: false,
			form: new FormData,
			cardImg: '',
			cardImgPreview: ''
		}
	},

	components: {
		draggable,
		VueBootstrapTypeahead
	},

	methods: {
		changeMove(event) {
			console.log(event.draggedContext.element.assignment_name);
		},

		onClose() {
			this.popoverShow = false
		},

		// getCards() {
		// 	axios.get('../board/'+ this.board_id +'/get_cards')
		// 	.then((response) => {
		// 		this.card_lists = response.data.card_lists;
		// 		this.board_lists = response.data.board_lists;
		// 		this.label_lists = response.data.label_lists;
		// 		this.check_lists = response.data.check_lists;
		// 		this.checklist_items = response.data.checklist_items;
		// 		this.card_attachment_list = response.data.card_attachment;
		// 	});
		// },

		updateList(cardId, listId) {
			axios.post('../board/'+ this.board_id +'/change_list', {
				cardId: cardId,
				listId: listId,
				boardId: this.board_id
			})
			.then((response) => {
				this.board_lists = response.data;
			});
		},

		onAdd(evt, lists) {
			console.log(evt);
			let cardId = evt.item.getAttribute('cardId');
			let listId = lists.id;
			this.updateList(cardId, listId);
		},

		fileChange(e) {
			let selectedThumbnail = e.target.files[0];
			this.cardImg = selectedThumbnail;
			this.cardImgPreview = selectedThumbnail.name;
			console.log(selectedThumbnail);
		},

		uploadAttachment() {
			this.form.append('image', this.cardImg);
			this.form.append('cardId', this.selected_card.id);
			this.form.append('id', this.board_id);
			const config = { headers: { 'Content-Type': 'multipart/form-data' } }
			axios.post('../board/newAttachment', this.form, config)
			.then((response) => {
				this.cardImg = [];
				this.cardImgPreview = '';
				// this.$refs.visitcardmodal.hide();
				this.board_lists = response.data.board_list;
				this.selected_card = response.data.card;
			}).catch(error => {
				this.$refs.visitcardmodal.hide();
				this.$swal('No image selected!', '', 'warning')
			});
		},

		removeAttachment() {
			axios.post('../board/' + this.board_id + '/removeAttachment', {
				cardId: this.selected_card.id,
				boardId: this.board_id
			})
			.then((response) => {
				this.board_lists = response.data.board_list;
				this.selected_card = response.data.card;
			}).catch(error => {
				this.$swal('Failed to remove. Something went wrong.', '', 'warning')
			});
		},

		selectedList(list) {
			this.selected_list = list;
			this.selected_list_id = list.id;
		},

		selectedListId(id) {
			this.selected_list_id = id;
		},

		newList() {
			axios.post('../board/'+ this.board_id +'/new_list', {
				id: this.board_id,
				listName: this.new_list
			})
			.then((response) => {
				this.new_list = '';
				this.board_lists = response.data;
			});
		},

		newCard() {
			axios.post('../board/'+ this.board_id +'/new_card', {
				boardId: this.id,
				listId: this.selected_list_id,
				card: this.new_card,
			})
			.then((response) => {
				this.$refs.newcardmodal.hide();
				this.board_lists = response.data;
				this.new_card = { 'name': '', 'description': '' };
			});
		},

		selectedCard(card, listName) {
			this.selected_card = card;
			console.log(this.selected_card)
			this.selected_card_name = listName;
		},

		addLabel(id) {
			axios.post('../board/'+ this.board_id +'/add_label', {
				cardId: this.selected_card.id,
				labelId: id,
				boardId: this.board_id,
				archived: 0,
			})
			.then((response) => {
				// this.selectedCard(response.data.card_info, response.data.list_name);
				// this.board_lists = response.data.board_list;

				this.board_lists = response.data.board_list;
				this.selected_card = response.data.card;
			});
		},

		selectLabelColor(id) {
			this.new_label_color = id;
		},

		saveNewLabel() {
			axios.post('../board/'+ this.board_id +'/new_label', {
				labelName: this.new_label,
				labelColorId: this.new_label_color
			})
			.then((response) => {
				// this.getCards();
			});
		},

		selectLabel(label) {
			this.selected_label = label;
		},

		saveEditedLabel() {
			axios.post('../board/'+ this.board_id +'/edited_label', {
				newLabelName: this.selected_label.name,
				labelId: this.selected_label.id
			})
			.then((response) => {
				this.selected_label = [];
			});
		},

		deleteLabel(id) {
			axios.post('../board/'+ this.board_id +'/delete_label', {
				labelId: id
			})
			.then((response) => {
				// this.getCards();
			});
		},

		saveEditedDesc() {
			axios.post('../board/'+ this.board_id +'/edited_card_desc', {
				cardId: this.selected_card.id,
				cardNewDesc: this.selected_card.description
			})
			.then((response) => {
				this.hiddenEditDesc = false;
				this.modifyDescBtn = true;
				this.cancelDescBtn = false;
				// this.getCards();
			});
		},

		saveEditedDueDate() {
			axios.post('../board/'+ this.board_id +'/save_edited_due_date', {
				cardId: this.selected_card.id,
				cardNewDueDate: this.selected_card.due_date
			})
			.then((response) => {
				this.editDueDateHidden = true;
				this.cancelDueDateBtn = false;
				// this.getCards();
			});
		},

		saveNewDueDate() {
			axios.post('../board/'+ this.board_id +'/save_new_due_date', {
				cardId: this.selected_card.id,
				dueDate: this.selected_card.due_date
			})
			.then((response) => {
				this.newDueDateHidden = false;
				this.createNewDueDateBtn = false;
				// this.getCards();
			});
		},

		newChecklist() {
			axios.post('../board/'+ this.board_id +'/new_checklist', {
				checkListName: this.new_checklist,
				cardId: this.selected_card.id,
				boardId: this.board_id,
			})
			.then((response) => {
				this.new_checklist = '';
				this.$refs.newChecklistModal.hide();
				this.board_lists = response.data.board_list;
				this.selected_card = response.data.card;
			});
		},

		checkBoxToogle(id, event) {
			if (event.target.checked) {
				axios.post('../board/'+ this.board_id +'/change_list_item', {
					itemId: id,
					boardId: this.board_id,
					cardId: this.selected_card.id,
					status: 'checked'
				})
				.then((response) => {
					this.board_lists = response.data.board_list;
					this.selected_card = response.data.card;
				});
			}
			else {
				axios.post('../board/'+ this.board_id +'/change_list_item', {
					itemId: id,
					boardId: this.board_id,
					cardId: this.selected_card.id,
					status: 'unchecked'
				})
				.then((response) => {
					this.board_lists = response.data.board_list;
					this.selected_card = response.data.card;
				});
			}
		},

		saveNewItem(id) {
			axios.post('../board/'+ this.board_id +'/new_checklist_item', {
				boardId: this.board_id,
				cardId: this.selected_card.id,
				itemName: this.new_checklist_item,
				checklistId: id
			})
			.then((response) => {
				this.board_lists = response.data.board_list;
				this.selected_card = response.data.card;
				this.newChecklistItemHidden = false;
				this.new_checklist_item = '';
			});
		},

		newListItemToggle(index) {
			this.newChecklistItemHidden = {index: false};
			this.newChecklistItemHidden[index] = !this.newChecklistItemHidden[index]
		},

		closeListItemToggle(index) {
			this.newChecklistItemHidden = {index: false};
			this.newChecklistItemHidden[index] = false;
		},

		closeEditListDesc(index) {
			this.hiddenEditChecklistDesc = {index: false};
			this.hiddenEditChecklistDesc[index] = false;
		},

		listMouseOver(index) {
			this.hiddenEditItemBtn = {index: true};
			this.hiddenEditItemBtn[index] = !this.hiddenEditItemBtn[index]
		},


		toggleChecklistDesc(index) {
			this.hiddenEditChecklistDesc = {index: false};
			this.hiddenEditChecklistDesc[index] = !this.hiddenEditChecklistDesc[index]
		},

		renameChecklist(checklist, index) {
			axios.post(this.board_id +'/rename_checklist', {
				checklistId: checklist.id,
				newDesc: checklist.description
			})
			.then((response) => {
				this.hiddenEditChecklistDesc = {index: true};
				// this.getCards();
			});
		},

		listItemEdit(index) {
			this.hiddenEditItemItem = {index: false};
			this.hiddenEditItemItem[index] = !this.hiddenEditItemItem[index]
		},

		closeEditItemList(index) {
			this.hiddenEditItemItem = {index: false};
			this.hiddenEditItemItem[index] = false;
		},

		saveEditedItemDesc(listItem, index) {
			axios.post('../board/'+ this.board_id +'/modify_checklist_item', {
				listItemId: listItem.id,
				newListDesc: listItem.description
			})
			.then((response) => {
				this.hiddenEditItemItem = {index: true};
				// this.getCards();
			});
		},

		deleteListItem(id) {
			axios.post('../board/'+ this.board_id +'/delete_checklist_item', {
				listItemId: id,
				boardId: this.board_id,
				cardId: this.selected_card.id,
			})
			.then((response) => {
				this.board_lists = response.data.board_list;
				this.selected_card = response.data.card;
			});
		},

		deleteChecklistToggle(index) {
			this.deleteChecklist = {index: false};
			this.deleteChecklist[index] = !this.deleteChecklist[index];
		},

		cancelDeleteList(index) {
			this.deleteChecklist = {index: false};
			this.deleteChecklist[index] = false;
		},

		confirmDeleteChecklist(id, index) {
			axios.post('../board/'+ this.board_id +'/delete_checklist', {
				checklistId: id,
				boardId: this.board_id,
				cardId: this.selected_card.id
			})
			.then((response) => {
				this.board_lists = response.data.board_list;
				this.selected_card = response.data.card;
				this.deleteChecklist = {index: true};
			});
		},

		changeName(id, newName) {
			axios.post('../board/board_new_name', {
				boardId: id,
				boardNewName: newName
			})
			.then((response) => {
				this.$refs.listSettingModal.hide();
			});
		},

		sendToArchive() {
			axios.post('../board/'+ this.board_id +'/sendToArchive', {
				cardId: this.selected_card.id,
				boardId: this.board_id
			})
			.then((response) => {
				this.board_lists = response.data;
				this.$refs.visitcardmodal.hide();
			});
		},
		// Archive Board including cards
		archiveBoardList(id) {
			this.$swal({
				title: 'Are you sure to archive this board including the card/s on it?',
				showCancelButton: true,
				confirmButtonColor: '#3085d6',
				cancelButtonColor: '#d33',
				confirmButtonText: 'Confirm'
			}).then((result) => {
				if (result.value) {
					axios.post('../board/archiveBoard', {
						listId: id,
						boardId: this.board_id
					})
					.then((response) => {
						this.$swal({
							type: 'success',
							title: 'Archived!',
							showConfirmButton: false,
							timer: 1500
						})
						this.$refs.listSettingModal.hide();
						this.board_lists = response.data;
					});
				}
			})
		},
		// Delete Board
		deleteBoardList(id) {
			this.$swal({
				title: 'Are you sure to delete this board including the list on it permanently?',
				showCancelButton: true,
				confirmButtonColor: '#3085d6',
				cancelButtonColor: '#d33',
				confirmButtonText: 'Delete'
			}).then((result) => {
				if (result.value) {
					axios.post('../board/deleteBoardList', {
						listId: id,
						boardId: this.board_id
					})
					.then((response) => {
						this.$swal({
							type: 'success',
							title: 'Deleted!',
							showConfirmButton: false,
							timer: 1500
						})
						this.$refs.listSettingModal.hide();
						this.board_lists = response.data;
					});
				}
			})
		},
		deleteCard() {
			this.$swal({
				title: 'Are you sure to delete this card?',
				showCancelButton: true,
				confirmButtonColor: '#3085d6',
				cancelButtonColor: '#d33',
				confirmButtonText: 'Confirm'
			}).then((result) => {
				if (result.value) {
					axios.post('../board/deleteCard', {
						card: this.selected_card,
						boardId: this.board_id
					})
					.then((response) => {
						this.$swal({
							type: 'success',
							title: 'Deleted!',
							showConfirmButton: false,
							timer: 1500
						})
						this.$refs.visitcardmodal.hide();
						this.board_lists = response.data;
					});
				}
			})
		}
	}
};
</script>

<style>
body {
	background-color: #1D1E3D;
}

.scroll-wrapper {
	overflow-x: scroll;
	overflow-y: hidden;
	white-space: nowrap;
	height: 650px;
}

.modified-card {
	display: inline-block;
}

.card_scroll {
	overflow-y: scroll;
	max-height: 620px;
	background-color: #DFE3E6;
}

.card-title {
	font-family: AileronRegular;
}

.cardText {
	font-family: AileronRegular;
	margin: 0;
	white-space: pre-line;
}

.labelStyle {
	border-radius: 100px;
	width: 15%;
	height: 10px;
	margin-bottom: 5px;
}

.visitedLabelStyle {
	margin-bottom: 5px;
	padding: 10px;
	border-radius: 5px;
	color: white;
	font-family: AileronRegular;
}

.modal-body {
	padding-top: 0px !important;
}

.checkboxContainer {
	display: block;
	position: relative;
	padding-left: 35px;
	margin-bottom: 12px;
	cursor: pointer;
	font-size: 22px;
	-webkit-user-select: none;
	-moz-user-select: none;
	-ms-user-select: none;
	user-select: none;
}

/* Hide the browser's default checkbox */
.checkboxContainer input {
	position: absolute;
	opacity: 0;
	cursor: pointer;
	height: 0;
	width: 0;
}

/* Create a custom checkbox */
.checkmark {
	position: absolute;
	top: -6px;
	left: -6px;
	height: 25px;
	width: 25px;
	background-color: #eee;
	border-radius: 6px;
}

/* On mouse-over, add a grey background color */
.checkboxContainer:hover input ~ .checkmark {
	background-color: #ccc;
}

/* When the checkbox is checked, add a blue background */
.checkboxContainer input:checked ~ .checkmark {
	background-color: #cccccd;
	border-radius: 8px;
}

/* Create the checkmark/indicator (hidden when not checked) */
.checkmark:after {
	content: "";
	position: absolute;
	display: none;
}

/* Show the checkmark when checked */
.checkboxContainer input:checked ~ .checkmark:after {
	display: block;
}

/* Style the checkmark/indicator */
.checkboxContainer .checkmark:after {
	left: 10px;
	top: 7px;
	width: 5px;
	height: 10px;
	border: solid white;
	border-width: 0 3px 3px 0;
	-webkit-transform: rotate(45deg);
	-ms-transform: rotate(45deg);
	transform: rotate(45deg);
}

.completed {
	text-decoration: line-through;
	font-style: italic;
	color: #C6C8CA;
}

.swal2-container {
	z-index: 10000 !important;
}
</style>