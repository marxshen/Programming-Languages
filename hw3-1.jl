function findSum(inp::AbstractVector, sum::Int) :: Union{Vector{Tuple{Int,Int}}, Nothing}
    if len(inp) < 2 || typeof(inp) != Vector{Int} return nothing end
    
    sets = pair(inp); ret = Tuple{Int,Int}[]
    for i in sets
        if i[1]+i[2] == sum
            push!(ret, i)
        end
    end
    trim(ret)
end

function extendedFindSum(inp::AbstractVector) :: Union{Vector{Tuple{Int, Vector{Tuple{Int,Int}}}}, Nothing}
    if len(inp) < 2 || typeof(inp) != Vector{Int} return nothing end

    sets = pair(inp); ret = Tuple{Int, Tuple{Int,Int}}[]
    for i in sets
        push!(ret, (i[1]+i[2],i))
    end
    sort!(classify(trim(ret)))
end

function len(inp::AbstractVector) :: Int
    ret = 0
    for i in inp
        ret += 1
    end
    ret
end

function pair(inp::Vector{Int}) :: Vector{Tuple{Int,Int}}
    sets = Any[]; push!(sets, Int[])
    for i in inp, j in 1:len(sets)
        push!(sets, [sets[j]; i])
    end

    ret = Tuple{Int,Int}[]
    for i in sets
        if len(i) == 2
            push!(ret, (i[1],i[2]))
        end
    end
    ret
end

function trim(inp::AbstractVector) :: AbstractVector
    if len(inp) == 0 return [] end
    
    head = popfirst!(inp); tail = trim(inp)
    if typeof(inp) == Vector{Tuple{Int,Int}}
        ret = Tuple{Int,Int}[]
    elseif typeof(inp) == Vector{Tuple{Int,Tuple{Int,Int}}}
        ret = Tuple{Int,Tuple{Int,Int}}[]
    end

    push!(ret, head)
    for i in tail
        if i != head
            push!(ret, i)
        end
    end
    ret
end

function classify(inp::Vector{Tuple{Int,Tuple{Int,Int}}}) :: Vector{Tuple{Int, Vector{Tuple{Int,Int}}}}
    dict = Dict{Int, Vector{Tuple{Int,Int}}}()
    map(inp) do tup
        if existkey(dict, tup[1])
            push!(dict[tup[1]], tup[2])
        else
            xs = Tuple{Int,Int}[]
            dict[tup[1]] = push!(xs, tup[2])
        end
    end
    
    ret = Tuple{Int, Vector{Tuple{Int,Int}}}[]
    for i in dict
        push!(ret, (i[1],i[2]))
    end
    ret
end

function existkey(inp::AbstractDict, key::Any) :: Bool
    for (k, v) in inp
        if key == k return true end
    end
    false
end

function sort!(inp::Vector{Tuple{Int,Vector{Tuple{Int,Int}}}}, start::Int = 1, stop::Int = len(inp)) :: Vector{Tuple{Int,Vector{Tuple{Int,Int}}}}
    if stop > start
        left, right, pivot = start, stop, inp[rand(start:stop)][1]
        while left <= right
            while inp[left][1] < pivot
                left += 1
            end
            while inp[right][1] > pivot
                right -= 1
            end
            if left <= right
                inp[left], inp[right] = inp[right], inp[left]
                left += 1; right -= 1
            end
        end
        sort!(inp, start, right)
        sort!(inp, left, stop)
    end
    inp
end

function main() :: Nothing
    println("findSum:")
    show(findSum([1,3,8,12,7,11,9,4,2,10,5], 12))
    println("\nextendedFindSum:")
    show(extendedFindSum([1,3,8,12,7,11,9,4,2,10,5]))
    println()
end

main()