# frozen_string_literal: true

require "csv"
require_relative "../../mimir"

# rubocop:disable Metrics/BlockLength
describe Dictionary do

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
115,Fancie,Constance.Fancie@yopmail.com,Constance.Fancie@gmail.com,Constance,firefighter", headers: true)
  end

  describe "#remove_words" do
    context "when it is provided with an array of words" do
      subject(:weeds_dictionary) { described_class.new(weeds, ground, sky) }
      let(:weeds) do
        ["Bindweed", "Crabgrass", "Purslane", "Chickweed", "Japanese knotweed", "Clover", "Plantain",
         "Creeping buttercup"]
      end
      let(:ground) { double Array }
      let(:sky) { double Hash }
      let(:garden) { %w[Sunflower Strawberry Chickweed Carrot Aubergine Clover Clover Clover Plantain Cucumber] }
      let(:garden_without_weeds) { %w[Sunflower Strawberry Carrot Aubergine Cucumber] }
      it "removes the words provided and returns an array" do
        expect(weeds_dictionary.remove_words(garden)).to match_array(garden_without_weeds)
      end
    end
  end

  describe "#remove_columns" do
    context "when it is provided with an array of columns" do
      subject(:unaffordable_dictionary) { described_class.new(undesirable_words, undesirable_columns, undesirable_words_to_replace) }
      let(:undesirable_words) { double Array }
      let(:undesirable_words_to_replace) { double Hash }
      let(:undesirable_columns) { %w[id email profession] }
      let(:csv_example_remove_output) do
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
Fancie,Constance.Fancie@gmail.com,Constance", headers: true)
      end
      it "removes the columns provided together with their contents and returns a CSV::Table object" do
        expect(unaffordable_dictionary.remove_columns(csv_example_input)).to eq(csv_example_remove_output)
      end
    end
  end

  describe "#replace_words" do
    subject(:replacing_dictionary) { described_class.new(array, csv_table, words_to_replace) }
    let(:array) { double Array }
    let(:csv_table) { double CSV::Table }
    let(:words_to_replace) do
      {
        "worker" => "labourer",
        "police officer" => "copper"
      }
    end
    let(:csv_example_replace_output) do
      CSV.parse("id,lastname,email,email2,firstname,profession
100,Minetta,Kimmy.Minetta@yopmail.com,Kimmy.Minetta@gmail.com,Kimmy,labourer
101,Kinnard,Chloris.Kinnard@yopmail.com,Chloris.Kinnard@gmail.com,Chloris,labourer
102,Brittani,Celestyna.Brittani@yopmail.com,Celestyna.Brittani@gmail.com,Celestyna,doctor
103,Ciapas,Tiffie.Ciapas@yopmail.com,Tiffie.Ciapas@gmail.com,Tiffie,firefighter
104,Scammon,Kathy.Scammon@yopmail.com,Kathy.Scammon@gmail.com,Kathy,labourer
105,Rogerio,Minne.Rogerio@yopmail.com,Minne.Rogerio@gmail.com,Minne,labourer
106,Heidt,Amelia.Heidt@yopmail.com,Amelia.Heidt@gmail.com,Amelia,labourer
107,Dosia,Adele.Dosia@yopmail.com,Adele.Dosia@gmail.com,Adele,firefighter
108,Kenney,Lizzie.Kenney@yopmail.com,Lizzie.Kenney@gmail.com,Lizzie,copper
109,Barbey,Pollyanna.Barbey@yopmail.com,Pollyanna.Barbey@gmail.com,Pollyanna,firefighter
110,Lory,Maud.Lory@yopmail.com,Maud.Lory@gmail.com,Maud,developer
111,Cath,Dominga.Cath@yopmail.com,Dominga.Cath@gmail.com,Dominga,doctor
112,Bollay,Cristine.Bollay@yopmail.com,Cristine.Bollay@gmail.com,Cristine,copper
113,Velick,Nerta.Velick@yopmail.com,Nerta.Velick@gmail.com,Nerta,doctor
114,Iiette,Marsiella.Iiette@yopmail.com,Marsiella.Iiette@gmail.com,Marsiella,doctor
115,Fancie,Constance.Fancie@yopmail.com,Constance.Fancie@gmail.com,Constance,firefighter", headers: true)
    end
    it "replaces the contents of rows according to hash provided" do
      expect(replacing_dictionary.replace_words(csv_example_input)).to eq(csv_example_replace_output)
    end
  end
end
# rubocop:enable Metrics/BlockLength
