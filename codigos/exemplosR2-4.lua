local gnuplot = require 'gnuplot'
require('symmath').setup()

require("curvaFuncoes")

local t = vars("t")

local e = Array(cos(t/3),sin(t/3)*cos(t/3))

-- Exportando para latex
-- print(symmath.export.LaTeX(e))
-- print(symmath.export.LaTeX(ComprimentoDeArco(e)))

-- e2 é a curva reparametrizada
-- local e2 = Reparametrizacao(e)

-- print(symmath.export.LaTeX(e2))

local ePlot = Array2GnuPlotR2(e)

-- Criando vetores alpha'(t) e alpha''(t) 
local x0,y0,x1,y1={},{},{},{}
local ed = e:diff(t)()
local edd = ed:diff(t)()
local eFunc = e:compile({t})
ed = ed:compile({t})
edd = edd:compile({t})


for i = 0, 24, 2 do
    local p0 = eFunc(i)
    table.insert(x0,p0[1])
    table.insert(y0,p0[2])
    local p1 = ed(i)
    table.insert(x1,p1[1])
    table.insert(y1,p1[2])
    
    table.insert(x0,p0[1])
    table.insert(y0,p0[2])
    local p2 = edd(i)
    table.insert(x1,p2[1])
    table.insert(y1,p2[2])

end

local toPlot = {
	--persist = true,
    "set term svg",
    "set grid",
    "set parametric",
    "set trange [-4*pi:4*pi]",
    "set xrange [-1.5:1.5]",
    "set yrange [-1.5:1.5]",
    output="imgs/curva-4.svg",
    {ePlot},
    style = 'data vector',
	data = {
		x0,
		y0,
		x1,
		y1,
	},
	{using = '1:2:3:4'},
}

gnuplot(toPlot)