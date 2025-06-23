# じゃんけんゲーム プログラム

require 'timeout'
require 'io/console'

####### 入力仕様 ######
##
##  制約 パラメータ数：3
##    整数値：[ 1, 2, 3 ]
##  変数名
##    your_hand_int
##
####### 出力仕様 ######
##
##  制約 パラメータ数：9
##    文字列：[
##          '［ グー：0、チョキ：1、パー：2 ］を入力',
##          '  あなたの手 ＝ ',
##          '  コンピューターの手 ＝ ',
##          '不正な入力を検出しました。再入力！',
##          'あなたの勝ちです！',
##          'あなたの負けです！',
##          'あいこ！',
##          '5秒以内に入力がありませんでした！',
##          'プレイ時間が30秒を越えました！また遊んでね！'
##           ]
##  変数名
##    output_str
##  
##  制約 パラメータ数：3
##    文字列：[
##          'グー',
##          'チョキ',
##          'パー',
##           ]
##  変数名
##    otete_map
##  
##  制約 パラメータ数：5
##    文字列：［
##          '　相手の手は グー でした！！！',
##          '　相手の手は チョキ でした！！！',
##          '　相手の手は パー でした！！！',
##          'イベント発動！！！',
##          '「z」「x」を交互に連打して勝利を勝ち取れ！！！'
##           ]
##  変数名
##    eventout_str
##
###### 内部変数 ######
##
##  制約　パラメータ数：2
##    bool：[ true, false ]
##  変数名
##    judge_bool
##
##  制約 パラメータ数：3
##    整数値：[ 0, 1, 2 ]
##  変数名
##    $cpu_hand_int
##  
##  制約　5秒
##    整数値：5
##  変数名
##    wdg_gets
##  
##  制約　30秒
##    整数値：30
##  変数名
##    wdg_while
##
######################


###############
### 初期化部 ###
###############

# 制御用変数
$judge_bool = true
$validate = true
$wdg_gets = 5
$wdg_while = 30

# 入力用　変数
$your_hand_int = nil

# コンピュータ用　変数
$cpu_hand_int = nil

# 出力文字用
$output_str = [
            '［ グー：1、チョキ：2、パー：3 ］を数値入力： ',
            '  ・あなたの手　　　　　＝ ',
            '  ・コンピューターの手　＝ ',
            '不正な入力を検出しました。再入力！',
            'あなたの勝ちです！',
            'あなたの負けです！',
            'あいこ！',
            '5秒以内に入力がありませんでした！',
            'プレイ時間が30秒を越えました！また遊んでね！'
           ]
$otete_map_str = [
            'グー',
            'チョキ',
            'パー'
          ]

$eventout_str = [
            '　相手の手は グー でした！！！',
            '　相手の手は チョキ でした！！！',
            '　相手の手は パー でした！！！',
            'イベント発動！！！',
            '「z」「x」を交互に連打して勝利を勝ち取れ！！！'
          ]


################
### ロジック部 ###
################

########## 入力処理
def input_otete()
  # 手の定義を提示する
  # 入力案内を提示する
  print $output_str[0]
  
  # getsで入力を受付。
  tmp = nil
  begin
    # 180秒($wdg_gets)の制約で入力を待つ
    input = Timeout.timeout($wdg_gets) do
      tmp = gets.chomp
    end
  rescue Timeout::Error
    puts #{nil}
    puts $output_str[7]
    $validate = false
  end
    
  # 入力値バリデーションチェック　1
  if tmp.nil? || tmp.size>1
    puts $output_str[3]  
    puts #{nil}
    $validate = false
  else
    # " .to_i "で整数に変換する。
    $your_hand_int = tmp.to_i
  end
  
  # 入力値バリデーションチェック　2
  if $your_hand_int.nil? || $your_hand_int<=0 || $your_hand_int>3
    puts $output_str[3]  
    puts #{nil}
    $validate = false
  else
    $validate = true
  end
  
  # マッピング対応化
  if $validate == true
    $your_hand_int = $your_hand_int - 1
  else
    tmp = nil
    $your_hand_int = nil
  end
end


########## イベント
def ii_event(difiTmp, chanceTmp)
  puts $eventout_str[3]
  puts $eventout_str[4]
  rendaCharTmp = nil
  rendaCntTmp = 0
  rendaCntMaxTmp = 0  
  keyTmp = true
  if rand(chanceTmp)==0
    begin
      eventLoop1 = Timeout.timeout(5) do
        while true
          if rendaCntMaxTmp<rendaCntTmp
            rendaCntMaxTmp = rendaCntTmp
          end
          rendaCntTmp=0
          #puts rendaCntMaxTmp
          begin
            eventLoop2 = Timeout.timeout(1) do
              while true
                rendaCharTmp = STDIN.getch
                #puts rendaTmp
                if keyTmp && rendaCharTmp=='z'
                  rendaCntTmp+=1
               elsif !keyTmp && rendaCharTmp=='x'
                  rendaCntTmp+=1
                end
                if keyTmp
                  keyTmp = false
                elsif !keyTmp
                  keyTmp = true
                end
              end
            end
          rescue  Timeout::Error
            #puts #{nil}
          end
        end
      end
    rescue Timeout::Error
      puts #{nil}
    end
  end
    if $your_hand_int==0 && $cpu_hand_int==2  # グー vs パー
      if rendaCntMaxTmp>difiTmp
        print "\033[F"  # 上に1行移動
        print "\033[F"  # 上に1行移動
        print "\033[F"  # 上に1行移動
        print "\033[F"  # 上に1行移動
        puts $eventout_str[1]
        puts $output_str[4]+"　　　　   　　　　　　　　"
        puts "　　　　　　   　　　　　　　　　　　　　　　　　　"
      else
        puts $output_str[5]
      end
    elsif $your_hand_int==1 && $cpu_hand_int==0  # チョキ vs グー
      if rendaCntMaxTmp>difiTmp
        print "\033[F"  # 上に1行移動
        print "\033[F"  # 上に1行移動
        print "\033[F"  # 上に1行移動
        print "\033[F"  # 上に1行移動
        puts $eventout_str[2]
        puts $output_str[4]+"　　　   　　　　　　　　　"
        puts "　　　　　　   　　　　　　　　　　　　　　　　　　"
      else
        puts $output_str[5]
      end
    elsif $your_hand_int==2 && $cpu_hand_int==1  # パー vs チョキ
      if rendaCntMaxTmp>difiTmp
        print "\033[F"  # 上に1行移動
        print "\033[F"  # 上に1行移動
        print "\033[F"  # 上に1行移動
        print "\033[F"  # 上に1行移動
        puts $eventout_str[0]
        puts $output_str[4] + "　　   　　　　　　　　　　"
        puts "　　　　　　   　　　　　　　　　　　　　　　　　　"
      else
        puts $output_str[5]
      end
    end
end


########## ループ処理メイン
def loop_main()
  # ループ処理部
  while $judge_bool
  
    # 出したい手を入力させる
    input_otete()
    if $validate==false
      next
    end
    
    print $output_str[1]
    puts $otete_map_str[$your_hand_int]
  
    # コンピューターの手を決める
    # コンピューターの手は0～2の整数でランダムに決める
    $cpu_hand_int = rand(3)

    # コンピューターの手を提示
    print $output_str[2]
    puts $otete_map_str[$cpu_hand_int]
  
    # 勝ち負けの判定
    
    if $your_hand_int==0 && $cpu_hand_int==1  # グー vs チョキ
      puts $output_str[4]
      $judge_bool=false
    elsif $your_hand_int==0 && $cpu_hand_int==2  # グー vs パー
      ii_event(10,1)
      #puts $output_str[5]
      $judge_bool=false
    elsif $your_hand_int==1 && $cpu_hand_int==0  # チョキ vs グー
      ii_event(10,1)
      #puts $output_str[5]
      $judge_bool=false
    elsif $your_hand_int==1 && $cpu_hand_int==2  # チョキ vs パー
      puts $output_str[4]
      $judge_bool=false
    elsif $your_hand_int==2 && $cpu_hand_int==0  # パー vs グー
      puts $output_str[4]
      $judge_bool=false
    elsif $your_hand_int==2 && $cpu_hand_int==1  # パー vs チョキ
      ii_event(10,1)
      #puts $output_str[5]
      $judge_bool=false
    else                      # "あいこ" ならば、繰り返し
      puts $output_str[6]
      puts #{nil}
    end
    
  end
end

########## メイン処理
begin
  # 600秒($wdg_while)の制約でループ処理を実行
  mainLoop = Timeout.timeout($wdg_while) do
    loop_main()
  end
rescue Timeout::Error
  puts #{nil}
  puts $output_str[8]
end
