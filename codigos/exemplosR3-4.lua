local gnuplot = require 'gnuplot'
require('symmath').setup()
require("curvaFuncoes")

local u = var("u")
local f = Array(1/(u)*cos(u), 1/(u)*sin(u),u)

-- Obter informações da curva no terminal
-- print(f)
-- print(CurvaturaR3(f,u))
-- print(TorcaoR3(f,u))
-- print(triedro)

-- Obter saida em LaTex
print(symmath.export.LaTeX(f))
print(symmath.export.LaTeX(CurvaturaR3(f,u)))
print(symmath.export.LaTeX(TorcaoR3(f,u)))

-- Exportar traço da curva como svg
local exp = Array2GnuPlotR3(f)
local toPlot = {
	--persist = true,
    "set term svg",
    "set grid",
    "set parametric",
    "set trange [0:10]",
    output="imgs/3d-4.svg",
    {splot=true,exp},
}
gnuplot(toPlot)