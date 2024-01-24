def is_right_angle?(sides)
    hypotenuse = sides.last
    a, b = sides
    
    return hypotenuse ** 2 == (a ** 2) + (b ** 2)
end

def is_isosceles?(sides)
    sides.uniq.size == 2
end

def is_equilateral?(sides)
    sides.uniq.size == 1
end

def get_triangle_type(a, b, c)
    sides = [a, b, c].sort

    if (is_right_angle?(sides))
        puts "Треугольник прямоугольный"
    elsif (is_isosceles?(sides))
        puts "Треугольник равнобедренный"
    elsif (is_equilateral?(sides))
        puts "Треугольник равносторонний"
    else
        puts "Треугольник невалидный"
    end
end

print "Укажите первую сторону: "
a = gets.chomp.to_i

print "Укажите вторую сторону: "
b = gets.chomp.to_i

print "Укажите третью сторону: "
c = gets.chomp.to_i

get_triangle_type(a, b, c)