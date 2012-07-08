module ODF                                                                                                                                                                                               
  class Converter                                                                                                                                                                                        
    module Filters                                                                                                                                                                                      
      module Import
        include BaseFilter
        
        # see http://wiki.services.openoffice.org/wiki/Framework/Article/Filter
        # most formats are auto-detected; only those requiring options are defined here
        TXT = {
          FilterName: "Text (encoded)",
          FilterOptions: "utf8"  
        }
        
        CSV = {
          FilterName: "Text - txt - csv (StarCalc)",
          FilterOptions: "44,34,0"
        }
      end                                                                                                                                                                         
    end                                                                                                                                                                                                  
  end                                                                                                                                                                                                    
end                                                                                                                                                                                                      