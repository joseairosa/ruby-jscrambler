require 'spec_helper'

describe JScrambler::Client do
  describe '#initialize' do

    context 'when calling constructor without a json config' do
      subject { described_class.new }

      it { expect(subject.config).to be_a Hash }
    end

    context 'when calling constructor with a custom json config' do
      let(:json_config) { '{"keys":{"accessKey": "1234","secretKey": "1234"}}' }

      subject { described_class.new(json_config) }

      it { expect(subject.config).to be_a Hash }
    end

    context 'when calling constructor with an invalid json config' do
      let(:json_config) { '' }

      subject { described_class.new(json_config) }

      it 'should fallback to config file' do
        expect(subject.config).to be_a Hash
      end
    end

    context 'when API details are not provided' do
      let(:json_config) { '{"keys":{"accessKey": "","secretKey": ""}}' }

      subject { described_class.new(json_config) }

      it 'should raise an error' do
        expect{subject.config}.to raise_error(JScrambler::MissingKeys)
      end
    end
  end
end
