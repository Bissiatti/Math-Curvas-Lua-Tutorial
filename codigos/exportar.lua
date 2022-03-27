require('symmath').setup()

local x,y,t = vars("x","y","t")

-- Definindo uma função qualquer
local f = x*sin(x)+x

print("Função f como expressão simbólica:")
print(f)
-- Exportando a função para LaTex

local fLatex = symmath.export.LaTeX(f)

print("\nfunção f exportada para LaTex:")

print(fLatex)

-- Exportar para uma função em lua:

-- Para exportar é preciso passar um table com as variáveis
local funcLua, code = f:compile({x})

print("\nImprimido o código da função traduzido para a linguagem lua:")
print(code)

print("Imprimido alguns valores da função")

print("x=0","f(x)="..funcLua(0),"x=pi/2","f(x)="..funcLua(math.pi/2),"x=pi","f(x)="..funcLua(math.pi))