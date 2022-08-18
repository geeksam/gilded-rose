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
      else             ; NormalItem
      end
    klass.new(item)
  end

  attr_reader :item
  def initialize(item)
    @item = item
  end

  def call
    raise "Subclass responsibility"
  end

  private

  def trim_quality
    item.quality = 50 if item.quality > 50
    item.quality =  0 if item.quality <  0
  end
end
