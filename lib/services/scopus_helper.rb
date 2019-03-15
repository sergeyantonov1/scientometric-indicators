class ScopusHelper
  attr_reader :params

  AVAILABLE_METHODS = %i[preferred_name name_variant].freeze

  def initialize(params = {})
    @params = params
  end

  def parse_name
    name, surname = preferred_name["given-name"], preferred_name["surname"]

    if invalid_data?(name) && invalid_data?(surname)
      name = find_valid_data(name, "given-name")
      surname = find_valid_data(surname, "surname")
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
    names = name_variant.map { |name| name[type] }

    names.each do |name|
      data = name unless invalid_data?(name)
    end

    data
  end

  def invalid_data?(data)
    data.present? && data.include?(".")
  end
end
