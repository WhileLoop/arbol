class LessThan < Base
  Irontofu.add_mapped_class(
    'less_than', 
    LessThan,
%{void less_than(long left[3], long right[3], long out[3]) {
  if(left[0] > right[0]) { out[0] = INTEGER_SCALE; } else { out[0] = 0; }
  if(left[1] > right[1]) { out[1] = INTEGER_SCALE; } else { out[1] = 0; }
  if(left[2] > right[2]) { out[2] = INTEGER_SCALE; } else { out[2] = 0; }
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
      "less_than(#{@left.name}, #{@right.name}, #{@name});"
    ]
  end
end

def less_than(left, right)
  h = ArbolHash.new
  h[:type] = 'less_than'
  h[:left] = resolve(left)
  h[:right] = resolve(right)
  h
end