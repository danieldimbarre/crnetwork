var app = new Vue ({
	el: '#app',
	template : `<div v-if="menu" class="menuContainer">

		<img src="./assets/menuBackground.png" alt="">

		<div class="menuContent">
			<header>
				<h1>{{selectedCategory == 'hair' ? 'Micropigmentação' : 
					(selectedCategory == 'head' ? 'Cabeça' : (
						selectedCategory == 'torso' ? 'Torso' : (
							selectedCategory == 'leftarm' ? 'Braço Esquerdo' : (
								selectedCategory == 'rightarm' ? 'Braço Direito' : (
									selectedCategory == 'leftleg' ? 'Braço Esquerdo' : (
										selectedCategory == 'leftleg' ? 'Perna Esquerda' : (
											selectedCategory == 'rightleg' ? 'Perna Direita' : ''
										)
									)
								)
							)
						)
					))
				}}</h1>
			</header>

			<nav>
				<div @click="selectedCategory = 'hair',selectedComponent = -1" :class="{selectedCategory: selectedCategory == 'hair'}" class="categoryIcon">
					<img src="./assets/categoryIcon1.svg" alt="">
				</div>
				<div @click="selectedCategory = 'head',selectedComponent = -1" :class="{selectedCategory: selectedCategory == 'head'}" class="categoryIcon">
					<img src="./assets/categoryIcon2.svg" alt="">
				</div>
				<div @click="selectedCategory = 'torso',selectedComponent = -1" :class="{selectedCategory: selectedCategory == 'torso'}" class="categoryIcon">
					<img src="./assets/categoryIcon3.svg" alt="">
				</div>
				<div @click="selectedCategory = 'leftarm',selectedComponent = -1" :class="{selectedCategory: selectedCategory == 'leftarm'}" class="categoryIcon">
					<img src="./assets/categoryIcon4.svg" alt="">
				</div>
				<div @click="selectedCategory = 'rightarm',selectedComponent = -1" :class="{selectedCategory: selectedCategory == 'rightarm'}" class="categoryIcon">
					<img src="./assets/categoryIcon5.svg" alt="">
				</div>
				<div @click="selectedCategory = 'leftleg',selectedComponent = -1" :class="{selectedCategory: selectedCategory == 'leftleg'}" class="categoryIcon">
					<img src="./assets/categoryIcon6.svg" alt="">
				</div>
				<div @click="selectedCategory = 'rightleg',selectedComponent = -1" :class="{selectedCategory: selectedCategory == 'rightleg'}" class="categoryIcon">
					<img src="./assets/categoryIcon7.svg" alt="">
				</div>
			</nav>

			<main>
				<div @click="selectItem(index)" :class="{purchasedItem: components[selectedCategory][index].purchased || selectedComponent -1 == index}" v-for="(v,index) in components[selectedCategory]" class="item">
					<h1>{{index + 1}}</h1>
				</div>
			</main>

			<footer>
				<div @click="limpar" class="button">
					<h1>Limpar</h1>
				</div>
				<div @click="closeUI" class="button">
					<h1>Salvar</h1>
				</div>
			</footer>
		</div>

		<div class="rotateButtonsContainer">
			<div class="rotateButtons">
				<div class="button">
					<h1>A</h1>
				</div>
				<div class="button">
					<h1>D</h1>
				</div>
			</div>

			<h1>Rotacionar</h1>
		</div>
	</div>`,

	data: {
		menu : false,
		selectedComponent : -1,
		components : {},
		selectedCategory : 'hair'
	},

	methods: {
		rotateDirection(direction){
			if (direction == 'menos'){
				axios.post('http://tattoos/Rotate',{ direction: 'Left' })
			} else if(direction == 'mais'){
				axios.post('http://tattoos/Rotate',{ direction: 'Right' })
			}
		},

		selectItem(index){
			let category = this.selectedCategory
			let number = index + 1
			this.selectedComponent = number

			if (!this.components[category][index].purchased){
				this.components[category][index].purchased = true
			} else {
				this.components[category][index].purchased = false
				this.selectedComponent = -1
			}

			axios.post('http://tattoos/Change',{
				type: category,
				id : number
			})
		},

		limpar(){
			axios.post('http://tattoos/Clean');
			Object.keys(this.components).map((table,index) => {
				Object.keys(this.components[table]).map((e,tattoIndex) => {
					if (this.components[table][e].purchased){
						this.components[table][e].purchased = false
						this.selectedComponent = -1
					}
				})
			})
		},

		searchCategory(tattoName){
			Object.keys(this.components).map((table,index) => {
				Object.keys(this.components[table]).map((e,tattoIndex)=> {
					if (this.components[table][e].name == tattoName){
						this.components[table][e].purchased = true
					}
				})
			})
		},

		formatObject(data){
			Object.keys(data).map((e,index) => {
				let category = this.searchCategory(e)
			})
		},

		openUI(data,myTattos){
			this.components = data
			this.formatObject(myTattos)
			this.menu = true
		},

		closeUI(){
			this.menu = false
			this.selectedComponent = -1
			axios.post('http://tattoos/Close')
		}
	},

	mounted(){
		document.addEventListener('keydown',(event) => {
			if (app.menu){
				if (event.key == 'Escape'){
					app.closeUI();
				} else if (event.key == 'x'){
					axios.post('http://tattoos/HandsUp');
				}
			}
		});

		document.addEventListener('keypress',(event) => {
			if (event.key == 'a'){
			  app.rotateDirection('menos');
			} else if (event.key == 'd'){
			  app.rotateDirection('mais');
			}
		},false);

		window.addEventListener("message",function(event){
			app.openUI(event.data.shop,event.data.tattoo);
		});
	}
});