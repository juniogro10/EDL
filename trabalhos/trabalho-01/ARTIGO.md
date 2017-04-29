(Não é necessário seguir a estrutura a seguir...)

# Introdução
Atualmente existe uma infinidade de linguagens de programação no mercado, mas nada tão resistente ao tempo e aos avanços tecnológicos como o COBOL.  
Cobol na realidade é uma sigla, **CO**mmon **B**usiness **O**riented **L**anguage (Linguagem Orientada a Negócios).  
# Origens e Influências

Foi criada no ano de 1959, durante uma conferência, entre o governo americano e algumas empresas de tecnologia de ponta, para a época.

COBOL foi desenvolvido em uma parceria entre sete grandes fabricantes de computadores e o governo dos EUA (incluindo os militares) para fornecer uma linguagem padrão em diferentes tipos de hardware, especificamente para a programação de negócios.
Além disso programas em cobol estão em uso globalmente em empresas comercias e estão sendo 
executados em sistemas operacionais como o da IBM z/OS e z/VSE, as famílias POSIX (Unix / Linux, etc) e Windows da Microsoft, bem como Unisys OS 2200. Em 1997, o Gartner Group relatou que 80% dos negócios do mundo rodavam em COBOL com mais de 200 bilhões de linhas de código existentes e cerca de 5 bilhões de linhas de código novo por ano.

Não haviam outras linguagens naquela época que funcionavam desta forma para fins comerciais. (cada fabricante tinha sistemas de programação específicos para os suas linhas de máquinas, muitas vezes diferentes, mesmo entre suas próprias máquinas)
Foi inspirada em grande parte pela linguagem FLOW-MATIC criada por Grace Hopper e pela linguagem COMTRAN da IBM criada por Bob Bemer.
O COBOL foi desenvolvido num período de seis meses e, mais de 40 anos depois, ainda é muito utilizada.








# Classificação
* **Permite tipagem Forte e estática** : O programador utiliza recurso de tipagem estática. Ao contrário do que acontece no **PHP**, pode-se declarar uma variável inteira da seguinte forma:

```
01 WS-CLASS   PIC 9(2)  VALUE  '10'.
```
Descrição do comando acima:

Comando         | Significado             
-----------|------------------------------------
 01        | Descrição do Registro entrada      
 WS-CLASS  | Nome da variável                   
 PIC 9 (2) | Nomeclatura de uma variável do tipo inteiro com 2 posições
 Value     | Inserindo o valor 10 na variável   


* **Abstração** : COBOL não dá suporte, logo, não tem como avaliar.
# Avaliação Comparativa

* Expressividade em relação ao Php ,a linguagem cobol oferece uma série de dificuldade para programadores.Na leitura e na escrita não é expressivo pois a forma de escrever é rígida e não é intuitiva.Veja a seguir o código comparando as duas linguagens:

Em **Php**:
```
$count = 1;

while($count < 10) 
{
echo ‘Count :’ . $count;	
$count+=1;
}
```
Agora sendo feito em **Cobol** :
```
01 COUNT PIC 9(2)  VALUE  '1'.

PROCEDURE DIVISION.
   A-PARA.
   PERFORM B-PARA WITH TEST AFTER UNTIL COUNT>9.
   STOP RUN.
   
   B-PARA.
   DISPLAY 'COUNT: 'COUNT.
   ADD 1 TO COUNT.
```

Para o indexador de um tabela em cobol , o indexador não pode ser inicializada por 0.

Resultado da interações acima :

```
Count :1
Count :2
Count :3
Count :4
Count :5
Count :6
Count :7
Count :8
Count :9
```
Sendo assim **PHP** é muito mais  prático a leitura do que o **COBOL**. 

# Conclusão

Tradicionalmente a COBOL é uma linguagem simples, com alcance limitado da função (sem ponteiros, sem tipos definidos pelo usuário e sem funções definidas pelo usuário) estimulando um estilo de codificação simples. Isso fez com que seja bem adequada ao seu domínio principal de computação de negócios, onde a complexidade do programa encontra-se em regras de negócio que precisam ser codificados em vez de sofisticados algoritmos e estruturas de dados.
Porém a leitura da linguagem é complexa, não é possível saber o que o programa está fazendo sem ter uma grande prática com a linguagem e conhecimento da documentação.
Somente um bom conhecimento da documentação não basta, ainda sim é difícil escrever o código pois são muito detalhes a lembrar. 



# Bibliografia

* Cobol Wikipédia - https://pt.wikipedia.org/wiki/COBOL
* Cobol Ainda esta viva DevMedia - http://www.devmedia.com.br/cobol-uma-linguagem-que-ainda-esta-viva/24585
* Cobol Point - https://www.tutorialspoint.com/pg/cobol/cobol_data_types.htm
* Linguagem Cobol 1959 - https://sites.google.com/site/linguagemcobol1959/home





