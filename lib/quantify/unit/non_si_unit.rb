
module Quantify
  module Unit
    class NonSI < Base

      # Class representing SI units. This inherits from Unit::Base

      # Additional initialize. Some NonSI units - temperature units, celsius and
      # farenheit - contain scaling factors in addition to multiplicative factors.
      # These are required in order to perform conversion, e.g. kelvin => celsius
      # and therefore become and additional attribute to NonSI units
      #
      def initialize(options = nil)
        @scaling = 0.0

        if options.is_a?(Hash) && options[:scaling]
          @scaling = options.delete(:scaling).to_f
        end

        super(options)
      end

    end
  end
end
