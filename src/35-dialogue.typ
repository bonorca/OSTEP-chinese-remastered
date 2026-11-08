#import "ostep.typ": *

// 本章前面多了分部标题页（第三部分：持久性）和一个空白页，章首从第 3 页开始，页码照原书。
// 模板的 chapter() 按物理第 1 页排章首，这里照第 25 章另写一份版式：
//   第 1 页：分部标题页，只有底部居中的页码；
//   第 2 页：空白页，什么都不印；
//   第 3 页：章首，只有底部居中的页码；
//   之后：和其他章一样的页眉页脚。
#let short = "关于持久性的对话"
#let years = "2008–25"

#set document(title: "35 关于持久性的对话")
#set page(
  width: 432pt, height: 648pt,
  margin: (x: margin-x, top: body-top, bottom: 648pt - body-bottom),
  background: context {
    let p = here().page()
    set text(font: serif, size: body-size, top-edge: "baseline", bottom-edge: "baseline")
    let at(y, body) = place(top + left, dx: margin-x, dy: y, box(width: text-width, body))
    if p == 1 or p == 3 {
      at(foot-y, align(center)[#p])
    } else if p > 3 {
      at(head-y, [#short #h(1fr) #p])
      place(top + left, dx: margin-x, dy: head-y + 3.5pt, line(length: text-width, stroke: 0.4pt))
      at(foot-y, text(size: 8pt)[
        #fsc("Operating Systems [Version 1.10]") #h(1fr) #fsc("© " + years + ", Arpaci-Dusseau")])
    }
  },
)
#set text(font: serif, size: body-size, lang: "zh", region: "cn", top-edge: 0.88em, bottom-edge: -0.12em)
#set par(justify: true, leading: skip - 1em, spacing: skip - 1em, first-line-indent: (amount: 2em, all: true))
#show strong: set text(weight: "bold")
// 对话台词：原书是斜体，台词里的术语是粗斜体。楷体没有粗体，加粗的术语看不出来，
// 所以和第 25 章一样自己定义：中文用楷体、西文用 Palatino 斜体；
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

// ---- 第 1 页：分部标题页（原书：“Part III” 14.3pt、“Persistence” 17.2pt，都加粗、居中）----
#block(height: 100%, width: 100%, {
  set text(top-edge: "baseline", bottom-edge: "baseline")
  place(top + center, dy: 249pt - body-top, text(size: 14.3pt, weight: "bold")[第三部分])
  place(top + center, dy: 294pt - body-top, text(size: 17.2pt, weight: "bold")[持久性])
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
    box(width: text-width - 9pt, align(right, text(font: sans, size: 20.7pt, "35"))))
  place(top + left, dy: 154pt - body-top,
    box(width: text-width, align(right, text(font: sans, size: 14.3pt, short))))
})

#P[于是，我们来到了操作系统四大……呃……三大支柱中的第三根：#strong[持久性]（persistence）。]

#S[您刚才说的是三大支柱，还是四大支柱？第四根是什么？]

#P[没有第四根。就三根，年轻人，就三根。我这是想把事情讲得简单点。]

#S[好吧，行。那么，高贵又了不起的教授，什么是持久性呢？]

#P[其实，你大概知道这个词在传统意义上是什么意思，对吧？用词典的话说：“不顾困难或阻挠，坚定或固执地把一件事做下去。”]

#S[有点像上您的课：得有点固执才行。]

#P[哈！没错。不过，这里说的持久性是另一回事。我来解释一下。想象你在外面，在一片田野里，摘了一个——]

#S[（打断）我知道！一个桃子！从桃树上摘的！]

#P[我本来想说苹果，从苹果树上摘的。哎，算了，我看就照你说的来吧。]

#S[（一脸茫然）]

#P[总之，你摘了一个桃子；事实上，你摘了好多好多桃子，但你想让它们放得久一点。毕竟，威斯康星的冬天又难熬又冷酷。你会怎么做？]

#S[嗯，我觉得办法有好几种。可以腌起来！或者烤个派，或者做成某种果酱。好玩极了！]

#P[好玩？嗯，也许吧。不过可以肯定的是，要让桃子#strong[持久保存]（persist），你得多花很多工夫。信息也是这样：不管计算机崩溃、磁盘故障还是断电，都要让信息持久保存下来，这是一个既艰巨又有意思的挑战。]

#S[过渡得真漂亮；您越来越擅长这个了。]

#P[谢谢！你知道的，教授总是乐意听几句好话。]

#S[我会记着的。我想，现在该停止聊桃子，开始聊计算机了吧？]

#P[是的，是时候了……]
