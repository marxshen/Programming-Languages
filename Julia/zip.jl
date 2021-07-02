function zip(x,y)
    if x == [] || y == [] return [] end
    [(popfirst!(x), popfirst!(y)); zip(x,y)]
end

function main()
    show(zip([1, 2], ['a', 'b']))
    println()
    show(zip([1], ['a', 'b']))
end

main()