# frozen_string_literal: true

require 'csv'
require_relative "../../mimir"

# rubocop:disable Metrics/BlockLength
describe Dictionary do
  describe "#remove_words" do
    context "when it is provided with an array of words" do
      subject(:weeds_dictionary) { described_class.new(weeds) }
      let(:weeds) { ["Bindweed", "Crabgrass", "Purslane", "Chickweed", "Japanese knotweed", "Clover", "Plantain", "Creeping buttercup"] }
      let(:garden) { %w[Sunflower Strawberry Chickweed Carrot Aubergine Clover Clover Clover Plantain Cucumber] }
      let(:garden_without_weeds) { %w[Sunflower Strawberry Carrot Aubergine Cucumber] }
      it "removes the words provided" do
        expect(weeds_dictionary.remove_words(garden)).to match_array(garden_without_weeds)
      end
    end
  end

  describe "#remove_columns" do
    context "when it is provided with an array of columns" do
      subject(:unaffordable_dictionary) { described_class.new(undesirable_words, undesirable_columns) }
      let(:undesirable_words) { double Array }
      let(:undesirable_columns) { %w[id email profession] }
      let(:csv_example_input) do
        CSV.parse("id,lastname,email,email2,firstname,profession
        100,Minetta,Kimmy.Minetta@yopmail.com,Kimmy.Minetta@gmail.com,Kimmy,worker
        101,Kinnard,Chloris.Kinnard@yopmail.com,Chloris.Kinnard@gmail.com,Chloris,worker
        102,Brittani,Celestyna.Brittani@yopmail.com,Celestyna.Brittani@gmail.com,Celestyna,doctor
        103,Ciapas,Tiffie.Ciapas@yopmail.com,Tiffie.Ciapas@gmail.com,Tiffie,firefighter
        104,Scammon,Kathy.Scammon@yopmail.com,Kathy.Scammon@gmail.com,Kathy,worker
        105,Rogerio,Minne.Rogerio@yopmail.com,Minne.Rogerio@gmail.com,Minne,worker
        106,Heidt,Amelia.Heidt@yopmail.com,Amelia.Heidt@gmail.com,Amelia,worker
        107,Dosia,Adele.Dosia@yopmail.com,Adele.Dosia@gmail.com,Adele,firefighter
        108,Kenney,Lizzie.Kenney@yopmail.com,Lizzie.Kenney@gmail.com,Lizzie,police officer
        109,Barbey,Pollyanna.Barbey@yopmail.com,Pollyanna.Barbey@gmail.com,Pollyanna,firefighter
        110,Lory,Maud.Lory@yopmail.com,Maud.Lory@gmail.com,Maud,developer
        111,Cath,Dominga.Cath@yopmail.com,Dominga.Cath@gmail.com,Dominga,doctor
        112,Bollay,Cristine.Bollay@yopmail.com,Cristine.Bollay@gmail.com,Cristine,police officer
        113,Velick,Nerta.Velick@yopmail.com,Nerta.Velick@gmail.com,Nerta,doctor
        114,Iiette,Marsiella.Iiette@yopmail.com,Marsiella.Iiette@gmail.com,Marsiella,doctor
        115,Fancie,Constance.Fancie@yopmail.com,Constance.Fancie@gmail.com,Constance,firefighter")
      end
      let(:csv_example_output) do
        CSV.parse("lastname,email2,firstname
        Minetta,Kimmy.Minetta@gmail.com,Kimmy
        Kinnard,Chloris.Kinnard@gmail.com,Chloris
        Brittani,Celestyna.Brittani@gmail.com,Celestyna
        Ciapas,Tiffie.Ciapas@gmail.com,Tiffie
        Scammon,Kathy.Scammon@gmail.com,Kathy
        Rogerio,Minne.Rogerio@gmail.com,Minne
        Heidt,Amelia.Heidt@gmail.com,Amelia
        Dosia,Adele.Dosia@gmail.com,Adele
        Kenney,Lizzie.Kenney@gmail.com,Lizzie
        Barbey,Pollyanna.Barbey@gmail.com,Pollyanna
        Lory,Maud.Lory@gmail.com,Maud
        Cath,Dominga.Cath@gmail.com,Dominga
        Bollay,Cristine.Bollay@gmail.com,Cristine
        Velick,Nerta.Velick@gmail.com,Nerta
        Iiette,Marsiella.Iiette@gmail.com,Marsiella
        Fancie,Constance.Fancie@gmail.com,Constance")
      end
      it "removes the columns provided together with their contents" do
        expect(unaffordable_dictionary.remove_columns(csv_example_input).to_eql(csv_example_output))
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
