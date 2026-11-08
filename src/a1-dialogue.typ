#import "ostep.typ": *

#show: chapter.with(number: "A", title: "关于虚拟机监视器的对话", short: "关于虚拟机监视器的对话", years: "2008–23")

// 对话台词：原书是斜体，台词里的术语是粗斜体。楷体没有粗体，所以照第 25 章的做法：
// 中文用楷体、西文用 Palatino 斜体；加粗的术语中文改用思源宋体粗体、西文用 Palatino 粗斜体。
#let say(who, body) = block(above: 7pt, below: 7pt, par(first-line-indent: 0pt)[
  #strong(who)：#{
    set text(font: kai, style: "italic", size: 1.05em)
    show strong: set text(font: ("Palatino Linotype", "Noto Serif SC"), size: 0.95em)
    body
  }])
#let S = say.with([学生])
#let P = say.with([教授])

#S[这下我们被困在附录里了，是吧？]

#P[是啊，就在你以为情况不可能更糟的时候。]

#S[那么，我们要聊些什么？]

#P[一个重获新生的老话题：#strong[虚拟机监视器]（virtual machine monitor），也叫 #strong[hypervisor]。]

#S[哦，就像 VMware 那样？挺酷的，这类软件我以前用过。]

#P[确实很酷。我们会学到 VMM 怎样在系统里再加一层虚拟化，而且这一层就在操作系统本身的下面！真是既疯狂又神奇。]

#S[听起来不错。那为什么不把它放在书前面讲虚拟化的那部分？它不是本来就该放在那儿吗？]

#P[恐怕这事轮不到我们拍板。不过我猜是这样：那部分的内容已经很多了。把 VMM 这段小小的题外话挪到附录里，每位老师就可以自己决定讲还是跳过。但我确实认为应该讲，因为如果你能弄懂 VMM 是怎么工作的，那你对虚拟化就真的理解得相当透彻了。]

#S[那好吧，我们开始干活吧！]
