<script setup>
import { ref } from 'vue'
import Headline from './components/Headline.vue';
import BlockchainCard from './components/BlockchainCard.vue'
import contracts from '@/contracts.js'

let isConnected = contracts.isConnected
let address = contracts.address

const cards = ref([
    { id: 1, name: "PulseChain", owner: "0xDEC72f2D7F6Ab68cd7A03900307d87B72F249CfC", price: 1000000000000000000n },
    { id: 2, name: "Ethereum", owner: "0xDEC72f2D7F6Ab68cd7A03900307d87B72F249CfC", price: 1000000000000000000n },
    { id: 3, name: "Arbitrum", owner: "0xDEC72f2D7F6Ab68cd7A03900307d87B72F249CfC", price: 1000000000000000000n },
    { id: 4, name: "BSC", owner: "0xDEC72f2D7F6Ab68cd7A03900307d87B72F249CfC", price: 1000000000000000000n },
    { id: 5, name: "Polygon", owner: "0xDEC72f2D7F6Ab68cd7A03900307d87B72F249CfC", price: 1000000000000000000n },
    { id: 6, name: "Avalanche", owner: "0xDEC72f2D7F6Ab68cd7A03900307d87B72F249CfC", price: 1000000000000000000n },
    { id: 7, name: "Solana", owner: "0xDEC72f2D7F6Ab68cd7A03900307d87B72F249CfC", price: 1000000000000000000n },
    { id: 8, name: "Fantom", owner: "0xDEC72f2D7F6Ab68cd7A03900307d87B72F249CfC", price: 1000000000000000000n },
    { id: 9, name: "Optimism", owner: "0xDEC72f2D7F6Ab68cd7A03900307d87B72F249CfC", price: 1000000000000000000n },
    { id: 10, name: "Bitcoin", owner: "0xDEC72f2D7F6Ab68cd7A03900307d87B72F249CfC", price: 1000000000000000000n },
]);

async function connect() {
  isConnected = await contracts.connectWallet()

  if (isConnected) {
    getData()
    let updater = setInterval(getData, 10000);
  }
}

async function getData() {
  readCardValues()
  getGameTimerStart()
  getGameTimerEnd()
}

async function readCardValues() {
  let values = await contracts.readCardValues()

  values.forEach(function(card, index) {
    cards.value[index].owner = card.owner
    cards.value[index].price = card.price

    //console.log(`Card ${cards.value[index].id} is owned by ${cards.value[index].owner} and costs ${cards.value[index].price}`)
  })
}

async function getGameTimerStart() {
  let timer = await contracts.getGameTimerStart()
  console.log(timer)
}

async function getGameTimerEnd() {
  let timer = await contracts.getGameTimerEnd()
  console.log(timer)
}

function buyCard(id) {
  let price = cards.value[id - 1].price
  contracts.buyCard(id, price)
}

function overbidCard(id, amount) {
  contracts.overbidCard(id, amount)
}

</script>

<template>
  <header>
    <Headline :is-connected="isConnected" :address="address" @connect="connect"/>
  </header>

  <main>
    <div id="cardRoster" class="container">
      <div class="row row-cols-2 row-cols-lg-5 g-2 g-lg-4">
        <div v-for="card in cards" :key="card.id">
          <BlockchainCard :id="card.id" :name="card.name" :owner="card.owner" :price="card.price" @buy="buyCard(card.id)" @overbid="overbidCard"/>
        </div>
      </div>
    </div>
  </main>
</template>

<style scoped>
#cardRoster {
  padding-bottom: 100px;
}
</style>
