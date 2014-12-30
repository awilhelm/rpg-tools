
var age_table = function() {
	table = []
	var f1 = Math.gaussian_function(20, 6)
	var f2 = Math.gaussian_function(60, 9)
	for(var i = 0; i < 100; ++i) table.push({frequency: 0.8 * f1(i) + 0.2 * f2(i)})
	return table
}()

function roll_age(button) {
	button.parentNode.previousSibling.firstChild.value = age_table.random_with_frequency()
}

function roll_attribute(button) {
	var node = button.parentNode.previousSibling.firstChild
	node.value = Math.floor(dice(2, 6) / 3)
	node.onchange()
}

function update_types() {
	var attributes = document.getElementById('attributes').childNodes
	var types = document.getElementById('types').childNodes
	for(var i = 1; i < attributes.length; ++i) {
		var node = attributes[i].childNodes[1].childNodes[2]
		node.value = 0
		for(var j = 1; j < types.length; ++j) node.value = Number(node.value) + Number(type_table[types[j].childNodes[1].firstChild.selectedIndex].attributes[i - 1])
	}
	update_attributes()
}

function update_attributes() {
	var attributes = document.getElementById('attributes').childNodes

	// calcule le score total
	for(var i = 1; i < attributes.length; ++i) with(attributes[i].childNodes[1]) {
		lastChild.value = Math.max(0, Number(firstChild.value) + Number(childNodes[2].value))
	}

	// décoche tous les attributs
	for(var i = 1; i < attributes.length; ++i) with(attributes[i].firstChild.firstChild) {
		removeAttribute('checked')
		setAttribute('disabled', 'disabled')
	}

	// calcule le score maximal
	var max = -1
	for(var i = 1; i < attributes.length; ++i) max = Math.max(max, attributes[i].childNodes[1].lastChild.value)

	// active les attributs avec le plus haut score
	var indices = []
	for(var i = 1; i < attributes.length; ++i) if(attributes[i].childNodes[1].lastChild.value == max) {
		indices = indices.concat([i])
		attributes[i].firstChild.firstChild.removeAttribute('disabled')
	}

	// sélectionne parmi les attributs les plus forts celui utilisé pour le Maid Power
	var node = attributes[indices[indices.random()]].firstChild.firstChild
	node.setAttribute('checked', 'checked')
	node.onchange()
}

function update_powers() {

	// calcule la somme des attributs
	var attributes = document.getElementById('attributes').childNodes
	var sum = 0
	for(var i = 1; i < attributes.length; ++i) sum += Number(attributes[i].childNodes[1].lastChild.value)

	// ajoute les Maid Powers réglementaires
	var node = document.getElementById('powers')
	node.clear(1)
	for(var i = 0; i < (sum < 10 ? 2 : 1); ++i) node.firstChild.lastChild.lastChild.onclick()
}

function append_power(button) {
	var index = -1
	var nodes = document.getElementById('form').max
	for(var i in nodes) if(nodes[i].checked) index = i
	var node = button.parentNode.parentNode.parentNode
	node.appendChild(node.nextSibling.childNodes[index].cloneNode(true)).lastChild.firstChild.onclick()
}

var nodes = document.getElementById('misc').childNodes
for(var i = 0; i < nodes.length; ++i) nodes[i].lastChild.firstChild.onclick()
for(var i = 0; i < 2; ++i) document.getElementById('types').firstChild.lastChild.lastChild.onclick()
document.getElementById('attributes').firstChild.lastChild.firstChild.onclick()
for(var i = 0; i < 2; ++i) document.getElementById('special-qualities').firstChild.lastChild.lastChild.onclick()
document.getElementById('weapons').firstChild.lastChild.lastChild.onclick()

