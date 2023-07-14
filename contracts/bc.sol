// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.19;

import "@openzeppelin/contracts/access/Ownable.sol";

contract BlockchainBattle is Ownable {

    // Events
    event Received(
        address sender,
        uint amount
    );

    event CardBuy(
        uint256 id, 
        uint256 potSize,
        address newOwner
    );

    // Data
    struct Card {
        uint256 id;
        uint256 timer;
        uint256 price;
        address payable owner;
    }

    Card[] public cards;
    uint256 private lastBuyCardId;

    uint256 private timerGameStart;
    uint256 private timerGameEnds; // end time is 0 if the game has not started yet

    // Settings
    uint256 constant private MAX_CARDS = 10;
    uint256 constant private CARD_PRICE = 1 ether;
    uint256 constant private PERCENT_POT_SIZE = 80;
    uint256 constant private PERCENT_DEV = 5;

    uint256 constant private GAME_PAUSE = 10 minutes;
    uint256 constant private CARD_TIME_BASE = 1 minutes;
    uint256 constant private CARD_TIME_INCR = 1 minutes;

    // Modifier
    modifier withinTime() {
        uint256 timeNow = block.timestamp;
        require(timeNow >= timerGameStart, "Game has not started yet");
        require(timeNow <= timerGameEnds || timerGameEnds == 0, "Game has already ended");
        _;
    }

    // Functions
    constructor() {
        for (uint256 i = 0; i < MAX_CARDS; i++) {
            cards.push(Card(0, 0, 0, payable(0x0)));
        }

        _setupNewRound(false);
    }

    receive() external payable {
        emit Received(msg.sender, msg.value);
    }

    function finishRound() public {
        uint256 timeNow = block.timestamp;
        require(timeNow > timerGameEnds && timerGameEnds != 0, "Game has not finished yet");
        
        require(lastBuyCardId > 0, "Card index too low");
        uint256 cardIndex = lastBuyCardId - 1;
        uint256 potSize = getPotSize();
        address payable winner = cards[cardIndex].owner;

        _setupNewRound(true);

        // payout winner
        (bool sent, ) = winner.call{value: potSize}("");
        require(sent, "Failed to send Ether");
    }

    function _setupNewRound(bool makePause) private {
        // set timers and state
        timerGameStart = makePause ? block.timestamp + GAME_PAUSE : block.timestamp;
        timerGameEnds = 0;

        lastBuyCardId = 0;

        _resetCards();
    }

    function getAllCards() public view returns(Card[] memory) {
        return cards;
    }

    function getStartTime() public view returns(uint256) {
        return timerGameStart;
    }

    function getEndTime() public view returns(uint256) {
        return timerGameEnds;
    }

    function getPotSize() public view returns(uint256) {
        uint256 balance = address(this).balance;
        uint256 potSize = (balance / 100) * PERCENT_POT_SIZE;

        return potSize;
    }

    function getLastBuyCardId() public view returns(uint256) {
        return lastBuyCardId;
    }

    function isRoundRunning() public view returns(bool) {
        uint256 timeNow = block.timestamp;
        bool gameStarted = timeNow >= timerGameStart;
        bool gameEnded = timeNow > timerGameEnds || timerGameEnds == 0;

        return (gameStarted && !gameEnded);
    }

    function _resetCards() internal {
        for (uint256 i = 0; i < MAX_CARDS; i++) {
            uint256 id = i + 1;
            uint256 timer = CARD_TIME_BASE + (i * CARD_TIME_INCR);
            uint256 price = CARD_PRICE;
            address payable owner = payable(this);

            Card storage c = cards[i];
            c.id = id;
            c.timer = timer;
            c.price = price;
            c.owner = owner;
        }
    }

    function buyCard(uint256 id) public payable {
        _buyCard(id, msg.value);
    }

    function overbidCard(uint256 id) public payable {
        Card storage card = cards[id - 1];
        uint256 price = card.price;

        // enough PLS
        require(msg.value >= price);
        uint256 residual = msg.value - price;

        // buy the card
        _buyCard(id, price);

        // return residual PLS
        if (residual > 0) {
            (bool sent, ) = msg.sender.call{value: residual}("");
            require(sent, "Failed to send Ether");
        }
    }

    function _buyCard(uint256 id, uint256 amount) internal withinTime() {
        // valid id
        require(id >= 1 && id <= MAX_CARDS, "Invalid card id");

        // exact amount of PLS sent
        Card storage card = cards[id - 1];
        require(card.owner != msg.sender, "Cannot buy own card");
        require(amount == card.price, "Sent amount does not match with card price");

        // make changes to state
        address payable oldOwner = card.owner;
        uint256 oldPrice = card.price;

        card.price = card.price * 2;
        card.owner = payable(msg.sender);

        timerGameEnds = block.timestamp + card.timer;

        lastBuyCardId = id;

        // previous card owner could be this contract
        if (oldOwner != payable(this)) {
            // 75% of card price will be send to previous card owner
            uint256 value = (oldPrice / 100) * 75;

            (bool sent, ) = oldOwner.call{value: value}("");
            require(sent, "Failed to send Ether");
        }

        emit CardBuy(id, getPotSize(), msg.sender);
    }

    function withdraw() public onlyOwner() {
        address payable owner = payable(owner());
        uint256 balance = address(this).balance;
        owner.transfer(balance);
    }
}