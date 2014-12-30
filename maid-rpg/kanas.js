
function roll_name(button) {
	var node = button.parentNode.previousSibling.firstChild
	var previous = node.value = ''
	var length = dice(2, 3)
	for(var i = 0; i < length; ++i) {
		var kana = kana_table[kana_table.random_with_frequency()]
		if(kana.latin == 'n' && !previous.match(/[aeiou]$/)) { --i; continue } // n toujours précédé d'une voyelle
		if(previous == 'n' && kana.latin.match(/^[aeiou]/)) { --i; continue } // n toujours suivi d'une consonne
		if(kana.latin == previous && previous.match(/^[aeiou]$/)) { --i; continue } // pas 2 voyelles identiques consécutives
		node.value += previous = kana.latin
	}
	node.value = node.value.substr(0, 1).toUpperCase() + node.value.substr(1)
}

