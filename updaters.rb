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

