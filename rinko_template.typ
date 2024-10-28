// utokyo eeis rinko template created by hamataku 2024/10/28

#let ja_fonts = ("Hiragino Mincho ProN", "Yu Mincho")
#let en_fonts = ("Times New Roman", "Georgia")

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
  // PDFメタデータ設定
  set document(title: title)

  // ページ設定
  set page(
    paper: "a4",
    margin: (top: 20mm, bottom: 20mm, x: 15mm),
    numbering: "1",
  )
  
  // 文書フォント設定
  set text(size: 10.5pt, cjk-latin-spacing: auto, font: ja_fonts, lang: "ja")

  // 段落設定
  set par(leading: 0.55em, first-line-indent: 1em, justify: true)
  // ブロックの間隔設定
  show par: set block(spacing: 0.55em)

  // 数式設定
  set math.equation(numbering: "(1)", supplement: [式])

  // 箇条書き設定
  set enum(indent: 10pt, body-indent: 9pt)
  set list(indent: 10pt, body-indent: 9pt)

  // 図表設定
  // Tableの時はCaptionの位置を上に設定
  show figure.where(
    kind: table
  ): set figure.caption(position: top)
  // TableはTable.n，ImageはFig.nで表示
  show figure.where(kind: table): set figure(supplement: [Table.], numbering: "1",)
  show figure.where(kind: image): set figure(supplement: [Fig.], numbering: "1")

  // 見出し設定
  set heading(numbering: "1.") // ナンバリング
  show heading: it => locate(loc => {
    let levels = counter(heading).at(loc)
    let deepest = if levels != () {
      levels.last()
    } else {
      1
    }
    if it.level == 1 {
      // 見出し1
      set par(first-line-indent: 0pt) // インデント0pt
      set text(14pt, weight: 600)
      let is-ack = it.body in ([謝辞], [Acknowledgment], [Acknowledgement], [Appendix])
      v(20pt, weak: true) // 見出し上部の余白
      if it.numbering != none and not is-ack {
        // is-ackの場合
        numbering("1.", ..levels)
        h(8pt, weak: true)
      }
      it.body
      v(13.5pt, weak: true) // 見出し下部の余白
     } else {
      // 見出し2以降
      set par(first-line-indent: 0pt)
      set text(12pt, weight: 600)
      v(15pt, weak: true) // 見出し上部の余白
      if it.numbering != none {
        numbering("1.", ..levels)
        h(8pt, weak: true)
      }
      it.body
      v(10pt, weak: true) // 見出し下部の余白
     }
  })

  // タイトル表示
  rect(width: 100%)[
    #columns(2)[
      #align(left, "電気系修士輪講資料")
      #colbreak()
      #align(right, day)
    ]
    #v(0.5cm)
    #align(center, strong(text(titleSize, title)))
    #v(-0.2cm)
    #align(center, text(etitleSize, etitle, font: en_fonts))
    #v(0.7cm)
    #columns(2)[
      #align(left, "指導教員: " + supervisor)
      #colbreak()
      #align(right, author)
    ]
  ]
  v(0.3cm)

  // Abstractがある場合は表示
  if abstract != none {
    align(center, strong("Abstract"))
    text(abstract, size: 12pt, font: en_fonts)
    v(1em, weak: false)
  }

  // 本文
  columns(2, gutter: 8mm)[
    #body
  ]
}

// 参考文献テンプレート
#let rinko_bib(bibfile) = {
  show bibliography: set text(9pt)
  show regex("[0-9a-zA-Z]"): set text(font: en_fonts)
  bibliography(bibfile, title: text(11pt)[参 考 文 献], style: "institute-of-electrical-and-electronics-engineers")
}