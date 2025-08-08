require 'rails_helper'

RSpec.describe LibreTranslate do
  describe '.translate' do
    context 'when successful' do
      let(:response) { { 'translatedText' => 'Olá Mundo' }.to_json }

      it 'translates the text', vcr: { cassette_name: 'libre_translate/hello_world_to_pt' } do
        result = described_class.translate(text: 'Hello World')
        expect(result).to eq('Olá, Mundo')
      end
    end

    context 'when text is blank' do
      it 'returns nil' do
        expect(described_class.translate(text: '')).to be_nil
        expect(described_class.translate(text: nil)).to be_nil
      end
    end

    context 'when API call fails' do
      before do
        allow(Net::HTTP).to receive(:post).and_raise(StandardError, 'API Error')
      end

      it 'returns the original text' do
        result = described_class.translate(text: 'Hello World')
        expect(result).to eq('Hello World')
      end

      it 'logs the error' do
        expect(Rails.logger).to receive(:error).with(/Translation error/)
        described_class.translate(text: 'Hello World')
      end
    end

    context 'with different languages' do
      let(:response) { { 'translatedText' => 'Hola' }.to_json }

      it 'uses specified languages', vcr: { cassette_name: 'libre_translate/hello_to_es' } do
        result = described_class.translate(text: 'Hello', from: 'en', to: 'es')
        expect(result).to eq('Hola')
      end
    end
  end
end
