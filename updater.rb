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
      else             ; self
      end
    klass.new(item)
  end

  attr_reader :item
  def initialize(item)
    @item = item
  end

  def call
    if item.name != 'Aged Brie' && item.name != 'Backstage passes to a TAFKAL80ETC concert'
      if item.quality > 0
        item.quality -= 1
      end
    else
      if item.quality < 50
        item.quality += 1
        if item.name == 'Backstage passes to a TAFKAL80ETC concert'
          if item.sell_in < 11
            if item.quality < 50
              item.quality += 1
            end
          end
          if item.sell_in < 6
            if item.quality < 50
              item.quality += 1
            end
          end
        end
      end
    end
    item.sell_in -= 1
    if item.sell_in < 0
      if item.name != "Aged Brie"
        if item.name != 'Backstage passes to a TAFKAL80ETC concert'
          if item.quality > 0
            item.quality -= 1
          end
        else
          item.quality = item.quality - item.quality
        end
      else
        if item.quality < 50
          item.quality += 1
        end
      end
    end
  end
end
