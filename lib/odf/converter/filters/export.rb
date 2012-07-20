module ODF
  class Converter
    module Filters
      module Export
        include BaseFilter
        
        # see http://wiki.services.openoffice.org/wiki/Framework/Article/Filter
        # most formats are auto-detected; only those requiring options are defined here
        PDF = {
          ODF::Converter::Families::TEXT => {
            FilterName: "writer_pdf_Export"
          },
          ODF::Converter::Families::WEB => {
            FilterName: "writer_web_pdf_Export"
          },
          ODF::Converter::Families::SPREADSHEET => {
            FilterName: "calc_pdf_Export"
          },
          ODF::Converter::Families::PRESENTATION => {
            FilterName: "impress_pdf_Export"
          },
          ODF::Converter::Families::DRAWING => {
            FilterName: "draw_pdf_Export"
          }
        }
        
        HTML = {
          ODF::Converter::Families::TEXT => {
            FilterName: "HTML (StarWriter)"
          },
          ODF::Converter::Families::SPREADSHEET => {
            FilterName: "HTML (StarCalc)"
          },
          ODF::Converter::Families::PRESENTATION => {
            FilterName: "impress_html_Export"
          },
          ODF::Converter::Families::DRAWING => {
            FilterName: "XHTML" #HTML Document (OpenOffice.org Draw)"
          }
        }
        
        ODT = {
          ODF::Converter::Families::TEXT => {
            FilterName: "writer8"
          },
          ODF::Converter::Families::WEB => {
            FilterName: "writerweb8_writer"
          }
        }
        
        DOC = {
          ODF::Converter::Families::TEXT => {
            FilterName: "MS Word 97"
          }
        }
        
        DOCX = {
          ODF::Converter::Families::TEXT => {
            FilterName: "MS Word 2007 XML"
          } 
        }
        
        RTF = {
          ODF::Converter::Families::TEXT => {
            FilterName: "Rich Text Format"
          }
        }
        
        TXT = {
          ODF::Converter::Families::TEXT => {
            FilterName: "Text",
            FilterOptions: "utf8"
          }
        }
        
        ODS = {
          ODF::Converter::Families::SPREADSHEET => {
            FilterName: "calc8"
          }
        }
        
        XLS = {
          ODF::Converter::Families::SPREADSHEET => {
            FilterName: "MS Excel 97"
          }
        }
        
        CSV = {
          ODF::Converter::Families::SPREADSHEET => {
            FilterName: "Text - txt - csv (StarCalc)",
            FilterOptions: "44,34,0"
          }
        }
        
        ODP = {
          ODF::Converter::Families::PRESENTATION => {
            FilterName: "impress8"
          }
        }
        
        PPT = {
          ODF::Converter::Families::PRESENTATION => {
            FilterName: "MS PowerPoint 97"
          }
        }
        
        SWF = {
          ODF::Converter::Families::PRESENTATION => {
            FilterName: "impress_flash_Export"
          },
          ODF::Converter::Families::DRAWING => {
            FilterName: "draw_flash_Export"
          }
        }
        
        ODG = {
          ODF::Converter::Families::DRAWING => {
            FilterName: "draw8"
          }
        }
      end
    end
  end
end