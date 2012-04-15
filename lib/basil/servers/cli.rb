module Basil
  module Server
    # A simple commandline interface. Assumes all messages are to basil
    # from environment variable USER.
    class Cli
      include Basil

      def run

		puts "       .              ``           `-.....`             ..                                          "
puts "     `os+`           :ss-          -o.....-o.          +/.                                          "
puts "     -yyys-        `+yyyo          -+     `o- `/:-:/.`-o/-`+    ./ `::::::/  :/::/:  ./:-:/` ./:-:/`"
puts "     `+yyy/        .yyys-          -s::::/o/ `s-```.s` o- `s`   -+ //    /o /+````+/`s.```-s`:+.``-."
puts " .ooo+-:s+`         :s+-/+oo/      -o     .s``y-----/` o- `s`   :o o:    :o o+----:--s-----/``.--:/:"
puts " `yyyyys.            `/yyyyy/      :o      o: //...:+` o-  o:...+o .+:..:oo .+-..-+-`+/...:/ //.`./+"
puts "  /yhhhh-            `yhhhyo.      `.      ..  .---.   .`  `---.`. `-..../+  `----`   .---.   .---. "
puts "   .:/+o:            `oo+/.`       :ss`   `ss:           oo- `//`  `//:://`       os:               "
puts "  -+syyy//s/.    `:os.sysys:`      /hh.   `hh/ .-..:::`  :/../hh:-  .://-`   .:::.yh/               "
puts " :hhhhhy-hhhh+  .yhhh/+hhhhho      /dh.   `hh/ ohh+/ohy` hh/-+hh+:`oyo/+yy- /hy+/ohd/               "
puts " +ssss+./ddddh` oddddy`:ossss`     /dh.   .dd/ ods  `dd- hd/ .dd. :dhoooyhs.hd-  `yd/               "
puts "        :dddds  :dddds             -hdo-.-odh. ods  `dd- hd/ .dd:`-hh:../o:`ydo.`:hd/               "
puts "         :ydd-  `ydh+`              .+syyys+.  /s+  `ss. os- `+ss+ .+ssso/` `/sss+os-               "
puts "           .:    --`                                                             "
puts ""
puts "RefUtd - Lovingly Crafted By Craig, Kevin, Rob and Sam"
puts "Copyright 1984"
        loop do
          print '> '; str = $stdin.gets.chomp
          msg = Message.new(Config.me, ENV['USER'], ENV['USER'], str, 'cli')

          ChatHistory.store_message(msg)

          begin
            if reply = Basil.dispatch(msg)
              puts reply.text
            end
          rescue Exception => ex
            $stderr.puts "error: #{ex}"
          end

        end
      end
    end
  end
end
