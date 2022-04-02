local gnuplot = require 'gnuplot'
require('symmath').setup()

require("curvaFuncoes")

local t = vars("t")


local alpha = Array(cos(t)*2,sin(t)*2)

print(alpha)
print(symmath.export.LaTeX(alpha))

local curvatura = CurvaturaR2(alpha)

alpha = Array2GnuPlotR2(alpha)

print(curvatura)
print(symmath.export.LaTeX(curvatura))

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
    "set trange [-pi:pi]",
    output="imgs/curvatura-2.svg",
    {alpha},
}

gnuplot(toPlot)


local toPlot = {
	--persist = true,
    "set term svg",
    "set grid",
    "set parametric",
    "set trange [-2*pi:2*pi]",
    output="imgs/curvatura-3.svg",
    {curva},
}

gnuplot(toPlot)
