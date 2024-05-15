# frozen_string_literal: true

# @api private
class Phlex::SGML::SafeValue
  def initialize(value)
    @value = value
  end

  def safe? = true
  def safe_value = @value
end
