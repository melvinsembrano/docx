require 'zip'
require 'nokogiri'

module Docx

  class BufferDocument < Docx::Document
    def initialize(stream, &block)
      @replace = {}
      @zip = Zip::File.open_buffer(stream)
      @document_xml = @zip.read('word/document.xml')
      @doc = Nokogiri::XML(@document_xml)
      @styles_xml = @zip.read('word/styles.xml')
      @styles = Nokogiri::XML(@styles_xml)
      if block_given?
        yield self
        @zip.close
      end
    end
  end
end
