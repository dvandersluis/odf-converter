Uno::PropertyValue = Rubyuno.uno_require "com.sun.star.beans.PropertyValue"

class Hash
  def to_uno_properties
    self.inject([]) do |memo, (key, value)|
      property = Uno::PropertyValue.new
      property.Name = key.to_s
      property.Value = value.to_s
      memo << property
      memo
    end      
  end
end