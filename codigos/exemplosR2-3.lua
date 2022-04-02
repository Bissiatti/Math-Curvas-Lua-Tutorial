local gnuplot = require 'gnuplot'
require('symmath').setup()

require("curvaFuncoes")

local t = vars("t")

--local e = Array(t^2*sin(t),t^2*cos(t)+3)
--local e = Array(t,t^(2/3)+(0.9*(3.3-t^2)^(0.5))*sin(1*pi*t))

local e =  Array(cos(t),sin(t)*cos(t))
-- informações da curva
print(e)
print((ComprimentoDeArco(e)))
print((CurvaturaR2(e,t)))


-- Exportando para latex
print(symmath.export.LaTeX(e))
--print(symmath.export.LaTeX(ComprimentoDeArco(e)))
--print(symmath.export.LaTeX(CurvaturaR2(e,t)))

-- Plot

local ePlot = Array2GnuPlotR2(e,t)


local toPlot = {
	--persist = true,
    "set term svg",
    "set grid",
    "set parametric",
    "set trange [-pi:pi]",
    "set xrange [-1.5:1.5]",
    "set yrange [-1.5:1.5]",
    output="imgs/curva-2.svg",
    {ePlot},
}

gnuplot(toPlot)
