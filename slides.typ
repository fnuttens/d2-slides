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
    logo: image("./assets/d2logo.svg"),
  ),
  config-common(show-notes-on-second-screen: right),
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

#grid(
  columns: 3,
  column-gutter: 148pt,
  row-gutter: 16pt,
  align: center,
  grid.cell(image("./assets/enterprise-architect.png")),
  grid.cell(image("./assets/powerdesigner.png")),
  grid.cell(image("./assets/visual-paradigm.png")),
  grid.cell(image("./assets/excalidraw.png")),
  grid.cell(image("./assets/ms-visio.png")),
  grid.cell(image("./assets/yed.png")),
)

#speaker-note[
  GUI classique avec disposition manuelle des éléments
  - utilisation intensive de la souris (cliquer-glisser)
  Exemples :
  - Enterprise Architect
  - Powerdesigner
  - Visual Paradigm
  - Excalidraw
  - MS Visio
  - yEd
]

---

#figure(
  image("assets/visual-paradigm-bpmn.png"),
  caption: [Modélisation BPMN avec Visual Paradigm],
  numbering: none,
)

---

#figure(
  image("assets/asciiflow.png"),
  caption: [Bonus : ASCIIFlow],
  numbering: none,
)

#speaker-note[
  - On commence à entrer au royaume des nerds
  - Placement toujours manuel mais export au bête format `.txt`
  - Approche utilisée dans les RFCs de l’IETF
]

== Langage déclaratif

#grid(
  columns: 2,
  align: center,
  grid.cell(image("assets/graphviz.png")),
  grid.cell(image("assets/plantuml.png")),
  grid.cell(image("assets/mermaid.svg", width: 45%)),
  grid.cell(image("assets/d2logo.svg", width: 45%)),
)

#speaker-note[
  aka *_Diagram as code_*

  Objectifs :
  - décrire l’ensemble du diag au format texte
  - placement automatique des éléments (layout engine)

  Exemples :
  - GraphViz (1991)
  - PlantUML (2009)
  - MermaidJS (2014)
  - D2 (2022)
]

#slide[
  Diagramme de flux avec Mermaid :
  ```mermaid
  flowchart TD
    Christmas -->|Get money| B(Go shopping)
    B --> C{Let me think}
    C -->|One| D[Laptop]
    C -->|Two| E[iPhone]
    C -->|Three| F[fa:fa-car Car]
  ```
][
  #image("assets/mermaid-shopping.png")
]

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
  - source de distraction

  #speaker-note[
    - On reparlera plus tard des moteurs de layout
    Distraction :
    - _WYSIWYG_ – le design du diagramme prend le pas sur le design du système
    - _Déclaratif_ – un dev peut se « perdre » dans le langage
  ]
][
  #meanwhile
  Langage déclaratif
  #pause
  #set list(marker: [✓])
  - layout auto-généré
  - facilement versionnable
  - maintenance aisée
  - motivant
  #pause
  #set list(marker: [𐄂])
  - médiocrité des moteurs de layout
  - offre réduite et peu maintenue
  - parfois source de distraction
]

---

Historiquement :
- faible complexité et/ou esthétique secondaire → *déclaratif*
- forte complexité et/ou esthétique soignée → *WYSIWYG*

#speaker-note[
  - diagramme de séquence paiement CB → déclaratif
  - schéma d’architecture APPP présenté lors d’un audit → WYSIWYG 
]

#focus-slide[
  Il n’y a pas de mauvaise approche, que des mauvais choix.
]

= D2

== _New kid on the block_

#slide[
  - _#strong[D]eclarative #strong[D]iagramming_
  - rendu public en 2022
  - codé en Go
  - langage déclaratif du même nom
][
  #figure(
    image("assets/d2logo.svg", width: 40%),
    caption: [Logo de D2],
    numbering: none,
  )
]

== Choix de conception

$ "Lisibilité" > "Concision" $

Mermaid :
```mermaid
A[(Christmas)]
```

#pause

D2 :
```d2
A: Christmas {shape: cylinder}
```

#speaker-note[
  - D2 est verbeux au profit d’une meilleure lisibilité
  - Petit jeu : que va rendre ce bout de code Mermaid ?
  - Mermaid est très concis mais parfois cryptique…
]

---

$ "Design du système" > "Design du diagramme" $

- Joli par défaut
  - _opinionated_
- Séparation claire entre éléments du diagramme et style
  - classes à la HTML/CSS
  - fichier de style séparé

#speaker-note[
  - Inutile de configurer 1000 choses pour avoir un beau diagramme
    - inconvénient : D2 a sa propre idée de ce que « beau » signifie (_opinionated_)
]

== Exemple

#slide[
  christmas.d2
  ```d2
  ...@styles

  Christmas.class: [emphasis; hohoho]
  Go: Go shopping
  LMT: Let me think {class: alt}
  Car.icon: https://...car.png

  Christmas -> Go: Get money
  Go -> LMT
  LMT -> Laptop: One
  LMT -> iPhone: Two
  LMT -> Car: Three
  ```
][
  styles.d2
  ```d2
  classes: {
  	hohoho: {
  		style: {
  			fill: "linear-gradient(#2f7336, #aa3a38)"
  		}
  	}

  	alt: {
  		shape: diamond
  		style: {
  			stroke: "#f4a261"
  		}
  	}
  }
  ```

  #speaker-note[
    - Ligne de styles omises pour l’exemple
    - La déclaration du diagramme reste lisible
  ]
]

#figure(image("samples/christmas.svg", width: 44%))

== Applications possibles

- Thèmes (`ei.d2`, `lyf.d2`, etc.)
- Séparation modèle / vue
- etc.

#speaker-note[
  - diagrammes réutilisables dans différents contextes
  - gain de temps
  - favorise le partage de la documentation
]

== De nombreuses fonctionnalités

- Composition / Animation
- Support blocs de code et Markdown
- Diagramme spéciaux (ERD, classes, séquence, grille)

À découvrir sur #link("https://d2lang.com/tour")[*d2lang.com/tour*]

#speaker-note[
  - Composition : publier PDF navigable à partir des diagrammes pour présenter ensemble d’un système
  - Animation : mouvement lignes pointillés, alternance entre N scénarii dans un seul digramme, etc.
]

#focus-slide[
  _The lack of ability to spacially architect a system should not block the creation of valuable documentation._

  #speaker-note[
    - Terrastruct aurait pu se contenter de proposer une alternative au moins aussi bien que Mermaid
    - Leur modèle économique _open core_ s’appuie en partie sur un _layout engine_ révolutionnaire
  ]
]

= TALA

== _Layout engine?_

- Logiciel responsable de la bonne disposition spaciale des éléments
- _Nerf de la guerre_ de l’approche déclarative
- Exemples connus : *Dagre*, *ELK*

#speaker-note[
  - Grosso modo ce qui permet de lâcher la souris et de gagner du temps
]

= Conclusion

== _I use Typst, btw_

- Alternative à LaTeX prometteuse
- Modèle _open core_ avec éditeur Web collaboratif
- Communauté active partageant modèles et extensions
- Écrit en Rust 🦀
- Plus d’infos sur #link("https://typst.app/")[*typst.app*]

#speaker-note[
  - LaTeX ou Word, sur la même opposition _code_/_WYSIWYG_
  - Extension utilisée pour écrire cette présentation : Touying
]

== Meme de circonstance

#image("assets/meme.jpg", width: 100%)

#focus-slide[
  _That’s all, folks!_
]
