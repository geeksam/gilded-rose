class LegendaryItem < Updater
  def call
    # This space intentionally left blank
  end
end

class AgedBrie < Updater
  def call
    item.quality += 1
    item.sell_in -= 1
    if item.sell_in < 0
      item.quality += 1
    end
    trim_quality
  end
end

class BackstagePass < Updater
  def call
    item.quality += 1
    if item.sell_in < 11
      item.quality += 1
    end
    if item.sell_in < 6
      item.quality += 1
    end
    item.sell_in -= 1
    if item.sell_in < 0
      item.quality = item.quality - item.quality
    end
    trim_quality
  end
end

class NormalItem < Updater
  def call
    item.quality -= 1
    item.sell_in -= 1
    if item.sell_in < 0
      item.quality -= 1
    end
    trim_quality
  end
end
