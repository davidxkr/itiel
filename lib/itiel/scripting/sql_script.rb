module Itiel
  module Scripting
    #
    # Executes a SQL script or command on the specified
    # connection
    #
    class SQLScript
      include InputOutputBehavior

      attr_accessor :connection
      attr_accessor :sql

      def initialize(*args)
        self.sql = args[0]
        super
      end

      def execute!
        sanity_check

        Executor.establish_connection connection.connection_string
        Executor.connection.execute(self.sql)
      end

      private
      def sanity_check
        raise "No connection was specified to run the script" unless connection
        raise "Connection is not Itiel::Extractors::DatabaseConnection" unless connection.is_a?(Itiel::Extractors::DatabaseConnection)
        raise "No SQL to execute given" unless self.sql
      end

      class Executor < ActiveRecord::Base ; end
    end

  end
end