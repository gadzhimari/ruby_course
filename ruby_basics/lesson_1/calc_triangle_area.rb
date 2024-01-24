def calc_triangle_area(a, h)
   area = 0.5 * a * h

   puts "Площадь треугольника равна: #{area}"
end

print "Укажите основание: "
base = gets.chomp.to_i

print "Укажите высоту: "
height = gets.chomp.to_i

calc_triangle_area(base, height)

