module Enumerable
  
  # my_map modifies all elements and returns them in a new array 
  # maintaining the original array size
  def my_map
    new_array = []
    for item in self
      new_array << yield(item)
    end
    new_array
  end

  # given an array, this method returns the original array with
  # index of elements included
  def my_each_with_index
    return enum_for unless block_given?
    index = -1  # defined with -1 to cater for 0 when increment starts
    self.my_each { |item| yield(item, index += 1) }    
  end

  # 
  def my_inject(init=nil)
    acc = init
    self.my_each do |item|
      acc = yield(acc, item)
    end
    acc
  end

  # Returns an array of elemets that pass a given condition
  # An empty array is returned if no elements pass.
  def my_select
    selected = []
    return enum_for unless block_given?
    self.my_each { |item| selected.push(item) if yield(item) }
    selected  
  end

  def my_count
    count = 0
    return self.size unless block_given?
    self.my_each { |item| count += 1 if yield(item)}
    count 
  end

  # Returns true if and only if all elements pass the given condition
  # Otherwise it returns false.
  def my_all?
    flag = true
    self.my_each do |item|
      return false unless yield(item)
    end
    flag
  end

  # Returns true if only a single element passes a given condition, false otherwise
  def my_any?
    flag = false
    self.my_each do |item|
      return true if yield(item)
    end
    flag
  end

  # If any item passes the condition, this method returns false.
  # It is only true if all elements don't pass the given condition.
  def my_none?
    self.my_each do |item|
      if yield(item)
        return false
      else
        return true
      end
    end
  end
end

# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method
class Array
  # This method is required for the custom enumerables.
  def my_each
    for item in self
      yield(item)
    end
  end
end

