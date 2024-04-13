require_relative "lib"

def update_quality(item)
  ItemUpdater.call(item)
end

class ItemUpdater
  def self.call(item)
    instance = updater_for(item)
    instance.call
  end

  def self.updater_for(item)
    klass =
      case item.name
      when /^Aged/           ; AgedItemUpdater
      when /^Backstage pass/ ; BackstagePassUpdater
      when /^Sulfuras/       ; LegendaryItemUpdater
      else                   ; NormalItemUpdater
      end
    klass.new(item)
  end

  attr_reader :item
  def initialize(item)
    @item = item
  end

  def call
    update_quality_before_tick
    tick
    update_quality_after_tick
    enforce_item_quality_constraints
  end

  private

  def update_quality_before_tick
    raise NotImplementedError, "Subclass must implement"
  end

  def tick # Time keeps on ticking...
    item.sell_in -= 1
  end

  def update_quality_after_tick
    raise NotImplementedError, "Subclass must implement"
  end

  def enforce_item_quality_constraints
    item.quality =  0 if item.quality <  0
    item.quality = 50 if item.quality > 50
  end
end

class AgedItemUpdater < ItemUpdater
  def update_quality_before_tick
    item.quality += 1
  end

  def update_quality_after_tick
    item.quality += 1 if item.sell_in < 0
  end
end

class BackstagePassUpdater < ItemUpdater
  def update_quality_before_tick
    item.quality += 1
    item.quality += 1 if item.sell_in < 11
    item.quality += 1 if item.sell_in < 6
  end

  def update_quality_after_tick
    item.quality = 0 if item.sell_in < 0
  end
end

class LegendaryItemUpdater < ItemUpdater
  def call
    # this space intentionally left blank
  end
end

class NormalItemUpdater < ItemUpdater
  def update_quality_before_tick
    item.quality -= 1
  end

  def update_quality_after_tick
    item.quality -= 1 if item.sell_in < 0
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

