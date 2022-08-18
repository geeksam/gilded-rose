require_relative "spec_helper"

require_relative "../gilded_rose"



# These are intended to make the specs below more intention-revealing without
# being absurdly verbose, while still avoiding a dependency on `rspec-given`.
module SpecHelpers
  def does_not_change(attr_name)
    specify "#{attr_name} does not change" do
      expect { update_quality(item) }.to_not change { item.send(attr_name) }
    end
  end

  def increases(attr_name, by:)
    n = by.to_i
    specify "#{attr_name} increases by #{n}"  do
      expect { update_quality(item) }.to change { item.send(attr_name) }.by( n )
    end
  end

  def decreases(attr_name, by:)
    n = by.to_i
    specify "#{attr_name} decreases by #{n}"  do
      expect { update_quality(item) }.to change { item.send(attr_name) }.by( -1 * n )
    end
  end

  def zeroes_out(attr_name)
    specify "#{attr_name} changes to zero"  do
      expect { update_quality(item) }.to change { item.send(attr_name) }.to( 0 )
    end
  end
end



RSpec.describe "update_quality" do

  extend SpecHelpers

  let(:item) { Item.new(name, initial_sell_in, initial_quality) }
  let(:initial_sell_in) { 30 }
  let(:initial_quality) { 10 }


  describe "A normal item" do
    let(:name) { "NORMAL ITEM" }

    context "of zero quality" do
      let(:initial_quality) { 0 }
      decreases :sell_in, by: 1
      does_not_change "quality"
    end

    context "before the sell date" do
      let(:initial_sell_in) { 1 }
      decreases :sell_in, by: 1
      decreases :quality, by: 1
    end

    context "on the sell date" do
      let(:initial_sell_in) { 0 }
      decreases :sell_in, by: 1
      decreases :quality, by: 2
    end

    context "after the sell date" do
      let(:initial_sell_in) { -1 }
      decreases :sell_in, by: 1
      decreases :quality, by: 2
    end
  end

  describe "Aged Brie" do
    let(:name) { "Aged Brie" }

    context "before the sell date" do
      let(:initial_sell_in) { 1 }
      decreases :sell_in, by: 1

      context "at max quality" do
        let(:initial_quality) { 50 }
        decreases :sell_in, by: 1
        does_not_change :quality
      end
    end

    context "on the sell date" do
      let(:initial_sell_in) { 0 }

      context "below max quality" do
        let(:initial_quality) { 48 }
        decreases :sell_in, by: 1
        increases :quality, by: 2
      end

      context "near max quality" do
        let(:initial_quality) { 49 }
        decreases :sell_in, by: 1
        increases :quality, by: 1
      end

      context "at max quality" do
        let(:initial_quality) { 50 }
        decreases :sell_in, by: 1
        does_not_change :quality
      end
    end

    context "after the sell date" do
      let(:initial_sell_in) { -1 }

      context "below max quality" do
        let(:initial_quality) { 48 }
        decreases :sell_in, by: 1
        increases :quality, by: 2
      end

      context "near max quality" do
        let(:initial_quality) { 49 }
        decreases :sell_in, by: 1
        increases :quality, by: 1
      end

      context "at max quality" do
        let(:initial_quality) { 50 }
        decreases :sell_in, by: 1
        does_not_change :quality
      end
    end
  end

  describe "Sulfuras" do
    let(:name) { "Sulfuras, Hand of Ragnaros" }
    let(:initial_quality) { 80 }

    context "before the sell date" do
      let(:initial_sell_in) { 1 }
      does_not_change :sell_in
      does_not_change :quality
    end

    context "on the sell date" do
      let(:initial_sell_in) { 0 }
      does_not_change :sell_in
      does_not_change :quality
    end

    context "after the sell date" do
      let(:initial_sell_in) { -1 }
      does_not_change :sell_in
      does_not_change :quality
    end
  end

  describe "Backstage pass" do
    let(:name) { "Backstage passes to a TAFKAL80ETC concert" }

    context "long before sell date" do
      let(:initial_sell_in) { 11 }
      decreases :sell_in, by: 1
      increases :quality, by: 1

      context "at max quality" do
        let(:initial_quality) { 50 }
        decreases :sell_in, by: 1
        does_not_change :quality
      end
    end

    context "medium close to sell date (upper bound)" do
      let(:initial_sell_in) { 10 }
      decreases :sell_in, by: 1
      increases :quality, by: 2

      context "at max quality" do
        let(:initial_quality) { 50 }
        decreases :sell_in, by: 1
        does_not_change :quality
      end
    end

    context "medium close to sell date (lower bound)" do
      let(:initial_sell_in) { 6 }
      decreases :sell_in, by: 1
      increases :quality, by: 2

      context "at max quality" do
        let(:initial_quality) { 50 }
        decreases :sell_in, by: 1
        does_not_change :quality
      end
    end

    context "very close to sell date (upper bound)" do
      let(:initial_sell_in) { 5 }
      decreases :sell_in, by: 1
      increases :quality, by: 3

      context "at max quality" do
        let(:initial_quality) { 50 }
        decreases :sell_in, by: 1
        does_not_change :quality
      end
    end

    context "very close to sell date (lower bound)" do
      let(:initial_sell_in) { 1 }
      decreases :sell_in, by: 1
      increases :quality, by: 3

      context "at max quality" do
        let(:initial_quality) { 50 }
        decreases :sell_in, by: 1
        does_not_change :quality
      end
    end

    context "on sell date" do
      let(:initial_sell_in) { 0 }
      decreases :sell_in, by: 1
      zeroes_out :quality
    end

    context "after sell date" do
      let(:initial_sell_in) { -10 }
      decreases :sell_in, by: 1
      zeroes_out :quality
    end
  end

  context "A conjured item" do
    let(:name) { "Conjured Mana Cake" }

    context "before the sell date" do
      let(:initial_sell_in) { 5 }
      decreases :sell_in, by: 1
      decreases :quality, by: 2

      context "at zero quality" do
        let(:initial_quality) { 0 }
        decreases :sell_in, by: 1
        does_not_change :quality
      end
    end

    context "on sell date" do
      let(:initial_sell_in) { 0 }
      decreases :sell_in, by: 1
      decreases :quality, by: 4

      context "at zero quality" do
        let(:initial_quality) { 0 }
        decreases :sell_in, by: 1
        does_not_change :quality
      end
    end

    context "after sell date" do
      let(:initial_sell_in) { -10 }
      decreases :sell_in, by: 1
      decreases :quality, by: 4

      context "at zero quality" do
        let(:initial_quality) { 0 }
        decreases :sell_in, by: 1
        does_not_change :quality
      end
    end
  end

end
