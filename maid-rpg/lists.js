
function roll_all(button) {
	var nodes = button.parentNode.parentNode.parentNode.childNodes
	for(var i = 1; i < nodes.length; ++i) nodes[i].lastChild.firstChild.onclick()
}

function list_add(button) {
	var node = button.parentNode.parentNode.parentNode
	node.appendChild(node.nextSibling.firstChild.cloneNode(true)).lastChild.firstChild.onclick()
}

function list_remove(button) {
	var node = button.parentNode.parentNode
	node.parentNode.removeChild(node)
}

