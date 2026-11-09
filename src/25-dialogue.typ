#import "ostep.typ": *

// 本章前面多了分部标题页（第二部分：并发）和一个空白页，章首从第 3 页开始，页码照原书。
// 模板的 chapter() 按物理第 1 页排章首，这里另写一份版式：
//   第 1 页：分部标题页，只有底部居中的页码；
//   第 2 页：空白页，什么都不印；
//   第 3 页：章首，只有底部居中的页码；
//   之后：和其他章一样的页眉页脚。
#let short = "关于并发的对话"
#let years = "2008–25"

#set document(title: "25 关于并发的对话") if not book-mode
#set page(
  width: 432pt, height: 648pt,
  margin: (x: margin-x, top: body-top, bottom: 648pt - body-bottom),
  background: context {
    let p = local-page()
    set text(font: serif, size: body-size, top-edge: "baseline", bottom-edge: "baseline")
    let at(y, body) = place(top + left, dx: margin-x, dy: y, box(width: text-width, body))
    if p == 1 or p == 3 {
      at(foot-y, align(center)[#page-no()])
    } else if p > 3 {
      at(head-y, [#short #h(1fr) #page-no()])
      place(top + left, dx: margin-x, dy: head-y + 3.5pt, line(length: text-width, stroke: 0.4pt))
      at(foot-y, text(size: 8pt)[
        #fsc("Operating Systems [Version 1.10]") #h(1fr) #fsc("© " + years + ", Arpaci-Dusseau")])
    }
  },
)
#set text(font: serif, size: body-size, lang: "zh", region: "cn", top-edge: 0.88em, bottom-edge: -0.12em)
#set par(justify: true, leading: skip - 1em, spacing: skip - 1em, first-line-indent: (amount: 2em, all: true))
#show strong: set text(weight: "bold")
// 对话台词：原书是斜体，台词里的术语是粗斜体。模板的 say() 用 emph，而楷体没有粗体，
// 术语加粗后看不出来，所以本章自己定义：中文用楷体、西文用 Palatino 斜体；
// 加粗的术语中文改用思源宋体粗体、西文用 Palatino 粗斜体。
#let say(who, body) = block(above: 7pt, below: 7pt, par(first-line-indent: 0pt)[
  #strong(who)：#{
    set text(font: kai, style: "italic", size: 1.05em)
    show strong: set text(font: ("Palatino Linotype", "Noto Serif SC"), size: 0.95em)
    body
  }])
#let S = say.with([学生])
#let P = say.with([教授])
#show regex("[A-Za-z]’[A-Za-z]"): set text(font: "Palatino Linotype")
#show smartquote.where(double: false): set text(font: "Palatino Linotype")

#part-mark("第二部分", "并发")
#chapter-mark(25, "关于并发的对话")
// ---- 第 1 页：分部标题页（原书：“Part II” 14.3pt、“Concurrency” 17.2pt，都加粗、居中）----
#block(height: 100%, width: 100%, {
  set text(top-edge: "baseline", bottom-edge: "baseline")
  place(top + center, dy: 249pt - body-top, text(size: 14.3pt, weight: "bold")[第二部分])
  place(top + center, dy: 294pt - body-top, text(size: 17.2pt, weight: "bold")[并发])
})
#pagebreak()
// ---- 第 2 页：空白页 ----
#block(height: 100%, width: 100%)
#pagebreak()

// ---- 第 3 页起：章首和正文 ----
#block(height: 200pt - body-top - 0.88 * body-size, width: 100%, below: 0pt, {
  set text(top-edge: "baseline", bottom-edge: "baseline")
  place(top + left, dy: 126pt - body-top, line(length: text-width, stroke: 0.5pt))
  place(top + left, dx: text-width, dy: 84pt - body-top, line(angle: 90deg, length: 42pt, stroke: 0.5pt))
  place(top + left, dy: 111pt - body-top,
    box(width: text-width - 9pt, align(right, text(font: sans, size: 20.7pt, "25"))))
  place(top + left, dy: 154pt - body-top,
    box(width: text-width, align(right, text(font: sans, size: 14.3pt, short))))
})

#P[于是，我们来到了操作系统三大支柱中的第二根：#strong[并发]（concurrency）。]

#S[我还以为有四大支柱呢……？]

#P[不，那是这本书旧版里的说法。]

#S[呃……好吧。那么，了不起的教授，什么是并发呢？]

#P[嗯，想象一下，我们有一个桃子——]

#S[（打断）又是桃子！您跟桃子到底有什么过不去的？]

#P[读过 T.S. 艾略特吗？《J. 阿尔弗瑞德·普鲁弗洛克的情歌》，“我敢吃下一只桃子吗”，还有那些好玩的东西？]

#S[哦，读过！高中英语课上读的。写得真好！我特别喜欢那一段——]

#P[（打断）这跟那个没关系——我只是喜欢桃子而已。总之，想象桌上有很多桃子，还有很多人想吃。假设我们这样来：每个吃桃子的人先用眼睛锁定一个桃子，然后伸手去拿，拿到就吃。这种做法有什么问题？]

#S[嗯……您看中的桃子，别人可能也看中了。要是他们先到，等您伸出手时，桃子就没您的份了！]

#P[正是！那我们该怎么办？]

#S[嗯，大概得想个更好的办法。也许可以排成一队，轮到你站到最前面时，就拿一个桃子走人。]

#P[很好！不过你这个办法有什么问题？]

#S[天哪，活儿都得我来干吗？]

#P[对。]

#S[好吧，让我想想。嗯，原来的做法是大家一拥而上同时抢，这样更快。可是按我的办法，大家只能一个接一个地来，这样是对了，但慢了不少。最好的办法大概是既快又对。]

#P[你真是越来越让人刮目相看了。事实上，你刚才已经把关于并发我们需要知道的一切都说出来了！干得好。]

#S[是吗？我还以为我们只是在聊桃子呢。记住，通常这时候您就该把话题扯回计算机上了。]

#P[确实如此。抱歉！具体的东西可永远不能忘。嗯，事实上，有一类程序，我们称之为#strong[多线程]（multi-threaded）应用；每个#strong[线程]（thread）有点像一个独立的代理，在程序里跑来跑去，替程序做事。但这些线程要访问内存，在它们眼里，内存中的每个位置都有点像那些桃子。如果我们不协调线程之间对内存的访问，程序就不会按预期工作。明白了吗？]

#S[有点明白。可是为什么要在操作系统课上讲这个？这不就是应用程序编程吗？]

#P[问得好！其实有好几个原因。第一，操作系统必须用#strong[锁]（lock）和#strong[条件变量]（condition variable）这样的原语来支持多线程应用，我们很快就会讲到。第二，操作系统本身就是第一个并发程序（concurrent program）——它必须非常小心地访问自己的内存，否则就会发生许多奇怪又可怕的事情。说真的，那场面可能相当惨烈。]

#S[明白了。听起来很有意思。我猜还有更多细节吧？]

#P[确实还有……]
