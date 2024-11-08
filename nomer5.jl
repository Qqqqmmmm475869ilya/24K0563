using HorizonSideRobots
inverse(side::HorizonSide) = HorizonSide((Int(side)+2)%4)
function HorizonSideRobots.move!(robot,side,num_steps::Integer)
    for _ in 1:num_steps
        move!(robot,side)
    end
end
function markline!(robot,side)  
    putmarker!(robot)
    while !isborder(robot,side)
        move!(robot,side)
        putmarker!(robot)
    end
end

function do_upora!(robot,side)
    c = 0
    while !isborder(robot,side)
        move!(robot,side)
        c+=1
    end
    return c
end
function cross!(robot)
    for side ∈ (Nord,Ost,Sud,West)
        markline!(robot,side)
    end
end
function stena!(robot)
    z = do_upora!(robot,Ost)
    n=z
    side = Ost
    while (n==z)
        move!(robot,Nord)
        side = inverse(side)
        n = do_upora!(robot,side)
    end
    if isborder(robot,West)
        side =West
    else
        side = Ost
    end
    putmarker!(robot)
    while isborder(robot,side)
        move!(robot,Nord)
        putmarker!(robot)
    end
    
    move!(robot,side)
    putmarker!(robot)
    while isborder(robot,Sud)
        move!(robot,side)
        putmarker!(robot)
    end
    move!(robot,Sud)
    putmarker!(robot)
    while isborder(robot,inverse(side))
        move!(robot,Sud)
        putmarker!(robot)
    end
    move!(robot,inverse(side))
    putmarker!(robot)
    while isborder(robot,Nord)
        move!(robot,inverse(side))
        putmarker!(robot)
    end
end
function finall!(robot)
    x = do_upora!(robot,West)
    y = do_upora!(robot,Sud)
    x+= do_upora!(robot,West)
    y+= do_upora!(robot,Sud)
    cross!(robot)
    stena!(robot)
    do_upora!(robot,West)
    do_upora!(robot,Sud)
    do_upora!(robot,West)
    do_upora!(robot,Sud)
    move!(robot,Nord,y)
    n =0
    c = 0
    while (n<x && !isborder(robot,Ost))
        move!(robot,Ost)
        n+=1
    end
    if (n<x)
        while isborder(robot,Ost)
            move!(robot,Sud)
            c+=1
    
        end
        move!(robot,Ost,x-n) 
        move!(robot,Nord,c)
    end
end


