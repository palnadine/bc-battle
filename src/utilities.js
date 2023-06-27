let exports = {};

exports.formatAddress = (addr) => {
    var address = addr.slice(0, 6)
    address += '...'
    address += addr.slice(addr.length -4, addr.length)

    return address
};


export default exports