Mihael Scofield de Azevedo — GRR 20182621

USO: Para criar a base usa-se:

$ ruby criaTabelas.rb

EXPLICAÇÃO:

Consegui criar as tabelas dentro do database principal e fiz um sistema de CRUD para preencher as tabelas que está funcionando na interação
Infelizmente ao popula-los tive dificuldade com a síntaxe e não consegui finalizar a tempo.

CONTEÚDO:
criaTabelas.rb — Gera as três tabelas principais em um database único.
crud.rb — Faz a interação com o usuário, de acordo com as especificações do trabalho. O Script roda enquanto você não cancela-lo.
populaTabelas.rb — Faz a geração dos dados "básicos" nas tabelas.

personagem.rb — Cada personagem pode possuir nome, sobrenome, algo que ele ama e algo que ele odeia. 
Além disso pode ser atribuido a ele itens (muitos para muitos) e uma filiação única (um para muitos).

filiacao.rb — Tabelas com as ideologias dos personagens (exemplo: Jedi, Rebelde, Império, Sith, Mercenário).
Cada filiação pode ter vários personagens.

itens.rb — Cada personagem pode possuir até 3 itens, sendo nave, sabre de luz e pistola.
Cada conjunto de itens pode ser atribuido a um personagem, entretanto os itens podem ser repetidos (exemplo: nave — Millenium Falcon)

