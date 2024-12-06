using HorizonSideRobots
inverse(side::HorizonSide) = HorizonSide((Int(side) + 2) % 4)
function HorizonSideRobots.move!(robot, side, num_steps::Integer)
    for _ in 1:num_steps
        move!(robot,side)
    end 
end
function shag!(robot)
    c = 1
    side = Ost
    while (isborder(robot,Nord))
        move!(robot,side,c)
        side = inverse(side)
        c+=1
    end
end