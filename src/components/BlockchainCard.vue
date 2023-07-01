<script setup>

import { ref } from 'vue'
import { onMounted } from 'vue'
import { ethers } from 'ethers'
import formatter from '@/formatter.js'

import IconBitcoin from "./icons/IconBitcoin.vue"
import IconPulsechain from "./icons/IconPulsechain.vue"
import IconEthereum from "./icons/IconEthereum.vue"
import IconBSC from "./icons/IconBSC.vue"
import IconArbitrum from "./icons/IconArbitrum.vue"
import IcomPolygon from "./icons/IconPolygon.vue"
import IconAvalanche from "./icons/IconAvalanche.vue"
import IconSolana from "./icons/IconSolana.vue"
import IconFantom from "./icons/IconFantom.vue"
import IconOptimism from "./icons/IconOptimism.vue"

const props = defineProps({
  id: Number,
  name: String,
  price: BigInt,
  owner: String
})

const toggleActive = ref(false)
const overbidValue = ref("2")
const explorerURL = "https://scan.pulsechain.com/address/"

onMounted(() => {
    //document.getElementById(`explorer-${props.id}`).href = explorerURL + props.owner
})

function toggleOverbidSwitch() {
    toggleActive.value = !toggleActive.value
    //console.log(`Switch state of card ${props.id}: ${toggleActive.value}`)
}

function buyBtnClick() {
    console.log(`Clicked card ${props.id}`)
}

function updateOverbidValue(value) {
    overbidValue.value = value
}

</script>

<template>
    <div class="card border-3">
        <IconPulsechain v-if="id == 1" />
        <IconEthereum v-else-if="id == 2" />
        <IconArbitrum v-else-if="id == 3" />
        <IconBSC v-else-if="id == 4" />
        <IcomPolygon v-else-if="id == 5" />
        <IconAvalanche v-else-if="id == 6" />
        <IconSolana v-else-if="id == 7" />
        <IconFantom v-else-if="id == 8" />
        <IconOptimism v-else-if="id == 9" />
        <IconBitcoin v-else-if="id == 10" />

        <div class="card-body">
            <h3 class="card-title text-center">{{ name }}</h3>

            <table class="table table-borderless">
                <tr>
                    <td>Timer</td>
                    <td>{{ id }} min</td>
                </tr>
                <tr>
                    <td>Owner</td>
                    <td>
                        <a :id="`explorer-${id}`" class="link-unstyled" :href="explorerURL + owner" target="_blank">{{ formatter.formatAddress(owner) }}</a>
                    </td>
                </tr>
                <tr>
                    <td>Price</td>
                    <td>{{ formatter.removeDecimals(ethers.formatEther(price)) }} PLS</td>
                </tr>
            </table>

            <div class="buttonArea">
                <div v-if="!toggleActive" class="d-flex justify-content-center">
                    <button :id="`btn-buy-${id}`" class="btn btn-primary btn-buy" type="button" @click="$emit('buy')">Buy</button>
                </div>

                <div v-else class="input-group">
                    <input type="number" class="form-control" placeholder="PLS" aria-label="Overbid Price"
                        :step="formatter.removeDecimals(ethers.formatEther(price * 2n))" 
                        :min="formatter.removeDecimals(ethers.formatEther(price * 2n))" 
                        :value="overbidValue"
                        @input="updateOverbidValue($event.currentTarget.value)"
                    >
                    <button class="btn btn-primary" type="button" @click="$emit('overbid', props.id, overbidValue)">Overbid</button>
                </div>
            </div>

            <div class="d-flex justify-content-center">
                <div style="padding-right: 10px;">Overbid</div>
                <div class="form-check form-switch">
                    <input id="flexSwitchCheckChecked" class="form-check-input" type="checkbox" role="switch" @click="toggleOverbidSwitch">
                </div>                
            </div>
        </div>
    </div>
</template>

<style scoped>
.link-unstyled, .link-unstyled:link, .link-unstyled:hover {
    padding: 0px;
    color: inherit;
    text-decoration: inherit;
    background-color: #30353b;
}
.card {
    padding-top: 16px;
    background-color: #30353b;
    color: #dddddd;
}

h3 {
    margin-top: -10px;
    margin-bottom: 30px;
}

.btn-buy {
    min-width: 80px;
}

.buttonArea {
    margin-top: 30px;
    margin-bottom: 10px;
}
</style>