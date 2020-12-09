class Boolean
  def self.parse(_tags_and_values, _tag)
    true
  end
end

module MyParser
  def value(tags_and_values, tag)
    tags_and_values[tags_and_values.index("-#{tag}") + 1]
  end
end

class String
  extend MyParser
  def self.parse(tags_and_values, tag)
    value(tags_and_values, tag)
  end
end

class Integer
  extend MyParser
  def self.parse(tags_and_values, tag)
    value(tags_and_values, tag).to_i
  end
end

class IntegerArray
  extend MyParser
  def self.parse(tags_and_values, tag)
    value(tags_and_values, tag).split(',').map(&:to_i)
  end
end

class Parser
  def self.process(schema, input)
    if input.empty?
      return schema.keys.each_with_object({}) do |tag, result|
        result[tag] = schema[tag][:default]
      end
    end

    schema.keys.each_with_object({}) do |tag, result|
      result[tag] =
        if input.include?("-#{tag}")
          tags_and_values = input.split(' ')
          schema[tag][:klass].parse(tags_and_values, tag)
        else
         schema[tag][:default]
        end
    end
  end
end
