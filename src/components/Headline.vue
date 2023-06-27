<script setup>
import Connect from './Connect.vue';
</script>

<template>
    <div class="container">
        <div id="connectSection" class="d-flex justify-content-end">
            <Connect />
        </div>
        <h1 class="text-center">Blockchain Battle</h1>

        <div id="stats">
            <div class="row gx-4">
                <div class="col">
                    <div id="price-pool" class="text-center rounded-3">
                        <span>Price pool</span>
                        <p>1,000,000 PLS</p>
                    </div>
                </div>

                <div class="col">
                    <div id="current-winner" class="text-center rounded-3">
                        <span>Last flip</span>
                        <p id="winner-address">0xa7bc...35E3</p>
                    </div>
                </div>

                <div class="col">
                    <div id="timer" class="text-center rounded-3">
                        <span>Round ends in</span>
                        <p>01:45</p>
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
    background-color: #252b30;
}

#stats {
    margin-top: 40px;
    margin-bottom: 48px;
}
</style>