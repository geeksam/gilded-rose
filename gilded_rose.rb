require_relative "lib"

def update_quality(item)
  brie = item.name == "Aged Brie"
  pass = item.name == "Backstage passes to a TAFKAL80ETC concert"
  hand = item.name == "Sulfuras, Hand of Ragnaros"
  norm = !brie && !pass && !hand

  if norm
    item.quality -= 1
  end
  if brie
    item.quality += 1
  end
  if pass
    item.quality += 1
    item.quality += 1 if item.sell_in < 11
    item.quality += 1 if item.sell_in < 6
  end

  if !hand
    item.sell_in -= 1
  end

  if norm
    if item.sell_in < 0
      item.quality -= 1
    end
  end
  if pass
    if item.sell_in < 0
      item.quality = 0
    end
  end
  if brie
    if item.sell_in < 0
      item.quality += 1
    end
  end

  item.quality =  0 if item.quality < 0
  item.quality = 50 if item.quality > 50 && !hand
end

# DO NOT CHANGE THINGS BELOW -----------------------------------------

Item = Struct.new(:name, :sell_in, :quality)

# We use the setup in the spec rather than the following for testing.
#
# Items = [
#   Item.new("+5 Dexterity Vest", 10, 20),
#   Item.new("Aged Brie", 2, 0),
#   Item.new("Elixir of the Mongoose", 5, 7),
#   Item.new("Sulfuras, Hand of Ragnaros", 0, 80),
#   Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 20),
#   Item.new("Conjured Mana Cake", 3, 6),
# ]

