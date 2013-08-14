require "rubyuno"
require "odf/config"
require "odf/converter/families"
require "odf/converter/filters/base_filter"
require "odf/converter/filters/import"
require "odf/converter/filters/export"
require "odf/converter/hash"
require "odf/converter/version"

Rubyuno.uno_require 'com.sun.star.lang.IllegalArgumentException'

module ODF
  class Converter
    class DocumentConversionError < Exception; end
    
    attr_reader :ctx, :smgr, :desktop, :document
    
    def initialize
      config = ODF.config
      @ctx = Uno::Connector.bootstrap(
        office: config.office_bin.to_s,
        type: config.connection_type.to_s,
        host: config.host.to_s,
        port: config.port,
        spawn_cmd: config.spawn_cmd
      )

      @smgr = @ctx.getServiceManager
      @desktop = @smgr.createInstanceWithContext("com.sun.star.frame.Desktop", @ctx)
    end
    
    def convert(infile, options = {})
      raise ArgumentError, "to option must be provided." unless options[:to]
      
      if options[:to].is_a? Symbol #and Filters::Export[options[:to]]
        outfile = get_output_name(infile, options[:to])
      elsif options[:to].is_a? String
        raise DocumentConversionError, "#{options[:to]} doesn't specify an extension" if File.extname(options[:to]).empty?
        outfile = File.expand_path(options[:to])
      else
        raise DocumentConversionError, "not given a valid destination"
      end
      
      perform_conversion(infile, outfile) && outfile
    end
    
    def inspect
      "#<#{self.class.name} #{self.class.config.office_bin}@#{self.class.config.host}:#{self.class.config.port}>"
    end
    
    def self.convert(*args)
      new.convert(*args)
    end
    
  private
    def detect_family(doc)
      return Families::WEB if doc.supportsService("com.sun.star.text.WebDocument")
      return Families::TEXT if doc.supportsService("com.sun.star.text.GenericTextDocument")
      return Families::SPREADSHEET if doc.supportsService("com.sun.star.sheet.SpreadsheetDocument")
      return Families::PRESENTATION if doc.supportsService("com.sun.star.presentation.PresentationDocument")
      return Families::DRAWING if doc.supportsService("com.sun.star.drawing.DrawingDocument")
      raise DocumentConversionError, "unknown document family"
    end
    
    def file_url_for(file)
      Rubyuno.system_path_to_file_url File.expand_path(file)
    end
    
    def get_output_name(file, ext)
      file = File.expand_path(file)
      File.join(File.dirname(file), File.basename(file, File.extname(file)) + ".#{ext}")
    end
    
    def perform_conversion(infile, outfile)
      begin
        load(infile) && store(outfile)
      ensure
        @document.close(true) if @document
      end
    end
    
    def load(infile)
      input_url = file_url_for(infile)
      input_ext = File.extname(infile).gsub(/^\./, "")
      props = { Hidden: true }.merge(Filters::Import[input_ext] || {})
      
      begin
        @document = desktop.loadComponentFromURL(input_url, "_blank", 0, props.to_uno_properties)
        raise DocumentConversionError, "could not load document" unless @document
      rescue Rubyuno::Com::Sun::Star::Lang::IllegalArgumentException => e
        raise DocumentConversionError, e.message
      end
      
      @document.refresh if @document.respond_to? :refresh
      
      family = detect_family(@document)
      
      if family == Families::SPREADSHEET
        page_styles = @document.getStyleFamilies.getByName('PageStyles')
        page_styles.getElementNames.each do |name|
          page_style = pageStyles.getByName(name)
          page_style.setPropertyValue("PageScale", 100)
          page_style.setPropertyValue("PrintGrid", false) 
        end
      end
      
      true
    end
    
    def store(outfile)
      output_url = file_url_for(outfile)
      output_ext = File.extname(outfile).gsub(/^\./, "")
      
      family = detect_family(@document)
      props = Filters::Export[output_ext] or raise DocumentConversionError, "unknown output format: #{output_ext}"
      props = props[family] or raise DocumentConversionError, "unsupported conversion: from #{family} to #{output_ext}"
      
      @document.storeToURL(output_url, props.to_uno_properties)

      true
    end
  end
end
