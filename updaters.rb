class LegendaryItem < Updater
  def call
    # This space intentionally left blank
  end
end

class AgedBrie < Updater
  def change_quality
    item.quality += quality_adjustment
  end

  def quality_adjustment
    if item.sell_in < 0
      2
    else
      1
    end
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
  def change_quality
    item.quality -= 1
    item.quality -= 1 if item.sell_in < 0
  end
end
