class IngestCsv
  require "#{Rails.root}/app/models/transcribed_forename"
  
  def self.ingest(filename)
    print "Ingesting #{filename}\n"
    TranscribedForename.process(filename)
  end


  
end
