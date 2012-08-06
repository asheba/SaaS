def combine_anagrams(words)
  anagrams = Hash.new
  words.map { |w| anagrams[w.downcase.split("").sort.join("")] = [] }
  words.map { |w| anagrams[w.downcase.split("").sort.join("")] << w }
  anagrams.values
end