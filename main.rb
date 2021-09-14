module Enumerable
#after going through the lambda/proc lesson, I still have no idea how to do it with lambdas/procs.
    def my_each
      for i, n in self
	yield(i, n)
	end
    end

    def my_each_with_index
       for item, index in self
	index = self.index(item)
         yield item, index
       end
    end

    def my_select
     if block_given?

      case self
      when Array
       my_select_arr = []

       for item in self
        if yield(item) == true
        my_select_arr.push(item)
        end
       end
       my_select_arr
      when Hash
       my_select_hash = {}
       for key, value in self
        if yield(key, value) == true
        my_select_hash[key] = value
        end
       end
       my_select_hash
      end

     else
      enumerator = self.to_enum(:my_select)
     end
    end
    
    def my_all?(pattern = nil)
      if block_given?
	for item in self
          if yield(item) == true
             true
          else
             return false
          end
         end
      else
        if pattern != nil
         for item in self
            if pattern === item
             true
            else
             return false
		end
	     end
        else
          for item in self
              if item
               true
              else
               return false
              end
          end
          end
       end
        true
    end

    def my_any?(pattern = nil)
      if block_given?
	for item in self
          if yield(item) == true
             return true
          else
             false
          end
         end
      else
        if pattern != nil
         for item in self
            if pattern === item
             return true
            else
             false
		end
	     end
        else
          for item in self
              if item
               return true
              else
               false
              end
          end
          end
       end
        false
    end

    def my_none?(pattern = nil)
      if block_given?
	for item in self
          if yield(item) == false
             true
          else
             return false
          end
         end
      else
        if pattern != nil
         for item in self
            if pattern != item
             true
            else
             return false
		end
	     end
        else
          for item in self
              if !item || nil
               true
              else
               return false
              end
          end
          end
       end
        true
    end
    
    def my_count(value = nil)
        i = 0
        if block_given?
           for item in self
            if yield(item) == true
               i = i + 1
            end
           end
        else
           if value === nil
              for item in self
              i = i + 1
              end
           else
              for item in self
              if value == item
                 i = i + 1
              end
              end
           end
        end
        i
    end
end

numbers = [1, 2, 3, 4, 5]
hash = {monica: "girl", ron: "boy", stella: "girl"}

puts "my_each vs. each"
numbers = [1, 2, 3, 4, 5]
puts ''
numbers.my_each  { |item| print item }
print ' '
numbers.each  { |item| print item }

puts "\n\nmy_each_with_index vs. each_with_index"
numbers.each_with_index {|item, index| puts "#{index}. #{item}"}
puts ''
numbers.my_each_with_index {|item, index| puts "#{index}. #{item}"}

puts "\n\nmy_select vs. select"

p numbers.my_select
p numbers.select {|item| item >= 3 }
p hash.my_select {|key, value| value == "girl"}
p hash.select {|key, value| value == "girl"}


puts "\n\nmy_all? vs. all?"
p numbers.all? {|num| num > 3}
p numbers.my_all? {|num| num > 3}

puts "\n\nmy_any? vs. any?"

p numbers.any? {|num| num > 6}
p numbers.my_any? {|num| num > 6}

puts "\n\nmy_none? vs. none?"

p numbers.none? {|num| num > 6}
p numbers.my_none? {|num| num > 6}

puts "\n\nmy_count vs. count"
p numbers.count(5)
p numbers.my_count(5)
p numbers.count {|x| x%2 == 0}
p numbers.my_count {|x| x%2 == 0}



