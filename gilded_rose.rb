def update_quality(item)
  Updater.call(item)
end



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
    item.quality += quality_adjustment
    enforce_quality_constraints
  end

  private

  def quality_adjustment
    if item.sell_in < 0
      quality_adjustment_after_sell_by
    else
      quality_adjustment_before_sell_by
    end
  end

  def enforce_quality_constraints
    item.quality = 50 if item.quality > 50
    item.quality =  0 if item.quality <  0
  end
end



class LegendaryItem < Updater
  def call
    # This space intentionally left blank
  end
end

class BackstagePass < Updater
  def quality_adjustment
    case item.sell_in
    when 0..4 ; 3
    when 5..9 ; 2
    when 10.. ; 1
    else      ; -1 * item.quality
    end
  end
end

class AgedBrie < Updater
  def quality_adjustment_before_sell_by ; 1 ; end
  def quality_adjustment_after_sell_by  ; 2 ; end
end

class NormalItem < Updater
  def quality_adjustment_before_sell_by ; -1 ; end
  def quality_adjustment_after_sell_by  ; -2 ; end
end

class ConjuredItem < Updater
  def quality_adjustment_before_sell_by ; -2 ; end
  def quality_adjustment_after_sell_by  ; -4 ; end
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

