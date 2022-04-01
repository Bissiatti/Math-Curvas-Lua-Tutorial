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
local gplot = symmath.export.GnuPlot(g)

print(gplot)

local plotSymmath = {
    "set term svg", -- Define o tipo de imagem como svg (por padrão é png)
    "set grid", -- Imagem com grade
    "set xrange [-10:10]", -- Define o intervalo de x
    "set yrange [-25:100]", -- Define o itervalo de y
    output="imgs/plotSymmath.svg", -- Define o arquivo de saida
    {gplot} -- Table com a função para plot
}

gnuplot(plotSymmath)

-- Agora vamos desenhar alguns pontos usando gnuplot e a função em symmath

-- Primeiro transformar a função simbólica em função lua

local glua = g:compile({x})

-- Em seguida criar duas tables para armazenar as coordenadas dos pontos

local xpoints, ypoints = {}, {}

-- Agora vamos iterar para gerar pontos xs e seu respectivo valor em g(x)
for i = -10, 10, 0.5 do
    table.insert(xpoints,i) -- inserindo o valor de x_i
    table.insert(ypoints,glua(i)) -- inserindo o valor de y_i
end

-- Imprimindo do console um ponto de exemplo
print("x="..xpoints[1],"y="..ypoints[1])

-- Unindo os dados em uma única tabela

local points = {xpoints,ypoints}

-- Imprimindo os pontos com gnuplot

local toPlot = {
    "set term svg", -- Define o tipo de imagem como svg (por padrão é png)
    "set grid", -- Imagem com grade
    "set xrange [-10:10]", -- Define o intervalo de x
    "set yrange [-25:100]", -- Define o itervalo de y
    output="imgs/points.svg", -- Define o arquivo de saida
	data = points, -- Table com os dados 
	{using = '1:2'}, -- Define o que cada coluna dos dados representa
}
gnuplot(toPlot)