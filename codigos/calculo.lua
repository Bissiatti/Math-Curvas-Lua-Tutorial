require('symmath').setup()
local gnuplot = require 'gnuplot'

-- Definição das variáveis simbólicas

local t,x,y,alpha,beta = vars("t","x","y","\\alpha","\\beta")

-- Definindo uma função simbólica
local f = alpha*sin(x)

print("Função f:")
print(f)

-- Definindo a derivada

local df = f:diff(x)

print("\nDefinindo a derivada:")
print(df)

-- Derivando

df = df()

print("Derivada calculada de f")
print(df)

-- Calculando a integral indefinida da função

local F = f:integrate(x)()

print("\nIntegral indefinifa de f")
print(F)

-- Calulando a integral definida da função no intervalo 0 a t

local integral = f:integrate(x,0,t)()

print("integral definifa de f de 0 a t:")
print(integral)

-- Definindo um vetor:

print("\nTrabalhando com vetores:")
local v = Array(4,3)
print("v=")
print(v)

-- Calculo da norma 2 de um vetor:

print("Norma do Vetor v:")

print(v:norm())

-- Criando uma matriz a partir de dois vetores
local u = Array(x,y)

local M = Matrix(v,u)

print("Matriz:")
print(M)
-- Perceba que os vetores são passados como as linhas da matriz e não como colunas

-- Matriz transposta

print("Matriz transposta")

Mt = M:T()
print(M)

print("Calculo do determinante de M^t")

print(Mt:determinant())