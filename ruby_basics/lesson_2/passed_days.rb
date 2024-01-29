@months = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

def is_leap_year?(year)
    (year % 4) == 0 && (year % 100 != 0 || (year % 400) == 0)
end

def get_days_passed(day, month, year)
    passed_days = @months[0...month].sum + day

    is_leap_year?(year) ? passed_days + 1 : passed_days
end


puts "Укажите день: "
day = gets.chomp.to_i
puts "Укажите месяц: "
month = gets.chomp.to_i
puts "Укажите год: "
year = gets.chomp.to_i

puts get_days_passed(day, month, year)