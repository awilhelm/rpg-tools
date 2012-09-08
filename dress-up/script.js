
function update() {
	var array = [];
	for(var i in options) array.push(i + '-' + options[i])
	document.getElementById('form').setAttribute('class', array.join(' '))
}

function set(key, value) {
	options[key] = value
	update()
}

