def quadratic_equation(a, b, c)
    d = (b ** 2) - 4 * a * c

    if (d > 0)
        x1 = (-b + Math.sqrt(d)) / (2 * a)
        x2 = (-b + Math.sqrt(d)) / (2 * a)
        puts "Корни уравнения #{x1} и #{x2}"
    elsif (d == 0)
        x = (-b + Math.sqrt(d)) / (2 * a)
        puts "Корень уравнения #{x}"
    else
        puts "Корней нет"
    end
end

print "Укажите a: "
a = gets.chomp.to_i

print "Укажите b: "
b = gets.chomp.to_i

print "Укажите c: "
c = gets.chomp.to_i

quadratic_equation(a, b, c)