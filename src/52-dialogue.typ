#import "ostep.typ": *

// 安全部分各章由 Peter Reiher 撰写，原书页脚的版权有两行（Arpaci-Dusseau、Reiher），模板的页脚只有一行。
// 这里用前景层盖住模板页脚再重画（章首页只有页码，不处理）。这条 show 规则必须放在 chapter 之前，
// 否则 set page 会出现在章首块之后，引起分页。
#show: it => {
  set page(foreground: context {
    if local-page() > 1 {
      set text(font: serif, size: 8pt, top-edge: "baseline", bottom-edge: "baseline")
      place(top + left, dx: margin-x, dy: foot-y - 9pt, rect(width: text-width, height: 15pt, fill: white, stroke: none))
      place(top + left, dx: margin-x, dy: foot-y, box(width: text-width, fsc("Operating Systems [Version 1.10]")))
      place(top + left, dx: margin-x, dy: foot-y - 4.5pt, box(width: text-width, align(right, fsc("© 2008–23, Arpaci-Dusseau (OSTEP)"))))
      place(top + left, dx: margin-x, dy: foot-y + 4.5pt, box(width: text-width, align(right, fsc("© 2019–23, Reiher (Security)"))))
    }
  })
  it
}
#show: chapter.with(number: 52, title: "关于安全的对话", short: "关于安全的对话", years: "2008–23")

// 原书章名下面有一行作者署名
#place(top + right, dy: 176pt - body-top, text(top-edge: "baseline", bottom-edge: "baseline")[本章作者：#strong[Peter Reiher（UCLA）]])

#P[你好啊，同学，又见面了！]

#S[我还以为这些都结束了呢。三大支柱我们已经学完了，我甚至还留下来听了几个附录。这门课我就永远学不完了吗？]

#P[那得看我是谁了。有的教授想讲安全，有的不想。对你来说不巧的是，既然你在这儿，我就是想讲的那种。]

#S[好吧，那我们还是赶紧开始吧。]

#P[这就对了！早开始，早结束。那么，假设你有一个桃子……]

#S[您说过，桃子的事至少已经讲完了！]

#P[谈安全的时候，谎言永远是话题的一部分。总之，你有一个桃子。你肯定不希望一转身，就发现有人把你的桃子偷走了，对吧？]

#S[嗯，只要它没烂成您最后拿到的那个样子，我大概不想让人偷走。]

#P[要是你一转身，发现有人把你的桃子换成了一个萝卜，你大概也不会更高兴吧？]

#S[应该不会，虽然我确实知道几道做萝卜的好菜。]

#P[你也不希望每次伸手去拿桃子时，都有人把你的手打开，对不对？]

#S[对，那也太没礼貌了。]

#P[你计算机掌管的任何资源，你同样不希望它们遇到这种事。如果那些资源真的很重要，你可能会更不高兴。你不希望正在写的情书泄露出去，不希望有人把你最喜欢的游戏存档重置、让你从头再来；要是在项目截止前一晚的半夜，你登录不了自己的计算机，你肯定会火冒三丈。]

#S[没错，这些事都烂透了。]

#P[咱们还是尽量保持专业的语气吧。毕竟这里是课堂。算是吧。操作系统安全讲的就是这些，我来这儿也正是要跟你讲这些。怎样确保秘密始终是秘密？怎样保证你的重要数据完整无损？怎样确保你想用计算机资源的时候就能用上？而且，这些问题适用于你计算机中的所有资源，无时无刻，永远如此。]

#S[这些听起来有点像我们以前讲过的可靠性（reliability）问题……]

#P[是，也不是。坏事可能多少是意外发生的，也可能是计划不周造成的，可靠性关心的就是这类事。但我们要更进一步。有人想要你的桃子！！！！]

#S[别嚷嚷了！要保持专业语气的可是您。]

#P[抱歉，讲到这些东西我有时会激动。我想说的是，谈到安全，我们面对的是真正的对手，是想方设法让你出问题的人类对手。这一点影响深远。他们很可能聪明、恶毒、执着、灵活，而且狡猾。你可能已经觉得整个宇宙都跟你过不去（至少大多数学生都这么觉得），但这些人是真真切切冲着你来的。不管他们使出什么手段，你都得保护好自己的资产。]

#S[听起来很有挑战性。]

#P[你根本想象不到……不过你会知道的！你会知道的！！（狂笑）]
