function myMaximum(xs)
    if xs == [] return [] end
    if length(xs) == 1 return xs[1] end
    
    x = popfirst!(xs)
    y = popfirst!(xs)
    if x < y
        myMaximum([y;xs])
    else
        myMaximum([x;xs])
    end
end

function myIntersection(xs,ys)
    if xs == [] || ys == [] return true end
    if isUniq(popfirst!(xs),copy(ys)) == false return false end
    myIntersection(xs,ys)
end

function isUniq(x,ys)
    if ys == [] return true end
    if x == popfirst!(ys) return false end
    isUniq(x,ys)
end

function myUnion(xs,ys)
    trim([xs; ys])
end

function trim(xs)
    if xs == [] return [] end
    x = popfirst!(xs)
    append!([x],[i for i in trim(xs) if i != x])
end

function myFinal(xs)
    if xs == [] return [] end
    if length(xs) == 1 return xs[1] end
    myFinal(deleteat!(xs,1))
end

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
    println(myMaximum([]))
    println(myMaximum([1,-3,2,0,-2,3,-1]))
    println(myFinal([]))
    println(myFinal([1,-3,2,0,-2,3,-1]))
    println(myIntersection([],[]))
    println(myIntersection([],[4,5,6]))
    println(myIntersection([1,2,3],[]))
    println(myIntersection([1,2,3],[4,5,6]))
    println(myIntersection([1,2,3],[3,4,5]))
    println(myIntersection([1,2,3],[4,3,2]))
    println(myUnion([],[]))
    println(myUnion([],[4,5,6]))
    println(myUnion([1,2,3],[]))
    println(myUnion([1,2,3],[4,5,6]))
    println(myUnion([1,2,3],[3,4,5]))
    println(myUnion([1,2,3],[4,3,2]))
    println(myAllPairs([],[]))
    println(myAllPairs([],[4,5,6]))
    println(myAllPairs([1,2,3],[]))
    println(myAllPairs([1, 2, 3], [4, 5, 6]))
    println(myAllPairs([1, 3, 3], [3, 5, 6]))
end

main()