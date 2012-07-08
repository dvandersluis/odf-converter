require 'odf/converter'

describe ODF::Converter do
  describe "#new" do
    it "should initialize a connection" do
    end
  end
  
  describe "#convert" do
    let(:c) { ODF::Converter.new }
    
    describe do
      before do
        Uno::Connector.stub_chain(:bootstrap, :getServiceManager, :createInstanceWithContext)
        c.stub(:perform_conversion) { true }
      end
      
      it "should raise an error if the to option is not given" do
        expect { c.convert("infile.txt") }.to raise_error ArgumentError
      end
  
      it "should raise an error if the to option is a string but doesn't look like a file with extension" do
        expect { c.convert("infile.txt", to: "file") }.to raise_error ODF::Converter::DocumentConversionError
      end
      
      it "should raise an error if the to option is not a string or a symbol" do
        expect { c.convert("infile.txt", to: []) }.to raise_error ODF::Converter::DocumentConversionError
      end
          
      it "should output to the input file name with the extension changed if to is set to a symbol" do
        FileUtils.cd "/"
        
        c.convert("infile.txt", to: :html).should == "/infile.html"
        c.convert("/home/username/infile.txt", to: :html).should == "/home/username/infile.html"
      end
      
      it "should output to the given name if it's a valid filename" do
        FileUtils.cd "/"
        
        c.convert("infile.txt", to: "outfile.html").should == "/outfile.html"
        c.convert("/home/username/infile.txt", to: "/home/username/outfile.html").should == "/home/username/outfile.html"
      end
    end
  end
end