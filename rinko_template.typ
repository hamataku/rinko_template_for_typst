#let mincho = ("Hiragino Mincho ProN", "Yu Mincho", "IPAexMincho", "Noto Serif CJK JP")
#let english = ("New Computer Modern", "Times New Roman")

#let rinko(
  day: [],
  title: [タイトル],
  titleSize: 14pt,
  etitle: [title],
  etitleSize: 11pt,
  supervisor: [指導教員],
  author: [著者],
  abstract: none,
  body
) = {
  set document(title: title)

  set page(
    paper: "a4",
    margin: (top: 20mm, bottom: 20mm, x: 15mm),
    numbering: "1",
  )
  set text(size: 10.5pt, cjk-latin-spacing: auto, font: mincho)

  set math.equation(numbering: "(1)")
  show math.equation: set block(spacing: 0.55em)

  show ref: it => {
    if it.element != none and it.element.func() == math.equation {
      link(it.element.location(), numbering(
        it.element.numbering,
        ..counter(math.equation).at(it.element.location())
      ))
    } else {
      it
    }
  }

  set enum(indent: 10pt, body-indent: 9pt)
  set list(indent: 10pt, body-indent: 9pt)

  set heading(numbering: "1.")
  show heading: it => locate(loc => {
    let levels = counter(heading).at(loc)
    let deepest = if levels != () {
      levels.last()
    } else {
      1
    }
    if it.level == 1 [
      #set par(first-line-indent: 0pt)
      #let is-ack = it.body in ([謝辞], [Acknowledgment], [Acknowledgement], [Appendix])
      #set text(14pt, weight: 600)
      #v(20pt, weak: true)
      #if it.numbering != none and not is-ack {
        numbering("1.", ..levels)
        h(8pt, weak: true)
      }
      #it.body
      #v(13.75pt, weak: true)
    ] else [
      #set par(first-line-indent: 0pt)
      #set text(12pt, weight: 600)
      #v(18pt, weak: true)
      #if it.numbering != none {
        numbering("1.", ..levels)
        h(8pt, weak: true)
      }
      #it.body
      #v(10pt, weak: true)
    ]
  })

  show figure.where(kind: table): set figure(supplement: [Table.], numbering: "1",)
  show figure.where(kind: image): set figure(supplement: [Fig.], numbering: "1")

  rect(width: 100%)[
    #columns(2)[
      #align(left, "電気系修士輪講資料")
      #colbreak()
      #align(right, day)
    ]
    #v(0.5cm)
    #align(center, strong(text(titleSize, title)))
    #v(-0.2cm)
    #align(center, text(etitleSize, etitle, font: english))
    #v(0.7cm)
    #columns(2)[
      #align(left, "指導教員: " + supervisor)
      #colbreak()
      #align(right, author)
    ]
  ]
  v(0.3cm)

  set par(leading: 0.55em, first-line-indent: 1em, justify: true)
  show par: set block(spacing: 0.55em)

  if abstract != none {
    align(center, strong("Abstract"))
    text(abstract, font: english, size: 11pt)
    v(1em, weak: false)
  }

  columns(2, gutter: 8mm)[
    #body
  ]
}

#let rinko_bib(bibfile) = {
  show bibliography: set text(9pt)
  show regex("[0-9a-zA-Z]"): set text(font: english)
  bibliography(bibfile, title: text(11pt)[参 考 文 献], style: "institute-of-electrical-and-electronics-engineers")
}