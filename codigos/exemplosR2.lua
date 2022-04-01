local gnuplot = require 'gnuplot'
require('symmath').setup()

require("curvaFuncoes")

local t = vars("t")

local e = Array(5*cos(t),5*sin(t))

-- Exportando para latex
-- print(symmath.export.LaTeX(e))
-- print(symmath.export.LaTeX(ComprimentoDeArco(e)))

-- e2 é a curva reparametrizada
local e2 = Reparametrizacao(e)

-- print(symmath.export.LaTeX(e2))

local ePlot = Array2GnuPlotR2(e)
local ePlot2 = Array2GnuPlotR2(e2)

-- Criando vetores alpha'(t) e alpha''(t) 
local x0,y0,x1,y1={},{},{},{}
local ed = e:diff(t)()
local edd = ed:diff(t)()
local eFunc = e:compile({t})
ed = ed:compile({t})
edd = edd:compile({t})


for i = 0, 6.30, 0.5 do
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
    "set trange [-pi:pi]",
    "set xrange [-8:8]",
    "set yrange [-8:8]",
    output="imgs/curva1.svg",
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

-- Criando vetores alpha'(t) e alpha''(t) 
x0,y0,x1,y1={},{},{},{}

local ed2 = e2:diff(t)()
local edd2 = ed2:diff(t)()
local eFunc2 = e2:compile({t})
ed2 =  ed2:compile({t})
edd2 = edd2:compile({t})


for i = 0, 2*math.pi*5, 2 do
    local p0 = eFunc2(i)
    table.insert(x0,p0[1])
    table.insert(y0,p0[2])
    local p1 = ed2(i)
    table.insert(x1,p1[1])
    table.insert(y1,p1[2])
    
    table.insert(x0,p0[1])
    table.insert(y0,p0[2])
    local p2 = edd2(i)
    table.insert(x1,p2[1])
    table.insert(y1,p2[2])
end


local toPlot = {
	--persist = true,
    "set term svg",
    "set grid",
    "set parametric",
    "set trange [-pi*5:pi*5]",
    "set xrange [-8:8]",
    "set yrange [-8:8]",
    output="imgs/curva2.svg",
    {ePlot2},
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
