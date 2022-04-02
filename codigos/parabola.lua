require('symmath').setup()
local gnuplot = require 'gnuplot'

-- Definição da variável
local t = vars("t")

-- Definição da curva parametrizada.
-- Vamos tratar a curva como um vetor bidmensional alpha(t) = [x(t),y(t)]
local alpha = Array(t,t^2-2*t+5)

print(alpha)

-- Transformando para plot
local alphaPlot = symmath.export.GnuPlot(alpha)

print(alphaPlot)

-- Infelizmente, o export contém "{}" do vetor que o gnuplot não compreende, então vamos remove-los da string.

alphaPlot = string.sub(alphaPlot,2,#alphaPlot-1)

print(alphaPlot)

-- Traço da curva:

gnuplot({
    "set term svg", -- Define que a imagem exportada será uma 
    "set grid",
    "set parametric", -- Define o tipo de função como paramétrica
    "set trange [-10:10]", -- Define o intervalo de t.
    output="imgs/parabola.svg", -- Define o output
    {alphaPlot},
})

