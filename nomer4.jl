
using HorizonSideRobots
inverse(side::HorizonSide)=HorizonSide((Int(side)+2)%4)
maks(side::HorizonSide)=HorizonSide((Int(side)+3)%4)
function HorizonSideRobots.move!(robot,side,num_steps::Integer)
    for _ in 1:num_steps
        move!(robot,side)
    end
end
function markline!(robot,side)
    counter=0
    while !isborder(robot,side) && !isborder(robot,maks(side))
        move!(robot,side)
        move!(robot,maks(side))
        putmarker!(robot)
        counter+=1
    end
    return counter

end


function cross!(robot)
    for side ∈ (Nord,Ost,Sud,West)
        y=markline!(robot,side)
        move!(robot,inverse(side),y)
        move!(robot,inverse(maks(side)),y)
        
    end
end
