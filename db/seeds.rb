# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 管理者ログイン用
Admin.create!(
  email: "admin@admin",
  password: "testtest"
)

# 基本的な投稿タグ
Tag.create!(
[
  { name: "サッカー" },
  { name: "野球" },
  { name: "バスケットボール" },
  { name: "バレーボール" },
  { name: "卓球" },
  { name: "バドミントン" },
  { name: "テニス" },
  { name: "ランニング" },
  { name: "その他" },
  { name: "初心者" },
  { name: "経験者" }
]
)
  
# テストデータ
users = User.create!(
[
  {email: 'test1@test.com',  name: '佐藤太郎',   password: 'password', telephone_number: '11111111111',prefecture: '北海道',   municipality: '札幌市',     display_name: 'Beck',           self_introduction: '宜しくお願いします', is_deleted: 'false', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user1.jpg"),  filename:"sample-user1.jpg")},
  {email: 'test2@test.com',  name: '藤本隆大',   password: 'password', telephone_number: '22222222222',prefecture: '埼玉県',   municipality: 'さいたま市', display_name: 'タビビト',       self_introduction: '宜しくお願いします', is_deleted: 'false', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user2.jpg"),  filename:"sample-user2.jpg")},
  {email: 'test3@test.com',  name: '小山内綾華', password: 'password', telephone_number: '33333333333',prefecture: '京都府',   municipality: '京都市',     display_name: 'Ann',            self_introduction: '宜しくお願いします', is_deleted: 'false', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user3.jpg"),  filename:"sample-user3.jpg")},
  {email: 'test4@test.com',  name: '岡部かおる', password: 'password', telephone_number: '44444444444',prefecture: '東京都',   municipality: '目黒区',     display_name: 'Jamie',          self_introduction: '宜しくお願いします', is_deleted: 'false', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user4.jpg"),  filename:"sample-user4.jpg")},
  {email: 'test5@test.com',  name: '前田修',     password: 'password', telephone_number: '55555555555',prefecture: '東京都',   municipality: '杉並区',     display_name: 'Hoodie',         self_introduction: '宜しくお願いします', is_deleted: 'false', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user5.jpg"),  filename:"sample-user5.jpg")},
  {email: 'test6@test.com',  name: '高木なほ',   password: 'password', telephone_number: '66666666666',prefecture: '鹿児島県', municipality: '鹿児島市',   display_name: 'ほなたか',       self_introduction: '宜しくお願いします', is_deleted: 'false', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user6.jpg"),  filename:"sample-user6.jpg")},
  {email: 'test7@test.com',  name: '五十嵐五郎', password: 'password', telephone_number: '77777777777',prefecture: '福岡県',   municipality: '北九州市',   display_name: '野鹿',           self_introduction: '宜しくお願いします', is_deleted: 'false', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user7.jpg"),  filename:"sample-user7.jpg")},
  {email: 'test8@test.com',  name: '小島千鶴',   password: 'password', telephone_number: '88888888888',prefecture: '北海道',   municipality: '札幌市',     display_name: '陽',             self_introduction: '宜しくお願いします', is_deleted: 'false', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user8.jpg"),  filename:"sample-user8.jpg")},
  {email: 'test9@test.com',  name: '吉田幸一',   password: 'password', telephone_number: '99999999999',prefecture: '東京都',   municipality: '品川区',     display_name: 'Basket Monster', self_introduction: '宜しくお願いします', is_deleted: 'false', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user9.jpg"),  filename:"sample-user9.jpg")},
  {email: 'test10@test.com', name: '大西雅人',   password: 'password', telephone_number: '1010101010', prefecture: '東京都',   municipality: '渋谷区',     display_name: '最強の子供',     self_introduction: '宜しくお願いします', is_deleted: 'false', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user10.jpg"), filename:"sample-user10.jpg")},
  {email: 'test11@test.com', name: '森島裕樹',   password: 'password', telephone_number: '1111111111', prefecture: '北海道',   municipality: '恵庭市',     display_name: 'マッスルパワー', self_introduction: '宜しくお願いします', is_deleted: 'false', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user11.jpg"), filename:"sample-user11.jpg")},
  {email: 'test12@test.com', name: '山本さやか', password: 'password', telephone_number: '1212121212', prefecture: '神奈川県', municipality: '横浜市',     display_name: 'Jessica',        self_introduction: '宜しくお願いします', is_deleted: 'false', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user12.jpg"), filename:"sample-user12.jpg")},
  {email: 'test13@test.com', name: '佐々木千秋', password: 'password', telephone_number: '1313131313', prefecture: '東京都',   municipality: '八王子市',   display_name: 'Chiaki',         self_introduction: '宜しくお願いします', is_deleted: 'false', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user13.jpg"), filename:"sample-user13.jpg")},
  {email: 'test14@test.com', name: '山本寛',     password: 'password', telephone_number: '1414141414', prefecture: '山梨県',   municipality: '都留市',     display_name: 'Paul',           self_introduction: '宜しくお願いします', is_deleted: 'false', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user14.jpg"), filename:"sample-user14.jpg")},
  {email: 'test15@test.com', name: '野口芳朗',   password: 'password', telephone_number: '1515151515', prefecture: '大阪府',   municipality: '吹田市',     display_name: 'ノグ',           self_introduction: '宜しくお願いします', is_deleted: 'false', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user15.jpg"), filename:"sample-user15.jpg")}
]
)

Post.create!(
[
  {title: 'バッティングセンター（初心者）',                       since_when: 'Fri, 10 Mar 2023 17:41:00.000000000 JST +09:00', at_where: '札幌市内のバッティングセンター', for_playing: 'なし',                       body: %Q{WBCの影響でバッティングセンターに行き始めました\n一緒に行ってくださる方がいれば嬉しいです！},                                                                    status: 0, image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post1.jpg"),  filename:"sample-post1.jpg"), user_id: users[0].id},
  {title: 'パス練習',                                             since_when: 'Fri, 10 Mar 2023 17:41:00.000000000 JST +09:00', at_where: 'さいたま市周辺',                 for_playing: '特に指定なし',               body: %Q{高校時代はサッカー部に入っていました。\n久しぶりにボールを蹴りたいので、付き合ってもらえる方を募集します。年代性別経験問いません。},                             status: 0, image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post2.jpg"),  filename:"sample-post2.jpg"), user_id: users[1].id},
  {title: '私をスキーに連れてって',                               since_when: 'Fri, 10 Mar 2023 17:41:00.000000000 JST +09:00', at_where: '北陸又は長野のスキー場',         for_playing: 'スキー道具一式、車',         body: 'スキーに行きたいのですが車がありません😢 どなたか車を出して頂けないでしょうか😿',                                                                                  status: 0, image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post3.jpg"),  filename:"sample-post3.jpg"), user_id: users[2].id},
  {title: '小学生の息子にサッカーを教えてくださる方を募集します', since_when: 'Fri, 10 Mar 2023 17:41:00.000000000 JST +09:00', at_where: '東京23区内',                     for_playing: '特になし',                   body: '先日小学生になった息子がサッカーを習い始めました。リフティングが苦手なようなので、経験者の方に教えて頂きつつ息子とサッカーで遊んで貰えないかと思い募集しました。', status: 0, image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post4.jpg"),  filename:"sample-post4.jpg"), user_id: users[3].id },
  {title: '対戦者求む',                                           since_when: 'Fri, 10 Mar 2023 17:41:00.000000000 JST +09:00', at_where: '杉並体育館',                     for_playing: 'バッシュ',                   body: 'バスケの1on1に絶対の自信あり。対戦者募集。',                                                                                                                       status: 0, image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post5.jpg"),  filename:"sample-post5.jpg"), user_id: users[4].id},
  {title: 'バスケ教えてください！',                               since_when: 'Fri, 10 Mar 2023 17:41:00.000000000 JST +09:00', at_where: '鹿児島市内',                     for_playing: 'バスケットボール、バッシュ', body: %Q{何となく募集してみました。未経験ですが、バスケは好きです。\nのびのび運動できたらと思います！},                                                                   status: 0, image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post6.jpg"),  filename:"sample-post6.jpg"), user_id: users[5].id},
  {title: '未経験者だが卓球したい！',                             since_when: 'Fri, 10 Mar 2023 17:41:00.000000000 JST +09:00', at_where: '福岡県内の体育館',               for_playing: 'ラケット',                   body: %Q{この間テレビで水谷選手を見て無性に卓球をやりたくなりました。\nラケットは体育館で借りられるとは思います。},                                                       status: 0, image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post7.jpg"),  filename:"sample-post7.jpg"), user_id: users[6].id},
  {title: '女子バレー練習（高校生）',                             since_when: 'Fri, 10 Mar 2023 17:41:00.000000000 JST +09:00', at_where: '札幌市東区体育館',               for_playing: 'シューズ',                   body: %Q{高校の女子バレー部に所属しています。\n部外で一緒に練習できる友人が欲しいと思い募集しました。},                                                                   status: 0, image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post8.jpg"),  filename:"sample-post8.jpg"), user_id: users[7].id },
  {title: 'Basket Monster is here',                               since_when: 'Fri, 10 Mar 2023 17:41:00.000000000 JST +09:00', at_where: 'Tokyo',                          for_playing: 'shoes, ball',                body: 'Nobody beats me. Just do it.',                                                                                                                                     status: 0, image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post9.jpg"),  filename:"sample-post9.jpg"), user_id: users[8].id },
  {title: '最強バドミントンプレイヤーを目指して',                 since_when: 'Fri, 10 Mar 2023 17:41:00.000000000 JST +09:00', at_where: '23区内の体育館',                 for_playing: 'ラケット、シャトル',         body: '最強のバドミントンプレイヤーを目指して日々練習しています。大人の方と対戦してみたいです。',                                                                         status: 0, image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post10.jpg"), filename:"sample-post10.jpg"), user_id: users[9].id },
  {title: '1on1',                                                 since_when: 'Fri, 10 Mar 2023 17:41:00.000000000 JST +09:00', at_where: '恵庭市総合体育館',               for_playing: 'シューズ',                   body: 'バスケやりましょう！どなたでも歓迎です！',                                                                                                                         status: 0, image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post11.jpg"), filename:"sample-post11.jpg"), user_id: users[10].id},
  {title: 'ランニングしませんか？',                               since_when: 'Fri, 10 Mar 2023 17:41:00.000000000 JST +09:00', at_where: '東京近郊',                       for_playing: 'なし',                       body: '健康のために毎日5km走っています。たまには他の方と走ってみたいと思い募集しました。',                                                                                status: 0, image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post12.jpg"), filename:"sample-post12.jpg"), user_id: users[11].id },
  {title: '人生初の皇居ラン',                                     since_when: 'Fri, 10 Mar 2023 17:41:00.000000000 JST +09:00', at_where: '皇居周辺',                       for_playing: '動きやすい服装',             body: '人生初の皇居ランに挑戦します。折角なので一緒に走ってくださる方を募集します。',                                                                                     status: 0, image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post13.jpg"), filename:"sample-post13.jpg"), user_id: users[12].id },
  {title: 'テニス練習',                                           since_when: 'Fri, 10 Mar 2023 17:41:00.000000000 JST +09:00', at_where: '都留テニスランド',               for_playing: 'ラケット',                   body: '日程の調整はききます、一緒にテニスしましょう！',                                                                                                                   status: 0, image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post14.jpg"), filename:"sample-post14.jpg"), user_id: users[13].id },
  {title: '大阪山登頂',                                           since_when: 'Fri, 10 Mar 2023 17:41:00.000000000 JST +09:00', at_where: '大阪山',                         for_playing: '登山道具一式',               body: '登りましょう。日帰り予定です。',                                                                                                                                   status: 0, image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post15.jpg"), filename:"sample-post15.jpg"), user_id: users[14].id }
]
)

PostTag.create!(
[
  {post_id: Post.find(1).id,  tag_id: Tag.find(2).id},
  {post_id: Post.find(1).id,  tag_id: Tag.find(10).id},
  {post_id: Post.find(2).id,  tag_id: Tag.find(1).id},
  {post_id: Post.find(2).id,  tag_id: Tag.find(10).id},
  {post_id: Post.find(2).id,  tag_id: Tag.find(11).id},
  {post_id: Post.find(3).id,  tag_id: Tag.find(9).id},
  {post_id: Post.find(4).id,  tag_id: Tag.find(1).id},
  {post_id: Post.find(4).id,  tag_id: Tag.find(11).id},
  {post_id: Post.find(5).id,  tag_id: Tag.find(3).id},
  {post_id: Post.find(5).id,  tag_id: Tag.find(11).id},
  {post_id: Post.find(6).id,  tag_id: Tag.find(1).id},
  {post_id: Post.find(6).id,  tag_id: Tag.find(10).id},
  {post_id: Post.find(6).id,  tag_id: Tag.find(11).id},
  {post_id: Post.find(7).id,  tag_id: Tag.find(5).id},
  {post_id: Post.find(8).id,  tag_id: Tag.find(4).id},
  {post_id: Post.find(9).id,  tag_id: Tag.find(3).id},
  {post_id: Post.find(10).id, tag_id: Tag.find(6).id},
  {post_id: Post.find(10).id, tag_id: Tag.find(11).id},
  {post_id: Post.find(11).id, tag_id: Tag.find(3).id},
  {post_id: Post.find(12).id, tag_id: Tag.find(8).id},
  {post_id: Post.find(13).id, tag_id: Tag.find(8).id},
  {post_id: Post.find(14).id, tag_id: Tag.find(7).id},
  {post_id: Post.find(14).id, tag_id: Tag.find(10).id},
  {post_id: Post.find(14).id, tag_id: Tag.find(11).id},
  {post_id: Post.find(15).id, tag_id: Tag.find(9).id}
]
)
