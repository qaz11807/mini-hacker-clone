# README

# mini Hacker News Clone

複製一個 mini 的 Hacker News，製作簡易可用的推文系統 prototype：

https://news.ycombinator.com/

## 主要需要實踐的功能概述

**對於任何訪客，進入到首頁：**

- 可以註冊帳號
- 可以登入帳號
- 可以看到所有貼文的
  - 標題
  - 權重分數
  - 作者
  - 留言數
- 可以點擊貼文觀看每則貼文的留言內容

**對於已經註冊的訪客：**

- 可以對其他人貼文投票 upvote
  - 未登入者點擊投票按鈕，導向去登入介面
  - 不可 downvote
  - 已點過 upvote 者再點一次即撤銷先前的投票
- 可以發表貼文
- 可以在貼文下留言
- 可以針對其他人的留言做留言（巢狀結構，最多 8 層，介面上請為巢狀結構稍作縮排示意）

**貼文排序：**

- 每一則貼文依照權重分數降冪排序，權重分數計算公式可參考下個段落
- 每分鐘更新一次權重分數（為求可以從介面上測試，故時間條件設定為每分鐘）
- 貼文需要分頁，一頁最多 10 篇內容

**貼文的留言排序：**

- 留言排序規則與貼文相同
- 每一層巢狀留言也都需要套用相同排序規則

## 權重分數計算公式

```
權重分數 = (P-1) / (T+2)^G

P = 每篇文章的基礎分數
T = 時間間距，單位為小時
G = 重力係數，文章分數下降的速度

```

# Install

run 
```
bundle install
```

# Database setup

run `db:seed` to generate default doorkeeper application

and run `rails console` to get application's uid and secret
```
app = Doorkeeper::Application.first
app.uid    # show below us CLIENT_ID
app.secret # show below us CLIENT_SECRET
```
# Data migration

this project also provide rake to fetch data from hacker-new

### extract and export

```
rails hacker_news:extract_and_export\[:start_id, :fetch_count, :file_name\]
```

- `start_id`: default is 1, the hacker-new item id
- `fetch_count`: default is 100, the fetch count of items
- `file_name`: default is `start_id-(start_id+fetch_count)`

this command will output the data to json file in `/data`

```
rails hacker_news:transform_and_load\[:file_name\]
```

- `file_name`: the file you want to load

this command will load the data to database

# Update CronJob

run
```
bundle exec whenever --update-crontab
```
to update the cronjob

# Test in Postman

[![Run in Postman](https://run.pstmn.io/button.svg)](https://app.getpostman.com/run-collection/5948636-eb68ad0b-9e6b-46ed-be61-02c66dc8712c?action=collection%2Ffork&collection-url=entityId%3D5948636-eb68ad0b-9e6b-46ed-be61-02c66dc8712c%26entityType%3Dcollection%26workspaceId%3D44cef014-6be8-430d-9df2-317bb776e061)

# DB schema

Yo can look db schema on [dbdigram](https://dbdiagram.io/d/649e159002bd1c4a5e471e98)
