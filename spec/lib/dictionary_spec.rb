# frozen_string_literal: true

require_relative "../../mimir"

describe Dictionary do
  describe "#remove_words" do
    context "when it is provided with an array of words" do
      subject(:weeds_dictionary) { described_class.new(weeds) }
      let(:weeds) { ["Bindweed", "Crabgrass", "Purslane", "Chickweed", "Japanese knotweed", "Clover", "Plantain", "Creeping buttercup"] }
      let(:garden) { %w[Sunflower Strawberry Chickweed Carrot Aubergine Clover Clover Clover Plantain Cucumber] }
      let(:garden_without_weeds) { %w[Sunflower Strawberry Carrot Aubergine Cucumber] }
      it "removes the words provided" do
        expect(weeds_dictionary.remove_words(garden)).to_match_array(garden_without_weeds)
      end
    end
  end
end
