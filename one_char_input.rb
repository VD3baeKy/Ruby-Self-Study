#'io/console'で、エンターなしで1文字のキー入力が可能。

require 'io/console'

cnt=0
while c = STDIN.getch
    print c
    cnt+=1
    if cnt>5
        puts #{nil}
        break
    end
end
