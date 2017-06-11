#!/usr/bin/env ruby

# file: kja.rb

require 'tempfile'
require 'rxfhelper'

# description: Intended for use with the kj gem
#
# e.g.

=begin

  require 'kj'
  bible = Kj::Bible.new

  s = bible.books[0].chapters[0].verses[0].title

  kja = Kja.new(player: '/usr/bin/ogg123 -q')
  kja.speak(s)

=end


class Kja

  def initialize(audio_player: '/usr/bin/ogg123 -q', 
                 ogg_baseurl: 'http://rorbuilder.info/r/ruby/kja/ogg')

    @ogg_baseurl, @audio_player = ogg_baseurl, audio_player

  end

  def speak(s)

    book_no, book_title, chapter_no, verse_no = \
      s.downcase.match(/^(?:(\d) )?([\w ]+) (\d+):(\d+)/).captures

    book_title = book_no + '_' + book_title if book_no
    chapter_title = book_title + '_' + chapter_no
    verse_title = chapter_title + '_' + verse_no

    ogg_filepath = File.join(book_title, chapter_title, verse_title + '.ogg')
    url = @ogg_baseurl + '/' + ogg_filepath
    audio, _ = RXFHelper.read(url)
    
    tmpfile = Tempfile.new('kva')
    file = File.new(tmpfile.path,'w')        
    file.puts audio
    file.close

    command = @audio_player + ' ' + tmpfile.path
    system command

  end

end

if __FILE__ == $0 then

  kja = Kja.new(audio_player: '/usr/bin/ogg123 -q')
  kja.speak(ARGV[0])

end
