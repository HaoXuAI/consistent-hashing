
require('coffee-script/register')

var consistent_hashing = require("./lib/consistent-hashing");

var cons  = new consistent_hashing(["node1", "node2", "node3", "node4", "node5"]);

var nodes = {};

var chars = [
  'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I',
  'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R',
  'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'
];

chars.forEach(function(c) {
	var node = cons.getNode(c);

	if (nodes[node]) {
		nodes[node].push(c);
	} else {
		nodes[node] = [];
		nodes[node].push(c);
	}
});

console.log(nodes);