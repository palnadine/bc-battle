<script setup>
import { ethers } from "ethers";
import { ref } from 'vue'
import Headline from './components/Headline.vue';
import BlockchainCard from './components/BlockchainCard.vue'

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

let provider = null
let signer = null
const address = ref('0x0')
const isConnected = ref(false)

let contract



async function connect() {
  if (window.ethereum == null) {

    // If MetaMask is not installed, we use the default provider,
    // which is backed by a variety of third-party services (such
    // as INFURA). They do not have private keys installed so are
    // only have read-only access
    console.log("MetaMask not installed; using read-only defaults")
    provider = ethers.getDefaultProvider()

  } else {

    // Connect to the MetaMask EIP-1193 object. This is a standard
    // protocol that allows Ethers access to make all read-only
    // requests through MetaMask.
    provider = new ethers.BrowserProvider(window.ethereum)

    // It also provides an opportunity to request access to write
    // operations, which will be performed by the private key
    // that MetaMask manages for the user.
    signer = await provider.getSigner();
    address.value = signer.address;
    isConnected.value = true
  }

  if (isConnected.value) {
    let network = await provider.getNetwork();
    console.log(`Chain ID ${network.chainId}`)

    let addressContract = "0xbf7C75F4547e5C76EFacB3017E3D39248B26d450"
    let abi = [ { "inputs": [], "stateMutability": "nonpayable", "type": "constructor" }, { "anonymous": false, "inputs": [ { "indexed": false, "internalType": "uint256", "name": "id", "type": "uint256" }, { "indexed": false, "internalType": "address", "name": "newOwner", "type": "address" } ], "name": "CardBuy", "type": "event" }, { "anonymous": false, "inputs": [ { "indexed": true, "internalType": "address", "name": "previousOwner", "type": "address" }, { "indexed": true, "internalType": "address", "name": "newOwner", "type": "address" } ], "name": "OwnershipTransferred", "type": "event" }, { "anonymous": false, "inputs": [ { "indexed": false, "internalType": "address", "name": "sender", "type": "address" }, { "indexed": false, "internalType": "uint256", "name": "amount", "type": "uint256" } ], "name": "Received", "type": "event" }, { "inputs": [ { "internalType": "uint256", "name": "id", "type": "uint256" } ], "name": "buyCard", "outputs": [], "stateMutability": "payable", "type": "function" }, { "inputs": [ { "internalType": "uint256", "name": "", "type": "uint256" } ], "name": "cards", "outputs": [ { "internalType": "uint256", "name": "id", "type": "uint256" }, { "internalType": "uint256", "name": "timer", "type": "uint256" }, { "internalType": "uint256", "name": "price", "type": "uint256" }, { "internalType": "address payable", "name": "owner", "type": "address" } ], "stateMutability": "view", "type": "function" }, { "inputs": [], "name": "getAllCards", "outputs": [ { "components": [ { "internalType": "uint256", "name": "id", "type": "uint256" }, { "internalType": "uint256", "name": "timer", "type": "uint256" }, { "internalType": "uint256", "name": "price", "type": "uint256" }, { "internalType": "address payable", "name": "owner", "type": "address" } ], "internalType": "struct BlockchainBattle.Card[]", "name": "", "type": "tuple[]" } ], "stateMutability": "view", "type": "function" }, { "inputs": [ { "internalType": "uint256", "name": "id", "type": "uint256" } ], "name": "overbidCard", "outputs": [], "stateMutability": "payable", "type": "function" }, { "inputs": [], "name": "owner", "outputs": [ { "internalType": "address", "name": "", "type": "address" } ], "stateMutability": "view", "type": "function" }, { "inputs": [], "name": "renounceOwnership", "outputs": [], "stateMutability": "nonpayable", "type": "function" }, { "inputs": [ { "internalType": "address", "name": "newOwner", "type": "address" } ], "name": "transferOwnership", "outputs": [], "stateMutability": "nonpayable", "type": "function" }, { "inputs": [], "name": "withdraw", "outputs": [], "stateMutability": "nonpayable", "type": "function" }, { "stateMutability": "payable", "type": "receive" } ]

    // Create a contract; connected to a Provider, so it may
    // only access read-only methods (like view and pure)
    contract = new ethers.Contract(addressContract, abi, signer)

    readCardValues()
    let updater = setInterval(readCardValues, 10000);
  }
}

async function readCardValues() {
  let values = await contract.getAllCards()

  values.forEach(function(card, index) {
    cards.value[index].owner = card.owner
    cards.value[index].price = card.price

    //console.log(`Card ${cards.value[index].id} is owned by ${cards.value[index].owner} and costs ${cards.value[index].price}`)
  })
}

async function buyCard(id) {
  let v = cards.value[id - 1].price
  let options = { value: v }

  const transaction = await contract.buyCard(id, options)

  console.log(transaction)
  await transaction.wait()
  console.log(transaction)
}

async function overbidCard(id, amount) {
  let v = ethers.parseEther(amount)
  let options = { value: v }
  console.log(`ID ${id}`)
  console.log(`Amount ${v}`)
  const transaction = await contract.overbidCard(id, options)

  console.log(transaction)
  await transaction.wait()
  console.log(transaction)
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
