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

    // Settings
    uint256 constant private MAX_CARDS = 10;
    uint256 constant private CARD_PRICE = 1 ether;

    // Functions
    constructor() {
        for (uint256 i = 0; i < MAX_CARDS; i++) {
            cards.push(Card(0, 0, 0, payable(0x0)));
        }

        resetCards();
    }

    receive() external payable {
        emit Received(msg.sender, msg.value);
    }

    function getAllCards() public view returns(Card[] memory) {
        return cards;
    }

    function resetCards() internal {
        for (uint256 i = 0; i < MAX_CARDS; i++) {
            uint256 id = i + 1;
            uint256 timer = 60 * id;
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

    function _buyCard(uint256 id, uint256 amount) internal {
        // valid id
        require(id >= 1 && id <= MAX_CARDS);

        // exact amount of PLS sent
        Card storage card = cards[id - 1];
        require(card.owner != msg.sender, "Cannot buy own card");
        require(amount == card.price, "Sent amount does not match with card price");

        address payable oldOwner = card.owner;
        uint256 oldPrice = card.price;
        card.price = card.price * 2;
        card.owner = payable(msg.sender);

        // previous card owner could be this contract
        if (oldOwner != payable(this)) {
            // 75% of card price will be send to previous card owner
            uint256 value = (oldPrice / 100) * 75;

            (bool sent, ) = oldOwner.call{value: value}("");
            require(sent, "Failed to send Ether");
        }

        emit CardBuy(id, msg.sender);
    }

    function withdraw() public onlyOwner() {
        address payable owner = payable(owner());
        uint256 balance = address(this).balance;
        owner.transfer(balance);
    }
}