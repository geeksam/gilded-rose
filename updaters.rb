class LegendaryItem < Updater
  def call
    # This space intentionally left blank
  end
end

class AgedBrie < Updater
  def call
    item.quality += 1
    item.sell_in -= 1
    item.quality += 1 if item.sell_in < 0
    trim_quality
  end
end

class BackstagePass < Updater
  def call
    item.quality += 1
    item.quality += 1 if item.sell_in < 11
    item.quality += 1 if item.sell_in < 6
    item.sell_in -= 1
    item.quality = 0 if item.sell_in < 0
    trim_quality
  end
end

class NormalItem < Updater
  def call
    item.quality -= 1
    item.sell_in -= 1
    item.quality -= 1 if item.sell_in < 0
    trim_quality
  end
end
