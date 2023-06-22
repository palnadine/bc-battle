<script setup>
import Connect from './Connect.vue';
</script>

<template>
    <div class="container">
        <div id="connectSection" class="d-flex justify-content-end">
            <Connect />
        </div>
        <h1 class="text-center">Blockchain Battle</h1>
    </div>
</template>

<style scoped>
.container {
    padding-top: 50px;
    padding-bottom: 100px;
}

#connectSection {
    height: 60px;
}

h1 {
    font-size: 4rem;
}
</style>