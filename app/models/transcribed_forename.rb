class TranscribedForename < ActiveRecord::Base
#  require 'csv'


  def self.process(filename)
    File.open(filename).each_line do |line|
      row = line.chomp.split(',')
      record = TranscribedForename.new
      record.fill_from_row(row)
      record.save!
    end
  end


  def fill_from_row(row)            
    role=''
    name=''
    frequency=1
    if row.count == 3
      role=row[0]
      name=row[1]
      frequency=row[2].to_i
    else

      if row.count == 2
        role=row[0]
        name=row[1]
        frequency=0
      else
        role=row[0]
        idx_frequency=row.count-1
        frequency=row[idx_frequency]
        name=row[1..(idx_frequency-1)].join(",") # add the commas again
        print "extracted [#{name}] from #{row}\n"
      end
    end


    self.role = role
    self.name = name
    self.frequency = frequency

    if name.match(/^[A-Za-z]+$/)
      self.simple=true
    else
      self.simple=false
    end

    if name.match(/\w+\s+\w+/)
      self.multiple=true
    else
      self.multiple=false
    end

    if name.match(/[\[\]_\*\?]/)
      self.ucf = true
    else
      self.ucf = false
    end

  end



  def analyze
    parts = self.name.split(/\s/)
    parts.each do |part|
      normalized_part = part.downcase.chomp
      record = NormalizedForename.where(:name => normalized_part).first
      unless record
        record = NormalizedForename.new(:name => normalized_part, 
                                        :frequency => 0,
                                        :number_of_sources => 0,
                                        :ucf => self.ucf)
      end
      record.frequency = record.frequency + self.frequency
      record.number_of_sources = record.number_of_sources + 1
      record.save!
    end
  end

end

