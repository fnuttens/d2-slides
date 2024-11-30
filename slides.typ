#import "@preview/touying:0.5.3": *
#import themes.metropolis: *

#show: metropolis-theme.with(
  aspect-ratio: "16-9",
  config-info(
    title: [D2],
    subtitle: [aka Mermaid on steroids],
    date: datetime(
      year: 2024,
      month: 12,
      day: 19,
    ),
    logo: image("d2logo.svg"),
  )
)

#set text(font: "Fira Sans", weight: "light", size: 20pt)
#set strong(delta: 100)
#set par(justify: true)

#set heading(numbering: "1.1")
#show heading.where(level: 1): set heading(numbering: "1.")

#title-slide()

= Sommaire <touying:hidden>

#show outline.entry: it => {
  it.body
}
#outline(title: none, indent: 1em, depth: 1)

= État de l’art

== WYSIWYG

== Diagram as code

== Que choisir ?

#slide[
  WYSIWYG
  #pause
  #set list(marker: [✓])
  - layout précis et soigné
  - facile à prendre en main
  - accessible à tous·tes
  #pause
  #set list(marker: [𐄂])
  - chronophage
  - modification coûteuse
  - complexité du format de données
][
  #meanwhile
  Diagram as code
  #pause
  #set list(marker: [✓])
  - layout auto-généré
  - facilement versionnable
  - maintenance aisée
  #pause
  #set list(marker: [𐄂])
  - médiocrité des moteurs de layout
  - offre réduite et peu maintenue
  - parfois source de distraction
]

#focus-slide[
  Il n’y a pas de mauvaise approche, que des mauvais choix.
]

= New kid on the block

#focus-slide[
  _The lack of ability to spacially architect a system should not block the creation of valuable documentation._
]
