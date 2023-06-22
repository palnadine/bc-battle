<script setup>
import Headline from './components/Headline.vue';
import BlockchainCard from './components/BlockchainCard.vue'

</script>

<template>
  <header>
    <Headline />
  </header>

  <main>
    <div class="container">
      <div class="row row-cols-2 row-cols-lg-5 g-2 g-lg-4">
        <div class="col"><BlockchainCard :id="1" name="PulseChain" owner="0x1281...3213" price="1000 PLS" :switch-active="false" /></div>
        <div class="col"><BlockchainCard :id="2" name="Ethereum" owner="0x1281...3213" price="1000 PLS" :switch-active="false" /></div>
        <div class="col"><BlockchainCard :id="3" name="Arbitrum" owner="0x1281...3213" price="1000 PLS" :switch-active="false" /></div>
        <div class="col"><BlockchainCard :id="4" name="BSC" owner="0x1281...3213" price="1000 PLS" :switch-active="false" /></div>
        <div class="col"><BlockchainCard :id="5" name="Polygon" owner="0x1281...3213" price="1000 PLS" :switch-active="false" /></div>
        <div class="col"><BlockchainCard :id="6" name="Avalanche" owner="0x1281...3213" price="1000 PLS" :switch-active="false" /></div>
        <div class="col"><BlockchainCard :id="7" name="Solana" owner="0x1281...3213" price="1000 PLS" :switch-active="false" /></div>
        <div class="col"><BlockchainCard :id="8" name="Fantom" owner="0x1281...3213" price="1000 PLS" :switch-active="false" /></div>
        <div class="col"><BlockchainCard :id="9" name="Optimism" owner="0x1281...3213" price="1000 PLS" :switch-active="false" /></div>
        <div class="col"><BlockchainCard :id="10" name="Bitcoin" owner="0x1281...3213" price="1000 PLS" :switch-active="false" /></div>
      </div>
    </div>
  </main>
</template>

<style scoped>
.container {
  padding-bottom: 100px;
}
</style>
