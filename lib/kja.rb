#!/usr/bin/env ruby

# file: kja.rb

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

  def initialize(audio_player: '/usr/bin/ogg123 -q', base_dir: '')

    @base_dir, @audio_player = base_dir, audio_player

  end

  def speak(s)

    book_no, book_title, chapter_no, verse_no = \
      s.downcase.match(/^(?:(\d) )?([\w ]+) (\d+):(\d+)/).captures

    book_title = book_no + '_' + book_title if book_no
    chapter_title = book_title + '_' + chapter_no
    verse_title = chapter_title + '_' + verse_no

    lib = File.dirname(__FILE__)
    base_dir = @base_dir.empty? ? File.join(lib,'..','ogg', 'kj')  : @base_dir

    filepath = File.join(base_dir, book_title, chapter_title, 
      verse_title + '.ogg')

    `#{@audio_player} #{filepath}`    

  end

end

if __FILE__ == $0 then

  kja = Kja.new(audio_player: '/usr/bin/ogg123 -q')
  kja.speak(ARGV[0])

end
