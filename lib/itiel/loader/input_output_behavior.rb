module Itiel
  module Loader
    #
    # This module defines the input and output behavior for Loader steps
    #
    # Whenever an Output receives input, it calls persist! and then
    # wires the input and the output
    #
    # All the clasess in Itiel::Output should implement persist!
    #
    module ChainedStep
      module InstanceMethods
        def input=(input_stream)
          Itiel::Logger.log_received(self, input_stream.size)
          persist(input_stream)
          self.next_step = input_stream if self.next_step
          Itiel::Logger.log_processed(self, input_stream.size)
        end

        #
        # This method has to be implemented in the class
        #
        def persist(input_stream)
          raise "persist is not implemented"
        end

        private
        attr_writer :output
      end

      def self.included(receiver)
        receiver.send :include, InstanceMethods
      end
    end
  end
end
