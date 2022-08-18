class LegendaryItem < Updater
  def call
    # This space intentionally left blank
  end
end

class AgedBrie < Updater
  def call
    if item.quality < 50
      item.quality += 1
    end
    item.sell_in -= 1
    if item.sell_in < 0
      if item.quality < 50
        item.quality += 1
      end
    end
  end
end

class BackstagePass < Updater
  def call
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
    item.sell_in -= 1
    if item.sell_in < 0
      item.quality = item.quality - item.quality
    end
  end
end
