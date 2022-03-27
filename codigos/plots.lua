require('symmath').setup()
local gnuplot = require 'gnuplot'

local x,y = vars("x","y")

-- Plot de uma função em R^2
local plotStr = {
    "set term svg", -- Define o tipo de imagem como svg (por padrão é png)
    "set grid", -- Imagem com grade
    "set xrange [-pi:pi]", -- Define o intervalo de x
    "set yrange [-pi:pi]", -- Define o itervalo de y
    output="imgs/plotStr.svg", -- Define o arquivo de saida
    {"sin(x)"} -- Table com a função que queremos imprimir em string
}

-- Para gerar o gráfico basta passar para o gnuplot a table com os parâmetros de plot
gnuplot(plotStr)


local g = x^2-2*x+5

print(g)

-- Para transformar em uma string para o GnuPlot basta exportar como tal
g = symmath.export.GnuPlot(g)

print(g)

local plotSymmath = {
    "set term svg", -- Define o tipo de imagem como svg (por padrão é png)
    "set grid", -- Imagem com grade
    "set xrange [-10:10]", -- Define o intervalo de x
    "set yrange [-25:100]", -- Define o itervalo de y
    output="imgs/plotSymmath.svg", -- Define o arquivo de saida
    {g} -- Table com a função esper
}

gnuplot(plotSymmath)