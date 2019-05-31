class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []
  
  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      binding.pry
      resp.write handle_search(search_term)
    elsif req.path.match(/add/)
      item = req.params["q"]
      #binding.pry
      resp.write handle_add(item)
    elsif req.path.match(/cart/)
    binding.pry 
      if @@cart.empty?
        "Your cart is empty"
      else
        @@cart.each do |item|
          resp.write "#{item}\n"
        end
      end
    else
      resp.write "Path Not Found"
    end

    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end
  
  def handle_add(item)
    #binding.pry
    if @@items.include?(item)
      binding.pry
      @@cart << item
    else
      return "We don't have that item"
    end
  end
end
