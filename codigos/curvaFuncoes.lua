require('symmath').setup()

-- Função utilitária para exportar a curva para o gnuplot  
function Array2GnuPlotR2(arr,var)
    local t = vars("t")
    if var then
        arr = symmath.replace(var, t, arr)
    end
    arr = symmath.export.GnuPlot(arr)
    return string.sub(arr,2,#arr-1)
end

function Array2GnuPlotR3(arr,var)
    local u = vars("u")
    if var then
        arr = symmath.replace(var, u, arr)
    end
    arr = symmath.export.GnuPlot(arr)
    return string.sub(arr,2,#arr-1)
end

function ProdutoEscalar(a,b)
    local result = 0;
    for index, value in ipairs(a) do
        result = result + (a[index]*b[index])
    end

    return result
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
    local y = vars('y')
    -- Calcula o comprimento de arco e faz o replace de t em função de y
    local eqn = symmath.op.eq(ComprimentoDeArco(c,var), y)
    -- Encontra a inversa de y
    local sol =  symmath.solve(eqn, t)[2]
    -- Substituiu t pelo valor parametrizado por comprimento de arco.
    sol = symmath.replace(sol,y,t)
    return symmath.replace(c, t, sol)
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

-- Função para obter uma curva a um movimento rígido a partir da curvatura.
-- Receve a curvatura e a variável var.
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
-- Função curvatura, calcula a curvatura (em R^3) de uma curva c em função de t.
-- Recebe curva c regular duas vezes diferenciável, e a variável var
-- Retorna sua curvatura
function CurvaturaR3(c,var)
    -- var, é opcional, caso o usuario não passe (valor = nil) substitue por u:
    local var = var or vars("u")
    -- dif1 é a primeira derivada da curva.
    local dif1 = c:diff(var)()
    local n = dif1:norm()
    -- dif2 é a segunda derivada da curva.
    local dif2 = dif1:diff(var)()

    local k = Array.cross(dif1,dif2)

    k = k:norm()

    return k/n^3
end
-- Função torção, calcula a torção (em R^3) de uma curva c em função de t.
-- Recebe curva c regular três vezes diferenciável, e a variável var
-- Retorna sua torção
function TorcaoR3(c,var)
    -- var, é opcional, caso o usuario não passe (valor = nil) substitue por u:
    local var = var or vars("u")
    -- dif1 é a primeira derivada da curva.
    local dif1 = c:diff(var)()
    -- dif2 é a segunda derivada da curva.
    local dif2 = dif1:diff(var)()
     -- dif3 é a terceira derivada da curva.
    local dif3 = dif2:diff(var)()

    local v = Array.cross(dif1,dif2)

    return ProdutoEscalar(v,dif3)/(v:norm()^2)
end

-- Função para calcular o Triedro de Frenet (em R^3) de uma curva c em função de t.
-- Recebe curva c regular três vezes diferenciável, e a variável var
-- Retorna um Array com os três vetores do Triedro de Frenet
function TriedroFrenet(c,var)
    -- var, é opcional, caso o usuario não passe (valor = nil) substitue por u:
    local var = var or vars("u")
    -- T é a primeira derivada da curva.
    c = Reparametrizacao(c,var)
    local T = c:diff(var)()
    -- N é a segunda derivada da curva.
    local N = T:diff(var)()
    N = N:unit()
    -- B é o vetor perpendicular a N e T.
    local B = Array.cross(N,T)

    return Array(T,N,B)
end