<script setup>
defineProps({
    source: String
})
</script>

<template>
    <img :src="source" class="rounded mx-auto d-block" alt="PulseChain">
</template>

<style scoped>
img {
    height: 80px; 
    width: 80px;
}
</style>