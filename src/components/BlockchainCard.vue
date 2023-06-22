<script setup>

import { ref } from 'vue'

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
  price: String,
  owner: String,
  switchActive: Boolean
})

const toggleActive = ref(false)

function toggleOverbidSwitch() {
    toggleActive.value = !toggleActive.value
    console.log(toggleActive.value)
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
                    <td>Card</td>
                    <td>{{ id }}</td>
                </tr>
                <tr>
                    <td>Owner</td>
                    <td>{{ owner }}</td>
                </tr>
                <tr>
                    <td>Price</td>
                    <td>{{ price }}</td>
                </tr>
            </table>

            <div id="buttonArea">
                <div v-if="!toggleActive" class="d-flex justify-content-center">
                    <button id="btnBuy" class="btn btn-primary" type="button">Buy</button>
                </div>

                <div v-else class="input-group">
                    <input type="text" class="form-control" placeholder="PLS" aria-label="Overbid Price">
                    <button class="btn btn-primary" type="button">Overbid</button>
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

.card {
    padding: 20px 0px;
    background-color: #30353b;
    color: #dddddd;
}

h3 {
    margin-top: -10px;
    margin-bottom: 30px;
}

#btnBuy {
    min-width: 80px;
}

#buttonArea {
    margin-top: 30px;
    margin-bottom: 10px;
}
</style>