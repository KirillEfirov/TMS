class WordlistCreator < ApplicationService
  def call
    total_folders = Folder.count
    word_translation = {}
    avg_cards = 0

    Folder.includes(:cards).all.map do |f|
      f.cards.map do |c|
        word_translation[c.word] = c.translation
      end
    end

    hash = {}

    Folder.includes(:cards).all.map do |f|
      hash[f.name] = f.cards.map { |c| { c.word => c.translation } }
    end

    total_cards = word_translation.size
    avg_cards = total_cards / total_folders

    @cards = hash.map { |f| f.second.sample(avg_cards) unless f.second.empty? }

    @cards.flatten.compact
  end
end
