<script setup>

import { ref } from 'vue'
import { ethers } from "ethers";

let provider;
const isConnected = ref(false)
const address = ref('0x0')

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
    let signer = await provider.getSigner();
    address.value = formatAddress(signer.address);
    isConnected.value = true
  }
}

function formatAddress(addr) {
  let address = addr.slice(0, 6)
  address += '...'
  address += addr.slice(addr.length -4, addr.length)

  return address
}

</script>

<template>
  <button v-if="!isConnected" type="button" class="btn btn-primary" @click="connect">
    Connect Wallet
  </button>

  <div v-else>
    Connected: <span id="address">{{ address }}</span> 
  </div>
</template>