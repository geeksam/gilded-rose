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
      when /Conjured/  ; ConjuredItem
      else             ; NormalItem
      end
    klass.new(item)
  end

  attr_reader :item
  def initialize(item)
    @item = item
  end

  def call
    item.sell_in -= 1
    change_quality
    trim_quality
  end

  private

  def change_quality
    item.quality += quality_adjustment
  end

  def quality_adjustment
    if item.sell_in < 0
      quality_adjustment_after_sell_by
    else
      quality_adjustment_before_sell_by
    end
  end

  def trim_quality
    item.quality = 50 if item.quality > 50
    item.quality =  0 if item.quality <  0
  end
end
