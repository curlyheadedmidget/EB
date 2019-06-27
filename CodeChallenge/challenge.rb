require 'docraptor'
require 'pdf-reader'
require 'bundler/setup'
require 'open-uri'

Bundler.require

DocRaptor.configure do |config|
  config.username = "O5Uoe9cQ0iYek2oVjH6f"
  # config.debugging = true
end

$docraptor = DocRaptor::DocApi.new
@urls = [["http://docraptor.com/documentation","docraptor.pdf"],["http://google.com","google.pdf"],["https://www.imdb.com/","imdb.pdf"],["http://testipes.compendiumblog.com/all-recipes","recipes.pdf"]]
@all_docs = []

# make array of urls, make loop to cycle through creating docs, print out json in asc order by page count

begin
 
  @urls.each do |url,name|
  create_response = $docraptor.create_async_doc(
    test: true,                                         
    document_url: url,
    name: name,                          
    document_type: "pdf",                                        
  )
    loop do
      status_response = $docraptor.get_async_doc_status(create_response.status_id)
      case status_response.status
      when "completed"
        doc_response = $docraptor.get_async_doc(status_response.download_id)
        File.open("/tmp/#{name}", "wb") do |file|
          file.write(doc_response)
          reader = PDF::Reader.new("/tmp/#{name}")
          @doc_info = {
          :pdf_version => reader.pdf_version,
          :info => reader.info,
          :metadata => reader.metadata,
          :page_count => reader.page_count,
          }
        end        
        break
      when "failed"
        puts "FAILED"
        puts status_response
        break
      else
        sleep 1
      end
      
    end
    @all_docs << @doc_info
  end

  rescue DocRaptor::ApiError => error
  puts "#{error.class}: #{error.message}"
  puts error.code          # HTTP response code
  puts error.response_body # HTTP response body
  puts error.backtrace[0..3].join("\n")
end
puts @all_docs.sort_by { |page| -page[:page_count] }.reverse