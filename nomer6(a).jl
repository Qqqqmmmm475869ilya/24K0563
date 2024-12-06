using HorizonSideRobots
inverse(side::HorizonSide) = HorizonSide((Int(side) + 2) % 4)
function HorizonSideRobots.move!(robot, side, num_steps::Integer)
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
function movetoangle!(robot, side::NTuple{2,HorizonSide})
    path = HorizonSide[]# складывает наши шаги
    while !(isborder(robot, side[1]) && isborder(robot, side[2]))
    # робот - не в углу
        trymove!(robot, side[1]) && push!(path, side[1])#push! - добавляет в массив trymove!-проверяет можно ли подвинуть и двигает если да
        trymove!(robot, side[2]) && push!(path, side[2])
    end
    return path
end
function trymove!(robot, side)
        isborder(robot, side) && return false
        move!(robot, side)
        return true
end
function cross!(robot)
    for side ∈ (Nord, Ost, Sud, West)
        markline!(robot, side)
    end
end
HorizonSideRobots.move!(robot, side) = for s in side move!(robot, s) end

function obratno!(robot,side::NTuple{2,HorizonSide})
    path=movetoangle!(robot, side)
    cross!(robot)
    move!(robot, reverse(inverse.(path)))
end




        

