require_relative "lib"

def update_quality(item)
  ItemUpdater.new(item).call
end

class ItemUpdater
  attr_reader :item
  def initialize(item)
    @item = item
  end

  def call
    case
    when norm?
      item.quality -= 1
    when brie?
      item.quality += 1
    when pass?
      item.quality += 1
      item.quality += 1 if item.sell_in < 11
      item.quality += 1 if item.sell_in < 6
    end

    if !hand?
      tick
    end

    case
    when norm?
      item.quality -= 1 if item.sell_in < 0
    when brie?
      item.quality += 1 if item.sell_in < 0
    when pass?
      item.quality = 0 if item.sell_in < 0
    end

    enforce_item_quality_constraints
  end

  def brie? ; item.name == "Aged Brie"                                 ; end
  def pass? ; item.name == "Backstage passes to a TAFKAL80ETC concert" ; end
  def hand? ; item.name == "Sulfuras, Hand of Ragnaros"                ; end
  def norm? ; !brie? && !pass? && !hand?                               ; end

  private

  def tick # Time keeps on ticking...
    item.sell_in -= 1
  end

  def enforce_item_quality_constraints
    item.quality =  0 if item.quality < 0
    item.quality = 50 if item.quality > 50 && !hand?
  end
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

