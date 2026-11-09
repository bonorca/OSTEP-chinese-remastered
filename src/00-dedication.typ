#import "ostep.typ": *

// 献词页：原书是罗马数字页码 i，页眉只有一条横线和页码，页脚是版权（2008–26）。
#set document(title: "献词") if not book-mode
#set page(
  width: 432pt, height: 648pt,
  margin: (x: margin-x, top: body-top, bottom: 648pt - body-bottom),
  background: {
    set text(font: serif, size: body-size, top-edge: "baseline", bottom-edge: "baseline")
    let at(y, body) = place(top + left, dx: margin-x, dy: y, box(width: text-width, body))
    at(head-y, [#h(1fr) i])
    place(top + left, dx: margin-x, dy: head-y + 3.5pt, line(length: text-width, stroke: 0.4pt))
    at(foot-y, text(size: 8pt)[#h(1fr) #fsc("© 2008–26, Arpaci-Dusseau")])
  },
)
#set text(font: serif, size: body-size, lang: "zh", region: "cn")

#unit-start()
#v(1fr)
#align(center, text(font: kai, style: "italic", size: 1.1em)[献给 Vedat S. Arpaci——我们一生的灵感源泉])
#v(1.2fr)
