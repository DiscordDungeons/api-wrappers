module DDAPI
  # Custom errors raised in various places
  module Errors

    # Raised when authorization is invalid or incorrect.
    class InvalidAuthorization < RuntimeError
      # Default message for this exception
      def message
        'API key/User Agent invalid!'
      end
    end
    # Raised when a device is invalid or incorrect.
    class ObjectNotFound < RuntimeError
      # Default message for this exception
      def message
        'A various Object is not found with this ID!'
      end
    end
  end
end