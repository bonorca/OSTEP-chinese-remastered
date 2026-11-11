#import "ostep.typ": *

// 本章前面多了分部标题页（第一部分：虚拟化）和一个空白页，章首从第 3 页开始，页码照原书。
// 版式同第 25 章：
//   第 1 页：分部标题页，只有底部居中的页码；
//   第 2 页：空白页；
//   第 3 页：章首，只有底部居中的页码；
//   之后：和其他章一样的页眉页脚。
#let short = "关于虚拟化的对话"
#let years = "2008–23"

#set document(title: "3 关于虚拟化的对话") if not book-mode
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
// 对话台词：原书是斜体，台词里的术语是粗斜体（同第 25 章）
// 台词间距比第 25 章略紧（6pt），免得最后一句单独落到第 4 页
#let say(who, body) = block(above: 6pt, below: 6pt, par(first-line-indent: 0pt)[
  #strong(who)：#{
    set text(font: kai, style: "italic", size: 1.05em)
    show strong: set text(font: ("Palatino Linotype", "Noto Serif SC"), size: 0.95em)
    body
  }])
#let S = say.with([学生])
#let P = say.with([教授])
#show regex("[A-Za-z]’[A-Za-z]"): set text(font: "Palatino Linotype")
#show smartquote.where(double: false): set text(font: "Palatino Linotype")

#part-mark("第一部分", "虚拟化")
#chapter-mark(3, "关于虚拟化的对话")
// ---- 第 1 页：分部标题页（原书 “Part I” 14.3pt、“Virtualization” 17.2pt，都加粗、居中）----
#block(height: 100%, width: 100%, {
  set text(top-edge: "baseline", bottom-edge: "baseline")
  place(top + center, dy: 249pt - body-top, text(size: 14.3pt, weight: "bold")[第一部分])
  place(top + center, dy: 294pt - body-top, text(size: 17.2pt, weight: "bold")[虚拟化])
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
    box(width: text-width - 9pt, align(right, text(font: sans, size: 20.7pt, "3"))))
  place(top + left, dy: 154pt - body-top,
    box(width: text-width, align(right, text(font: sans, size: 14.3pt, short))))
})

#P[那么，我们就从操作系统三个部分中的第一部分讲起：#strong[虚拟化]（virtualization）。]

#S[可是什么是虚拟化呢，尊敬的教授？]

#P[想象一下，我们有一个桃子。]

#S[一个桃子？（难以置信）]

#P[对，一个桃子。我们把它叫作#strong[物理]（physical）桃子。可是有很多人都想吃这个桃子。我们希望给每个吃桃子的人都端上一个他们自己的桃子，让大家都高兴。我们把给他们的桃子叫作#strong[虚拟]（virtual）桃子；我们设法用这一个物理桃子造出许多个虚拟桃子。重要的是：在这个假象里，每个吃桃子的人看上去都拥有一个物理桃子，但实际上并没有。]

#S[所以大家在分着吃这个桃子，自己却根本不知道？]

#P[对！正是如此。]

#S[可是只有一个桃子啊。]

#P[对。然后呢……？]

#S[嗯，如果我在和别人分一个桃子，我想我会注意到的。]

#P[啊，没错！说得好。不过吃桃子的人多了就是这样：他们大多数时候都在打盹或者忙别的，所以你可以把桃子拿走，给别人吃一会儿。这样我们就营造出了许多个虚拟桃子的假象，每人一个桃子！]

#S[听起来像个糟糕的竞选口号。您说的是计算机，对吧，教授？]

#P[啊，小蚱蜢，你想要一个更具体的例子。好主意！我们拿最基本的资源，也就是 CPU 来说。假设系统里有一个物理 CPU（虽然现在常常有两个、四个甚至更多）。虚拟化做的事，就是让系统上运行的应用程序觉得，这一个 CPU 是许多个虚拟 CPU（virtual CPU）。这样，虽然每个应用程序都以为自己有一个 CPU 可用，实际上却只有一个。于是操作系统营造出了一个美丽的假象：它把 CPU 虚拟化了。]

#S[哇！听起来像魔法一样。再多讲讲！这是怎么做到的？]

#P[到时候就知道了，年轻的学生，别急。看来你已经准备好开始了。]

#S[准备好了！嗯，算是吧。我得承认，我有点担心您又要开始讲桃子了。]

#P[别太担心；我其实根本不喜欢桃子。好了，我们开始吧……]
