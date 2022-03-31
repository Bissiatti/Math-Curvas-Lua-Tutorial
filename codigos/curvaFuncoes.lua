require('symmath').setup()

-- Função utilitária para 
function Array2GnuPlotR2(arr,var)
    if var then
        arr = symmath.replace(var, t, arr)
    end
    arr = symmath.export.GnuPlot(arr)
    return string.sub(arr,2,#arr-1)
end

function Array2GnuPlotR3(arr,var)
    if var then
        arr = symmath.replace(var, u, arr)
    end
    arr = symmath.export.GnuPlot(arr)
    return string.sub(arr,2,#arr-1)
end

-- Função que calcula o comprimento de arco
-- Recebe curva c regular diferenciável, variável var, intervalo inicial a, intervalo final b
-- Retorna o comprimento de arco no intervalo definido [a,b] ou a integral indefinida em função de t
function ComprimentoDeArco(c,var,a,b)
    -- var, a, b são opcionais, caso o usuario não passe (valor = nil) substituo por:
    a = a or true
    b = b or true
    local t = var or vars("t")

    -- Calcula a norma do vetor tangente de c
    local u = c:diff(t)():norm()

    -- Calcula o comprimento de arco através da integral da norma do vetor tangente
    if a or b then
        u = u:integrate(t)();
    else
        u = u:integrate(t,a,b)()
    end
    return u
end

-- Função de reparametrização de uma curva c
-- Recebe curva c regular diferenciável, e a variável var
-- Retorna a nova curva c só que reparametrizada por comprimento de arco
function Reparametrizacao(c,var)
    -- var, é opcional, caso o usuario não passe (valor = nil) substitue por t:
    local t = var or vars("t")
    -- Calcula o comprimento de arco e faz o replace de t, t = comprimentoDeArco(t)
    return symmath.replace(c, t, ComprimentoDeArco(c))
end

-- Função curvatura, calcula a curvatura (em R^2) de uma curva c em função de t.
-- Recebe curva c regular duas vezes diferenciável, e a variável var
-- Retorna sua curvatura

function CurvaturaR2(c,var)
    -- Verifica se a dimensão da curva é 2.
    if c:dim()[1] ~= 2 then
        error("The dimension of curve c is not 2")
    end
    -- var, é opcional, caso o usuario não passe (valor = nil) substitue por t:
    local var = var or vars("t")
    -- dif1 é a primeira derivada da curva, vetor velocidade
    local dif1 = c:diff(var)()
    -- dif2 é a segunda derivada da curva, vetor aceleração
    local dif2 = dif1:diff(var)()
    -- u é a norma do vetor velocidade
    local u = dif1:norm()

    -- retorna a função curvatura de c. 
    return ((dif1[1]*dif2[2])-(dif1[2]*dif2[1]))/(u)^3
end

-- Função para obter a curva alpha a partir da curvatura e um ponto inicial 
-- Receve a curvatura, a variável var.
-- Retorna a curva
function CurvaDeCurvaturaR2(curvatura,var)
    -- var, é opcional, caso o usuario não passe (valor = nil) substitue por t:
    local var = var or vars('t')

    -- Encontra a função Theta
    local theta = symmath.Integral(curvatura,var)()
    -- Encontra o vetor tangente a um movimento rígdo
    local cdiff = Array(cos(theta),sin(theta))

    -- Retorna a curva
    return cdiff:integrate(var)()

end

local t = vars("t")

print(CurvaDeCurvaturaR2(0))

print(CurvaDeCurvaturaR2(1))