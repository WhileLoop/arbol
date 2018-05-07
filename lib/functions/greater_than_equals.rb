class GreaterThanEquals < Base
  Irontofu.add_mapped_class(
    'greater_than_equals', 
    GreaterThanEquals,
%{void greater_than_equals(long left[3], long right[3], long out[3]) {
  if(left[0] >= right[0]) { out[0] = INTEGER_SCALE; } else { out[0] = 0; }
  if(left[1] >= right[1]) { out[1] = INTEGER_SCALE; } else { out[1] = 0; }
  if(left[2] >= right[2]) { out[2] = INTEGER_SCALE; } else { out[2] = 0; }
}}
  )
  attr_accessor :left
  attr_accessor :right
  
  def param_keys
    [:left, :right]
  end

  def arduino_code
    [
      "long #{@name}[3];",
      "greater_than_equals(#{@left.name}, #{@right.name}, #{@name});"
    ]
  end
end

def greater_than_equals(left, right)
  h = ArbolHash.new
  h[:type] = 'greater_than_equals'
  h[:left] = resolve(left)
  h[:right] = resolve(right)
  h
end