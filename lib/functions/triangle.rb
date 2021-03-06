class PhaseTriangle < Base
  Arbol.add_mapped_class(
    'triangle', 
    PhaseTriangle,
%{//long twice_int_scale_vec[3] = {long(INTEGER_SCALE * 2), long(INTEGER_SCALE * 2), long(INTEGER_SCALE * 2)};
void triangle(long mils, long phase[3], long out[3]) {
  long times_result[3];
  times(phase, twice_int_scale_vec, times_result);
  if(times_result[0] > INTEGER_SCALE) { out[0] = (twice_int_scale_vec[0] - times_result[0]); } else { out[0] = times_result[0]; }
  if(times_result[1] > INTEGER_SCALE) { out[1] = (twice_int_scale_vec[1] - times_result[1]); } else { out[1] = times_result[1]; }
  if(times_result[2] > INTEGER_SCALE) { out[2] = (twice_int_scale_vec[2] - times_result[2]); } else { out[2] = times_result[2]; }
}}
  )
  attr_accessor :phase
  
  def param_keys
    [:phase]
  end

  def arduino_code
    unless @frame_optimized 
      [
        "triangle(mils, #{@phase.name}, #{@name});"
      ]
    else
      []
    end
  end
  
  def cycle_level_arduino_code
    if @frame_optimized
      [
        "triangle(mils, #{@phase.name}, #{@name});"
      ]
    else
      []
    end
  end
  
  def top_level_scope_code
    [
      "long #{@name}[3];",
    ]
  end
end

module Arbol
  class Documentation

  def triangle 
%{--
### triangle(phase)

* **phase**

`phase` input 0.0-1.0 input is transformed into a triangle.

}
  end

  end
end

def triangle(phase)
  h = ArbolHash.new
  h[:type] = 'triangle'
  h[:phase] = resolve(phase)
  h
end