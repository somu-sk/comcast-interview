namespace :db do
  task :add_apple_to_basket, [:variety, :count] => [:environment] do |task, args|
    basket_filling_count = args[:count].to_i
    basket_index         = 0
    grouped_apples       = Basket
                             .joins("left join apples on apples.basket_id = baskets.id")
                             .select('baskets.id basket_id,baskets.capacity, apples.variety as variety, count(apples.id) as apple_count')
                             .group('1,2,3')
                             .to_sql

    baskets = Basket
                .joins("left join (#{grouped_apples}) apples on apples.basket_id = baskets.id")
                .order('apples.apple_count')
                .where("((apples.apple_count = 0) OR (apples.variety = :variety AND apples.apple_count > 0)) AND baskets.capacity > 0", variety: args[:variety])
                .select('apples.basket_id, (apples.capacity - apples.apple_count) as filling_capacity')

    while basket_filling_count > 0 do
      current_basket = baskets[basket_index]
      if current_basket.present? && current_basket.filling_capacity > 0
        fillable_count = current_basket.filling_capacity > basket_filling_count ? basket_filling_count : current_basket.filling_capacity
        (1..fillable_count).each do
          Apple.create(basket_id: current_basket.basket_id, variety: args[:variety])
        end
        basket_filling_count -= current_basket.filling_capacity
        basket_index         += 1
      else
        puts "All baskets are full. We couldn't find the place for #{basket_filling_count} apples"
        break
      end
    end
  end
end