import Html exposing (text)

-- Considere uma turma de 50 alunos.
-- Cada aluno possui duas notas.
-- O aluno que ficou com média maior ou igual a sete é considerado aprovado.

-- Considere as seguintes definições em Elm para os tipos Aluno e Turma:

type alias Aluno = (String, Float, Float) -- Aluno é um tipo tupla com o nome e as duas notas
type alias Turma = List Aluno             -- Turma é um tipo lista de alunos

-- O nome ou a média de um aluno pode ser obtido através das seguintes funções:

media: Aluno -> Float
media (_,n1,n2) = (n1+n2)/2     -- o nome é ignorado

nome: Aluno -> String
nome (nm,_,_) = nm              -- as notas são ignoradas

-- Por fim, considere as assinaturas para as funções map, filter, e fold a seguir:

--List.map: (a->b) -> (List a) -> (List b)
  -- mapeia uma lista de a's para uma lista de b's com uma função de a para b

--List.filter: (a->Bool) -> (List a) -> (List a)
  -- filtra uma lista de a's para uma nova lista de a's com uma função de a para Bool

--List.foldl : (a->b->b) -> b -> List a -> b
  -- reduz uma lista de a's para um valor do tipo b
        -- usa um valor inicial do tipo b
        -- usa uma função de acumulacao que
            -- recebe um elemento da lista de a
            -- recebe o atual valor acumulado
            -- retorna um novo valor acumulado

-- Usando as definições acima, forneça a implementação para os três trechos marcados com <...>:

turma: Turma
turma = [ ("Joao",7,4), ("Maria",10,8) , ("Mauricio",10,9)]       -- 50 alunos

-- a) LISTA COM AS MÉDIAS DOS ALUNOS DE "turma" ([5.5, 9, ...])
medias: List Float
medias = List.map media turma

-- b) LISTA COM OS NOMES DOS ALUNOS DE "turma" APROVADOS (["Maria", ...])
mediaaprovada: Aluno -> Bool
mediaaprovadas = List.filter mediaaprovada turma

aprovados: List String
aprovados = List.map nome mediaaprovadas
-- c) MÉDIA FINAL DOS ALUNOS DE "turma" (média de todas as médias)

--Soma das medias da lista turma
lista_media_soma = List.foldr (+) 0.0 medias

--O tamanho da lista turma
size_turma: Float
size_turma = toFloat(List.length turma)

total: Float
total = lista_media_soma / size_turma


-- d) LISTA DE ALUNOS QUE GABARITARAM A P1 ([("Maria",10,8), ...])
gabarito: Aluno -> Bool
gabarito (_,n1,_) = n1 == 10
turma_gabarito = List.filter gabarito turma


-- e) LISTA COM OS NOMES E MEDIAS DOS ALUNOS APROVADOS ([("Maria",9), ...])

aluno_medias: Aluno -> (String,Float)
aluno_medias amp = (nome amp,media amp)

aprovados_nome_nota: List (String , Float)
aprovados_nome_nota = List.map aluno_medias mediaaprovadas

-- f) LISTA COM TODAS AS NOTAS DE TODAS AS PROVAS ([7,4,10,8,...])

notap1: Aluno -> Float
notap1 (_,n1,_) = n1
notap1s: List Float
notap1s = List.map notap1 turma


notap2: Aluno -> Float
notap2 (_,_,n2) = n2
notap2s: List Float
notap2s = List.map notap2 turma


lista_prova = List.map2 (,) notap1s notap2s

-- É permitido usar funções auxiliares, mas não é necessário.
-- (As soluções são pequenas.)
--main = text (toString medias)
--main = text (toString aprovados)
--main = text (toString total)
--main = text (toString turma_gabarito)
--main = text (toString aprovados_nome_nota)
main = text (toString lista_prova)
