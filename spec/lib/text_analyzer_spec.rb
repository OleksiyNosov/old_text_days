require_relative '../../lib/text_analyzer'

RSpec.describe TextAnalyzer do
  let(:text) { 'Hello, my day is awfully good, my id is 6876312112667995' }

  subject { described_class.new text }

  describe '#count_words' do
    it { expect(subject.count_words).to eq 9 }
  end

  describe '#count_special_symbols' do
    let(:text) { '/^\s*\[(35.+)\]$/' }

    it { expect(subject.count_special_symbols).to eq 14 }
  end

  describe '#count_numbers' do
    let(:text) { %q| f(x) = 2.5x^2 + 1.5x + 10,600; f(x)' = 5x + 1.5 | }

    it { expect(subject.count_numbers).to eq 6 }
  end

  describe '#longest_word' do
    it { expect(subject.longest_word).to eq 'awfully' }
  end

  describe '#most_frequent_words' do
    it { expect(subject.most_frequent_words).to eq ['my', 'is'] }
  end

  describe '#least_frequent_words' do
    it { expect(subject.least_frequent_words).to eq ['Hello', 'day', 'awfully', 'good', 'id'] }
  end

  describe '#without_shortest_word' do
    it { expect(subject.without_shortest_word).to eq 'Hello,  day is awfully good,  id is 6876312112667995' }
  end

  describe '#replace_letters_with_numbers' do
    let(:text) { 'Hello, ruby!' }

    it { expect(subject.replace_letters_with_numbers).to eq '0805121215, 18210225!' }
  end
end
