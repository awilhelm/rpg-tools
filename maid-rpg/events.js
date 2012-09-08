
function roll_event(form) {
	var nodes = document.evaluate('.//html:div', form, ns_resolver, XPathResult.UNORDERED_NODE_SNAPSHOT_TYPE, null)

	var goal = 0
	for(var i = 0; i < nodes.snapshotLength; ++i) goal += get_frequency(i)
	goal *= Math.random()

	var index = -1
	for(var sum = 0; sum < goal; sum += get_frequency(++index)) {}

	var node = nodes.snapshotItem(index).lastChild
	var text = node.childNodes[node.random()].value
	var node = form.nextSibling.insertBefore(document.createElement('p'), form.nextSibling.firstChild)
	node.appendChild(document.createTextNode(text))
	node.onclick = remove

	return false

	function get_frequency(i) {
		return nodes.snapshotItem(i).lastChild.previousSibling.value * nodes.snapshotItem(i).lastChild.childNodes.length
	}

	function remove() {
		this.parentNode.removeChild(this)
	}

	function ns_resolver(prefix) {
		return 'http://www.w3.org/1999/xhtml'
	}
}

function clear_events(form) {
	form.nextSibling.clear(0)
	return false
}

