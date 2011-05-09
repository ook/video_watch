require 'pathname'

class VigyVideo
  FROM = '/video/to_encode'
  TO   = '/video/encoded'
  ACCEPTED_EXTENTIONS = ['mpg', 'avi', 'mpeg', 'mp2']

  class << self
    from = Pathname.new(FROM)
    to   = Pathname.new(TO)

    from.children.each do |filename|
      next if !filename.file? || ACCEPTED_EXTENTIONS.include?(filename.extname.downcase)
      cmd = "mencoder -oac mp3lame -lameopts cbr:br=128 -ovc xvid -xvidencopts bitrate=900 #{filename} -o #{to.realpath + filename.basename.to_s.gsub(/\..+$/, '.avi')}"
      system cmd
      res = $?
      if 0 == res
        filename.delete
      end
    end
  end
end
