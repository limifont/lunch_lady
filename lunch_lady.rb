require 'pry'


class Order
	attr_accessor :main_dish, :side_dish

	def initialize
		@main_dishes = []
		@side_dishes = []
	end

	def display_order(show_nutrition = false)
		puts '|-------------------------------------------------------------------------|'
		puts '|                                  CART                                   |'
		puts '|-------------------------------------------------------------------------|'
		puts '|              ITEM               |   $$$   |   CAL   |   FAT   |   SUG   |'
		puts '|-------------------------------------------------------------------------|'
		
		item_col_size = 31
		col_size = 9
		@main_dishes.each do |item|
			print '|  ' + item[:name] + (' ' * (item_col_size - item[:name].length)) + "|   $.5   |   300   |    5    |    12   |\n"
			# remaining_spaces = ((col_size - item[:price].length) / 2).floor
			# if item[:price] % 2 && COL_SIZE % 2
			# print '|' item[:price]
		end
	end

	def add_main(main_dish)
		@main_dishes << main_dish
	end

	def add_side(side_dish)
		@side_dishes << side_dish
	end

	def get_total
		total = 0.0
		@main_dishes.each do |item|
			total += item[:price]
		end

		@side_dishes.each do |item|
			total =+ item[:price]
		end
		return total
	end

	def clear
		@main_dishes.clear
		@side_dishes.clear
	end
end


class Wallet
	attr_accessor :balance

	def initialize
	end

	def display_avail_bal
	end

	def get_avail_bal
	end

	def add_to
	end
end

burrito = {
		name: 'Burrito',
		price: 2.00,
		nutrition: {
			calories: 200,
			sugar: 10
		}
	}


order_one = Order.new
order_one.add_main({
		name: 'Pizza',
		price: 3.00,
		nutrition: {
			calories: 500,
			sugar: 5
			}
		})
order_one.add_main(burrito)
puts 'What would you like to add to the order?'
order_one.display_order

puts 'This is the total!'
puts order_one.get_total
