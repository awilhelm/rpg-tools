
function roll_color(button) {
	var node = button.parentNode.previousSibling.firstChild
	node.selectedIndex = color_table.random_with_frequency()
	update_color(node)
}

function update_color(node) {
	node.parentNode.setAttribute('style', 'color:' + node.value)
}

