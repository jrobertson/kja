#!/usr/bin/env ruby

# file: kja.rb

require 'dynarex'
require 'tempfile'
require 'rxfreader'
require 'kj_reading'


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
                 ogg_baseurl: 'http://a0.jamesrobertson.me.uk/'  \
                + 'rorb/r/ruby/kja/ogg', debug: false)

    @ogg_baseurl, @audio_player = ogg_baseurl, audio_player
    @debug = debug

  end

  def download_ogg(s)

    ogg_filepath = fetch_ogg_filepath(s)
    url = @ogg_baseurl + '/' + ogg_filepath
    audio, _ = RXFReader.read(url)

    tmpfile = Tempfile.new('kva')
    File.write tmpfile.path + '.ogg', audio

    return tmpfile.path + '.ogg'

  end

  def duration(s)

    book_title, chapter_title, verse_no = fracture(s)

    url = @ogg_baseurl + '/' + File.join(book_title, chapter_title, 'dir.xml')

    dx = Dynarex.new url
    ogg = dx.find_by_name chapter_title + '_' + verse_no + '.ogg'
    ogg.description[/\d+\.\d+$/].to_f

  end

  def speak(title)

    a = KjReading.verses title

    a.each do |x|

      filename = download_ogg(x.title)
      command = @audio_player + ' ' + filename
      system command

    end

  end


  def download(s, outfile=nil)

    puts 'downloading ...' if @debug

    a = KjReading.verses s

    downloads = a.map do |x|
      download_ogg(x.title)
    end

    puts 'converting to wav: ' + downloads.inspect if @debug

    wavfiles = downloads.map do |oggfile|

      wavfile = oggfile.sub(/\.ogg$/,'.wav')
      EasyAudioUtils.new(oggfile, wavfile).convert
      sleep 1.4
      File.basename(wavfile)

    end

    puts 'concatenating wav files ...' if @debug

    # concat wav files
    #
    fullwavfile = Tempfile.new('kva').path + '.wav'
    puts 'creating fullwavfile:' + fullwavfile.inspect if @debug
    EasyAudioUtils.new(out: fullwavfile, working_dir: \
                       File.dirname(fullwavfile)).concat(wavfiles, sample_rate: 22050)

    # convert wav to ogg
    #
    fulloggfile = outfile || fullwavfile.sub(/\.wav$/, '.ogg')
    puts 'creating fulloggfile: ' + fulloggfile.inspect if @debug
    EasyAudioUtils.new(fullwavfile, fulloggfile).convert

    'downloaded ' + fulloggfile

  end

  private

  def fracture(s)

    book_no, book_title, chapter_no, verse_no = \
      s.downcase.match(/(?:(\d) )?([\w ]+) (\d+):(\d+)$/).captures

    book_title.gsub!(/\s/,'_')
    book_title = book_no + '_' + book_title if book_no
    chapter_title = book_title + '_' + chapter_no

    return [book_title, chapter_title, verse_no]
  end

  def fetch_ogg_filepath(s)

    book_title, chapter_title, verse_no = fracture(s)
    verse_title = chapter_title + '_' + verse_no

    File.join(book_title, chapter_title, verse_title + '.ogg')
  end

end

if __FILE__ == $0 then

  kja = Kja.new(audio_player: '/usr/bin/ogg123 -q')
  kja.speak(ARGV[0])

end
