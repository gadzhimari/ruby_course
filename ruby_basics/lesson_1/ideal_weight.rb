print "Ваше имя? "
name = gets.chomp

print "Ваш рост в сантиметрах? "
height = gets.chomp.to_i

weight = (height - 110) * 1.15

if weight < 0
  puts "Ваш вес уже оптимальный"
else
  puts "#{name}, ваш идеальный вес: #{weight} кг."
end