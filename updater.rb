class Updater ; end
require_relative "updaters"

class Updater
  def self.call(item)
    instance = instance_for(item)
    instance.call
  end

  def self.instance_for(item)
    klass =
      case item.name
      when /Sulfuras/  ; LegendaryItem
      when /Aged Brie/ ; AgedBrie
      when /Backstage/ ; BackstagePass
      else             ; self
      end
    klass.new(item)
  end

  attr_reader :item
  def initialize(item)
    @item = item
  end

  def call
    if item.quality > 0
      item.quality -= 1
    end
    item.sell_in -= 1
    if item.sell_in < 0
      if item.quality > 0
        item.quality -= 1
      end
    end
  end
end
