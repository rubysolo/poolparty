module PoolParty
      
  module Plugin
    
    class Plugin
      include MethodMissingSugar
      include Configurable
      include CloudResourcer
      include Resources
      extend Resources
      
      attr_accessor :parent
      class_inheritable_accessor :name
      
      default_options({})
      
      def initialize(parent=self, opts={}, &block)
        set_parent(parent)
        block ? instance_eval(&block) : enable
      end
      
      # Overwrite this method
      def enable
      end
                  
    end
    
  end
end