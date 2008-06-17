require 'action_view/helpers/number_helper'
module ActionView  
  module Helpers    
    module NumberHelper
      def number_to_currency(number, options = {})
        options = options.stringify_keys        
        options[:locale] ||= request.locale if respond_to?(:request)

        formats = :'currency.format'.t options.delete(:locale)        
        precision = options["precision"] || formats[:precision]
        unit      = options["unit"] || formats[:unit]
        separator = precision > 0 ? options["separator"] || formats[:separator] : ""
        delimiter = options["delimiter"] || formats[:delimiter]
        format    = options["format"] || formats[:format]

        begin
          parts = number_with_precision(number, precision).split('.')
          format.gsub(/%n/, number_with_delimiter(parts[0], delimiter) + separator + parts[1].to_s).gsub(/%u/, unit)
        rescue
          number
        end
      end
    end
  end
end