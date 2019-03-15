class ScopusHelper
  attr_reader :params

  AVAILABLE_METHODS = %i[preferred_name name_variant].freeze

  def initialize(params = {})
    @params = params
  end

  def parse_name(preferred_name, name_variant)
    name, surname = preferred_name["given-name"], preferred_name["surname"]

    if name_variant
      name = find_valid_data(name, "given-name") if invalid_data?(name)
      surname = find_valid_data(surname, "surname") if invalid_data?(surname)
    end

    [name&.split&.first, surname]
  end

  private

  AVAILABLE_METHODS.each do |method_name|
    define_method(method_name) do
      params[method_name]
    end
  end

  def find_valid_data(data, type)
    splitted_names = name_variant.map { |name| name[type]&.split }

    splitted_names.each do |splitted_name|
      next unless splitted_name

      if splitted_name.length == 1
        name = splitted_name.first

        return data = name unless invalid_data?(name)
      else
        splitted_name.each do |name|
          return data = name unless invalid_data?(name)
        end
      end
    end

    data
  end

  def invalid_data?(data)
    data.present? && data.include?(".")
  end
end
