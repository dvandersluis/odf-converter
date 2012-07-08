module ODF
  class Converter
    module Filters
      module BaseFilter
        def self.included(klass)
          klass.extend(ClassMethods)
        end
        
        module ClassMethods
          def [](filter)
            self.const_get(filter.to_s.upcase) rescue nil
          end
        end
      end
    end
  end
end