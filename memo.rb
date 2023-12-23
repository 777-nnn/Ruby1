require "csv" # CSVファイルを扱うためのライブラリを読み込んでいます

class OutputCSV

    def initialize()
        @@file_name = ""
        @memo_type = 1
    end

    def input_memo_type
        puts "1 → 新規でメモを作成する / 2 → 既存のメモを編集する"
        @memo_type = gets.to_i # ユーザーの入力値を取得し、数字へ変換しています

        if @memo_type != 1 && @memo_type != 2 then
            puts "不正な値です"
            self.input_memo_type()
        end
    end

    def input_file_name
        puts "拡張子を除いたファイル名を入力してください"
        puts "/exitと打つと中断できます"
        @@file_name = gets.chomp

        if @@file_name == "/exit" then  #CSVがない状態での既存メモ編集の無限ループ等防止
            puts "プログラムを中断します"
            exit!
        elsif @memo_type == 2 && File.exist?("#{@@file_name}.csv") == false then
            puts "存在しないファイル名です"
            self.input_file_name()
        end

    end

    def input_memo_text
        puts "メモしたい内容を記入してください"
        puts "完了したらCtrl + D を押します"

        memo_text = $stdin.readlines(chomp: true)
        CSV.open("#{@@file_name}.csv","a") do |csv|
            csv << memo_text
        end

        puts "保存しました"

    end

end

    output = OutputCSV.new()
    output.input_memo_type()
    output.input_file_name()
    output.input_memo_text()
