
def consolidate_cart(cart)
    new_cart = {}
    keys = []
    cart.each do |item|
      item.each do |k, v|
        keys << k
        new_cart[k] = v
        new_cart[k][:count] = keys.count(k)
    end
    end
    new_cart
    end

  def apply_coupons(cart, coupons)
    hash = cart
    coupons.each do |coupon|
      item = coupon[:item]

      if !hash[item].nil? && hash[item][:count] >= coupon[:num]
        temp = {"#{item} W/COUPON" => {
          :price => coupon[:cost],
          :clearance => hash[item][:clearance],
          :count => 1
          }
        }

        if hash["#{item} W/COUPON"].nil?
          hash.merge!(temp)
        else
          hash["#{item} W/COUPON"][:count] += 1
        end
        hash[item][:count] -= coupon[:num]
      end
    end
    hash
  end

  def apply_clearance(cart)
    cart.each do |key, value|
      if value[:clearance] == true
          value[:price] = (value[:price] * 0.8).round(2)
          end
      end
      cart
    end

    def checkout(items, coupons)
      cart = consolidate_cart(items)
      cart1 = apply_coupons(cart, coupons)
      cart2 = apply_clearance(cart1)

      total = 0

      cart2.each do |name, price_hash|
        total += price_hash[:price] * price_hash[:count]
      end

      total > 100 ? total * 0.9 : total

    end
