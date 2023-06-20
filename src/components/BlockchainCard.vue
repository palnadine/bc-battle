<script setup>

defineProps({
  name: String,
  price: String,
  owner: String
})

import { ethers } from "ethers";
import IconBlockchain from "./icons/IconBlockchain.vue";

</script>

<template>
    <div class="card text-center">
        <IconBlockchain />

        <div class="card-body">
            <h3>{{ name }}</h3>
            <p class="card-text">Owner: {{ owner }}</p>
            <p class="card-text">Price: {{ price }}</p>
            <button type="button" class="btn btn-primary">Buy</button>
        </div>
    </div>
</template>

<style scoped>

.card {
    padding: 20px;
}
</style>