# -*- coding: utf-8 -*-
%w(time_slits events rooms event_rubyists event_rooms event_time_slits).each do |t|
  conn = ActiveRecord::Base.connection
  conn.execute("truncate #{t};")
  conn.execute("alter table #{t} auto_increment = 1;")
end

# time_slit
[Time.zone.parse('2010/8/27 9:30'), Time.zone.parse('2010/8/28 9:30'), Time.zone.parse('2010/8/29 9:30')].each do |start_time|
  t, end_time = start_time, 10.hours.since(start_time)
  while t < end_time
    TimeSlit.create :start_at => t, :end_at => 30.minutes.since(t)
    t += 30.minutes
  end
end

# room: name_en: string, name_ja: string, floor_en: string, floor_ja: string, sort_order: integer
big = Room.create :name_en => 'Main Convention Hall', :name_ja => '大ホール', :floor_en => '2nd floor', :floor_ja => '2階', :sort_order => 1
medium = Room.create :name_en => 'Convention Hall 200', :name_ja => '中ホール200', :floor_en => '2nd floor', :floor_ja => '2階', :sort_order => 2
b202 = Room.create :name_en => '202-B', :name_ja => '202-B', :floor_en => '2nd floor', :floor_ja => '2階', :sort_order => 3
a202 = Room.create :name_en => '202-A', :name_ja => '202-A', :floor_en => '2nd floor', :floor_ja => '2階', :sort_order => 4
b201 = Room.create :name_en => '201-B', :name_ja => '201-B', :floor_en => '2nd floor', :floor_ja => '2階', :sort_order => 5
a201 = Room.create :name_en => '201-A', :name_ja => '201-A', :floor_en => '2nd floor', :floor_ja => '2階', :sort_order => 6
foyer = Room.create :name_en => 'Foyer', :name_ja => 'ホワイエ', :floor_en => '2nd floor', :floor_ja => '2階', :sort_order => 7


# event
EventLoader.with_options(:day => 27) do |e27|
  e27.with_options(:room => big) do |e27_big|
    e27_big.create :title => 'Opening', :from => '12:30'
    e27_big.create :title => 'Conflicts and Resolutions in Ruby and Rails', :speaker => 'Akira Matsuda, Masayoshi Takahashi and others(TBA)', :from => '13:00', :to => '14:00', :profile => (<<PROFILE), :abstract => "To Be Announced (We're sorry, at Jeremy's request, his keynote has been cancelled)", :abstract_ja => "Jeremy Kemper氏の基調講演はご本人の都合により中止となりました。代替プログラムについては、追ってアナウンスいたします。悪しからずご了承ください", :lang => 'ja and/or en'
To Be Announced
PROFILE
    e27_big.create :title => 'jpmobile on Rails 3', :title_ja => 'jpmobile on Rails 3 の作り方', :speaker => 'Shin-ichiro OGAWA (Tokyu.rb / Nihon Ruby no Kai)', :from => '14:00', :abstract => (<<ABSTRACT), :abstract_ja => (<<ABSTRACT_JA), :lang => 'ja', :profile_ja => (<<PROFILE_JA), :profile => (<<PROFILE)
Jpmobile is a Rails plugin for Japanese mobile phones. This plugin features the ability to convert Japanese emoticons and Japanese kanji codes, and session management for mobile phones which can't handle HTTP cookies. In this talk, I will introduce how we rebuilt the jpmobile codebase to support Rack applications such as Rails 3 and Sinatra.
ABSTRACT
jpmobile を Rails 3 や Sinatra に対応させるまでの道のりを紹介。Rack化や絵文字やデコメへの対応などを、どのようにRailsをハックしたかとともに紹介します。
ABSTRACT_JA
小川 伸一郎 (Tokyu.rb)
株式会社イオレで「らくらく連絡網」という携帯向けメーリングリストサービスの開発に従事。RubyKaigi2009を機にjpmobileのコアコミッターに。京都生まれで大阪育ちの博士（理学）。
PROFILE_JA
Shin-ichiro OGAWA (Tokyu.rb)
Developer of Raku-Raku renraku-mou in eole. inc., which is mailing list service for Japanese mobile phone. Core commiter of jpmobile.
Born in Kyoto, grew up in Osaka. Ph.D in Physics, but It's no use for works.
PROFILE
    e27_big.create :title => 'Open social application development for cell-phones to begin in Ruby on Rails', :title_ja => 'Ruby on Railsではじめる携帯電話向けオープンソーシャルアプリケーション開発', :speaker => 'Masaki Yamada (Control plus Co. Ltd.)', :from => '14:30', :abstract => (<<ABSTRACT), :abstract_ja => (<<ABSTRACT_JA), :lang => 'ja', :profile => (<<PROFILE_JA)
In the world of the open social application development for cell-phones, PHP is a major language, but the development using Ruby on Rails is possible. I show the know-how which we got through development of our product \"Sweets Collection\" and introduce open social application development using Ruby on Rails.
ABSTRACT
携帯電話向けのオープンソーシャルアプリケーション開発の世界では、PHPがメジャーな言語ですが、Ruby on Railsを使った開発も可能です。私達が自社プロダクト「スイーツコレクション」の開発を通じて得たノウハウを公開するとともに、Ruby on Railsを使ったオープンソーシャルアプリケーション開発をご紹介します。
ABSTRACT_JA
山田将輝 (コントロールプラス株式会社)
ソーシャルゲーム作ってます
レッドブルを入力するとソースコードを出力します
社内唯一のemacs派
@masarakki
github.com/masarakki
PROFILE_JA
    e27_big.create_break :from => '15:00'
    e27_big.create :title => 'Building Real Time Web', :title_ja => 'リアルタイムウェブができるまで', :speaker => 'Makoto Inoue (New Bamboo (London, UK))', :from => '15:30', :abstract => (<<ABSTRACT), :abstract_ja => (<<ABSTRACT_JA), :profile => (<<PROFILE), :profile_ja => (<<PROFILE_JA)
The real time web is not about adding chat on your website. It's not really about having stock tickers. The most interesting aspect of the realtime web is to be found in augmenting the web that we already know. We can add realtime functionally to our applications as another layer of fidelity.
This is our story (New Bamboo, London, UK) of experimenting various real time web technologies and coming up with our own solutions (http://www.pusherapp.com). This is not about explaining how to use our solutions, but about sharing exciting opportunities and new technical challenges HTML5 WebSocket brings when you build real time web.
ABSTRACT
ここ最近のAjaxにかわるトレンドとしてリアルタイムウェブを利用した例が見かけられることが多いですが、その多くはチャットや株価更新などのサンプルの域をでないように見えます。弊社New Bamboo (London, UK)では、既存のリアルタイム技術をいろいろ研究した結果をPusher (http://www.pusherapp.com)というサービスとしてリリースしました。このトークでは、リリースにいたるまでの経緯をご紹介すると共に、HTML5 WebSocketを使うことによる新しい発見やチャレンジを皆様と共有していきたいと思います。
ABSTRACT_JA
Makoto Inoue (New Bamboo)
Rubyist living in London since 2004 (though did not know about Ruby when I was in Japan. Sorry..)
ex-DBA(Sybase). Co-organises London Javascript Meetup, London NoSQL Summer. Hosts Tokyo Cabinet Wiki. Currently toying around with Golang.
PROFILE
井上真(New Bamboo)
2004年からロンドンに在住中の逆輸入Rubyist（日本にいる時はRubyのこと知りませんでした。すみません）。元DBA(Sybase)。London Javascript Meetup, London NoSQL Summerの共同運営者、Tokyo Cabinet Wiki主催、 ３ヶ月ごとに興味の対象が変わるのが悩み。現在はGolangに浮気中。
PROFILE_JA
    e27_big.create :title => 'We can make the GC X times slower than the original', :title_ja => 'われわれは、GCをX倍遅くできる', :speaker => 'nari (Network Applied Communication Laboratory)', :from => '16:00', :to => '17:00', :abstract => (<<ABSTRACT), :abstract_ja => (<<ABSTRACT_JA), :lang => 'ja', :profile => (<<PROFILE), :profile_ja => (<<PROFILE_JA)
The presentation introduces the technique and a result about Lazy Sweep GC for CRuby GC. In addition, I introduce the prospects of the future GC improvement.
ABSTRACT
CRubyに対するLazySweepGCの実装方法と結果を紹介する。また、今後のGC改善の展望を述べる。
ABSTRACT_JA
nari (Network Applied Communication Laboratory Ltd.)
A Ruby commiter.
He is good at letting it collect garbages.
He have written a japanese book: "Garbage Collection - Algorithms and implementions"
PROFILE
nari（株式会社ネットワーク応用通信研究所）
Rubyコミッタ。ゴミを集めさせることが得意。
著書は『ガベージコレクションのアルゴリズムと実装』（共著）
PROFILE_JA
    e27_big.create_break :from => '17:00'
    e27_big.create :title => 'The basis of making DSL with Ruby', :title_ja => 'Rubyで作るDSLの基礎', :speaker => 'Yasuko Ohba (Everyleaf Corporation)', :from => '17:30',:abstract => (<<ABSTRACT), :abstract_ja => (<<ABSTRACT_JA), :lang => 'ja', :profile => (<<PROFILE), :profile_ja => (<<PROFILE_JA)
Ruby is well known as a language with which you can create your own DSL easily. Making DSL with Ruby is really easy, but there seem to be many developers who have not tried to make DSL with Ruby by design. In my opinion, there is no clear boundary between 'Useful APIs' and DSL. However, we can always judge whether a code is like DSL or not, that means, we can create DSL by design. In this talk, I'll start by looking into what DSL is and when to use it. After that I'll talk what concepts, habits and techniques you need to make your own DSL, showing typical examples from famous DSL codes like Rails, RSpec and so on.
ABSTRACT
RubyはDSLを作りやすい言語として知られています。実際に、DSLを作るのは簡単です。しかし、Rubyで意識的にDSLを作ったことのある人は意外に少ないのかもしれません。 Rubyで実現するDSLは、「使いやすいAPI」の一形態であり、ここから先がDSLだという明確な境界はありませんが、結果として出来上がったコードがDSL的かどうかは歴然と判断できます。つまり、コードをDSL的にするかどうかは開発者が意図的に選択していける事柄なのです。 本セッションでは、DSLとは何か、どんなときにDSLが有効かからはじめて、RubyでDSLを書く際に必要となる考え方、習慣、そしてテクニックを、 Rails や RSpec といった良く知られたコードを例にして話していきます。
ABSTRACT_JA
Yasuko Ohba (Everyleaf Corporation), nay3
A Rails application developer who loves programing.
President & CEO of Everyleaf Corporation.
One of her products is Kozuchi, a family bookkeeping web application.
Wrote the book “Ruby on Rails 逆引きクイックリファレンス” (with other authors, published by Mainichi Communications Inc.) and translated Ola Bini's "Practical JRuby on Rails Web 2.0 Projects" into Japanese (with other guys. The Japanese version, "JRuby on Rails 実践開発ガイド" was published by SHOEISHA).
PROFILE
大場寧子（株式会社万葉）, nay3
実装をこよなく愛するRailsエンジニア。株式会社万葉の代表取締役社長。
プロダクトにWeb家計簿「小槌」など。
著書「Ruby on Rails 逆引きクイックリファレンス」（共著、毎日コミュニケーションズ） 訳書「JRuby on Rails 実践開発ガイド」（Ola Bini 著、共訳、翔泳社）。
PROFILE_JA
    e27_big.create :title => 'Best Imitation of Your Class', :title_ja => '君のクラスの最高の偽物', :speaker => 'Shugo Maeda (Network Applied Communication Laboratory Ltd.)', :from => '18:00', :to => '19:00',:abstract => (<<ABSTRACT), :abstract_ja => (<<ABSTRACT_JA), :lang => 'ja', :profile => (<<PROFILE), :profile_ja => (<<PROFILE_JA)
Ruby's open classes contribute to extensibility of applications such as Ruby on Rails. However, they sometimes cause serious conflicts between class extensions. This talk illustrates problems of open classes, and propose a resolution by which classes can be refined locally.

  Keywords: selector namespace, classbox, context-oriented programming
ABSTRACT
Rubyのオープンクラスは、Ruby on Railsのようなアプリケーションの拡張性に 寄与している。しかし、オープンクラスはクラス拡張間の深刻な衝突を引き起こ すこともある。この発表では、オープンクラスの問題を説明し、クラスを局所的に 変更することができるような解決法を提案する。

  キーワード: selector namespace, classbox, context-oriented programming
ABSTRACT_JA
Shugo Maeda (Network Applied Communication Laboratory Ltd.)
He is a director of Network Applied Communication Laboratory Ltd., a co-chairperson of Ruby Association LLC, and a daimyo programmer.
PROFILE
前田 修吾（株式会社ネットワーク応用通信研究所）
株式会社ネットワーク応用通信研究所取締役。Rubyアソシエーション副理事長。大名プログラマ。
PROFILE_JA
  end

  e27.with_options(:room => medium) do |e27_medium|
    e27_medium.create :title => 'Feels Like Ruby', :speaker => 'Sarah Mei (Pivotal Labs)', :from => '14:00',:abstract => (<<ABSTRACT), :profile => (<<PROFILE)
For a Rubyist, writing Javascript is the worst part of working on a Ruby web application. Those clean, modern UIs are often made possible by incredibly complex Javascript. The helpers inevitably get in the way, and you end up writing most of it by hand.

It is painful.

But you can make writing Javascript code feel more like writing Ruby code. I will show techniques that go beyond \"unobtrusive\" and turn Javascript into a first-class citizen in your Ruby application. Make your Javascript more joyful!
ABSTRACT
Sarah Mei has spent most of the last dozen years writing code, and
most of the last four doing Ruby. She's a developer at Pivotal Labs,
and a pair programming fangirl. She spends a lot of her free time
showing people of all ages and backgrounds how awesome programming is
- especially, of course, with Ruby.
PROFILE
    e27_medium.create :title => 'User Experience for Library Designers', :speaker => 'geemus (Wesley Beary)(Engine Yard)', :from => '14:30',:abstract => (<<ABSTRACT), :profile => (<<PROFILE)
I've written \"a lot of code\":http://github.com/geemus, both hobby and work, over the last year, and looking back I can't help but think that writing code for yourself is easy; it's writing code for others can be tough. In this session, I'll share some examples of good and bad practices gathered in my years writing code and libraries, and discuss how to get past being too close to the problem. I'll talk specifically about growing your work into something anybody (and hopefully everybody) will use.
ABSTRACT
geemus (Wesley Beary) [github.com/geemus] is an avid Rubyist and Open Source enthusiast. When not spending his spare time working on enumerable overly ambitious open source projects he spends his days developing the Engine Yard Cloud [http://www.engineyard.com/products/cloud].
PROFILE
    e27_medium.create_break :from => '15:00'
    e27_medium.create :title => 'Rubygems, Bundler, and the future', :speaker => 'Carl Lerche (Engine Yard)', :from => '15:30',:abstract => (<<ABSTRACT), :profile => (<<PROFILE)
Rubygems has served the community well for many years. However, as applications become more and more complex, certain problems arise. Bundler was created to solve some of those problems and has been evolving rapidly based on community feedback. It's time to look at the current state of affairs and think about Rubygems 2.0. What parts of bundler could be moved upstream and what problems remain to be solved?
ABSTRACT
Until Carl Lerche discovered Ruby on Rails in 2005 he thought he would
never do web development again. It was Ruby that lured him back into
programming and open source development. Currently, he spends much of
his time at Engine Yard contributing to Rails, and in his free time,
to many side projects.
PROFILE
    e27_medium.create :title => 'Truth and Consequences: Handling Ruby 1.9 Encodings in Rails', :speaker => 'Yehuda Katz (Engine Yard)', :from => '16:30',:abstract => (<<ABSTRACT)
Ruby 1.9 adds support for many different encodings, making it possible to write Ruby web programs that can handle non-English characters well. However, these changes have had many consequences. At the beginning, the new encoding support has introduced much confusion in simple, English-only Rails applications and applications relying heavily on Unicode. Yehuda will explain the common problems caused by the changes, talk about what Rails has done to eliminate many of them, and what the Ruby community can do to make writing internationalized programs easier.
ABSTRACT
    e27_medium.create :title => 'A frog in a well does not know the great sea', :title_ja => '井の中の蛙、大海を知らず', :speaker => 'Sarah Allen (Mightyverse)', :from => '16:00',:abstract => (<<ABSTRACT), :abstract_ja => (<<ABSTRACT_JA), :profile => (<<PROFILE)
When building an application it is easy to forget that most applications today are available globally and used by people who speak many languages. You may create user interface in English or Japanese, but people may choose to type their data in their native language. Web browsers will allow people to enter text in almost any script, and if you are lucky it will \"just work\" ... but often it needs a little more attention. Sarah will share anecdotes from her adventures building Mightyverse, a multi-lingual database of native language video recordings. She will highlight details of how to get unicode text in and out of a database well as how to handle multibyte text in Ruby.
ABSTRACT
アプリケーションを構築する時、ほとんどのアプリケーションが今日グローバル的に使用されること、多国語を話す人々に使用されること忘れがちになってしまいます。あなたは、英語や日本語のユーザーインターフェイスを制作するかもしれません。でも、人々は母国語でデーターを記入することを選ぶかもしれません。ウェブブラウザは、ほぼすべてのスクリプトを記入することを可能にします。もし、あなたがラッキーなら、それはなんとか機能するかもしれません。しかし、しばしば、それはもう少し注意を必要とします。サラは、ネイティブスピーカーのビデオを使用した多国語データーベースのMightyverseを構築する経験からの逸話を共有するでしょう。　サラは、どのようにしてUnicodeテキストをデータベースに出し入れするのかの詳細に重点をおきます。また、Rubyでどのようにマルチバイトテキストを扱うかにも重点をおきます。
ABSTRACT_JA
Sarah leads a small consulting group, Blazing Cloud, and is working on a mobile-focused startup, Mightyverse. Sarah started in web development by creating Shockwave and Flash video, but has enjoyed the transition from native, proprietary code to dynamic languages and open source.  In addition to mobile and web development, she regularly teaches Ruby and Rails with a test-first approach. In her spare time, Sarah works to diversify the Ruby on Rails community with a focus on outreach to women through the RailsBridge Open Workshop project.  She blogs at ultrasaurus.com and tweets as @ultrasaurus.
PROFILE
    e27_medium.create_break :from => '17:00'
    e27_medium.create :title => 'My many failed products', :speaker => 'jugyo (Everyleaf Corporation)', :from => '17:30',:abstract => (<<ABSTRACT), :abstract_ja => (<<ABSTRACT_JA), :lang => 'ja', :profile_ja => (<<PROFILE_JA), :profile => (<<PROFILE)
I will talk about my many failed products, and a few of my successful ones. My products can be found here: http://github.com/jugyo
ABSTRACT
私のたくさんの失敗プロダクトと少しの成功プロダクトについて話します。 私のプロダクトはここ => http://github.com/jugyo/
ABSTRACT_JA
jugyo, 河野十行 (株式会社万葉)
Rails エンジニアであり Termtter と g の開発者。
github.com/jugyo
PROFILE_JA
jugyo, Kazuyuki Kohno (Everyleaf Corporation)
He is a Rails engineer, and author of Termtter and g.
github.com/jugyo
PROFILE
    e27_medium.create :title => 'Coding for fun, and having fun coding', :title_ja => 'みんなが楽しくプログラミング出来る魔法', :speaker => 'tenderlove (AT&T Interactive)', :from => '18:00', :to => '19:00', :abstract => (<<ABSTRACT), :profile => (<<PROFILE)
Programming for fun, or having fun programming. Ruby is the best language for both! Let's talk about programming after we've punched out from work, the programming we can do while drinking a beer, and the programming we can do to make our friends laugh. We'll take a look at projects built for fun, as well as projects built to have fun! We'll dissect them to figure out what makes them tick, then
extract techniques that we can use with our day to day tasks.
ABSTRACT
Aaron Patterson:

Mild mannered Rubyist by day, and culinary superhero by night. When
Aaron isn’t ruining people’s lives by writing software like phuby,
enterprise, and neversaydie, he can be found writing slightly more
useful software like nokogiri. To keep up his Gameboy Lifestyle, Aaron
spends his weekdays writing high quality software for ATTi. Be sure to
catch him on Karaoke night, where you can watch him sing his favorite
smooth rock hits of the 70’s and early 80’s.
PROFILE
  end
  e27.create :title => 'World Wide Ruby Conferences', :title_ja => '世界の Ruby Conference から', :speaker => 'Kuniaki IGARASHI (Everyleaf Corporation)', :room => b202, :from => '17:30', :to => '19:00',:abstract => (<<ABSTRACT), :abstract_ja => (<<ABSTRACT_JA), :lang => 'en, ja', :profile => (<<PROFILE), :profile_ja => (<<PROFILE_JA)
There are many Ruby/Rails conferences, \"RubyKaigi\"s and Ruby/Rails meetups throughout the world, but we can only participate in a few of these. I'd like to use the \"Lightening Talk\" style to introduce some of the people running these other meetups. You may learn about a new meetup to visit, or give you ideas for your own m0eetup.

Speakers

Pat Allan
Rails Camps
http://railscamps.com/

Chad Fowler
Rubyconf
http://rubyconf.org/

Jiang Wu
Rubyconf China
http://rubyconfchina.org/

Daniel Bovensiepen
EuRuKo
http://euruko2011.org/

Masayoshi Takahashi
RubyKaigi
http://rubykaigi.org/
ABSTRACT
世界中でたくさんのRuby会議、Ruby/Rails Conference、Ruby/Rails勉強会が行われています。私たちが参加できるのはそのうちのほんの一部です。この時間は世界中の勉強会を運営する方々にLT形式で紹介していただきます。次に行く勉強会を開拓したり、あなたが開催する勉強会の参考にするのはいかがでしょうか？

Speakers

Pat Allan
Rails Camps
http://railscamps.com/

Chad Fowler
Rubyconf
http://rubyconf.org/

Jiang Wu
Rubyconf China
http://rubyconfchina.org/

Daniel Bovensiepen
EuRuKo
http://euruko2011.org/

Masayoshi Takahashi
RubyKaigi
http://rubykaigi.org/
ABSTRACT_JA
Kuniaki IGARASHI , igaiga (@igaiga555) http://github.com/igaiga
Rails and iPhone app developer in Everyleaf Corporation.
Chief developer of the timer "TwYM" that is used in RubyKaigi2009
Lightning Talks.
Staff of Kosen Conference Committee, founder of coffee.rb.

Daniel Bovensiepen (@bovensiepen) http://www.bovensiepen.net
Projectmanager at Siemens AG.
Building High Frequency Radios for Mass Transit Projects.
Giving another talk at RubyWorld Conf 2010

Jiang Wu
Jiang Wu(呉江) is a Ruby developer in Shanghai, China. He has worked with Ruby for 3 years. In 2008, he open sourced a library of Chinese payment gateway, implemented in Active Merchant. From 2009, he is devoted to promote "off rails", such as Sinatra and Sequel, in China.

and Chad Fowler.
PROFILE
五十嵐邦明 (@igaiga555) http://github.com/igaiga
株式会社万葉 で Rails, iPhone アプリの開発に従事。
RubyKaigi2009 Lightning Talks で使われたタイマー "TwYM" のメイン開発者。
高専カンファレンス副代表、coffee.rb設立者。
PROFILE_JA
  e27.with_options(:room => a202) do |e27_a202|
    e27_a202.create :title => 'Ruby developer meeting at Tsukuba', :title_ja => 'Ruby開発会議つくば', :speaker => 'Ruby core team', :from => '10:00', :to => '12:30',:abstract => (<<ABSTRACT), :lang => 'ja'
We will hold a meeting about development of Ruby.
ABSTRACT
    e27_a202.create :title => "Monthly 'toRuby' workshop in Tsukuba", :title_ja => '出張版 toRuby勉強会', :speaker => 'Shouichi Nakauchi (toRuby)', :from => '14:00', :to => '16:00',:abstract => (<<ABSTRACT), :abstract_ja => (<<ABSTRACT_JA), :lang => 'ja'
Monthly 'toRuby' workshop that always holds in Nasu area comes to here Tsukuba and holds the same workshop as usual. Since we are going to prepare some subject maters, you will be able to enjoy programing Ruby. Please bring your PC for Ruby programing.

The Nasu area is located in an only 150km north direction from Tokyo. Nasu is Tochigi-ken Nasushiobara city formally. 'to' of toTuby is 'To' of Tochigi-ken. Now, we are having programming and a discussion using the book of Mr. Masatoshi Seki's dRuby. Please look at http://pub.cozmixng.org/~the-rwiki/rw-cgi.rb?cmd=view;name=toRuby for details. (This page is Japanese only.) Moreover, also about the contents of our event performed by RubyKaigi, we are going to notify in the above-mentioned website. Thank you.
ABSTRACT
いつも那須方面で開催しているtoRuby勉強会が、つくばに出張してきて、いつものような勉強会を開催します。Rubyを使ったお題を用意するので、参加者みなさんにPCを持参してもらい、手を動かしながらRubyを楽しむ会になります。

toRubyは東京のちょっとだけ北、150kmくらいにある栃木県、那須塩原市で月に一度、勉強会を開催しています。toRubyのtoはとちぎの'と'です。現在は咳さんのdRubyの本を使って、写経やディスカッションをしています。詳細は http://pub.cozmixng.org/~the-rwiki/rw-cgi.rb?cmd=view;name=toRuby をご覧ください。またRubyKaigiでの内容についても、上記Webにて告知していきます。
ABSTRACT_JA
    e27_a202.create :title => 'Head First "Ordinary" System Development', :title_ja => 'Head First ふつうのシステム開発', :speaker => 'Eiwa System Management, Inc.', :from => '16:00', :to => '18:00',:abstract => (<<ABSTRACT), :abstract_ja => (<<ABSTRACT_JA), :lang => 'ja'
We, Eiwa System Management, Inc. are one of the cutting-edge Ruby/Rails company in Japan. We're proud of presenting our way on building Rails application. @pragdave says "agility is part of the fabric of Rails." in his book Agile Web Development with Rails.
However, we need a little bit more tools to improve our Rails projects in the real world. In this sub event, we'll give you live-demo, some commentary on what agile software development is and discussion with audiences.

Keywords: Agile Software Devleopment, Test Driven Development, Scrum, Pivotal Tracker, Ruby on Rails, Bundler, RSpec, Steak, Git, Capistrano
ABSTRACT
『RailsによるアジャイルWebアプリケーション開発』にもあるように「アジリティ(アジャイルであること)は、Railsの骨組みの一部」です。
とはいうものの、実際にプロジェクトを進めるには、Rails以外にももう少し仕掛けが必要です。
この企画では、永和システムマネジメントが普段の受託開発プロジェクトでおこなっている、ふつうのシステム開発のすすめ方をライブ形式でお伝えします。
参加者の皆さまからの疑問・質問にお答えする時間も用意しております。
Railsの良さを活かしたプロジェクトの進め方に興味のある皆さまのご参加をお待ちしております。

キーワード: アジャイル開発、TDD、Scrum、Pivotal Tracker、Ruby on Rails、Bundler、RSpec、Steak、Git、Capistrano、など
ABSTRACT_JA
  end

  e27.with_options(:room => b201) do |e27_b201|
    e27_b201.create :title => 'rake:money', :title_ja => 'rake:money 拡大版～Rubyエンジニアと企業の幸せな関係～', :speaker => 'Ayumu Aizawa / Ouka Yuka (rake:money and RubyKaigi2010 Sponsors)', :from => '14:00', :to => '16:00',:abstract => (<<ABSTRACT), :abstract_ja => (<<ABSTRACT_JA), :lang => 'ja'
The meeting of the IT system engineer to think that I earn money seriously.

I raise awareness of the money, and it is a meeting of the people who want to become the engineer who can earn one's convincible income. I take up marketing and a business trend or a topic about the money that it is not readily possible for in a topic about economy in tax or assets use in the normal technology system study society how I cut one's skill efficiently in imitation Ta'izz.

In the Ruby meeting extension, I make it.
ABSTRACT
真剣にお金を稼ぐことを考えるIT系エンジニアの会。

お金に対する意識を高めて、自分の納得のいく収入を稼げるエンジニアになりたいと考える人たちの会合です。 自分のスキルをどうすれば効率よくマネタイズできるか、マーケティングやビジネストレンド、はたまた節税や資産運用についてなど、普通の技術系勉強会ではなかなか話題にできないお金に関する話題を取り上げます。

Ruby会議拡大版では、Ruby会議スポンサーの各社をパネラーに迎え、Rubyエンジニアに対するビジネスニーズや、企業の中のRubyist がどのようにビジネス価値を発揮していくかといったテーマについてパネルディスカッションを行います。
ABSTRACT_JA
    e27_b201.create :title => 'Ruby Business Owner Kaigi', :title_ja => 'Ruby親方会議', :speaker => 'Takeyuki FUJIOKA (xibbar)(Rabbix corporation / Nihon Ruby no kai)', :from => '16:00', :to => '18:00',:abstract => (<<ABSTRACT), :abstract_ja => (<<ABSTRACT_JA), :lang => 'ja'
Ruby's small business owner talk about own working and exchange experience each other.
ABSTRACT
Rubyを使ってスモールビジネスを展開しているビジネスオーナーの情報交換を行います。
ABSTRACT_JA
  end

  foyer_event = e27.create :title => "Let's create your own T-shirt designed by Ruby at RubyKaigi 2010!! / The Origami Ruby (paper craft) Generated by The Ruby", :title_ja => 'RubyKaigiで自分だけのrubyTシャツを作ろう！ / Ruby で作る Ruby の折り紙', :speaker => '(See Abstract)', :room => foyer, :from => '13:00', :to => '15:30',:abstract => (<<ABSTRACT), :abstract_ja => (<<ABSTRACT_JA), :lang => 'ja'
Events held during the session in the foyer.
ABSTRACT
会期中にホワイエにて行われているイベントです。
ABSTRACT_JA
  e27.create :title => "Let's create your own T-shirt designed by Ruby at RubyKaigi 2010!!", :title_ja => 'RubyKaigiで自分だけのrubyTシャツを作ろう！', :speaker => 'Yasuo Yoshikawa (tmix producer)', :room => foyer, :from => '13:00', :to => '15:30',:abstract => (<<ABSTRACT), :abstract_ja => (<<ABSTRACT_JA), :lang => 'ja', :parent_event => foyer_event, :profile_ja => (<<PROFILE_JA)
Let's create your own T-shirt designed by Ruby on tmix! tmix is the only on-demand retail platform for consumers.

If you can create T-shirt today, you can put on it tomorrow!

This event open until Aug 27th 15:00 pm . price 1,500en (front or back print only!) White or Black T ,size 160,S,M,L,XL Cash only.
ABSTRACT
tmixを使って、自分だけのRubyKaigi記念rubyTシャツを作ろう！

・Rubyのコードでデザイン、意外にカッコいいかも！？
・twitterのアカウントなど入れてもOK！
・ユニフォーム交換のように会場であった人と交換しても楽しい！

今日作って明日届く！みんなで着てワイワイ楽しも〜☆

！！注意！！白、黒メンズ定番Tシャツ（160〜XL）のみ。前側、もしくは背中側どちらかの面のみ。午後15時までに注文をお願いします。

1枚1,500円（現金のみ）

作り方（各自持参のPCにてお願いします。）
・http://tmix.jp/rubykaigi2010 にアクセス
・tmix会員登録、もしくはopenIDを使って各自でログイン
・サンプルデザインから、各自思い思いにデザイン
・デザインが終わったら、サイズを選択。名前、メアドを記入して購入ボタンで注文完了。その後tmix担当（吉川）にすぐに支払い、引換券をもらう。
※支払いを持って正式に注文を受付となります。

・翌日午後13時から17時のあいだに受け取る。

2010 年 8 月 27 日(金)のみ開催注文は28 日(土)13時から17時までに会場で受け取りできる人のみ。
ABSTRACT_JA
株式会社spice life代表取締役。
オリジナルTシャツデザインサイトtmix http://tmix.jp/ ,
ミニ名刺作成pocketer http://pocketer.jp/
を運営してます。
ちなみに、tmixはrailsで作ってます。

http://twitter.com/yoshikawayasuo
PROFILE_JA
  e27.create :title => "The Origami Ruby (paper craft) Generated by The Ruby", :title_ja => 'Ruby で作る Ruby の折り紙', :speaker => 'Hiroyuki Shimura (Nihon Ruby-no-kai (Japan Ruby Group))', :room => foyer, :from => '13:00', :to => '15:30',:abstract => (<<ABSTRACT), :abstract_ja => (<<ABSTRACT_JA), :lang => 'ja', :parent_event => foyer_event
  The Origami Ruby (paper craft) Generated by The Ruby: Let's fold origami \"Ruby\" like http://dl.dropbox.com/u/4921720/RubyFoldings/IMG_0362.A3_C35_Chu25.WebSmall.JPG  . In the first half, we will fold origami \"Ruby\" together with the origami paper that has crease fold lines. In the second half, we will fold something with foil paper and cellophane paper and read a Ruby script that generates paper with crease fold lines.
ABSTRACT
  Ruby の折り紙を折ります。http://dl.dropbox.com/u/4921720/RubyFoldings/IMG_0362.A3_C35_Chu25.WebSmall.JPG
  折り線をプリントした展開図を用意しますので、前半それを参考にみんなで折りましょう。後半は、ちょっと難しくなりますがホイル折紙や透明折紙(セロファン)で折ってみたり、或は展開図を作成する Rubyスクリプトを読みましょう。
ABSTRACT_JA
end

EventLoader.with_options(:day => 28) do |e28|
  e28.with_options(:room => big) do |e28_big|
     e28_big.create :title => 'Ruby 1.9.2 is released! / Ruby committers Q & A', :title_ja => 'Ruby 1.9.2 is released! / Rubyコミッタ Q & A', :speaker => 'Yugui, Shugo Maeda', :from => '9:30', :to => '11:00',:abstract => (<<ABSTRACT), :abstract_ja => (<<ABSTRACT_JA), :lang => 'ja'
Many committers will come to RubyKaigi, so it's a good chance to ask them. In this event Ruby committers will answer questions from audience (or other committers).
ABSTRACT
RubyKaigiにはたくさんのコミッタが来場するので、彼らに質問するよい機会です。このイベントでは、Rubyコミッタが聴衆(又は他のコミッタ) からの質問に回答します。
ABSTRACT_JA
    e28_big.create :title => 'Keynote', :title_ja => '基調講演', :speaker => 'Matz', :length => 1.hour, :lang => 'ja', :profile_ja => (<<PROFILE_JA)
いまや数えきれないほどのユーザーを持つ世界的プログラミング言語Rubyの創造者。っていうか、そういう立場に本人が一番困惑してるんですが。
PROFILE_JA
    e28_big.create_break :from => '12:00', :length => 90.minutes
    e28_big.create :title => 'Esoteric Obfuscated Ruby Programming', :title_ja => '超絶技巧 Ruby プログラミング', :speaker => 'Yusuke Endoh (independent)',:abstract => (<<ABSTRACT), :abstract_ja => (<<ABSTRACT_JA), :lang => 'ja', :profile => (<<PROFILE), :profile_ja => (<<PROFILE_JA)
Ruby allows us to write not only easy-to-read programs but also hard-to-read programs. In this presentation, we introduce our \"artistically\" hard-to-read programs written in Ruby. We also discuss its implementation techniques, if time permits.
ABSTRACT
Ruby は読みやすいプログラムを簡単に書ける言語だが、読みにくいプログラムも簡単に書ける。 本発表では、発表者による「芸術的に」読みにくい Ruby プログラムを紹介する。 時間があれば、その実装技法の解説を行う。
ABSTRACT_JA
A committer for Ruby and RubySpec.  1.9.2 assistant release manager.
A Ruby test maintainer.
His main interests are YARV, release engineering, tests, functional programming features and bignum.
He enjoys esoteric programming and Quine.
PROFILE
Ruby と RubySpec のコミッタ。1.9.2 リリースマネージャ補佐。Ruby テストメンテナ。
評価器 (YARV) 、リリースエンジニアリング、テスト、関数型プログラミング機能、Bignum など、Ruby の中でもどうでもいいところに興味を持つ。
Esoteric programming や Quine を好む。
PROFILE_JA
    e28_big.create :title => 'Daily Ruby', :title_ja => 'Rubyな日々', :speaker => 'Kazuhiro NISHIYAMA (Good-Day, Inc.)',:abstract => (<<ABSTRACT), :abstract_ja => (<<ABSTRACT_JA), :lang => 'ja'
I will talk about my daily life as a committer of Ruby and the Ruby Reference Manual Renewal Project.
ABSTRACT
Ruby や Ruby リファレンスマニュアル刷新計画のコミッターとしてどういうことをしているのかという話をする予定です。
ABSTRACT_JA
    e28_big.create :title => 'Ruby Reference Manual Renewal Project 2010 Summer', :title_ja => 'Ruby リファレンスマニュアル刷新計画 2010 夏', :speaker => 'okkez (Ruby Reference Manual Renewal Project)',:abstract => (<<ABSTRACT), :abstract_ja => (<<ABSTRACT_JA), :lang => 'ja'
In this talk, I will talk about Ruby Reference Manual Renewal Project and discuss the latest developments and future plans.
ABSTRACT
昨年の報告以降の動きをまとめて報告します。また、今後の予定や特に助けが必要な部分について説明します。
ABSTRACT_JA
    e28_big.create_break
    e28_big.create :title => 'Ruby API is Improved Unix API', :title_ja => 'Unix修正主義', :speaker => 'Tanaka Akira (National Institute of Advanced Industrial Science and Technology (AIST))', :length => 1.hour,:abstract => (<<ABSTRACT), :abstract_ja => (<<ABSTRACT_JA), :lang => 'ja', :profile => (<<PROFILE), :profile_ja => (<<PROFILE_JA)
Ruby's library API is like Unix's API, but improved. Ruby tries to fix some of the problems in Unix's API. For example, non-blocking IO in Unix is provided by setting a flag when opening a file, making it difficult to specify non-blocking behavior for individual operations. Ruby overcomes this problem by providing non-blocking methods such as #read_nonblock.

Another example is the fork() system call, which has problems in multi-threaded environments. Ruby provides the #spawn method as an alternative way to launch processes safely.

This presentation will discuss techniques for API problem discovery with more examples of Ruby's improvements over Unix's API and other problematic parts of Unix which Ruby may improve in the future.
ABSTRACT
Ruby のライブラリ API は Unix の影響を色濃く受けているが、 Unix の API をそのまま提供しているのではなく、 Unix の失敗を修正している部分がいくつかある。 たとえば、ノンブロッキング I/O は、オープンしたファイルに対するフラグで指示するため、 特定の操作だけをノンブロッキングにすることが難しい。 これに対し、Ruby ではフラグでなく read_nonblock メソッドなどを用いることにより、それが簡単になっている。 また、プロセスを起動する fork システムコールは近年のマルチスレッド環境では大きな問題がある。 これに対し、Ruby ではその問題がないプロセス起動方法として spawn メソッドを導入した。 本発表ではこのような修正例を述べ、また、まだ修正していない Unix の失敗とそれを Ruby で修正する可能性について述べる。 それにより、API の問題の発見と修正についての知見を示す。
ABSTRACT_JA
A Ruby committer.
Main interests are I/O, socket, process, time and other difficulties.
PROFILE
Ruby コミッタ。
主に I/O、ソケット、プロセス、時刻、その他の厄介事に興味を持つ。
PROFILE_JA
    e28_big.create_break
    lt_event = e28_big.create :title => 'Lightning Talks', :abstract => "Lightning Talks are 11 x 5minutes talk in a 60 minutes time slot", :abstract_ja => "1人持ち時間5分のライトニングトークです", :speaker => '(See Abstract)', :length => 1.hour, :lang => 'ja, en'
    e28_big.create :title => 'ARToolKit Ruby Binding', :abstract => '', :speaker => 'Urabe, Shyouhei (Network Applied Communication Lab.)', :lang => 'ja', :parent_event => lt_event, :from => '17:00', :to => '18:00', :profile => (<<PROFILE), :profile_ja => (<<PROFILE_JA)
Urabe Shyouhei (Network Applied Communication Laboratory)

is a software scientist, best known as a Ruby core developer who maintains
Ruby 1.8.7.  He is now mainly writing codes at NaCl.  His presentation is
based on what he wrote there.
PROFILE
Ruby 1.8.7のお守り係として知られるが本人はプログラマのつもりなので、たまには
作ったプログラムの紹介をしたい。仕事で作ったやつだけど。
PROFILE_JA
    e28_big.create :title => 'Toward creating a single stand-alone executable of Ruby', :title_ja => "Ruby/Tk-Kit から RubyKit へ : Ruby の単一ファイル実行環境の構築に向けて", :abstract => '', :speaker => 'Hidetoshi NAGAI (Kyushu Institute of Technology / Rubyist Kyushu)', :lang => 'ja', :parent_event => lt_event, :from => '17:00', :to => '18:00', :profile => (<<PROFILE), :profile_ja => (<<PROFILE_JA)
One of CRuby committers and a Ruby/Tk developer.
PROFILE
CRuby の commit 権所有者で，Ruby/Tk 開発者．
PROFILE_JA
    e28_big.create :title => 'What is few?', :abstract => '', :speaker => 'Shota Fukumori/@sora_h (few developers team)', :lang => 'ja', :parent_event => lt_event, :from => '17:00', :to => '18:00', :profile => (<<PROFILE), :profile_ja => (<<PROFILE_JA)
Shota Fukumori (sora_h) is a junior high school 2 grade *half-time(!)* student and a rubyist in Japan.
He commits to Termtter and some projects and his repository, and create web service by rails. Also he is usually talking at some communities. He has a online workshop which name is online.sg http://onlinesg.org/ .
PROFILE
Shota Fukumori (sora_h)は中2で半登校 (昼休み後早退). よくtermtterや自分のレポジトリにコミットしたり, Rails などでいろいろ作ってたり, よくいろんなコミュニティのチャットで喋っている. そしてOnline.sg と呼ばれるオンラインの勉強会を開催したりもしている.
PROFILE_JA
    e28_big.create :title => 'Toward Lightning RubyVM', :abstract => '', :speaker => 'Koichi Sasada (The University of Tokyo)', :lang => 'ja', :parent_event => lt_event, :from => '17:00', :to => '18:00'
    e28_big.create :title => 'MessagePack, a cross-language communication system', :title_ja => 'MessagePackで多言語間通信', :speaker => 'Sadayuki Furuhashi', :lang => 'ja', :parent_event => lt_event, :from => '17:00', :to => '18:00', :abstract => '', :abstract_ja => ''
    e28_big.create :title => 'Let\'s calculate easily civil days by using "Ruby"', :title_ja => 'Rubyで手軽に暦日を算出しよう！', :abstract => '',:abstract_ja => '' ,:speaker => 'Yoshihiko Hara, Japan OSS Promotion Forum Application Sub Committee Ruby Application Task Force, FUJITSU SOCIAL SCIENCE LABORATORY LIMITED', :lang => 'ja', :parent_event => lt_event, :from => '17:00', :to => '18:00'
    e28_big.create :title => 'Introducing the Lingo Project: A New Generationi Text Input System Leveraging Non-native English Writing', :abstract => '', :speaker => 'Kazki Matz (Lingo project)', :lang => 'ja', :parent_event => lt_event, :from => '17:00', :to => '18:00'
    e28_big.create :title => 'babushka―test-driven sysadmin for rubyists', :abstract => '', :speaker => 'Ben Hoskings (babushka)', :parent_event => lt_event, :from => '17:00', :to => '18:00'
    e28_big.create :title => 'parse.y Fam Tour', :title_ja => "parse.yの歩き方 -ワシのRubyは4式まであるぞ-", :abstract => '', :speaker => 'Ando Yasushi (Seesaa Inc.)', :lang => 'ja', :parent_event => lt_event, :from => '17:00', :to => '18:00', :profile => (<<PROFILE), :profile_ja => (<<PROFILE_JA)
The author of the first and last Google Wave book written in Japanese; the book released on August 19th.
PROFILE
たぶん史上最後のGoogle Wave本の著者。あとおっぱいとかカリスマとか
PROFILE_JA
    e28_big.create :title => 'The Timeless Way of E-Publishing with Ruby', :title_ja => "時を超えた電子出版の道の中をRubyと歩いていく", :abstract => '', :speaker => 'Masayoshi Takahashi (Tatsu-zine publishing, Nihon Ruby-no-Kai)', :lang => 'ja', :parent_event => lt_event, :from => '17:00', :to => '18:00'
    e28_big.create :title => "My Report of \"Ruby Summer of Code 2010\" - Road to be a stdlib -", :title_ja => "Ruby Summer of Code 2010のご報告 〜俺たちのDecimalはまだ始まったばかりだ〜", :abstract => '', :speaker => 'Tadashi Saito (University of Tsukuba)', :lang => 'ja', :parent_event => lt_event, :from => '17:00', :to => '18:00', :profile => (<<PROFILE)
Tadashi is in his nth year of University of Tsukuba where n is smaller than 0xDEAD. He is always interested in to make the world better a little, so he started Decimal project. It's the only one project which was accepted in Ruby Summer of Code 2010 from Japan, but Tadashi wants a cute girlfriend rather than a bounty. His weak subject is math.
PROFILE
  end

  e28.with_options(:room => medium) do |e28_medium|
    e28_medium.create :title => 'Rocking the enterprise with Ruby', :speaker => 'Munjal Budhabhatti And Sudhindra Rao (ThoughtWorks Inc)', :from => '9:30',:abstract => (<<ABSTRACT)
ThoughtWorks has been working on a long scale project at Rackspace building data center of the future using Ruby. This projects has evolved since its inception. And so has the architecture. Developing in ruby has assisted us in managing changes to the business rules at a rapid pace. We have been delivering successfully every two weeks for last three years. We would like to share our learnings from this effort.
ABSTRACT
    e28_medium.create :title => 'Rails to Sinatra: What is ready', :speaker => 'Jiang Wu (Tengu)',:abstract => (<<ABSTRACT), :lang => 'en', :profile => (<<PROFILE)
As Sinatra 1.0 came out, we have a good alternative to rails(before is merb). I will introduce efforts of people around Sinatra community to eliminate gap of moving from Rails to Sinatra including my works.
ABSTRACT
Jiang Wu(呉江) is a Ruby developer in Shanghai, China. He has worked with Ruby for 3 years. In 2008, he open sourced a library of Chinese payment gateway, implemented in Active Merchant. From 2009, he is devoted to promote "off rails", such as Sinatra and Sequel, in China.
PROFILE
    e28_medium.create :title => 'Mapping the world with DataMapper', :speaker => 'Ted Han (%w(Videojuicer DataMapper))',:abstract => (<<ABSTRACT)
Ubiquitous computing has opened the door to two new revolutions, data collection and data manipulation. Mobile phones, digital cameras, low cost electronics, and wireless internet access have made it possible to collect data any time, anywhere. But what are we doing with the data once it's collected? How do we navigate the oceans of data we generate daily? Where can we find a Rubyist's tools for data mining and manipulation? We'll discuss how to use DataMapper, a Ruby data access library, to make sense of data of all kinds.
ABSTRACT
    e28_medium.create_break :from => '12:00', :length => 90.minutes
    e28_medium.create :title => 'The Necessity and Implementation of Speedy Tests', :speaker => 'Jake Scruggs (Backstop Solutions)', :length => 1.hour,:abstract => (<<ABSTRACT), :profile => (<<PROFILE)
Your project's software practices are deteriorating every minute the developers wait for slow tests to finish. Once developers get fed up and stop running the tests, disregard for failing builds can't be far behind, and from there it's only a short leap to the albatross of a brittle/irrelevant test suite. Luckily this can all be avoided by adopting some time-saving testing standards and practices.
ABSTRACT
In 2004 Jake Scruggs was a high school physics teacher.  Jobs since then: apprentice at Object Mentor, consultant at ThoughtWorks, consultant at Obtiva, and developer at Backstop Solutions.

He also created and maintains the code metrics gem: metric_fu
http://jakescruggs.blogspot.com/
http://metric-fu.rubyforge.org/
http://twitter.com/jakescruggs
http://www.backstopsolutions.com/
PROFILE
    e28_medium.create :title => 'Seamless Integration Testing', :speaker => 'paulelliott (Hashrocket)', :abstract => (<<ABSTRACT), :profile => (<<PROFILE)
Do you have a solid, full coverage integration test suite? You should. It is the final automated point of assurance that what you are about to push to production is not going to blow something up and cost your or your client money. I show how to integration test a real Rails application, demonstrating best practices you can apply to any setup and the latest technologies for fully covering your app, including javascript!
ABSTRACT
Paul works for Hashrocket on projects for clients ranging from small start ups to large enterprises. In addition to his consulting work, he contributes regularly to open source projects and maintains some of his own, most notably Fabrication, an object generation framework for Ruby. He is passionate about outside-in testing, Ruby, jQuery, and motorcycles.
PROFILE
    e28_medium.create_break
    e28_medium.create :title => 'A Metaprogramming Spell Book', :speaker => 'Paolo "Nusco" Perrotta', :length => 1.hour, :abstract => (<<ABSTRACT)
When I started to learn Ruby, I was awed by the code of experienced rubyists. That code was full of amazing magic tricks that I could barely understand. People called those tricks \"metaprogramming\".

With time, I found that metaprogramming sits right at the core of Ruby. To think in Ruby, I had to understand all those scary tricks! Feeling like a sorcerer's apprentice, I set out to write a Spell Book of metaprogramming techniques. Once I'd finished the Spell Book, metaprogramming didn't seem like black magic anymore. Instead, it just felt like any other set of techniques.

In this talk, I'll show you the content of my Spell Book, so that you don't have to go through the trouble of writing one yourself.
ABSTRACT
    e28_medium.create_break
  end

  e28.create :title => 'JRubyKaigi 2010', :title_ja => 'JRuby会議 2010', :speaker => 'Koichiro Ohba / Akasaka.rb (JRuby.org and EngineYard)', :room => b202, :from => '12:00', :to => '18:00',:abstract => (<<ABSTRACT), :abstract_ja => (<<ABSTRACT_JA), :lang => 'ja, en'
It's JRubyKaigi for people who love JRuby, by JRuby core developers and Japanese JRuby developers. This kaigi will make both people who like JRuby already or not love JRuby much more. It will contain great sessions; the keynote session by Thomas E.Enebo(@tom_enebo) and Charles O.Nutter(@headus), the invited talks by Yoshiharu Hashimoto(@hasssie), Hiroshi Nakamura(@nahi), Takeru Sasaki(@urekat), Koichi Fujikawa(@fujibee), Yoko Harada(@yokolet). We also have 10 lightning talks. You can check out details of talks on JRubyKaigi 2010 web site.

  Site: http://j.rubykaigi.org/2010
ABSTRACT
JRuby コア開発者と日本のJRuby開発者によるJRubyが好きな人のためのJRubyKaigiを開催します。JRubyが好きな人はますます好きになり、そうでない人もJRubyが好きになる会議です。開催概要は次を予定しています。基調講演：Thomas E.Enebo(@tom_enebo) and Charles O.Nutter(@headus)、招致講演：Yoshiharu Hashimoto(@hasssie)、Hiroshi Nakamura(@nahi)、Takeru Sasaki(@urekat)、Koichi Fujikawa(@fujibee)、Yoko Harada(@yokolet)、他にライトニングトークスとして10枠を予定。詳しくはJRubyKaigi2010公式サイトを参照してください。。

  サイト: http://j.rubykaigi.org/2010
ABSTRACT_JA

  e28.with_options(:room => a202) do |e28_a202|
    e28_a202.create :title => 'tDiaryKaigi', :title_ja => 'tDiary会議', :speaker => 'SHIBATA Hiroshi (Eiwa System Management,Inc., asakusa.rb, tDiary.org)', :from => '9:30', :length => 90.minutes,:abstract => (<<ABSTRACT), :abstract_ja => (<<ABSTRACT_JA), :lang => 'ja', :profile => (<<PROFILE), :profile_ja => (<<PROFILE_JA)
In this session, tDiary users and developpers will discuss future and love for tDiary! we plan to hackathon, and if you have useful patches, please attend this session.
ABSTRACT
tDiary のユーザと開発者が集まって今後のロードマップや意見交換を中心にtDiary愛について語り合いたいと思います。 Hackathonも予定していますので、コミッタに取り込んでもらいたいパッチがある人はぜひお越し下さい。
ABSTRACT_JA
SHIBATA Hiroshi(hsbt) (Eiwa System Management,Inc./asakusa.rb)
He is a programmer in Eiwa System Management,Inc. member of  Japanese Society for Quality Control (JSQC). His lifework is to develop Rails application and tDiary, The tsukkomi oriented weblog.
PROFILE
柴田博志(hsbt) (永和システムマネジメント/asakusa.rb)
サービスプロバイディング事業部プログラマ、品質管理学会 正会員
Rails を使った業務システムや tDiary という Web 日記システムを作っています。
PROFILE_JA
    e28_a202.create :title => 'Asakusa.rb in Tsukuba', :title_ja => '浅草.rb in つくば', :speaker => 'Akira Matsuda (Asakusa.rb)', :from => '12:00', :length => 90.minutes,:abstract => (<<ABSTRACT), :abstract_ja => (<<ABSTRACT_JA)
During RubyKaigi, you'll find tons of foreign Ruby Stars and Book writers here in Tsukuba. Why don't we directly tell them our questions, requirements, and of course, our deep appreciation, since these days are only once a year and are a very special chance for us. OK, of course we're all willing to tell them, but we know it's very hard to do so. We can hardly distinguish who's who, maybe we lack the courage to talk to them, especially when there's a language barrier between us. So, Asakusa.rb are producing a special event which aims to help introduce everybody to one another and facilitate communicate. We're having live discussions with, for example,
    the creators of Rails 3, the author of \"The Passionate Programmer\", guys from the crazy \"Ruby Brigade\" Seattle.rb, and lot of other foreign super Ruby Stars who are sticking around here. C'mon everybody, let's get together and talk about \"your\" Ruby!
ABSTRACT
RubyKaigi の会場には、皆さんも日ごろお世話になっているはずのプロダクトや書籍の作者さんご本人がうじゃうじゃ来場しています。せっかくの年に一度のチャンスなので、是非この機会にいつも感じている疑問や要望、それから感謝の気持ちを思い切って直接作者さんに伝えちゃいましょう！とはいえ、誰が誰だかよくわからないし、いきなり面と向かっては話しかけづらいし、特に言語の壁があったりするとなかなか勇気が要りますよね？そこで、僕たち Asakusa.rbでは、Jeremy Kemper や Chad Fowler をはじめ、当日会場に居る豪華外タレさんたちをゲストにお迎えして、彼ら自身の 'あの'プロダクトについて、ご本人と Asakusa.rb のメンバーたちと、それからもちろん会場の皆様も巻き込んで、生のアツいディスカッションを行います。
ABSTRACT_JA
    e28_a202.create :title => 'Pair Programming Cultural Exchange', :title_ja => 'ペアプログラミング文化交流会', :speaker => 'Sarah Mei (Pivotal Labs)', :to => '18:00', :abstract => (<<ABSTRACT), :abstract_ja => (<<ABSTRACT_JA), :lang => 'en, ja'
We may not speak the same language, but we do have one language in common. So, we can code together!

Armed with a list of pair programming phrases in English and Japanese, let's work together on a project in Ruby. Coding together can help us bridge the artificial boundaries created by language, culture, and distance, and can create friendships that last beyond the conference.

Unicorns and ponies for everyone!
ABSTRACT
私たちが話す言葉は同じじゃないかもしれない。でも、私たちには一つの共通語がある。そう、だから私たちはいっしょにコードを書けるんだ！

この企画では、英語と日本語のペアプログラミング語録をひもときながら、あるRubyプロジェクトをいっしょにやってみましょう。いっしょにコードを書くことで、私たちの間の言語、文化、距離の壁を乗り越えて、Kaigiを越えた友情が生まれることでしょう。

ユニコーンとポニーをみんなに！
ABSTRACT_JA
  end

  e28.with_options(:room => b201) do |e28_b201|
    e28_b201.create :title => 'jpmobile Kaigi 2010', :speaker => 'Shin-ichiro OGAWA (Tokyu.rb)', :from => '9:30', :length => 90.minutes,:abstract => (<<ABSTRACT), :abstract_ja => (<<ABSTRACT_JA), :lang => 'ja', :profile => (<<PROFILE), :profile_ja => (<<PROFILE_JA)
A Kaigi for \"jpmobile\" developers. Jpmobile is the de facto standard Rails plugin for Japanese mobile phones. Almost all of \"jpmobile\" developers will come to this session and discuss the future of jpmobile, then
start to struggle to make it real, that means, write codes. The main topics will be supporting Rails 3.0+ and Ruby 1.9, building Rack middleware.

Anyone who wants to contribute to jpmobile should attend this Kaigi.
ABSTRACT
日本全国から jpmobile 開発者・利用者が一堂に会して、jpmobile の今後について議論や開発を行う企画です。えにしテックの設楽さんを中心に、Rails 3.0 以降や Rack について、その場で議論して開発に入るハッカソンスタイルを取る予定です。
ABSTRACT_JA
Shin-ichiro OGAWA (Tokyu.rb)
Developer of Raku-Raku renraku-mou in eole. inc., which is mailing list service for Japanese mobile phone. Core commiter of jpmobile.
Born in Kyoto, grew up in Osaka. Ph.D in Physics, but It's no use for works.
PROFILE
小川 伸一郎 (Tokyu.rb)
株式会社イオレで「らくらく連絡網」という携帯向けメーリングリストサービスの開発に従事。RubyKaigi2009を機にjpmobileのコアコミッターに。京都生まれで大阪育ちの博士（理学）。
PROFILE_JA
    e28_b201.create :title => 'PGP Key Signing Party', :title_ja => "キーサインパーティー 2010", :speaker => 'Shyouhei Urabe w/ Yugui (Ruby Core Team)', :from => '12:00', :length => 90.minutes, :abstract => (<<ABSTRACT), :abstract_ja => (<<ABSTRACT_JA), :lang => 'ja'
Let's trade pubkeys! A key signing party is a get-together of people who use the PGP encryption system with the purpose of allowing those people to sign each others keys. Key signing parties serve to extend the web of trust to a great degree.

If you get interested you need some preparation. Take a look at
http://qwik.atdot.net/rubykaigi2010keysignparty/FrontPageJa.html
ABSTRACT
公開会議を交換しましょう。キーサインパーティーは PGP 暗号化方式を利用する人たちが相互に公開鍵を署名しあう集まりです。キーサインパーティーに参加することで信頼の輪を広げることができます。

参加には若干の準備が必要ですので、ご興味のある方は以下のURLを御覧下さい。
http://qwik.atdot.net/rubykaigi2010keysignparty/FrontPageJa.html
ABSTRACT_JA
    e28_b201.create :title => 'M-x ruby-and-emacs-workshop', :speaker => 'Zev Blut', :length => 90.minutes, :abstract => (<<ABSTRACT), :abstract_ja => (<<ABSTRACT_JA), :profile => (<<PROFILE)
Stretch your fingers and warm up your control and meta keys. Bring your laptop and .emacs file. Let's show each other our techniques for writing Ruby code using Emacs.

This is a workshop for both beginners and advanced users to share tips and tricks for developing Ruby code with Emacs.
ABSTRACT
指のストレッチ！CtrlキーとMetaキーのウォーミングアップ！
みんなで自分のラップトップと.emacsファイルを持ち込んで、見せ合いっこしながらEmacsでRubyプログラミングをする技をシェアしましょう。

この企画は、初心者から達人まで、みんなでEmacsでのRubyプログラミングの技をシェアするワークショップです。
ABSTRACT_JA
Zev is a software developer for Cerego Japan who helps with the
web operations and development of the smart.fm website.  He knows
enough Japanese to enjoy natto but not chicken sashimi.
PROFILE
    e28_b201.create :title => 'Cucumber hands-on', :title_ja => 'Cucumber ハンズオン', :speaker => 'MOROHASHI Kyosuke (EIWA System Management, Inc.)', :length => 90.minutes,:abstract => (<<ABSTRACT), :abstract_ja => (<<ABSTRACT_JA), :lang => 'ja', :profile_ja => (<<PROFILE_JA)
Cucumber is a very nice testing framework. But the major feature, execute natural language text as tests, varies from familiar \"Ruby syntax\". Therefore, you may feel inhibited to take the first step (so I was.). In this sub-event, we try Cucumber to build a simple Rails application. It will tell you that cucumber is not so difficult to start and has great power to describe software test.
ABSTRACT
Cucumberはとてもよくできたテスティングツールです。しかし、その大きな特長である、自然言語を使ったテスト定義は、慣れ親しんでいる「Ruby の文法」とは見た目が大きくことなります。そのため、はじめの一歩を踏み出すに心理的な抵抗を感じることもあるでしょう(私もそうでした)。この企画では、Cucumberを使いながら簡単なRailsアプリケーションを作っていくことで、始めるのは難しくないことと、そしてCucumber のパワーを実感してもらうことを目的としています。
ABSTRACT_JA
諸橋恭介(moro) (永和システムマネジメント/Rails勉強会@東京/asakusa.rb)
サービスプロバイディング事業部プログラマ

RSpecやCucumberが好きです。RubyやRailsで受託開発をしています。
主に、サービス系のWebアプリケーションを作っています。
著書「Railsレシピブック(2008年、共著)」があります。
PROFILE_JA
  end

  e28.with_options(:room => a201) do |e28_a201|
    e28_a201.create :title => 'Nihon Ruby-no-Kai meeting', :title_ja => '日本Rubyの会の会', :speaker => 'Koji Shimada (Nihon Ruby-no-Kai)', :from => '12:00', :length => 90.minutes,:abstract => (<<ABSTRACT), :abstract_ja => (<<ABSTRACT_JA), :lang => 'ja'
An open meeting where Rubyists discuss what we can do for Ruby.
ABSTRACT
RubyのためにRubyistができることについて話し合うイベント。 RubyKaigi2010の時期には実は第6期が終わっているので、第6期の活動のふりかえりと、第7期の活動のアイデア出しをやりましょう!
ABSTRACT_JA
    e28_a201.create :title => 'Vim', :speaker => 'Kana', :to => '17:00', :abstract => (<<ABSTRACT), :abstract_ja => (<<ABSTRACT_JA), :lang => 'ja'
About half of Rubyists are using Vim to code Ruby. Vim is one of the ultimate tools for software developments, which vary among programmers. Why don't you exchange the ways you use Vim?

For example, I am using some Vim plugins such as quickrun.vim, neocomplcache, and smartchr.vim to code Ruby efficiently. Although my ~/.vimrc is less than just 3000 lines, there are plenty of good tricks worth telling to you. I'd like to tell you about my Vim knowledge, and learn how you yourself are optimizing Vim.

I'd like to make the event in English, because most Japanese have already been learning English for a while. Of course, attendees are supposed to be familiar with Ruby and Vim, because they are the lingua franca of this event. I can help translating Japanese to English or English to Japanese. Even if you don't have a lot of confidence with other languages, you can still attend this event.

Other editor users such as Emacs users also can attend this event. In general, tech religious wars are fun.
ABSTRACT
Rubyistの約半数が使用していると噂の統合開発環境Vimについて、使いこなすためのノウハウや快適にRubyコードを書くためのテクニックを交換しあう勉強会です。

当日は有志によるライトニングトーク、Q&A、および会場内で得た知識を実践するためのfree hack時間を設け、参加者のVim戦闘力を向上させる予定です。
ABSTRACT_JA
  end

  e28.create :title => "The Origami Ruby (paper craft) Generated by The Ruby", :title_ja => 'Ruby で作る Ruby の折り紙', :speaker => 'Hiroyuki Shimura (Nihon Ruby-no-kai (Japan Ruby Group))', :room => foyer, :from => '12:00', :to => '17:00',:abstract => (<<ABSTRACT), :abstract_ja => (<<ABSTRACT_JA), :lang => 'ja'
  The Origami Ruby (paper craft) Generated by The Ruby: Let's fold origami \"Ruby\" like http://dl.dropbox.com/u/4921720/RubyFoldings/IMG_0362.A3_C35_Chu25.WebSmall.JPG  . In the first half, we will fold origami \"Ruby\" together with the origami paper that has crease fold lines. In the second half, we will fold something with foil paper and cellophane paper and read a Ruby script that generates paper with crease fold lines.
ABSTRACT
  Ruby の折り紙を折ります。http://dl.dropbox.com/u/4921720/RubyFoldings/IMG_0362.A3_C35_Chu25.WebSmall.JPG
  折り線をプリントした展開図を用意しますので、前半それを参考にみんなで折りましょう。後半は、ちょっと難しくなりますがホイル折紙や透明折紙(セロファン)で折ってみたり、或は展開図を作成する Rubyスクリプトを読みましょう。
ABSTRACT_JA
end

EventLoader.with_options(:day => 29) do |e29|
  e29.with_options(:room => big) do |e29_big|
    e29_big.create :title => 'Cloud management with Ruby', :title_ja => 'Rubyでクラウドを便利にする方法〜ニフティクラウドの事例〜', :speaker => 'Kei Hamanaka, Yuichi Saotome (NIFTY Corporation)', :from => '9:30',:abstract => (<<ABSTRACT), :lang => 'ja'
We show the construction/operation methods for Cloud with Ruby. (ex. NIFTY Cloud)
ABSTRACT
    e29_big.create :title => 'Distributed storage system with ruby', :title_ja => 'Rubyによる分散ストレージシステムの実装', :speaker => 'Toshiyuki Terashita (RICOH IT SOLUTIONS Co.,Ltd.)', :abstract => (<<ABSTRACT), :abstract_ja => (<<ABSTRACT_JA), :lang => 'ja', :profile_ja => (<<PROFILE_JA)
Castoro is a new scalable storage system implemented in Ruby. In this session, we talk about why we decided to develop a new storage system, Castoro. We will also compare Castoro against other distributed storage systems, such as MogileFS and kumoFS.
ABSTRACT
Castoroは、Rubyで実装されたスケーラブルなストレージシステムです。本発表では、開発に至った経緯と、MogileFSやkumoFS等、他の分散ストレージシステムとの違いについて紹介します。
ABSTRACT_JA
寺下 敏之（てらした としゆき） リコーITソリューションズ株式会社

OSなし組み込みファームウエアからデータセンター内ソフトウエアまで手がけてき
ました。
自宅で書いたものをgithubへ置いてOSSと称して業務に持ち込む、自作自演プログラ
マです。
Railsアプリコードを書いたら負けかなと思っているRuby使いで、鳥取Ruby会
「tottoruby」主催・開催しています。
ストレージサービス「quanp」ではミドルウエアからOS寄りのコンポーネントを作っ
ています。
PROFILE_JA
    e29_big.create :title => 'The last decade of RWiki and lazy me', :title_ja => 'RWikiと怠惰な私の10年間', :speaker => 'Masatoshi SEKI (druby.org)',:abstract => (<<ABSTRACT), :abstract_ja => (<<ABSTRACT_JA), :lang => 'ja', :profile_ja => (<<PROFILE_JA)
On August 31st, 2000, A slightly unusual Wiki was introduced on ruby-list. It was [ruby-list:24661] The first practical dRuby application, RWiki.

RWiki is strongly opinionated software. RWiki was introduced as an demonstration of the usage of various Ruby libraries, but its unique implementation also reflects the author's opinion. The most significant feature of RWiki is that it is an in-memory application that contains both the database and objects all in a single process. Which is rather reminiscent of some recent buzzwords: NoSQL and In-Memory.

A couple days after this presentation, RWiki will celebrate its tenth year anniversary. I am currently running several active RWiki sites. These sites have over 30 thousand pages with a process size exceeding 1Gb. In this presentation, I will tell a little story of how these RWiki sites achieved scale and volume.
ABSTRACT
2000-8-31、ruby-listにすこし変わったWikiが紹介されました。[ruby-list:24661] dRubyの最初の実用的なアプリケーション、RWikiです。

RWikiはメッセージ色の濃いソフトウェアです。RWikiはRuby周辺のさまざまなライブラリのサンプルとして紹介されましたが、特異な実装も作者のメッセージです。RWikiのもっとも大きな特徴はデータベース、オブジェクトを全て一つのプロセスの中に配置する、In-Memory のアプリケーションであることです。そういえば、NoSQL、In-Memoryは最近のバズワードでもありますね。

この発表の数日後、RWikiはちょうど10年を迎えます。 私はアクティブなRWikiサイトを複数運営していて、現在では3万ページ、プロセスサイズは1GBを超えています。本発表では、このサイトが「大きさ・量」を獲得していく過程で展開された、ちょっとした物語を報告します。
ABSTRACT_JA
関将俊（druby.org）
プログラマ。dRuby、ERBの作者。代表作はhメソッド、著書『dRubyによる分散・Webプログラミング』。ポケモンWCS2010栃木県代表(カード部門)。
PROFILE_JA
    e29_big.create :title => 'Practical Ruby Projects with MongoDB', :speaker => 'Alex Sharp (Lead Developer, OptimisDev)', :length => 1.hour,:abstract => (<<ABSTRACT), :profile => (<<PROFILE)
While there is a lot of excitement surrounding MongoDB and the NoSQL movement, MongoDB is all about practicality, pragmatism and performance. MongoDB boasts a robust feature set that provides a pragmatic blend of rich functionality, performance and scalability that today's software developers need, and all at a relatively low barrier to entry.
ABSTRACT
Alex has been Lead Developer for OptimisDev since October 2009. Prior to joining OptimisDev, he co-founded Second Street Creative in 2006, a boutique web application development and design consultancy specializing in creative brand development and agile ruby application development. He is particularly interested in the NoSQL movement and mastering the art of refactoring.

Among other open source contributions, Alex is the author of Bunyan and Papermill, two libraries for working with MongoDB.

In addition to hacking, Alex enjoys shredding fresh powder, gourmet coffee and being an amateur foodie. He does not enjoy referring to himself in third person, because it sounds weird. He currently lives in sunny Los Angeles, CA, blogs at alexjsharp.com and tweets as @ajsharp.
PROFILE
    e29_big.create_break :length => 90.minutes
    e29_big.create :title => "IronRuby - What's in it for Rubyists?", :speaker => 'Shay Friedman (Sela Group)', :length => 1.hour, :abstract => (<<ABSTRACT), :profile => (<<PROFILE)
IronRuby is the new implementation of the Ruby language from Microsoft which opens the .NET world to Rubyists. This brings a whole set of new opportunities to Rubyists like using Ruby to write RIA applications, providing enhanced user interface to Ruby applications and more. Come and see the new possibilities that IronRuby brings to the Ruby world!
ABSTRACT
Shay Friedman is the author of IronRuby Unleashed and a Microsoft IronRuby MVP. With more than 10 years of experience, Friedman now works as a consultant and instructor of dynamic languages and .NET related subjects in CodeValue, a company he has recently co-founded. You can read his blog at http://IronShay.com and contact him via his twitter account - @ironshay.
PROFILE
    e29_big.create_break
    e29_big.create :title => 'The spread of enterprise Ruby at hot spot SHIMANE', :title_ja => 'Ruby業務システムの広がりとホットスポット島根', :speaker => 'Hiroshi Yoshioka (TechnoProject Ltd.)',:abstract => (<<ABSTRACT), :abstract_ja => (<<ABSTRACT_JA), :lang => 'ja', :profile => (<<PROFILE), :profile_ja => (<<PROFILE_JA)
In Matsue City and SHIMANE prefecture of local government, many common business systems began to remake by Ruby/Rails since 2007. Now, the wave of Ruby/Rails spreads to enterprise system fields and prepheral regions. Based many experience and results, how to built up the enterprise systems by Ruby/Rails, how to built up the long term maintenance systems, challenging to high productivty and another Agile development.
ABSTRACT
地方自治体である松江市や島根県では、2007年から一般的な行政システムをRuby/Railsで再構築を行っている。今、Ruby/Railsの波が企業システムの分野や周辺の地域に広がり始めた。 多くの経験と実績に基づいて、Ruby/Railsの基幹業務システムの構築方法、長期間メンテナンスするシステムの構築方法、高生産性や別なアジャイル開発への挑戦について説明する。
ABSTRACT_JA
Hiroshi Yoshioka (TechnoProject LTD. & Matsukei LTD. Both CEO)
I am born in 1953.It started from the development of the middleware, and SI and a lot of package developments and application such as finance and public in the field were commanded in the first line.
A lot of environments have been experienced from the mainframe to the CSS・Web application program.
PROFILE
吉岡 宏（ヨシオカ ヒロシ）
(株)テクノプロジェクト：代表取締役社長兼(株)マツケイ：代表取締役社長
1953年生まれ。1976年からソフトウエア業界に身を置く。その間、ミドルウエアの開発から始まり、フィールドでの金融・公共など多くのＳＩやパッケージ開発・適用を第一線で指揮して来た。メインフレームからＣＳＳ・Webアプリまで、多くの環境を経験してきた。
PROFILE_JA
    e29_big.create :title => 'There Is No Spoon -- Think Global, Act Regional', :speaker => 'Shintaro Kakutani (rubykaigi.org, Nihon Ruby-no-kai)', :abstract => (<<ABSTRACT), :abstract_ja => (<<ABSTRACT_JA), :lang => 'ja', :profile => (<<PROFILE), :profile_ja => (<<PROFILE_JA)
I have been a member of RubyKaigi organizer since 2006 and also am the founder of Regional RubyKaigi started in 2008. \"Kaigis\" have changed the landscape of the Ruby community in Japan. These 2 years mean a lot to me. I'd love to show you what happened is and tell you what I believe is going to happen in the Ruby community in Japan.
ABSTRACT
2008年につくばで(!)開催されたRejectKaigiで提案した地域Ruby会議プロジェクトは2周年を迎えます。この2年間に9都市で17の地域Ruby会議が実施され、私はその全てに参加しました。本セッションでは、過去2年間の地域Ruby会議をふりかえり、今後の地域Ruby会議のありかたについて私見を述べます。東京と東京以外の違いと地域のRubyユーザグループの重要性や地域Ruby会議とRubyKaigiの関係など、「RubyKaigi以後」のRuby コミュニティのあり方を考える材料を提供します。
ABSTRACT_JA
Kakutani Shintaro is a just another strong Ruby proponent, chief programmer in Eiwa System Management, Inc and board member of Nihon Ruby-no-kai(Japan Ruby Group). He is one of the organizers of RubyKaigi since 2006. He have translated some english technical book into japanese: "Agile Estimating and Planning"(co-translator), "Interface Oriented Design"(supervisor), "Practices of an Agile Developer"(co-supervisor) and "From Java to Ruby"(translator).
PROFILE
ただのRuby厨。(株)永和システムマネジメントサービスプロバイディング事業部チーフプログラマ。日本Rubyの会理事。RubyKaigiの運営を2006年からやってます。著書は『アジャイルな見積りと計画づくり』(共同翻訳)、『インターフェイス指向設計』(監訳)、『アジャイルプラクティス』(共同監訳)、『JavaからRubyへ』(翻訳)。
PROFILE_JA
    e29_big.create_break
    e29_big.create :title => 'Keynote', :title_ja => '基調講演', :speaker => 'Chad Fowler', :length => 1.hour
    e29_big.create :title => 'Closing'
  end

  e29.with_options(:room => medium) do |e29_medium|
    e29_medium.create :title => 'The future of the bigdecimal library and the number system of Ruby', :title_ja => "bigdecimal ライブラリと Ruby の数値系の未来", :speaker => 'Kenta Murata (GeneticLab Co., Ltd. && Ruby Sapporo)',:abstract => (<<ABSTRACT), :abstract_ja => (<<ABSTRACT_JA), :from => '9:30', :lang => 'ja', :profile => (<<PROFILE), :profile_ja => (<<PROFILE_JA)
I taked over the maintainer of the bigdecimal standard library in the beginning of this year. Today, the bigdecimal library has some problems in its behaviors, such as interacting convention with any other number classes. In this presentation, I will demonstrate these problematic behaviors and express their appropriate characteristics in the next version of Ruby. Additionally, I will discuss the number system which the future version of Ruby, that is 2.0, should have.
ABSTRACT
私は今年の初めに bigdecimal 標準ライブラリのメンテナに採用されました。現在 bigdecimal ライブラリは、他の数値クラスとの相互作用規則など、その振る舞いについて幾つかの問題を抱えています。私はこのプレゼンテーションで、このような問題ある振る舞いを実演で示し、これらに対して Ruby の次のバージョンで実現されるべき適切な性質を説明します。加えて、私は Ruby の未来のバージョン（すなわち 2.0）が持っているべき数値系について議論します。
ABSTRACT_JA
mrkn, Kenta Murata (Genetic Lab Co., Ltd.)
Kenta is a Ruby committer, who manages the bigdecimal library, and is interested in numerical computation, programming languages, random number generators, and complex networks.
He obtained his Ph.D. (Information science) from Hokkaido University in 2009.
Also, he is an author of a Japanese book titled "Ruby 逆引きレシピ".
Finally, he is a member of Ruby Sapporo, Nihon Ruby-no-kai, and Kosen Conference Committee.
PROFILE
mrkn, 村田賢太 (株式会社ジェネティックラボ)
2009年北海道大学博士 (情報科学)。同年、株式会社ジェネティックラボ入社。
2010年 bigdecimal のメンテナに就任し Ruby コミッタになる。
数値計算、プログラミング言語、乱数生成器、複雑ネットワークに興味を持つ。
著書は『Ruby逆引きレシピ』(共著)。情報処理学会、人工知能学会、各会員。
Ruby札幌、日本Rubyの会、高専カンファレンス実行委員会に所属。
PROFILE_JA
    e29_medium.create :title => 'NArray and scientific computing with Ruby', :speaker => 'Masahiro Tanaka (University of Tsukuba)',:abstract => (<<ABSTRACT), :lang => 'ja', :profile => (<<PROFILE), :profile_ja => (<<PROFILE_JA)
NArray is an n-dimensional numerical array library developed for use in science fields, but it is usable for handling binary data efficiently. I talk about NArray for the first time after 10 years from the first release. I will also present topics including the next version of NArray, and distributed scientific computing using Ruby for multi-core era.
ABSTRACT
Masahiro Tanaka (University of Tsukuba)
Research fellow at Center for Computational Sciences, University of Tsukuba.
Author of Ruby/NArray.
His research fields include infrared astronomy, distributed systems, etc.
PROFILE
田中昌宏（筑波大学）
筑波大学計算科学研究センター研究員．Ruby/NArrayの作者．
研究分野は，赤外線天文学，分散システムなど．
PROFILE_JA
    e29_medium.create :title => 'How Did Yarv2llvm Fail', :title_ja => 'yarv2llvmはどう失敗したのか', :speaker => 'Hideki Miura (CSNagoya)',:abstract => (<<ABSTRACT), :abstract_ja => (<<ABSTRACT_JA), :lang => 'ja', :profile => (<<PROFILE), :profile_ja => (<<PROFILE_JA)
Yarv2llvm is a translator which converts instruciton set of VM of CRuby (aka YARV) into llvm. The feature of yarv2llvm is to use the type inference for raising the execution efficiency of generated llvm. Yarv2llvm get a results. For example it executes the program for computing fibonacci number 40 times faster than Ruby1.9. But it was clarified to be able not to convert all Ruby programs into llvm well either though it had expected beforehand. I will show the example of programming Ruby that cannot be converted with yarv2llvm well and the settlement plan. In addition I will introduce the outline of the next generation translator (ytl) that I am developing to support all specification of Ruby.
ABSTRACT
yarv2llvmはCRubyのVMの命令列をllvmに変換するトランスレータである。生成するllvmの実行効率を上げるために、型推論を用いるのが特徴である。 yarv2llvmはフィボナッチ級数プログラムでRuby1.9の約40倍の実行速度を得るなど、一定の成果が得られた。一方で、事前に予想していたことではあるが、すべてのRubyプログラムがうまくllvmに変換できるわけではないことも明らかになった。 この発表ではyarv2llvmではうまく変換できないRubyプログラム例とその解決案を説明する。さらに、フルセットRubyをサポートすることを目的に現在開発中の次世代トランスレータ(ytl)の概要を紹介する。
ABSTRACT_JA
Hideki Miura (CSNagoya)
My job is pipework. I develop software as my hobby. You can see my products in http://github.com/miura1729 .
PROFILE
三浦 英樹　(CSNagoya)
水道屋です。趣味でプログラムを書いています。書いたものはhttp://github.com/miura1729 にあります。
PROFILE_JA
    e29_medium.create :title => 'AOT Compiler for Ruby', :title_ja => 'Ruby 用 AOT コンパイラ', :speaker => 'Satoshi Shiba (The University of Tokyo)',:abstract => (<<ABSTRACT), :abstract_ja => (<<ABSTRACT_JA), :lang => 'ja', :profile_ja => (<<PROFILE_JA), :profile => (<<PROFILE)
We developed a AOT Compiler, which translates Ruby script into native code to run Ruby script faster.

In this presentation, we show the composition of CRuby and the challenges we overcome to achieve full compatible AOT compiler for the CRuby. We also show the design and the implementation of our AOT compiler. We evaluated the compatibility and performance by using tests and benchmarks included in CRuby release.
ABSTRACT
Ruby スクリプトの実行をより高速にするために，Ruby スクリプトを機械語に変換する AOT（Ahead-Of-Time）コンパイラ を開発した．

本発表では，CRubyの構成を述べ，CRubyと完全互換なAOTコンパイラを開発するにあたっての課題を述べる．そして，我々のAOTコンパイラの設計と実装を示す． Ruby処理系に付属するテストプログラム，ベンチマークプログラムを用いて， その互換性，および得られた性能向上について述べる．
ABSTRACT_JA
芝 哲史 (シバ サトシ)
東京大学笹田研究室の学生です。
Ruby 1.9用の AOT コンパイラを開発しています。
PROFILE_JA
Satoshi Shiba
A graduate student in the Sasada Laboratory, The University of Tokyo.
Develop an AOT compiler for Ruby 1.9.
PROFILE
    e29_medium.create :title => 'Memory Profiler for Ruby', :speaker => 'Tetsu Soh (The University of Tokyo)',:abstract => (<<ABSTRACT), :profile => (<<PROFILE)
We developed a memory profiler for Ruby programming language that fulfills the requirement for measuring and analyzing the memory usage of Ruby applications.

In this presentation, we will describe the features, the design and the implementation of the memory profiler. We will also show the performance evaluation and demonstrate the memory profiler in action.
ABSTRACT
A graduate student in the Sasada Laboratory, The University of Tokyo.
Developed a memory profiler for Ruby1.9.
PROFILE
    e29_medium.create_break :length => 1.5.hours
    e29_medium.create :title => 'How to create Ruby reference manual search Web application with Ruby 1.9  groonga and rroonga', :title_ja => 'るりまサーチの作り方 - Ruby 1.9でgroonga使って全文検索', :speaker => 'Kouhei Sutou (ClearCode Inc. / COZMIXNG)',:abstract => (<<ABSTRACT), :abstract_ja => (<<ABSTRACT_JA), :lang => 'ja', :profile => (<<PROFILE), :profile_ja => (<<PROFILE_JA)
This talk explains about rurema-search, Ruby reference manual in Japanese search Web application, and how to create rurema-search. Rurema-search uses Ruby 1.9.1 (MRI) as a Ruby interpreter, groonga as a full-text search engine and data store and rroonga as a Ruby-groonga interface. Those technologies are particularly explained in 'how to create rurema-search' time.

  rurema-search (Japanese): http://rurema.clear-code.com/
ABSTRACT
このトークではるりまサーチについてとるりまサーチの作り方について話します。るりまサーチはRubyリファレンスマニュアル刷新計画の成果物であるRubyのリファレンスマニュアルを高速に検索するWebアプリケーションです。るりまサーチはRubyインタプリタとしてRuby 1.9.1（MRI）、全文検索エンジンとデータストアとしてgroonga、Rubyとgroongaのインターフェイスとしてrroongaを使っています。作り方の説明では、特にこれらの技術の使い方について詳しく説明します。

 るりまサーチ: http://rurema.clear-code.com/
ABSTRACT_JA
Kouhei Sutou (ClearCode Inc.)
The president of ClearCode Inc.. The author or a developer of RSS Parser, Rabbit, rcairo, Ruby-GNOME2, ActiveLdap, ActiveSambaLdap, test-unit 2.x, rroonga, rurema-search, Ruby/Subversion, RWiki, Ruby and so on.
PROFILE
須藤 功平（株式会社クリアコード）
株式会社クリアコード代表取締役。RSS ParserとRabbitとrcairoとRuby-GNOME2とActiveLdapとActiveSambaLdapとtest-unit 2.xとrroongaとるりまサーチとRuby/SubversionとRWikiとRubyなどの開発者。
PROFILE_JA
    e29_medium.create :title => "Now you're thinking with virtual clocks", :title_ja => 'ゲームとバーチャルタイム', :speaker => 'Tom Lieber (SonicMule,Inc.)',:abstract => (<<ABSTRACT)
Turn the multimedia render loop inside out. Cooperatively scheduling lightweight Ruby threads on a virtual clock allows you to reason about the concurrent code in your game and perform complex synchronization tasks without even realizing it. Ditch the nested trees of update() calls by making time a first class citizen!
ABSTRACT
    e29_medium.create_break
    e29_medium.create :title => "How to survive in a post-Rails world", :title_ja => 'before Rails 時代のプログラマが如何にして after Rails の世界にたどりついたか', :speaker => 'SHIBATA Hiroshi (Eiwa System Management,Inc. / asakusa.rb / tDiary.org)',:abstract => (<<ABSTRACT), :abstract_ja => (<<ABSTRACT_JA), :lang => 'ja', :profile => (<<PROFILE), :profile_ja => (<<PROFILE_JA)
Even before the release of Rails, we have created many useful tools and applications in Ruby. In this post-Rails world, however, the way we approach application development has changed. In this session, I will talk about my experiences in adapting my way of thinking to a post-Rails world.
ABSTRACT
Rails が登場する以前(before Rails)から私たちは多くのプロダクトやツールをRubyによって作ってきました。しかし、Rails が登場した現代(after Rails)のアプリケーション開発では、before Rails とは異なる考え方を持つ必要があります。このセッションでは、自分が経験したbefore Rails から after Rails に適応するための頭の切り替え方を話します。
ABSTRACT_JA
SHIBATA Hiroshi(hsbt) (Eiwa System Management,Inc./asakusa.rb)
He is a programmer in Eiwa System Management,Inc. member of  Japanese Society for Quality Control (JSQC). His lifework is to develop Rails ap
plication and tDiary, The tsukkomi oriented weblog.
PROFILE
柴田博志(hsbt) (永和システムマネジメント/asakusa.rb)
サービスプロバイディング事業部プログラマ、品質管理学会 正会員
Rails を使った業務システムや tDiary という Web 日記システムを作っています。
PROFILE_JA
    e29_medium.create :title => 'How To Create A Beautiful Template Engine Which Never Breaks HTML', :title_ja => 'HTMLデザインをまったく崩さない、美しいテンプレートエンジンの作り方', :speaker => 'Makoto Kuwata (programmer)',:abstract => (<<ABSTRACT), :abstract_ja => (<<ABSTRACT_JA), :lang => 'ja'
One of the biggest challenges in modern web application development is the difficulty of collaborating with web designers. For example, eRuby requires Ruby code to be embedded inside template files, often resulting in broken HTML designs, making life difficult for web designers. To solve this problem, various template engines which don't break HTML have been created. The trade off of these template engines, however, is that they sacrifice other features such as performance or usability.

In this session, a template engine that doesn't break HTML while also  preserving performance and usability will be introduced. This session  will also explore a variety of problems relating to template engines, such as the problems with techniques used in existing template engines, and whether simple "not breaking" HTML designs is sufficient.  This will be definitive session about template engines for web application development. If you are interested in web design, you must attend this session.
ABSTRACT
Webアプリケーション開発における問題点のひとつに、Webデザイナと協業がしにくいことが挙げられます。たとえばeRubyだとテンプレートファイル中にRubyコードを埋め込むため、テンプレートファイルのHTMLデザインが崩れてしまい、デザイナが作業しにくくなってしまいます。この問題を解決するために、HTMLデザインを崩さないようなテンプレートエンジンがいくつか考案されています。しかしそれらはHTMLデザインの問題を解決したかわりに、パフォーマンスや使い勝手の悪さなど別の問題を引き起こしています。本セッションでは、HTMLデザインを一切崩さず、かつ使いやすくて高速なテンプレートエンジンの作り方を紹介します。また既存の方法は何が間違っていたのか、そもそもHTMLデザインを崩さないだけでいいのか、など、テンプレートエンジンにまつわる様々な問題について考察します。本セッションは、テンプレートエンジンについての「決定版」ともいうべき内容です。Webデザインに興味のある方は必見です。
ABSTRACT_JA
    e29_medium.create_break
  end

  e29.with_options(:room => b202) do |e29_b202|
    e29_b202.create :title => 'Regional RubyKaigi Kaigi', :title_ja => '地域Ruby会議会議', :speaker => 'Koji Shimada (Nihon Ruby-no-Kai)', :from => '10:00', :length => 2.hours,:abstract => (<<ABSTRACT), :abstract_ja => (<<ABSTRACT_JA), :lang => 'ja'
An open meeting (\"kaigi\") about Regional RubyKaigi for anyone who is interested.
ABSTRACT
地域 Ruby 会議に興味ある人たちが集まって、地域Ruby会議の今後について話し合うBOF。これまでの開催の関係者、これから地域Ruby会議を開催したいと考えている人、単に地域Ruby会議に興味のある人の参加を歓迎します。
ABSTRACT_JA
    e29_b202.create :title => "We're rubyists living abroad. Any questions?", :title_ja => '外国で暮らすRubyistだけど何か質問ある？', :speaker => 'Kazuhiko (Nexedi SA)', :from => '13:30', :length => 90.minutes,:abstract => (<<ABSTRACT), :abstract_ja => (<<ABSTRACT_JA)
In the RubyKaigi, we have many foreign Rubyists. And we also have Japanese rubyists who are living abroad and foreign rubyists who are living in Japan. Please join this sub-event to discuss with such 'rubyists living abroad'! If you are interested in 'living in Japan as a foreign rubyist', please feel free to ask your questions. Both English language and Japanese lauguage are welcome in this sub-event.
ABSTRACT
RubyKaigiには、外国から多くのRubyistが来ますが、外国で活躍する日本人Rubyistや日本で活躍する外国人Rubyistもたくさんやってきます。そんな身近だけれどちょっと遠い存在に見えなくもない「外国で暮らすRubyist」と意見交換する企画です。 この企画では、@ujm, @vincentisambart, @lchin といった「外国で活躍する」豪華Rubyistを招いて、「カナダのRubyistはどういうところに着目しているか」「母国語と違う環境での Rubyistの仕事の様子」など、参加者の皆さんからの質問に何でもお答えします。なお、この企画では日本語も英語もどちらもOKです。
ABSTRACT_JA
  end

  e29.with_options(:room => a202) do |e29_a202|
    e29_a202.create :title => 'Ruby Game Developers Kaigi', :title_ja => 'Rubyゲーム会議', :speaker => 'kumaryu (Ryuichi Sakamoto)',:abstract => (<<ABSTRACT), :from => '10:00', :length => 2.hours, :lang => 'ja'
Short sessions and Demos for Game Developement with Ruby. Demos are open to all.
ABSTRACT
    e29_a202.create :title => 'Asakusa.rb in Tsukuba', :title_ja => '浅草.rb in つくば', :speaker => 'Akira Matsuda (Asakusa.rb)', :from => '12:00', :length => 90.minutes,:abstract => (<<ABSTRACT), :abstract_ja => (<<ABSTRACT_JA)
During RubyKaigi, you'll find tons of foreign Ruby Stars and Book writers here in Tsukuba. Why don't we directly tell them our questions, requirements, and of course, our deep appreciation, since these days are only once a year and are a very special chance for us. OK, of course we're all willing to tell them, but we know it's very hard to do so. We can hardly distinguish who's who, maybe we lack the courage to talk to them, especially when there's a language barrier between us. So, Asakusa.rb are producing a special event which aims to help introduce everybody to one another and facilitate communicate. We're having live discussions with, for example, the creators of Rails 3, the author of \"The Passionate Programmer\", guys from the crazy \"Ruby Brigade\" Seattle.rb, and lot of other foreign super Ruby Stars who are sticking around here. C'mon everybody, let's get together and talk about \"your\" Ruby!
ABSTRACT
RubyKaigi の会場には、皆さんも日ごろお世話になっているはずのプロダクトや書籍の作者さんご本人がうじゃうじゃ来場しています。せっかくの年に一度のチャンスなので、是非この機会にいつも感じている疑問や要望、それから感謝の気持ちを思い切って直接作者さんに伝えちゃいましょう！とはいえ、誰が誰だかよくわからないし、いきなり面と向かっては話しかけづらいし、特に言語の壁があったりするとなかなか勇気が要りますよね？そこで、僕たち Asakusa.rbでは、Jeremy Kemper や Chad Fowler をはじめ、当日会場に居る豪華外タレさんたちをゲストにお迎えして、彼ら自身の 'あの'プロダクトについて、ご本人と Asakusa.rb のメンバーたちと、それからもちろん会場の皆様も巻き込んで、生のアツいディスカッションを行います。
ABSTRACT_JA
    e29_a202.create :title => 'TermtterKaigi', :speaker => 'jugyo (Termtter Dev Team)', :length => 3.hours,:abstract => (<<ABSTRACT), :abstract_ja => (<<ABSTRACT_JA), :lang => 'ja'
\"Termtter\" is a twitter client, written in Ruby, and based on terminal applications/softwares or shells.

TermtterKaigi does:

* Hackathon
* Lightning Talks
* Refactoring Termtter
* Tutorial of Termtter
* Q&A of Termtter
ABSTRACT
TermtterはRubyで実装されている、ターミナルやシェルから利用することができるTwitterクライアントです。

TermtterKaigiは以下の事をします:

* ハッカソン
* ライトニングトーク
* Termtter のリファクタリング
* Termtter チュートリアル
* Q&A of Termtter
ABSTRACT_JA
  end

  e29.with_options(:room => b201) do |e29_b201|
    e29_b201.create :title => 'Ruby meets LDAP, choices and case', :title_ja => 'Ruby で扱う LDAP のススメ - 選択肢とその事例', :speaker => 'Kazuaki Takase', :from => '10:00', :length => 2.hours,:abstract => (<<ABSTRACT), :abstract_ja => (<<ABSTRACT_JA), :lang => 'ja'
LDAP is widely used for directory service, defined on RFC 4510-4519.

Ruby has library to manage LDAP, such as \"Ruby/LDAP\", \"Net::LDAP\" and \"ActiveLdap\". Unfortunately, no found enough documentation on the internet to determine library which is better.

This session introduce case of each library for Ruby community to determine for choosing which library.
ABSTRACT
Ruby/LDAP, Net::LDAP, ActiveLdap など数々の実装がある中でLDAP自身のマイナーさも相まってか、各パッケージ間の特色やその利用事例について、まとまった情報が存在していません。

数種のパッケージが存在する以上、そこに多様性が存在するはずです。求めるオペレーションによって最適なものは何か、妥当性を選択するための判断基準が存在するはずと考えます。

この企画は各パッケージでの利用事例を公募し、それぞれがその利点を発表する事によって、 LDAP を扱おうとする Ruby コミュニティにパッケージ選択の指針を提供しようとする試みです。
ABSTRACT_JA
    e29_b201.create :title => 'Ruby powering 9 million dining tables', :title_ja => 'Ruby powering 9 million dining tables', :speaker => 'Kenta Hashimoto(COOKPAD Inc.)', :from => '12:00', :length => 90.minutes,:abstract => (<<ABSTRACT), :abstract_ja => (<<ABSTRACT_JA), :lang => 'ja'
Do you know the website that 45% of Japanese women in their 30's are
using regularly?
COOKPAD (cookpad.com) is the world's greatest user-generated recipe
site with 9.8 million monthly users and over 800 thousand recipes.
So what is the reason for its continued growth as the largest Ruby on
Rails site in Japan?
Kenta Hashimoto, our CTO, will introduce you to our practical
technology and development environment.

We will focus on these 3 points:

・Ruby; the value proposition for COOKPAD
・How we scale and develop COOKPAD
・COOKPAD from the eyes of non-Japanese engineers

The slides will be in English, and the lecture will be given in
Japanese, so non-Japanese are more than welcome to participate.


<time table>
12:00-12:50 - 'Ruby powering 9 million dining tables'
12:50-13:20 - Q&A and Lunch time（Please bring your lunch）

<Notice>
COOKPAD has branch offices in the US, and is always eager to take in
engineers regardless of nationality. We would appreciate participation
of non-Japanese technicians interested in working with a Japanese
company.

<Reference>
Cookpad Developer Blog
http://techlife.cookpad.com/
ABSTRACT
日本人女性30代の45％が利用するサイトをご存じですか？
クックパッド（cookpad.com）は月間989万人が利用し、80万品のレシピが集まる世界最大の料理レシピ投稿サイトです。そんなクックパッドが日本最大のRuby
on Rails製サイトとして成長を続けている理由とは何か。日々実践している技術や開発環境についてCTOの橋本健太がお話します。

以下の３つを中心にお話します。

・価値を提供する手段としてのRuby
・クックパッドのスケーリングと開発体制
・クックパッドで働く外国人エンジニアから見たクックパッド

当日スライド資料は英語、講演は日本語で行いますので、外国人の方も是非ご参加ください。

＜time table＞
12：00～12：50　'Ruby powering 9 million dining tables'
12：50～13：20　Q&A and Lunch time（各自お弁当を持参ください）

＜お知らせ＞
クックパッドは米国に支社を設けており、国籍問わず技術者の積極採用をしております。日本企業で働くことに興味がある外国人の方も、ぜひご参加ください。

＜参考＞
クックパッド開発者ブログ
http://techlife.cookpad.com/
ABSTRACT_JA
    e29_b201.create :title => 'Making MS-Win32 Ruby Hands-ON', :title_ja => 'MSWin32版Ruby野良ビルダー養成塾', :speaker => 'Akio Tajima aka arton', :from => '13:30', :length => 3.hours,:abstract => (<<ABSTRACT), :abstract_ja => (<<ABSTRACT_JA), :lang => 'ja'
This hands-on is for Window user who 'd like to build own ruby, extended libs and gem. From installation of the compiler to build own extended library.
ABSTRACT
この企画は、無料の意味でのFreeなVisual C++ 2010 Expressを利用して、WindowsでRubyのタールボール（安定版、および最新版スナップショット）からのmakeとinstall、PATH の通し方、拡張ライブラリの作成、make、インストール、Gemの管理など、Ruby野良ビルダーに最低限必要な知識をハンズオン形式で講習します。
ABSTRACT_JA
  end
  e29.create :title => 'The Origami Ruby (paper craft) Generated by The Ruby', :title_ja => 'Ruby で作る Ruby の折り紙', :speaker => 'Hiroyuki Shimura (Nihon Ruby-no-kai (Japan Ruby Group))', :room => foyer, :from => '10:00', :to => '16:30',:abstract => (<<ABSTRACT), :abstract_ja => (<<ABSTRACT_JA), :lang => 'ja'
Let's fold origami \"Ruby\" like http://dl.dropbox.com/u/4921720/RubyFoldings/IMG_0362.A3_C35_Chu25.WebSmall.JPG. In the first half, we will fold origami \"Ruby\" together with the origami paper that has crease fold lines. In the second half, we will fold something with foil paper and cellophane paper and read a Ruby script that generates paper with crease fold lines.
ABSTRACT
Ruby の折り紙を折ります。 http://dl.dropbox.com/u/4921720/RubyFoldings/IMG_0362.A3_C35_Chu25.WebSmall.JPG 折り線をプリントした展開図を用意しますので、前半それを参考にみんなで折りましょう。後半は、ちょっと難しくなりますがホイル折紙や透明折紙(セロファン)で折ってみたり、或は展開図を作成する Rubyスクリプトを読みましょう。
ABSTRACT_JA
end

# Event.create :title_en => 'Opening', :title_ja => 'オープニング',
#    :abstract_en => 'begin RubyKaigi',
#    :abstract_ja => 'はじまり', :detail_en => 'DETAIL!', :detail_ja => 'くわしく', :additional_info => 'ADDITIONAL!', :lang => 'ja', :break => false
# Rubyist.create :username => 'a_matsuda', :email => 'ronnie@dio.jp', :twitter_user_id => 7220202, :identity_url => 'http://dio.jp/', :full_name => '松田 明', :website => 'http://localhost:3000/'
