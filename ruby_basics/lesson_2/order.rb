@orders = Hash.new

def add_order(name)
    puts 'Цена'
    price = gets.to_f

    puts 'Кол-во товаров'
    quantity = gets.to_i

    @orders[name] = {
        price: price,
        quantity: quantity, 
        total_amount: price * quantity
    }
end

def show_orders
    puts "Ваша корзина: "

    @orders.each do |name, order|
        puts "Вы взяли: '#{name}' кол-ом: #{order[:quantity]} шт и стоимостью: #{order[:total_amount]} руб."
    end
end

def show_total_price
    total_price = @orders.values.sum { |order| order[:total_amount] }
    
    puts "Итого: #{total_price} руб."
end

while true
    puts 'Название продукта'
    name = gets.chomp.downcase

    if name == "стоп"
        show_orders
        show_total_price
        break
    else
        add_order(name)
    end
end