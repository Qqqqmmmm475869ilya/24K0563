using HorizonSideRobots
inverse(side::HorizonSide) = HorizonSide((Int(side) + 2) % 4)
function HorizonSideRobots.move!(robot, side, num_steps::Integer)
    for _ in 1:num_steps
        move!(robot,side)
    end
end

mutable struct ChesRobot
    robot::Robot
    flag::Bool
end
function HorizonSideRobots.move!(robot::ChesRobot, side)
    robot.flag && putmarker!(robot.robot)
    move!(robot.robot, side)
    robot.flag = !robot.flag
end
HorizonSideRobots.isborder(robot::ChesRobot, side) = isborder(robot.robot,
side)

function markdirect!(robot, side)
    while !isborder(robot, side)
        move!(robot, side)
        putmarker!(robot)
    end
end
function do_upora!(robot,side)
    c = 0
    while !isborder(robot,side)
        move!(robot,side)
        c += 1
    end
    return c
end
function markperim!(robot)
    for s in (Nord, Ost, Sud, West)
        putmarker!(robot)
        markdirect!(robot, s) # - здесь первая клетка не маркируется
    end
end
function cross!(robot)
    x = do_upora!(robot,West)
    y = do_upora!(robot,Sud)
    side = Ost
    while !isborder(robot,Nord) 
        do_upora!(robot,side)
        side=inverse(side)
        move!(robot,Nord)
    end
    do_upora!(robot,side)
    do_upora!(robot,Sud)
    do_upora!(robot,West)
    move!(robot,Nord,x)
    move!(robot,Ost,y)

end  
cross!(robot::Robot) =  cross!(ChesRobot(robot, true))