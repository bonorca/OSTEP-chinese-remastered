#import "ostep.typ": *

#show: chapter.with(number: "C", title: "关于管程的对话", short: "关于管程的对话", years: "2008–23")

// 对话台词：照第 25 章的做法，中文楷体、西文 Palatino 斜体；加粗的术语用粗体
#let say(who, body) = block(above: 7pt, below: 7pt, par(first-line-indent: 0pt)[
  #strong(who)：#{
    set text(font: kai, style: "italic", size: 1.05em)
    show strong: set text(font: ("Palatino Linotype", "Noto Serif SC"), size: 0.95em)
    body
  }])
#let S = say.with([学生])
#let P = say.with([教授])

#P[又是你啊，嗯？]

#S[我猜您现在一定累坏了吧，毕竟，呃，您懂的，年纪大了？其实 50 岁也不算多老啦。]

#P[我可没 50！其实我刚满 40。不过天哪，我想对你这个二十几岁的人来说……]

#S[……其实是 19 岁……]

#P[（唉）……好好，19 岁，随便吧。我想在你看来 40 岁和 50 岁差不多。但相信我，差远了。至少我那些 50 岁的朋友是这么跟我说的。]

#S[不管怎么说……]

#P[啊对！我们刚才在聊什么来着？]

#S[Monitor，也就是管程。不过我可不知道 #strong[monitor] 是什么，只知道它是我面前这台电脑显示器的一个老派叫法。]

#P[对，这完全是另一回事。它是一种古老的并发（concurrency）原语，设计出来是为了把加锁（locking）自动融入面向对象的程序里。]

#S[那为什么不把它放到讲并发的那部分？]

#P[嗯，这本书大部分讲的是 C 编程和 POSIX 线程库（thread library），而那里面没有管程（monitor），这是一个原因。不过出于一些历史原因，至少该把这方面的内容收进来，所以就放在这儿了，我想。]

#S[啊，历史。那是你们这些老人家的事，对吧？]

#P[（瞪眼）]

#S[哎，别那么较真嘛。我开玩笑的！]

#P[我真等不及你参加期末考试了……]
