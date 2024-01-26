# frozen_string_literal: true

require_relative "../mimir"

describe Mimir do
  describe "@greet" do
    context "when it is told to greet with 'Howdy!'" do
      subject(:greeter) { described_class }
      let(:greeting) { "Howdy!" }
      it "prints 'Howdy!' to the STDOUT" do
        expect { greeter.greet(greeting) }.to output("Howdy!").to_stdout
      end
    end
  end
end
