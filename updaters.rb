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
    item.quality += quality_adjustment
  end

  def quality_adjustment
    case item.sell_in
    when 0..4 ; 3
    when 5..9 ; 2
    when 10.. ; 1
    else      ; -1 * item.quality
    end
  end
end

class NormalItem < Updater
  def change_quality
    item.quality += quality_adjustment
  end

  def quality_adjustment
    if item.sell_in < 0
      -2
    else
      -1
    end
  end
end
