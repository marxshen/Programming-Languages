function myAllPairs(xs,ys)
    if xs == [] || ys == [] return [] end
    trim([pairs(popfirst!(xs), copy(ys)); myAllPairs(xs, ys)])
end

function pairs(x,ys)
    if ys == [] return [] end
    [(x, popfirst!(ys)); pairs(x,ys)]
end

function trim(xs)
    if xs == [] return [] end
    x = popfirst!(xs)
    append!([x],[i for i in trim(xs) if i != x])
end

function main()
    println(myAllPairs([],[]))
    println(myAllPairs([],[4,5,6]))
    println(myAllPairs([1,2,3],[]))
    println(myAllPairs([1, 2, 3], [4, 5, 6]))
    println(myAllPairs([1, 3, 3], [3, 5, 6]))
end

main()