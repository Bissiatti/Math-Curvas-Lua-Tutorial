# Tutorial: Como desenhar curvas matemáticas em lua a partir da curvatura.

## Emanuel Bissiatti de Almeida

O tutorial foi testado no Ubuntu e também funciona no Windows com Ubuntu/WSL (mas no Windows é preciso usar uma gambiara para abrir imagens pelo WSL com esse [tutorial](https://techcommunity.microsoft.com/t5/windows-dev-appconsult/running-wsl-gui-apps-on-windows-10/ba-p/1493242))

## Requisitos

Para esse tutorial é preciso instalar as seguintes linguagens e programas


* [Linguagem de programação brasileira Lua,](https://www.lua.org/)
* [GnuPlot para desenhar os gráficos das funções matemáticas,](http://www.gnuplot.info/)
* [luarocks um gerenciador de pacotes para lua.](https://luarocks.org/)

Baixe também as seguintes bibliotecas para lua nesta ordem:

* [ext.lua,](https://github.com/thenumbernine/lua-ext)
* [lua gnuplot,](https://github.com/thenumbernine/lua-gnuplot)
* [lua symmath.](https://github.com/thenumbernine/symmath-lua)

Para instalar as bibliotecas, após baixar os arquivos para uma pasta qualquer, descompacte cada biblioteca em uma pasta separada, vá para o diretório em que foi descompactado os arquivos e execute o comando:

```bash
luarocks make
```

## Hello World em Lua

Lua possuiu uma sintaxe simples e familiar principalmente para quem já conhece MatLab e Python. Veja alguns conceitos básicos:

### Comentários

```lua
-- Isso é um comentário em lua
```

### Print e Hello World

```lua
-- Veja um Hello World

print("Hello World")

-- Assim também é válido

print "Hello World"
```

### Tipos de dados

Em lua temos os seguintes tipos de dados primitivos, qualquer dúvida recomendo a consulta ao [manual oficial da linguagem](https://www.lua.org/manual/5.1/pt/manual.html), disponível em português.

* 1	
nil

Usado para diferenciar o valor de ter alguns dados ou nenhum dado (nulo).

* 2	
boolean

Inclui verdadeiro e falso como valores. Geralmente usado para verificação de condições.

* 3	
number

Representa números reais (ponto flutuante de precisão dupla).

* 4	
string

Representa matriz de caracteres.

* 5	
function

Representa um método escrito em C ou Lua.

* 6	
userdata

Representa dados C arbitrários.

* 7	
thread

Representa threads de execução independentes e é usado para implementar co-rotinas.

* 8	
table

Representa matrizes comuns, tabelas de símbolos, conjuntos, registros, gráficos, árvores, etc., e implementa matrizes associativas. Ele pode conter qualquer valor (exceto nulo).

Fonte [ Manual de Referência de Lua 5.1](https://www.lua.org/manual/5.1/pt/manual.html)


### Definição de variáveis e funções

Em lua todas as definições inclusive dentro de funções são globais, inclusive se carregar o arquivo para outro código lua. Por isso recomenda-se definir as variáveis como locais.

```lua
-- Isso é uma variável global

a = 1

-- Isso é uma variável local

local b = 0

-- Funções também são definidas globalmente
function f(arg)
    return arg
end

-- Serão locais se definir como uma função local:

local function f2(arg)
    c = arg
end

-- Como c é global, posso imprimir o valor de c após executar a função.

f2(10)

print(c)
```

### Condições

Similar ao matlab, temos a seguinte estrutura condicional em lua:

```lua
local x = true
if x then
    print("essa expressão é verdadeira")
    print("\n")
end

-- Em lua utilizamos as palavras especiais 'and', 'or' e 'not' para trabalhar com operadores lógicos

local y = -1

if not x then
    print("Essa mensagem não vai aparecer")
elseif x and y >0
    print("X é verdadeiro, mas como y<0, isso aqui nunca vai acontecer")
else
    print("Essa mensagem é esperada, tudo acima é falso.")
end

```

### Tables e for em tables

As tabelas são uma estrutura de dados muito útil em lua, capaz de armazenar qualquer tipo de dados em uma estrutura que lembra um dicionário python, porém com algumas propriedades a mais com a capacidade de trabalhar como um vetor.

```lua

-- Para definir uma table utiliza "{}"
local myTable = {a,b,c}

-- Atente que em lua começamos a contar os elementos de uma table a partir do 1

print(myTable[1]) -- imprime a

-- Caso um índice de uma table não possuiu um elemento, vai retornar nil

print(myTable[0]) -- imprime nil


-- Podemos adicionar e modificar elementos passando um índice e o valor desejado

myTable[1] = 10

-- É possível utilizar tanto índices inteiros como strings:

myTable["t1"] = 1

-- Se preferir use:

myTable.t2 = 2

-- O índice inteiro não precisa coincidir com o números de elementos da tabela

myTable[7] = 77

-- O interpretador vai automaticamente preencher os valores entre os índices que estão vazios com nil


-- Para fazer um for sobre o vetor use:

for key, value in pairs(myTable) do
    print(key,value)
end

```

Saída:

```bash 
1       10
2       b
3       c
7       77
t2      2
t1      1
```
Também é possível iterar apenas pelos indices numéricos, como se fosse uma lista.
```lua
for index, value in pairs(myTable) do
    print(index,value)
end
```

Entretanto, esse método termina no primeiro índice nulo, o 7 índice não foi iterado, veja:

```bash 
1       10
2       b
3       c
```

### Iteradores

Já vimos como iterar sobre uma table, veja outras formas de iterações conhecidas:


```lua
-- No for, primeiro determina a variável de iteração com o seu valor final,
-- em seguida o valor final e por fim o valor que será acrescentado a cada iteração.
for i=0,3,0.5 do
    print(i)
end
```
Veja a saída
```bash
0.0
0.5
1.0
1.5
2.0
2.5
3.0
```
```lua
-- O While segue a mesma lógica de outras linguagens, veja a sintaxe.
while true do
    if true then
        break
    end
end
```
