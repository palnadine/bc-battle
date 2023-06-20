<script setup>
import Address from './components/Address.vue'
import BlockchainCard from './components/BlockchainCard.vue'

</script>

<template>
  <header>
    <Address />
  </header>

  <main>
    <div class="container">
      <div class="row row-cols-2 row-cols-lg-1 g-2 g-lg-3">
        <div class="col"><BlockchainCard name="PulseChain" owner="0x1281...3213" price="1000 PLS" /></div>
        <div class="col"><BlockchainCard name="Bitcoin" owner="0x1281...3213" price="1000 PLS" /></div>
      </div>
    </div>
  </main>
</template>

<style scoped>
</style>
