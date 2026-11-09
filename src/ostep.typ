// 仿 OSTEP 原书版式的中文译本模板。页面 432×648pt（6×9 英寸，同原书），左右边距相同、每页版式一致。

#let serif = ((name: "Palatino Linotype", covers: "latin-in-cjk"), "Noto Serif SC")
#let kai = ((name: "Palatino Linotype", covers: "latin-in-cjk"), "KaiTi")
#let sans = ((name: "Arial", covers: "latin-in-cjk"), "Microsoft YaHei")
#let mono = ("Courier New", "Noto Sans SC")

#let body-size = 9pt
#let skip = 13.5pt            // 正文行距（基线到基线）
#let margin-x = 40pt
#let text-width = 432pt - 2 * margin-x
#let head-y = 48pt            // 页眉基线
#let body-top = 66pt
#let body-bottom = 596pt
#let foot-y = 626pt           // 页脚基线

// 原书用的是“假小型大写”：大写字母 9pt，小写字母改成大写 7.2pt
#let fsc(s) = for c in s.clusters() {
  if c != upper(c) { text(size: 0.8em, upper(c)) } else { c }
}

#let crux(title, body) = block(
  fill: luma(226), width: 100%, breakable: false,
  inset: (x: 7pt, top: 8pt, bottom: 10pt),
  above: 14pt, below: 14pt,
)[
  #align(center, title)
  #v(2pt, weak: true)
  #set align(left)
  #body
]

// TIP / ASIDE 框和原书一样做成浮动体，放到当前页的顶部或底部，正文接着往下排
// tag：给框起个名字，正文里用 locate(<名字>).page() 引用框实际所在的页（浮动后可能不在原位置）
#let tip(title, body, tag: none) = place(auto, float: true, clearance: 14pt, crux(title)[
  #if tag != none [#metadata(none)#label(tag)]
  #set par(first-line-indent: 0pt)
  #body
])
#let aside = tip

// 图和表：同样做成浮动体，下面是“图 15.1：标题”（标题加粗）
// at：浮动位置，默认 auto（页顶或页底），高的图在节末留白太多时可以传 top 强制浮到页顶
// ---- 整本模式 ----
// typst compile --input book=1 book.typ 时为真：全书合成一本，页码连续，每章是一个“单元”。
// 单章编译时为假，一切照旧。
#let book-mode = sys.inputs.at("book", default: "0") == "1"
// 每个文件（单元）开头放一个锚点；整本模式下每章脚注重新从 1 编号
#let unit-start() = [#metadata(none)<ostep-unit>] + if book-mode { counter(footnote).update(0) }
#let unit-starts() = query(<ostep-unit>).map(m => m.location().page())
// 本单元内的第几页（章首页是 1）；单章编译时就是物理页码。需要在 context 里调用
#let local-page() = {
  let p = here().page()
  let s = unit-starts().filter(x => x <= p)
  p - (if s.len() > 0 { calc.max(..s) } else { 1 }) + 1
}
// 页眉页脚上印的页码：整本模式用全书连续的页码计数器，单章就是物理页码
// （第 1 章首页的页码计数器是在页面中间重置成 1 的，页脚读的是页顶的值，所以单独处理）
#let page-no() = if book-mode {
  let ch1 = query(<ostep-chapter>).filter(m => m.value.no == "1")
  if ch1.len() > 0 and ch1.first().location().page() == here().page() { 1 } else { counter(page).get().first() }
} else { here().page() }
// loc 和当前位置是否在同一个单元（同一章）里
#let same-unit(loc) = {
  let s = unit-starts()
  s.filter(x => x <= loc.page()).len() == s.filter(x => x <= here().page()).len()
}
// 章的锚点：目录、「第 N 章」链接、书签都靠它；整本模式下再放一个看不见的一级标题当书签
#let chapter-mark(no, title) = {
  unit-start()
  [#metadata((no: str(no), title: title))<ostep-chapter>]
  if book-mode { place(hide(heading(level: 1, outlined: true, bookmarked: true)[#str(no) #title])) }
}
#let part-mark(no, title) = [#metadata((no: no, title: title))<ostep-part>]

// 跳转链接：图的锚点（正文里的「图 X.Y」点了跳过来）、参考文献条目的锚点（「[FLR98]」点了跳过来）
// 先找本章里的；cross: true 时本章没有就到别的章找（图号全书唯一，文献键各章重复所以不跨章）
#let figmark(num) = [#metadata(str(num))<ostep-fig>]
#let reflink(kind, key, body, cross: false) = context {
  let hits = query(kind).filter(m => m.value == key or (type(m.value) == dictionary and m.value.no == key))
  let own = hits.filter(m => same-unit(m.location()))
  let tgt = if own.len() > 0 { own.first() } else if cross and hits.len() > 0 { hits.first() } else { none }
  if tgt != none { link(tgt.location(), body) } else { body }
}
#let bibkey = "[A-Z][A-Za-z+\-]*\d{2}[a-z]?"

#let fig(num, title, body, tag: none, at: auto) = place(at, float: true, clearance: 14pt, block(width: 100%, {
  figmark(num)
  if tag != none [#metadata(none)#label(tag)]
  set par(first-line-indent: 0pt, justify: false)
  align(center, body)
  v(8pt)
  align(center)[图 #num：#strong(title)]
}))

// 引用某个 tag 所在的页码。命令行核对页码用：typst eval 'query(<fig1>).first().location().page()' --in 某章.typ
#let pageof(tag) = context {
  let hits = query(label(tag)).filter(m => same-unit(m.location()))
  let loc = if hits.len() > 0 { hits.first().location() } else { locate(label(tag)) }
  link(loc, str(counter(page).at(loc).first()))
}

// 带行号的代码清单（原书的代码图）：#fig("28.1", "标题", align(left, numbered("…")))
// 只翻注释；行号小号灰色，和原书一样放在左边
#let numbered(src) = {
  show raw.line: it => box(width: 1em, align(right, text(size: 5.5pt, fill: luma(90), str(it.number)))) + h(0.9em) + it.body
  raw(src, block: true)
}

// 对话体章节（第 24、25、34 章等）：说话人加粗，台词按原书的斜体处理（中文楷体、英文斜体）
#let say(who, body) = block(above: 7pt, below: 7pt, par(first-line-indent: 0pt)[
  #strong(who)：#emph(body)])
#let S = say.with([学生])
#let P = say.with([教授])

// 图里的斜线阴影（空闲 / 未使用区域）
#let hatch = tiling(size: (3.5pt, 3.5pt),
  place(line(start: (0pt, 3.5pt), end: (3.5pt, 0pt), stroke: 0.35pt + luma(150))))

// 竖直箭头，坐标相对于所在的 box
#let varrow(x, y1, y2) = {
  let d = if y2 > y1 { 1 } else { -1 }
  place(top + left, line(start: (x, y1), end: (x, y2 - d * 4pt), stroke: 0.9pt))
  place(top + left, polygon(fill: black, (x - 2.2pt, y2 - d * 5.5pt), (x + 2.2pt, y2 - d * 5.5pt), (x, y2)))
}

// 以 (x, y) 为中心放一段文字；white: 加白底（放在阴影上时用）
#let label-at(x, y, body, backed: false, w: 120pt) = place(top + left, dx: x - w / 2, dy: y - 5pt,
  box(width: w, height: 10pt, align(center + horizon,
    if backed { box(fill: white, inset: (x: 1.5pt, y: 1pt), body) } else { body })))

// 原书风格的表格：表头加粗，表头下一条线；rules: 行与行之间也画细线
#let booktable(columns, header, ..cells, rules: false, size: 8pt) = {
  set text(size: size)
  set par(first-line-indent: 0pt, justify: false, leading: 10pt - 1em)
  table(columns: columns, stroke: none, inset: (x: 4pt, y: 2.5pt), align: left,
    table.header(..header.map(h => strong(h))),
    table.hline(stroke: 0.6pt),
    ..if rules {
      let n = columns.len()
      let cs = cells.pos()
      range(0, cs.len(), step: n).map(i => (..cs.slice(i, i + n), table.hline(stroke: 0.3pt))).flatten()
    } else { cells.pos() })
}

// version：页脚的版本号，照原文页脚填（大多数章是 1.10，第 32 章是 1.20）
#let chapter(number: none, title: none, short: none, years: "2008–25", version: "1.10", body) = {
  set document(title: str(number) + " " + title) if not book-mode
  set page(
    width: 432pt, height: 648pt,
    margin: (x: margin-x, top: body-top, bottom: 648pt - body-bottom),
    background: context {
      let p = local-page()
      set text(font: serif, size: body-size, top-edge: "baseline", bottom-edge: "baseline")
      let at(y, body) = place(top + left, dx: margin-x, dy: y, box(width: text-width, body))
      if p == 1 {
        at(foot-y, align(center)[#page-no()])
      } else {
        at(head-y, [#short #h(1fr) #page-no()])
        place(top + left, dx: margin-x, dy: head-y + 3.5pt, line(length: text-width, stroke: 0.4pt))
        at(foot-y, text(size: 8pt)[
          #fsc("Operating Systems [Version " + version + "]") #h(1fr) #fsc("© " + years + ", Arpaci-Dusseau")])
      }
    },
  )

  set text(font: serif, size: body-size, lang: "zh", region: "cn",
    top-edge: 0.88em, bottom-edge: -0.12em)
  set par(justify: true, leading: skip - 1em, spacing: skip - 1em,
    first-line-indent: (amount: 2em, all: true))

  // 西文斜体用 Palatino Italic，中文没有斜体，改用楷体（楷体字面偏小，放大一点）
  show emph: it => {
    show regex("[\p{Han}，。、；：！？（）]+"): set text(font: "KaiTi", style: "normal", size: 1.1em, tracking: -0.06em)
    it
  }
  show strong: set text(weight: "bold")
  // 英文所有格、缩写里的撇号（Belady’s、C’s）用 Palatino，否则会落到中文字体变成全角
  show regex("[A-Za-z]’[A-Za-z]"): set text(font: "Palatino Linotype")
  show smartquote.where(double: false): set text(font: "Palatino Linotype")
  // 「I/O」不许在斜线处断行
  show "I/O": box

  // 链接：图引用、文献引用、页码引用都能点；链接用深蓝色，免得看不出来能点
  show link: set text(fill: rgb("#1f4e8c"))
  show regex("图\s?(?:[A-Z]|\d+)\.\d+"): it => {
    let num = it.text.replace(regex("^图\s?"), "")
    reflink(<ostep-fig>, num, it, cross: true)
  }
  show regex("\[" + bibkey + "(?:[,，;；]\s?" + bibkey + ")*\]"): it => {
    let s = it.text
    let out = ()
    let last = 0
    for m in s.matches(regex(bibkey)) {
      out.push(s.slice(last, m.start))
      out.push(reflink(<ostep-bib>, m.text, m.text))
      last = m.end
    }
    out.push(s.slice(last))
    out.join()
  }

  show raw: set text(font: mono, size: 1.25em)
  show raw.where(block: true): it => {
    set par(leading: 10.5pt - 1em, justify: false)
    block(inset: (left: 11pt), above: 9pt, below: 9pt, it)
  }

  show heading: set text(weight: "regular")
  // 整本模式下章名占一级标题（书签用），节标题整体降一级
  let L1 = if book-mode { 2 } else { 1 }
  show heading.where(level: L1): it => block(above: 18pt, below: 10pt, sticky: true,
    move(dx: -21pt, text(size: 10.9pt, it.body)))
  show heading.where(level: L1 + 1): it => block(above: 15pt, below: 8pt, sticky: true,
    text(size: 10pt, weight: "bold", it.body))

  set footnote.entry(separator: line(length: 30%, stroke: 0.4pt), gap: 3pt, clearance: 8pt)
  show footnote.entry: set text(size: 7pt)
  show footnote.entry: set par(first-line-indent: 0pt, leading: 9pt - 1em)

  set enum(indent: 12pt, body-indent: 5pt, spacing: 8pt)
  show enum: set par(first-line-indent: 0pt)
  set list(indent: 12pt, body-indent: 6pt, spacing: skip - 1em, marker: text(size: 0.6em, baseline: -0.2em)[●])
  show list: set par(first-line-indent: 0pt)

  // 整本模式：「第 N 章」可以点，跳到那一章
  show regex("第\s?(?:\d+|[A-H])\s?章"): it => if book-mode {
    reflink(<ostep-chapter>, it.text.replace(regex("[第章\s]"), ""), it, cross: true)
  } else { it }

  chapter-mark(number, title)
  if book-mode and str(number) == "1" { counter(page).update(1) }

  // 章首：右上角大号章号 + 折角线，下面是右对齐的章名
  block(height: 200pt - body-top - 0.88 * body-size, width: 100%, below: 0pt, {
    set text(top-edge: "baseline", bottom-edge: "baseline")
    place(top + left, dy: 126pt - body-top, line(length: text-width, stroke: 0.5pt))
    place(top + left, dx: text-width, dy: 84pt - body-top, line(angle: 90deg, length: 42pt, stroke: 0.5pt))
    place(top + left, dy: 111pt - body-top,
      box(width: text-width - 9pt, align(right, text(font: sans, size: 20.7pt, str(number)))))
    place(top + left, dy: 154pt - body-top,
      box(width: text-width, align(right, text(font: sans, size: 14.3pt, title))))
  })

  set heading(offset: 1) if book-mode
  body
}

#let references(body) = {
  set text(size: 7.5pt, lang: "en", font: "Palatino Linotype")
  set par(first-line-indent: 0pt, leading: 9pt - 1em, spacing: 4pt)
  // 每个条目开头的「[KEY]」前放一个锚点，正文里的引用点了跳到这里
  // 解析后「[D91]」是三段文字：「[」「D91」「]」，也可能连成一段
  let kids = if body.has("children") { body.children } else { (body,) }
  let txt(k) = if k.func() == text { k.text } else { none }
  let start = true
  for (i, k) in kids.enumerate() {
    if k.func() == parbreak { start = true; k; continue }
    if k == [ ] { k; continue }
    if start {
      let key = none
      let t = txt(k)
      if t == "[" and i + 2 < kids.len() and txt(kids.at(i + 2)) == "]" {
        key = txt(kids.at(i + 1))
      } else if t != none {
        let m = t.match(regex("^\[(" + bibkey + ")\]"))
        if m != none { key = m.captures.at(0) }
      }
      if key != none and key.match(regex("^" + bibkey + "$")) != none [#metadata(key)<ostep-bib>]
    }
    start = false
    k
  }
}
