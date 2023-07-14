let exports = {}

import { ethers } from "ethers";
import { ref } from 'vue'

let provider = null
let signer = null
let contract = null

const address = ref('0x0')
exports.address = address
const isConnected = ref(false)
exports.isConnected = isConnected

const addressContract = "0xb8349Fb2b5Af259b143A7c377C8F098B00371371"
const abi = [ { "inputs": [ { "internalType": "uint256", "name": "id", "type": "uint256" } ], "name": "buyCard", "outputs": [], "stateMutability": "payable", "type": "function" }, { "inputs": [], "name": "finishRound", "outputs": [], "stateMutability": "nonpayable", "type": "function" }, { "inputs": [ { "internalType": "uint256", "name": "id", "type": "uint256" } ], "name": "overbidCard", "outputs": [], "stateMutability": "payable", "type": "function" }, { "inputs": [], "stateMutability": "nonpayable", "type": "constructor" }, { "anonymous": false, "inputs": [ { "indexed": false, "internalType": "uint256", "name": "id", "type": "uint256" }, { "indexed": false, "internalType": "address", "name": "newOwner", "type": "address" } ], "name": "CardBuy", "type": "event" }, { "anonymous": false, "inputs": [ { "indexed": true, "internalType": "address", "name": "previousOwner", "type": "address" }, { "indexed": true, "internalType": "address", "name": "newOwner", "type": "address" } ], "name": "OwnershipTransferred", "type": "event" }, { "anonymous": false, "inputs": [ { "indexed": false, "internalType": "address", "name": "sender", "type": "address" }, { "indexed": false, "internalType": "uint256", "name": "amount", "type": "uint256" } ], "name": "Received", "type": "event" }, { "inputs": [], "name": "renounceOwnership", "outputs": [], "stateMutability": "nonpayable", "type": "function" }, { "inputs": [ { "internalType": "address", "name": "newOwner", "type": "address" } ], "name": "transferOwnership", "outputs": [], "stateMutability": "nonpayable", "type": "function" }, { "inputs": [], "name": "withdraw", "outputs": [], "stateMutability": "nonpayable", "type": "function" }, { "stateMutability": "payable", "type": "receive" }, { "inputs": [ { "internalType": "uint256", "name": "", "type": "uint256" } ], "name": "cards", "outputs": [ { "internalType": "uint256", "name": "id", "type": "uint256" }, { "internalType": "uint256", "name": "timer", "type": "uint256" }, { "internalType": "uint256", "name": "price", "type": "uint256" }, { "internalType": "address payable", "name": "owner", "type": "address" } ], "stateMutability": "view", "type": "function" }, { "inputs": [], "name": "getAllCards", "outputs": [ { "components": [ { "internalType": "uint256", "name": "id", "type": "uint256" }, { "internalType": "uint256", "name": "timer", "type": "uint256" }, { "internalType": "uint256", "name": "price", "type": "uint256" }, { "internalType": "address payable", "name": "owner", "type": "address" } ], "internalType": "struct BlockchainBattle.Card[]", "name": "", "type": "tuple[]" } ], "stateMutability": "view", "type": "function" }, { "inputs": [], "name": "getEndTime", "outputs": [ { "internalType": "uint256", "name": "", "type": "uint256" } ], "stateMutability": "view", "type": "function" }, { "inputs": [], "name": "getStartTime", "outputs": [ { "internalType": "uint256", "name": "", "type": "uint256" } ], "stateMutability": "view", "type": "function" }, { "inputs": [], "name": "isRoundRunning", "outputs": [ { "internalType": "bool", "name": "", "type": "bool" } ], "stateMutability": "view", "type": "function" }, { "inputs": [], "name": "owner", "outputs": [ { "internalType": "address", "name": "", "type": "address" } ], "stateMutability": "view", "type": "function" } ]

exports.connectWallet = connect;
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

      // Create a contract; connected to a Provider, so it may
      // only access read-only methods (like view and pure)
      contract = new ethers.Contract(addressContract, abi, signer)
  
      return true
    } else {
        return false
    }
}

exports.readCardValues = readCardValues
function readCardValues() {
    return contract.getAllCards()
}

exports.getGameTimerStart = getGameTimerStart
function getGameTimerStart() {
  return contract.getStartTime()
}

exports.getGameTimerEnd = getGameTimerEnd
function getGameTimerEnd() {
  return contract.getEndTime()
}

exports.buyCard = buyCard
async function buyCard(id, price) {
    let v = price
    let options = { value: v }

    const transaction = await contract.buyCard(id, options)

    console.log(transaction)
    await transaction.wait()
    console.log(transaction)
}

exports.overbidCard = overbidCard
async function overbidCard(id, amount) {
    let v = ethers.parseEther(amount)
    let options = { value: v }

    //console.log(`ID ${id}`)
    //console.log(`Amount ${v}`)
    
    const transaction = await contract.overbidCard(id, options)

    console.log(transaction)
    await transaction.wait()
    console.log(transaction)
}

export default exports