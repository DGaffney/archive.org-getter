#usage: ruby archive.org-getter.rb [TERM]
#URL opener
require 'open-uri'

# set variables
start = 0
ROWS = 200


def parameterize(params)
  "?"+URI.escape(params.collect{|k,v| "#{k}=#{v}"}.join('&'))
end
# incrementally download JSON files
while start < 1000
# don't forget to turn variable numbers into strings with .to_s
  term = URI.encode(ARGV[0])
  params = {:start => start, :rows => ROWS, :output => "json", :q => term}
  url = "http://archive.org/details/tv#{parameterize(params)}"
  print "fetching from " + start.to_s + "\n"
  print "  "+url + "\n"

  
  file = open(url)
  results = file.read
  print "  got "+results.length.to_s+" characters\n"
 
  #openurl library and pass url to fetch it
  #if success
   # increment start row +100
    #save to disk with filename results startrow#.json
  #else 
   # wait one minute and do it again

# if page doesn't load...
  if results.index("Our Search Engine was not responsive.") == nil
    start = start + ROWS
    aFile = File.new("TVNews_results"+ start.to_s + ".json", "w")
    aFile.write(results)
    aFile.close
  else 
    print "request failed"
# hang out for a minute before trying again
    sleep(60)
  end
end 
