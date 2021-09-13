class Record
  attr_accessor :key, :copy

  def initialize(attributes)
    @key = attributes[:key]
    @copy = attributes[:copy]
  end

  def value(params)
    value = copy
    parameters = copy.scan(/\{([^}]+)\}/).flatten
    parameter_hash = {}

    parameters.each do |parameter|
      parameter_name = parameter.split(",")[0]
      parameter_type = parameter.split(",")[1]&.strip.to_s
      parameter_value = params[parameter_name]

      if parameter_value.present? && parameter_type == "datetime"
        date = Time.at(value.to_i)
        parameter_value = date.strftime("%a %b %-d %l:%M:%S%p")
      end

      parameter_hash[parameter_name] = { macros: "{#{parameter}}", value: parameter_value.to_s }
    end

    parameter_hash.each do |k,v|
      value.gsub!(v[:macros], v[:value])
    end

    value
  end
end