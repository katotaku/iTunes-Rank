#! /usr/bin/env ruby

require 'zlib'
require 'open-uri'

STORE  = '143462-9'

Categories = %w(6021 6016 6022 6017 6014 6007 6006 6008 6004 6005 6001 6010 6009 6000 6015 6018 6013 6011 6020 6002 6012 6003 36)
PopIdes = %w(27 30 38 44 47 46)

BASE_URL = 'http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewTop?'

def getUrl(category,popId)
  return BASE_URL+"genreId="+category+"&popId="+popId
end
def getRanks(url)
   open(url,
      "User-Agent" => "User-Agent: iTunes/8.0.2",
      "X-Apple-Store-Front" => STORE) do |f|

      gz = f
      i = 0

      begin
         gz.each do |line|
            next if !line.match(/Buy.*salableAdamId=(\d+)/)
            i += 1
            line.match(/itemName="([^"]+)"/)
            puts i.to_s + ": " + $1
         end
      ensure
         gz.close
      end
   end
end

#main
Categories.each {|category|
  PopIdes.each {|popId|
    url = getUrl(category,popId)
    #getRanks(url)
  }
}
