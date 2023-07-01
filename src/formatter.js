let exports = {};

exports.formatAddress = (addr) => {
    var address = addr.slice(0, 6)
    address += '...'
    address += addr.slice(addr.length -4, addr.length)

    return address
};

exports.removeDecimals = (str) => {
    if (str.includes('.')) {
        return str.split('.')[0]
    } else {
        return str
    }
}


export default exports