#import "./rinko_template.typ": rinko, rinko_bib
#import "@preview/codelst:2.0.2": sourcecode

#show: rinko.with(
  day: [yyyy年mm月dd日],
  title: [typstで書く輪講資料のテンプレート],
  titleSize: 15pt,
  etitle: [A Template for Rinko Report in typst],
  etitleSize: 13pt,
  supervisor: [hoge 教授],
  author: [修士課程x年 xx-xxxxxx fuga],
  abstract: [This is a template for the Rinko report.],
)

= 序論
この文書は，typstを使用して東京大学電気系の輪講資料を作成するためのテンプレートです．typstはmarkdown likeな記法で文章を記述でき，またlatexよりも高速にコンパイルできるため，輪講資料の作成にオススメです．(というか個人的に布教したいだけです)

なお，このテンプレートは公式のものではなく，あくまで一個人が作成したものであるため，使用にあたっては自己責任でお願いします．


= 推奨環境
vscodeを使用できる場合は拡張機能を導入するだけで使用可能です．
- VSCode
- Python
  - 句読点，読点の変換にのみ使用するためtypstのコンパイルには直接関係ありません．
  - 使用するPCにインストールされていれば良いです．
- VSCode拡張機能
  - Tinymist typst
    - typstをコンパイルするための拡張機能です．
  - Run on Save
    - 保存時にこの拡張機能を用いてPythonを実行し，句読点，読点の変換を行います．
    - .vscode/settings.jsonとtransform_punctuations.pyで構成されています．

= 図の挿入
普通の図は以下の様に記述することで@fig:figure1 のように挿入されます．
#sourcecode[```typ
#figure(
placement: auto,
image("./image/typst_logo.png", width: 90%),
caption: [*The logo of typst.*],
)<fig:figure1>
```]

*placement*は*top*，*bottom*，*auto*のいずれかを指定可能で，*auto*を使用すると自動で上か下の近い方に配置されます．

#figure(
  placement: auto,
  image("./image/typst_logo.png", width: 90%),
  caption: [*The logo of typst.*],
)<fig:figure1>

また，typst 0.12.0からは*scope*を指定することで，@fig:figure2 のように複数カラムにまたがる形で図を挿入することが可能になりました．

#sourcecode[```typ
#figure(
scope: "parent",
placement: auto,
image("./image/typst_logo_sawaratsuki.svg", width: 60%),
caption: [*The logo of typst(sawaratsuki version).*],
)<fig:figure2>
```]

#figure(
  scope: "parent",
  placement: auto,
  image("./image/typst_logo_sawaratsuki.svg", width: 60%),
  caption: [*The logo of typst(sawaratsuki version).*],
)<fig:figure2>

= 数式の挿入
== 通常の数式
数式は以下の様に記述することで @eq:1 のように挿入されます．*この時，数式の前後には半角スペースを入れることに注意してください．*
#sourcecode[```typ
$ v_"mig" = v_"ref" u_"ref" $
```]

$ v_"mig" = v_"ref" u_"ref" $ <eq:1>

== インライン数式
インライン数式は以下の様に記述することで$v_"mig" = v_"ref" u_"ref"$ のように挿入されます．*数式の前後に半角スペースを入れない場合はインライン数式として挿入されます．*

#sourcecode[```typ
$v_"mig" = v_"ref" u_"ref"$
```]

== 参考数式

以下に参考程度の数式を記載しておきます．ちなみにtinymistの手書きシンボル検索機能が便利です．

$ bold(upright(v))_"coh,ij" = cases(
  c_"coh"(d_"ij" - d_"ref")(bold(upright(p)_j)-bold(upright(p))_i)/d_"ij" "if" d_"ij" > d_"ref",
  0 "                   otherwise",
) $

$ bold(accent(upright(v), ~))_i = bold(upright(v))_"mig" + bold(upright(v))_"coh,i" + bold(upright(v))_"rep,i" 
\+ bold(upright(v))_"fric,i" + sum_(m in M) bold(upright(v))_"obs,im" $

$ bold(upright(a))_i = bold(accent(upright(a), ~))_i/(||bold(accent(upright(a), ~))_i||) min(||bold(accent(upright(a), ~))_i||, a_"max") $

$ bold(upright(v))_"min" lt.eq bold(upright(v))_i (k+l|k) lt.eq bold(upright(v))_"max" $
$ d_"ij" (k+l|k)^2 gt.eq d_"agent-safety"^2 $
$ attach(min, b: bold(upright(X))(k)","bold(upright(U))(k)) sum_(i=1)^N (J_"prop,i" + J_"sep,i" + J_"dir,i" + J_"u,i") $

$ p_(x,0)(t) = a_(3,0) t^3 + a_(2,0) t^2 + a_(1,0) t + a_(0,0) $

$ upright(bold(c) = bold(M)^(-1) bold(b)) $

$ upright(bold(M) = mat(
  bold(F)_0, 0, 0, ..., 0;
  bold(E)_1, bold(F)_1, 0, ..., 0;
  0, bold(E)_2, bold(F)_2, ..., 0;
  dots.v, dots.v, dots.v, dots.down, dots.v;
  0, 0, 0, ..., bold(F)_(M-1);
  0, 0, 0, ..., bold(E)_M;
)) $

$ (diff cal(W))/(diff q_"i,j") = "Tr" {(bold(upright(M^(-1))) (diff bold(upright(b)))/(diff q_"i,j"))^T (diff cal(K))/(diff bold(upright(c)))} $

$ J_v (t) = ||accent(p, ".")_i (t) - v_p||_2^2 $

= 参照や引用
== 参照
```<fig:figure1>```のように参照したい項目にラベルを付与しておき，```@fig:figure1```のようにすることで参照することができます．図や表，数式，章などに対して参照することができます．

== 引用
bibtexを使用して文献を引用することができます．*references.bib*にbibtexで文献情報を記述し，以下の様に記述することで文献を引用できます@typst．

#sourcecode[```typ
～引用できます@typst．
```]

#rinko_bib("references.bib")