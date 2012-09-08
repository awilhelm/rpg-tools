
function dice(dice, faces) {
	var value = 0
	for(var i = 0; i < dice; ++i) value += Math.max(Math.ceil(Math.random() * faces), 1)
	return value
}

function roll_select(button) {
	var node = button.parentNode.previousSibling.firstChild
	node.selectedIndex = node.random()
	if(node.onchange) node.onchange()
}

Array.prototype.random = function() {
	return dice(1, this.length) - 1
}

Array.prototype.random_with_frequency = function() {
	var index = -1
	var goal = Math.random()
	for(var sum = 0; sum < goal; sum += this[++index].frequency) {}
	return index
}

Node.prototype.random = function() {
	return dice(1, this.childNodes.length) - 1
}

Node.prototype.clear = function(size) {
	while(this.childNodes.length > size) this.removeChild(this.lastChild)
}

Math.gaussian_function = function(mu, sigma) {
	return function(x) {
		return Math.exp((x - mu) * (mu - x) / sigma / sigma / 2.0) / sigma / Math.sqrt(2.0 * Math.PI)
	}
}

