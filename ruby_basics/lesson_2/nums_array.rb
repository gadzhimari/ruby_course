filtered_nums = []

(10..100).each do |num|
    if (num % 5 == 0)
        filtered_nums << num
    end
end

puts filtered_nums