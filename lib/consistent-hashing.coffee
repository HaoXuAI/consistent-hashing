crypto = require 'crypto'

consitent_hashing = (nodes, options) ->
  @ring = {}
  @keys = []
  @nodes = []
  replicas = options?.replicas ? 160
  algorithm = options?.algorithm ? 'md5'
  @addNode node for node in nodes

consitent_hashing::addNode = (node) ->
  @nodes.push node
  for i in [0...@replicas - 1]
    key = @crypto((node.id ? node) + ':' + i)
    @keys.push key
    ring[key] = node
  @keys.sort()

consitent_hashing::removeNode = (node) ->
  for _, i in @nodes
    if @nodes[i] == node
      nodes.splice(i, 1)
      i--

  for i in [0...replicas - 1]
    key = @crypto ((node.id ? node) + ':' + i)
    delete @ring[key]
    for _, j in @keys
      if @keys[j] == key
        keys.splice j, 1
        j--

consitent_hashing::getNode = (key) ->
  return 0 if @getRingLength() is 0

  hash = @crypto(key)
  pos = @getNodePosition(hash)
  @ring[@keys[pos]]

consitent_hashing::getNodePosition = (hash) ->
  upper = @getRingLength() - 1
  lower = 0
  idx = 0
  comp = 0
  return 0 if upper is 0
  while lower <= upper
    idx = Math.floor (lower + upper) / 2
    comp = @compare keys[idx], hash

    if comp is 0
      return idx
    else if comp > 0
        upper = idx - 1
    else
      lower = idx + 1

  if upper < 0
    upper = @getRingLength() - 1

  upper

consitent_hashing::getRingLength = ->
  Object.keys(@ring).length

consitent_hashing::compare = (v1, v2) ->
  if v1 > v2 then 1 else if v1 < v2 then -1 else 0

consitent_hashing::crypto = (str) ->
  crypto.createHash(@algorithm).update(str).digest('hex')

module.exports = consitent_hashing