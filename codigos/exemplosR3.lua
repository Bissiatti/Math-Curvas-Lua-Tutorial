local gnuplot = require 'gnuplot'
require('symmath').setup()
require("curvaFuncoes")

local u = var("u")
local f = Array(sin(u),cos(u),u)

local triedro = TriedroFrenet(f,u)

-- Obter informações da curva no terminal
print(f)
print(CurvaturaR3(f,u))
print(TorcaoR3(f,u))
print(triedro)
-- Obter saida em LaTex
-- print(symmath.export.LaTeX(f))
-- print(symmath.export.LaTeX(CurvaturaR3(f,u)))
-- print(symmath.export.LaTeX(TorcaoR3(f,u)))

-- criar o triedo em um ponto

local t0 = 2
local funcF,code1 = f:compile({u})
local funcTriedo,code2 = triedro:compile({u})

-- print(code1)
-- print(code2)

local p0Triedo = funcTriedo(t0)
local p0 = funcF(t0)
x0 = {p0[1],p0[1],p0[1]}
y0 = {p0[2],p0[2],p0[2]}
z0 = {p0[3],p0[3],p0[3]}

x1 = {p0Triedo[1][1],p0Triedo[1][2],p0Triedo[1][3]}
y1 = {p0Triedo[2][1],p0Triedo[2][2],p0Triedo[1][3]}
z1 = {p0Triedo[3][1],p0Triedo[3][2],p0Triedo[3][3]}

-- Exportar traço da curva como svg
local exp = Array2GnuPlotR3(f)
local toPlot = {
	--persist = true,
    "set term svg",
    "set grid",
    "set parametric",
    output="imgs/3d.svg",
    {splot=true,exp},
    style = 'data vector',
	data = {
		x0,
		y0,
        z0,
		x1,
		y1,
        z1,
	},
	{splot=true,using = '1:2:3:4:5:6'},
}
gnuplot(toPlot)