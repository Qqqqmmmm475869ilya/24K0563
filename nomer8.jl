using HorizonSideRobots
inverse(side::HorizonSide) = HorizonSide((Int(side) + 1) % 4)
function HorizonSideRobots.move!(robot, side, num_steps::Integer)
    for _ in 1:num_steps
        if (!ismarker(robot))
            move!(robot,side)
        else
            break
        end
    end 
end
function spir!(robot)
    c = 1
    side = Ost

    while (!ismarker(robot))
        move!(robot,side,c)
        if (ismarker(robot))
            break
        end
        side  = inverse(side)
        move!(robot,side,c)
        
        c+=1
        if (ismarker(robot))
            break
        end
        side=inverse(side)
    end
end


