function longestString(inp::String) :: Union{String, Nothing}
    if len(inp) == 0 return nothing end

    maxLen, dict = cleave(inp)
    if maxLen == 0 return nothing end

    dict[maxLen][1]
end

function extendedLongestString(inp::String) :: Union{Vector{String}, Nothing}
    if len(inp) == 0 return nothing end
    
    maxLen, dict = cleave(inp)
    if maxLen == 0 return nothing end

    dict[maxLen]
end

function len(inp::AbstractString) :: Int
    ret = 0
    for i in inp
        ret += 1
    end
    ret
end

function cleave(inp::String) :: Tuple{Int, Dict{Int, Vector{String}}}
    n = len(inp); dict = Dict{Int, Vector{String}}()
    p = 1; maxLen = 0
    for i in 1:n
        if isspace(inp[i])
            if i > p
                if maxLen < i-p
                    maxLen = i-p
                end
                if existkey(dict, i-p)
                    push!(dict[i-p], inp[p:i-1])
                else
                    xs = String[]
                    dict[i-p] = push!(xs, inp[p:i-1])
                end
                p = i + 1;
            else
                p += 1
            end
        end
    end

    if p <= n
        if maxLen < n-p+1
            maxLen = n-p+1
        end
        if existkey(dict, n-p+1)
            push!(dict[n-p+1], inp[p:n])
        else
            xs = String[]
            dict[n-p+1] = push!(xs, inp[p:n])
        end
    end
    maxLen, dict
end

function isspace(c::Char) :: Bool
    c == ' ' || c - '\t' <= 4 || Int(c) == 0xa0
end

function existkey(inp::AbstractDict, key::Any) :: Bool
    for (k, v) in inp
        if key == k return true end
    end
    false
end

function main() :: Nothing
    println("longestString:")
    show(longestString("Programming languages are awesomeeeeee"))
    println("\nextendedLongestStrings:")
    show(extendedLongestString("string abcdef ghi jk l"))
    println()
end

main()