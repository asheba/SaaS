class Class

  def attr_accessor_with_history(attr_name)

    attr_name = attr_name.to_s   # make sure it's a string
    attr_reader attr_name        # create the attribute's getter
    attr_reader attr_name+"_history" # create bar_history getter

    class_eval <<-write
      
      def #{attr_name}=(value)
        @#{attr_name} = value
        (@#{attr_name}_history ||= [nil]) << value
      end

    write

  end

end

class Foo
  attr_accessor_with_history :bar
end

f = Foo.new
f.bar = 1
f.bar = 2
f.bar_history

class Numeric

  @@currencies = { :yen => 0.013, :euro => 1.292, :rupee => 0.019, :dollar => 1 }

  def method_missing(method_id)
    transform(method_id, :*)
  end

  def in(currency)
    transform(currency, :/)
  end

  def transform(currency, operation)

    singular_currency = currency.to_s.gsub(/s$/, '').to_sym
    if @@currencies.has_key? singular_currency
      self.send(operation,  @@currencies[singular_currency])
    else
      super
    end
  end
end

class String
  def palindrome?
    merged = self.downcase.gsub(/[^\w]/, "")
    merged == merged.reverse
  end
end

module Enumerable
  def palindrome?
    reverse = []
    regular = []
    self.reverse_each { |v| reverse << v }
    self.each { |v| regular << v }

    reverse == regular
  end
end