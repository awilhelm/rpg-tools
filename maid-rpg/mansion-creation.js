
function update_world() {
	var nodes = document.getElementById('appearance').childNodes
	for(var i = 0; i < nodes.length; ++i) nodes[i].setAttribute('class', 'hidden')
	nodes[document.getElementById('world').firstChild.selectedIndex].removeAttribute('class')
	document.getElementById('appearance').nextSibling.firstChild.onclick()
}

function roll_appearance(button) {
	var nodes = button.parentNode.previousSibling.childNodes
	for(var i = 0; i < nodes.length; ++i) if(!nodes[i].getAttribute('class')) nodes[i].selectedIndex = nodes[i].random()
}

var nodes = document.getElementById('misc').childNodes
for(var i = 0; i < nodes.length; ++i) nodes[i].lastChild.firstChild.onclick()
for(var i = 0; i < 2; ++i) document.getElementById('special-facilities').firstChild.lastChild.lastChild.onclick()

