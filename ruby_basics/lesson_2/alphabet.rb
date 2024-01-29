def get_vowels_with_index()
    vowels = ['a', 'e', 'i', 'o', 'u']
    vowels_hash = {}

    ("a".."z").to_a.each.with_index(1) do |letter, index|
        if vowels.include?(letter)
            vowels_hash[letter] = index
        end
    end

    vowels_hash
end

puts get_vowels_with_index()