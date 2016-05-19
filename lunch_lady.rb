# require 'pry'


class Order
	attr_accessor :main_dishes, :side_dishes

	def initialize
		@main_dishes = []
		@side_dishes = []
	end

	def display_order
		puts '|-----------------------------------------------------------------------------|'
		puts '|                                     CART                                    |'
		puts '|-----------------------------------------------------------------------------|'
		puts '|              ITEM               |   $$$$   |   CALS   |   FATS   |   SUGS   |'
		puts '|-----------------------------------------------------------------------------|'
		
		item_col_size = 31
		col_size = 7
		@main_dishes.each do |item|
			print '|  ' + item[:name] + (' ' * (item_col_size - item[:name].length)) + "|   " + item[:price] + (' ' *(col_size - item[:price].length)) + "|   \n"
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
			total += item[:price].to_f
		end

		@side_dishes.each do |item|
			total =+ item[:price].to_f
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
		@balance = 20.00 
	end

	def add_to(amount)
		@balance += amount
	end

	def subtract_from(amount, main_dish)
		@balance = @balance - main_dish[:price]
	end

	def display
		puts "Available balance: #{@balance}"
	end
end



@main_menu_options = [
		{
			name: 'Burrito',
			description: 'Veggies, rice, and \'meat\'',
			price: '2.00',
			nutrition: {
				calories: '200',
				sugar: '10'
			}
		}, 
		{
			name: 'Burger',
			description: 'Veggie burger',
			price: '2.00',
			nutrition: {
				calories: '200',
				sugar: '10'
			}
		}
	]

@side_menu_options = [
		{
			name: 'Fries',
			description: 'Sweet potato fries',
			price: '2.00',
			nutrition: {
				calories: '200',
				sugar: '10'
			}
		}, 
		{
			name: 'Salad',
			description: 'Side salad with vegan dressing',
			price: '2.00',
			nutrition: {
				calories: '200',
				sugar: '10'
		}
	}]









def main_menu(order, wallet)
	puts '1. Order'
	puts '2. Wallet'
	puts '3. EXIT'
	puts '--------------------------'
	puts order.get_total
	wallet.display
	puts '--------------------------'
	puts 'Please select an option > '
	selection = gets.strip

	case selection
	when '1', 'Order'
		order_menu(order, wallet)
	when '2', 'Wallet'
		wallet_menu(wallet)
	when '3', 'EXIT'
		abort('Thank you, come again!')
	end
end

def order_menu(order,wallet)
	puts '--------------------------'
	puts '1. Add main dish'
	puts '2. Add side dish'
	puts '3. Display order'
	puts '4. Check out'
	puts '5. Main menu'
	puts 'Please select an option > '
	menu_option = gets.strip

	case menu_option
	when '1', 'Add main dish'
		display_items(@main_menu_options)
	when '2', 'Add side dish'
		display_items(@side_menu_options)
	when '3', 'Display order'
		puts 'Current Order:'
		puts 'Main dishes'
		puts '--------------------------'
		display_items(order.main_dishes, order, wallet)
		puts '--------------------------'
		puts 'Side dishes'		
		puts '--------------------------'
		display_items(order.side_dishes)
		puts '--------------------------'
	end
end

def display_items(items, order, wallet)
	number = 1
	if items == @main_menu_options
		items.each do |item|
			puts "#{number}" + ". " + item[:name] + ('.' * (30 - item[:name].length)) + item[:price]
			number += 1
		end
		case gets.strip
		when '1'
			order.add_main(@main_menu_options[0])
			wallet.subtract_from(@main_menu_options[0])
			order_menu(order, wallet)
		when '2'
			order.add_main(@main_menu_options[1])
			wallet.subtract_from(@main_menu_options[1])
			order_menu(order, wallet)
		end

	elsif items == @side_menu_options
		items.each do |item|
			puts "#{number}" + ". " + item[:name] + ('.' * (30 - item[:name].length)) + item[:price]
			number += 1
		end
		case gets.strip
		when '1'
			order.add_main(@side_menu_options[0])
			wallet.subtract_from(@side_menu_options[0])
			order_menu(order, wallet)
		when '2'
			order.add_main(@side_menu_options[1])
			wallet.subtract_from(@side_menu_options[1])
			order_menu(order, wallet)
		end	

	elsif items == @main_dishes || items == @side_dishes
		items.each do |item|
			puts "#{number}" + ". " + item[:name]
			number += 1
		end
	end
end

def check_out(order)
	order.display_order
	puts "\nContinue? (y/n)"
end

def wallet_menu(wallet)
	wallet.display
	puts 'How much do you want to add?'
	amount = gets.strip.to_f
	wallet.add_to(amount)
	wallet.display
end

wallet = Wallet.new
order = Order.new

while true
	main_menu(order,wallet)
end


