def palindrome?(string)
  merged = string.downcase.gsub(/[^\w]/, "")
  merged == merged.reverse
end

def count_words(string)
  words = string.downcase.split(/\b/).reject { |w| not w =~ /\w+/ }
end