require "net/http"
require "json"
require "csv"
#
require("./get_forums.rb")
require("./get_post_id.rb")
require("./get_post_content.rb")
require("./get_post_comment.rb")
require("./mv_files.rb")
#
require "fileutils"

def loop_cawler
  all_boards = CSV.parse(File.read("forums.csv"), headers: false)

  # 0.upto = 從第一個版開始
  0.upto(all_boards.count-1) do |board|

    table_title = all_boards["#{board}".to_i.."#{board}".to_i].first.first
      
    # Content_cut = 撈取資料數
    content_cut = 50
   
    # 每 n 筆資料暫停
    sleep_every = 10 

    # 暫停時休息秒數
    sleep_cut = 5

    get_post_id(board, content_cut,sleep_every ,sleep_cut )
    get_post_content(sleep_every ,sleep_cut)
    get_post_comment(sleep_every ,sleep_cut)
    mv_files(table_title, content_cut)
  end
end

get_forums()
beta_folder_name()
loop_cawler()
finish_time()
