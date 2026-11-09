// 整本 PDF 的封面（只在 book.typ 里用；也可以单独编译预览：typst compile cover.typ）
#import "ostep.typ": *

#let accent = rgb("#1f4e8c")
#let pale = rgb("#dfe7f1")

#page(width: 432pt, height: 648pt, margin: 0pt, background: none, foreground: none, {
  set text(font: serif, lang: "zh", region: "cn", top-edge: "baseline", bottom-edge: "baseline")
  let x0 = 48pt
  let w = 432pt - 2 * x0

  // 上方：和章首页一样的折角线
  place(top + left, dx: x0, dy: 96pt, line(length: w, stroke: 0.6pt))
  place(top + left, dx: x0 + w, dy: 54pt, line(angle: 90deg, length: 42pt, stroke: 0.6pt))
  place(top + left, dx: x0, dy: 84pt, text(font: sans, size: 8pt, tracking: 0.12em, fill: luma(90))[OSTEP · 中文翻译重制版])

  // 书名
  place(top + left, dx: x0, dy: 170pt, text(font: sans, size: 40pt, weight: "bold")[操作系统导论])
  place(top + left, dx: x0, dy: 204pt,
    text(font: "Palatino Linotype", size: 17pt, style: "italic")[Operating Systems: Three Easy Pieces])

  // 三块拼图：虚拟化、并发、持久性（书名里的 three easy pieces）
  let pieces = (("虚拟化", "Virtualization"), ("并发", "Concurrency"), ("持久性", "Persistence"))
  let gap = 12pt
  let side = (w - 2 * gap) / 3
  let top0 = 278pt
  for (i, (zh, en)) in pieces.enumerate() {
    let dx = x0 + i * (side + gap)
    let dy = top0 + (2 - i) * 22pt
    place(top + left, dx: dx, dy: dy,
      rect(width: side, height: side, fill: if i == 1 { accent } else { pale }, stroke: none))
    let fg = if i == 1 { white } else { accent }
    place(top + left, dx: dx + 10pt, dy: dy + side - 26pt, text(font: sans, size: 12pt, weight: "bold", fill: fg, zh))
    place(top + left, dx: dx + 10pt, dy: dy + side - 12pt, text(font: "Palatino Linotype", size: 8pt, style: "italic", fill: fg, en))
  }
  // 拼图下方的基线
  place(top + left, dx: x0, dy: top0 + 2 * 22pt + side + 14pt, line(length: w, stroke: 0.4pt + luma(150)))

  // 作者
  place(top + left, dx: x0, dy: 520pt, text(font: "Palatino Linotype", size: 12pt)[Remzi H. Arpaci-Dusseau])
  place(top + left, dx: x0, dy: 537pt, text(font: "Palatino Linotype", size: 12pt)[Andrea C. Arpaci-Dusseau])
  place(top + left, dx: x0, dy: 556pt, text(size: 8.5pt, fill: luma(80))[原著 · Version 1.10])

  // 底部
  place(top + left, dx: x0, dy: 600pt, line(length: w, stroke: 0.4pt))
  place(top + left, dx: x0, dy: 614pt,
    text(font: "Palatino Linotype", size: 7.5pt, fill: luma(90))[github.com/bonorca/OSTEP-chinese-remastered])
})
