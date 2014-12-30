
function roll_age(button) {
	button.parentNode.previousSibling.firstChild.value = dice(1, 56) + 10
}

function roll_attribute(button, attribute) {
	var node = button.parentNode.previousSibling.firstChild
	switch(attribute) {
		case 'will':
		node.value = dice(2, 6)
		break

		case 'luck':
		node.value = Math.floor(dice(2, 6) / 3)
		break

		default:
		node.value = Math.floor(dice(2, 6) / 2)
	}
	node.onchange()
}

function update_attribute(td) {
	td.childNodes[4].value = Number(td.childNodes[0].value) + Number(td.childNodes[2].value)
}

function attribute_changed(input) {
	update_attribute(input.parentNode)
}

function type_changed(select, type_id) {
	var attributes = document.getElementById('attributes').childNodes
	var types = document.getElementById('types').childNodes
	for(var i = 1; i < attributes.length; ++i) {
		var input = attributes[i].childNodes[1].childNodes[2]
		input.value = 0
		for(var j = 1; j < types.length; ++j) input.value = Number(input.value) + Number(butler_types[types[j].childNodes[1].firstChild.selectedIndex].attributes[i - 1])
		attribute_changed(input)
	}

	var powers = document.getElementById('powers')
	var old_power = powers.childNodes[type_id]
	var new_power = powers.insertBefore(powers.nextSibling.childNodes[select.selectedIndex].cloneNode(true), old_power)
	powers.removeChild(old_power)
	roll_power(new_power.lastChild.firstChild)
}

function select_same(nodes, i1, i2) {
	return nodes[i1].childNodes[1].firstChild.selectedIndex == nodes[i2].childNodes[1].firstChild.selectedIndex
}

function roll_power(button) {
	var select = button.parentNode.previousSibling.firstChild
	var types = document.getElementById('types').childNodes
	var powers = document.getElementById('powers').childNodes
	var index = Array.prototype.indexOf.call(powers, button.parentNode.parentNode)
	roll: for(;;) {
		select.selectedIndex = select.random()
		for(var i = 1; i < powers.length; ++i) if(i != index && select_same(types, i, index) && select_same(powers, i, index)) continue roll
		break
	}
}

with(document.getElementById('misc')) for(var i = 0; i < childNodes.length; ++i) childNodes[i].lastChild.firstChild.onclick()
document.getElementById('attributes').firstChild.lastChild.firstChild.onclick()
document.getElementById('types').firstChild.lastChild.firstChild.onclick()
for(var i = 0; i < 2; ++i) document.getElementById('special-qualities').firstChild.lastChild.lastChild.onclick()
for(var i = 0; i < 2; ++i) document.getElementById('weapons').firstChild.lastChild.lastChild.onclick()
