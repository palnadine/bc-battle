<script setup>

defineProps({
  id: Number,
  name: String,
  price: String,
  owner: String
})

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

</script>

<template>
    <div class="card text-center">
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
            <h3>{{ name }}</h3>
            <div>{{ id }}</div>
            <div>Owner: {{ owner }}</div>
            <p class="card-text">Price: {{ price }}</p>

            <div class="row">
                <div class="col"><button type="button" class="btn btn-primary">Buy</button></div>
                <div class="col"><button type="button" class="btn btn-primary">Overbid</button></div>
            </div>
        </div>
    </div>
</template>

<style scoped>

.card {
    padding: 20px 0px;
}
</style>