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
