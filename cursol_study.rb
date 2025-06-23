# ANSIエスケープシーケンスを使用してカーソルを移動

def print_at_same_position(text,x)
  
  if x==1
    # カーソルを上に移動
    print "\033[F"  # 上に1行移動
  elsif x==2
    # カーソルを行の先頭に移動
    print "\r"  # 行の先頭に戻る
  end
  
  # テキストを出力
  print text
  print ' ' * (20 - text.length)

end

# 使用例

puts "最初のメッセージ"
sleep(2)  # 2秒待つ
print_at_same_position("新しいメッセージ 1",1)
sleep(2)  # 2秒待つ
print_at_same_position("新メッセージ 2",2)
sleep(2)  # 2秒待つ
print_at_same_position("新 3",2)
puts #{nil}
