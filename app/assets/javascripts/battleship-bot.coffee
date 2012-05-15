
class Point
  constructor: (x, y) ->
    @x = x
    @y = y

  toString: ->
    "(" + @x + "," + @y + ")"


class BattleshipBot
  constructor: (size) ->
    @size = size
    @commands = ["miss", "carrier", "battleship", "submarine", "destroyer", "patrol", "hit"]
    @ships = @commands[1..5]
    @left = @commands[1..5]
    @init()

  suggest: (out) ->
    data = (0 for i in [0..99])
    exclude = []
    result = undefined

    for info, slot in @information
      if info is "hit" # check probabilities of all ships in that slot
        exclude.push(slot)
        for ship in @left
          for current, tile in data
            if not (tile in exclude)
              for any in @left
                data[tile] = Math.round(data[tile] + @corr(slot, ship, tile, any))
            else data[tile] = -500
      else if info is "miss"
        exclude.push(slot)
        for ship in @left
          for current, tile in data
            if not (tile in exclude)
              data[tile] = Math.round(data[tile] + @corr(slot, "miss", tile, ship))
      else if info isnt "water" # other ships given a sunk in a particular slot
        exclude.push(slot)
        for current, tile in data
          if not (tile in exclude)
            for any in @left
              if info isnt any
                data[tile] = Math.round(data[tile] + @corr(slot, info, tile, any))

    result = (slot for item, slot in data when item is (max = Math.max data...))

    console.log ((@fromScalar(res) for res in exclude))
    @printData(@information, "ships")
    @printData(data, "probabilities")
    console.log "Max probability : " + max + " on slots -> " + (@fromScalar(res) for res in result)
    out("\n" + max)
    @fromScalar(result[Math.floor(Math.random()*result.length)])

  emptyArray: (value, size) ->
    result = []
    for i in [1..size]
      result.push(value)
    result

  printData: (data, msg) ->
    console.log "Displaying " + msg + " data "
    console.log (data[i*10..(i+1)*10-1]) for i in [0..9]

  suggestEmpty: (out) ->
    result = undefined
    max = 0
    for info, slot in @information
      if info == "water"
        for ship in @left
          probability = @ship(slot, ship)
          if probability > max
            max = probability
            result = slot
    out(max)
    @fromScalar(if result == undefined then Math.round(Math.random() * 100) else result)

  # update board with "miss", "hit", "carrier", "battleship", "submarine", "destroyer", or "patrol"
  update: (x, y, command) ->
      @information[@toScalar(x, y)] = command

  # info(slot, command) should tell us if given command matches on given slot
  info: (slot, command) ->
    @information[slot] == command

  # corr(slot, ship, tile, command)
  corr: (slot, ship, tile, command) ->
    @correlation[@commands.indexOf(ship)][slot][@commands.indexOf(command) - 1][tile]

  # ship(slot, ship) should tell us the probability of there being the given ship on the given slot
  ship: (slot, ship) ->
    @background[@ships.indexOf(ship)][slot]

  toScalar: (x, y) ->
    x * @size + y

  fromScalar: (i) ->
    new Point(Math.floor(i / @size), i % @size)

  init: () ->
    @background = B
#    @information = @emptyArray("water", 100)
    @information = ("water" for i in [0..99])
    @correlation = C


$ ->
  area = $('#area')
  a = (text) ->
    area.append(text)
  board = new BattleshipBot 10
  for i in [1..5]
    suggest = board.suggest(a)
    a(" -> " + suggest + "\n")
    board.update(suggest.x,  suggest.y, "carrier")

