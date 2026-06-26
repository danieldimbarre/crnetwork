<script setup lang='ts'>
    import { ref, computed, onMounted, onUnmounted } from 'vue';
    
    interface SlotData {
    	speed?: number;
    	plate?: string;
    	class?: string;
    	model?: string;
    }
    
    interface MessagePayload {
    	action: string;
    	state?: boolean;
    	slot?: 'front' | 'back';
    	data?: SlotData;
    }
    
    const open = ref(false);
    const frozen = ref(false);
    const front = ref<SlotData | null>(null);
    const back = ref<SlotData | null>(null);
    
    const slots = computed(() => [
    	{ key: 'front', label: 'Radar Dianteiro', data: front.value },
    	{ key: 'back', label: 'Radar Traseiro', data: back.value }
    ]);
    
    const badgeClass = (value?: string) => {
    	const c = String(value || '').toLowerCase().charAt(0);
    	return c === 's' || c === 'a' || c === 'b' || c === 'c' ? c : 'a';
    };
    
    const speed = (slot: { data: SlotData | null }) => {
    	return slot.data ? Math.round(slot.data.speed || 0) : 0;
    };
    
    const handleMessage = (event: MessageEvent<MessagePayload>) => {
    	const payload = event.data;
    	if (!payload) return;
    
    	switch (payload.action) {
    		case 'toggle':
    			open.value = !!payload.state;
    			break;
    		case 'reset':
    			open.value = false;
    			frozen.value = false;
    			front.value = null;
    			back.value = null;
    			break;
    		case 'freeze':
    			frozen.value = !!payload.state;
    			break;
    		case 'slot':
    			if (payload.slot === 'front') front.value = payload.data || null;
    			if (payload.slot === 'back') back.value = payload.data || null;
    			break;
    	}
    };
    
    onMounted(() => {
    	window.addEventListener('message', handleMessage);
    });
    
    onUnmounted(() => {
    	window.removeEventListener('message', handleMessage);
    });
</script>

<template>
	<transition name='slide'>
		<div class='radar' v-if='open'>
			<div
				v-for='slot in slots'
				:key='slot.key'
				class='card'
				:class='{ frozen }'
			>
				<div class='top'>
					<span class='title'>{{ slot.label }}</span>
				</div>
				<div class='grid'>
					<div class='box speed span'>
						<span class='k'>Velocidade</span>
						<span class='num'>{{ speed(slot) }}<small>km/h</small></span>
					</div>
					<div class='box'>
						<span class='k'>Placa</span>
						<span class='v'>{{ slot.data ? (slot.data.plate || '—') : '—' }}</span>
					</div>
					<div class='box cls' :class='badgeClass(slot.data?.class)'>
						<span class='k'>Classe</span>
						<span class='v'>{{ slot.data?.class || '—' }}</span>
					</div>
					<div class='box span'>
						<span class='k'>Modelo</span>
						<span class='v'>{{ slot.data?.model || '—' }}</span>
					</div>
				</div>
			</div>
		</div>
	</transition>
</template>

<style>
    * {
    	margin: 0;
    	padding: 0;
    	box-sizing: border-box;
    	user-select: none;
    	letter-spacing: .025em;
    	font-family: 'Manrope', ui-sans-serif, system-ui, sans-serif;
    }
    
    html, body, #app {
    	width: 100%;
    	height: 100%;
    	overflow: hidden;
    }
    
    body {
    	color: #fff;
    	background: transparent;
    }
    
    :root {
    	font-size: 1rem;
    	--from: 54 45 8;
    	--to: 28 23 4;
    	--inset: 255 255 255;
    	--accent: 247 199 26;
    }
    
    @media screen and (max-width:800px), screen and (max-height:600px) { :root { font-size: .35rem; } }
    @media screen and (min-width:800px) and (min-height:600px) { :root { font-size: .45rem; } }
    @media screen and (min-width:1000px) and (min-height:700px) { :root { font-size: .55rem; } }
    @media screen and (min-width:1300px) and (min-height:700px) { :root { font-size: .68rem; } }
    @media screen and (min-width:1600px) and (min-height:800px) { :root { font-size: .8rem; } }
    @media screen and (min-width:1850px) and (min-height:1000px) { :root { font-size: 1rem; } }
    
    .radar {
    	position: absolute;
    	left: 4vh;
    	bottom: 33vh;
    	display: flex;
    	flex-direction: column;
    	gap: 8px;
    	width: 14.5rem;
    }
    
    .card {
    	position: relative;
    	overflow: hidden;
    	border-radius: 10px;
    	background-image: linear-gradient(150deg, rgb(var(--from) / .96) 0%, rgb(var(--to) / .97) 100%);
    	box-shadow:
    		0 10px 50px rgba(0, 0, 0, .45),
    		0 4px 22px rgba(0, 0, 0, .28),
    		inset 0 1px 0 rgb(var(--inset) / .08);
    	transition: box-shadow .35s cubic-bezier(.4, 0, .2, 1);
    }
    
    .card.frozen {
    	box-shadow:
    		0 10px 50px rgba(0, 0, 0, .45),
    		inset 0 0 0 2px rgb(var(--accent)),
    		0 0 16px rgb(var(--accent) / .55),
    		inset 0 0 18px rgb(var(--accent) / .25);
    }
    
    .top {
    	position: relative;
    	display: flex;
    	align-items: center;
    	justify-content: center;
    	gap: .4rem;
    	padding: 7px 10px 0;
    }
    
    .top .title {
    	flex: 1;
    	text-align: center;
    	font-size: .76rem;
    	font-weight: 800;
    	letter-spacing: .12em;
    	text-transform: uppercase;
    	color: #fff;
    }
    
    .box.span { grid-column: span 2; }
    .box.cls { align-items: center; text-align: center; }
    .box.cls .v { font-weight: 900; }
    .box.cls.s .v { color: #ff5d5d; }
    .box.cls.a .v { color: rgb(var(--accent)); }
    .box.cls.b .v { color: #5fe35a; }
    .box.cls.c .v { color: #b9bdc4; }
    
    .box.speed {
    	align-items: stretch;
    	gap: 1px;
    	padding: 6px 10px 7px;
    	margin-top: 4px;
    }
    
    .box.speed .k { text-align: left; }
    .box.speed .num {
    	text-align: center;
    	font-family: 'Digital', 'Manrope', monospace;
    	font-size: 3.1rem;
    	line-height: 1;
    	color: #fff;
    	text-shadow: 0 0 18px rgba(0, 0, 0, .4);
    }
    
    .box.speed .num small {
    	font-family: 'Manrope', sans-serif;
    	font-size: .62rem;
    	font-weight: 800;
    	letter-spacing: .12em;
    	text-transform: uppercase;
    	color: rgb(var(--inset) / .6);
    	margin-left: 5px;
    }
    
    .grid {
    	display: grid;
    	grid-template-columns: 1fr auto;
    	gap: 6px;
    	padding: 0 9px 9px;
    }
    
    .box {
    	display: flex;
    	flex-direction: column;
    	gap: 0;
    	padding: 5px 8px;
    	border-radius: 6px;
    	background: rgb(var(--inset) / .1);
    	border: 1px solid rgb(var(--inset) / .3);
    	box-shadow: inset 0 1px 0 rgb(var(--inset) / .08);
    }
    
    .box .k {
    	font-size: .6rem;
    	font-weight: 800;
    	letter-spacing: .08em;
    	text-transform: uppercase;
    	color: rgb(var(--inset) / .7);
    }
    
    .box .v {
    	min-width: 0;
    	overflow: hidden;
    	white-space: nowrap;
    	text-overflow: ellipsis;
    	font-size: .9rem;
    	font-weight: 700;
    	text-transform: uppercase;
    	color: #fff;
    }
    
    .slide-enter-active, .slide-leave-active {
    	transition: all .22s cubic-bezier(.4, 0, .2, 1);
    }
    
    .slide-enter-from, .slide-leave-to {
    	opacity: 0;
    	transform: translateX(-20px);
    }
</style>