# Introducing the kja gem


    require 'kj'
    require 'kja'

    bible = Kj::Bible.new

    title = bible.books[0].chapters[0].verses[8].title
    #=> "Genesis 1:9" 

    text =  bible.books[0].chapters[0].verses[8].text
    #=> "And God said, Let the waters under the heaven be gathered together ..." 

    kja = Kja.new(audio_player: '/usr/bin/ogg123 -q')
    kja.speak(title)

The above snippet uses the kja gem to download and play an ogg file for verse title *Genesis 1:9* from the King James Bible.

Note: I had originally intended for the OGG files to be included with the gem. However, the OGG directory file size was over 1.2GB and it was causing input/output error when trying to build the gem.

## Resources

* kja https://rubygems.org/gems/kja

kja kj bible ogg rorbuilder
