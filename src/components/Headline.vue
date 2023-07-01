<script setup>
import formatter from '@/formatter.js'

const props = defineProps({
  isConnected: Boolean,
  address: String
})
</script>

<template>
    <div class="container">
        <div id="connectSection" class="d-flex justify-content-end">
            <button v-if="!isConnected" id="connectBtn" type="button" class="btn btn-primary" @click="$emit('connect')">
                Connect Wallet
            </button>

            <div v-else>
                Connected: <span id="address">{{ formatter.formatAddress(address) }}</span> 
            </div>
        </div>
        <h1 class="text-center">Blockchain Battle</h1>

        <div id="stats">
            <div class="row gx-4">
                <div class="col">
                    <div id="price-pool" class="text-center rounded-3">
                        <p>1,000,000 PLS</p>
                        <span>Price pool</span>
                    </div>
                </div>

                <div class="col">
                    <div id="current-winner" class="text-center rounded-3">
                        <p id="winner-address">0xa7bc...35E3</p>
                        <span>Last flip</span>
                    </div>
                </div>

                <div class="col">
                    <div id="timer" class="text-center rounded-3">
                        <p>01:45</p>
                        <span>Round ends in</span>
                    </div>
                </div>
            </div>
        </div>
                
    </div>
</template>

<style scoped>
h1 {
    font-size: 3rem;
}

span {
    font-size: 1.5rem;
    font-weight: 500;
}

p {
    color: #eeeeee;
    font-size: 2rem;
    font-weight: 500;
    margin-bottom: 0px;
}

#price-pool, #current-winner, #timer {
    padding: 20px;
    background-color: #2a3136;
}

#connectBtn {
  height: 60px;
}

#address {
    font-size: 1rem;
    font-weight: 400;
}

#stats {
    margin-top: 40px;
    margin-bottom: 48px;
}
</style>