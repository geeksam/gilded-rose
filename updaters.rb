class LegendaryItem < Updater
  def call
    # This space intentionally left blank
  end
end

class AgedBrie < Updater
  def change_quality
    item.quality += 1
    item.quality += 1 if item.sell_in < 0
  end
end

class BackstagePass < Updater
  def change_quality
    item.quality += 1
    item.quality += 1 if item.sell_in < 10
    item.quality += 1 if item.sell_in < 5
    item.quality = 0 if item.sell_in < 0
  end
end

class NormalItem < Updater
  def call
    item.sell_in -= 1
    change_quality
    trim_quality
  end

  def change_quality
    item.quality -= 1
    item.quality -= 1 if item.sell_in < 0
  end
end
