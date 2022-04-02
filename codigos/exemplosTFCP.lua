local gnuplot = require 'gnuplot'
require('symmath').setup()

require("curvaFuncoes")

local curvatura = 0

local curva = CurvaDeCurvaturaR2(curvatura)

print(curva)

print(symmath.export.LaTeX(curva))

curva = Array2GnuPlotR2(curva)


-- Plot

local toPlot = {
	--persist = true,
    "set term svg",
    "set grid",
    "set parametric",
    "set trange [-1:1]",
    output="imgs/curvatura-1.svg",
    {curva},
}

gnuplot(toPlot)
