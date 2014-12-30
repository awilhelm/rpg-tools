
var age = {dice: 0, faces: 0, base: 0}

function roll_age(button) {
	button.parentNode.previousSibling.firstChild.value = dice(age.dice, age.faces) + age.base
}

function roll_attribute(button, attribute) {
	var node = button.parentNode.previousSibling.firstChild
	switch(attribute) {
		case 'will':
		node.value = 2
		break

		default:
		node.value = Math.floor(dice(2, 6) / 4)
	}
}

function type_changed(select) {
	var node = select.childNodes[select.selectedIndex]
	age.dice = Number(node.getAttribute('x-age-dice'))
	age.faces = Number(node.getAttribute('x-age-faces'))
	age.base = Number(node.getAttribute('x-age-base'))
	document.getElementById('age').lastChild.firstChild.onclick()
}

with(document.getElementById('misc')) for(var i = 0; i < childNodes.length; ++i) childNodes[i].lastChild.firstChild.onclick()
document.getElementById('attributes').firstChild.lastChild.firstChild.onclick()
for(var i = 0; i < 2; ++i) document.getElementById('special-qualities').firstChild.lastChild.lastChild.onclick()
for(var i = 0; i < 2; ++i) document.getElementById('power-sources').firstChild.lastChild.lastChild.onclick()
