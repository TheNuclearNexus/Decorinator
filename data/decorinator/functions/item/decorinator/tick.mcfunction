if score @s decorinator.drop matches 1.. function ~/handle_drop:
    scoreboard players operation $id decorinator.id = @s decorinator.id
    as @e[type=item,nbt={Item:{id: "minecraft:warped_fungus_on_a_stick", tag:{smithed:{id: "decorinator:decorinator"}}}, Age: 0s}] function ./drop

store success score $holding_decorinator decorinator.temp if predicate decorinator:technical/is_holding_decorinator 

if score $holding_decorinator decorinator.temp matches 1 function ~/process:
    function ./load_mode

    if data storage decorinator:temp {mode: 'move'} function ~/mode/move:
        anchored eyes positioned ^ ^ ^0.1 anchored feet function ./position_object:
            if block ~ ~ ~ air unless block ^ ^ ^0.1 air positioned ^ ^ ^-0.1 function ~/adjust_object:
                unless block ^ ^ ^0.01 air function ~/tp_object:
                    scoreboard players operation $id decorinator.id = @s decorinator.id
                    store success score $snap decorinator.temp if predicate decorinator:technical/is_sneaking
                    as @e[type=item_display,tag=decorinator.decoration] if score @s decorinator.id = $id decorinator.id:
                        unless score $snap decorinator.temp matches 1 tp @s ~ ~ ~
                        if score $snap decorinator.temp matches 1 align xyz tp @s ~.5 ~ ~.5
                if block ^ ^ ^0.01 air positioned ^ ^ ^0.01 function ~/
            if entity @s[distance=..8] positioned ^ ^ ^0.1 if block ~ ~ ~ air function ./position_object

    if data storage decorinator:temp {mode: 'rotate'} function ~/mode/rotate:
        scoreboard players operation $id decorinator.id = @s decorinator.id
        store success score $free decorinator.temp if predicate decorinator:technical/is_sneaking

        tag @s add decorinator.target
        as @e[type=item_display,tag=decorinator.decoration] positioned as @s if score @s decorinator.id = $id decorinator.id function ~/update_rotation:
            facing entity @p[tag=decorinator.target] feet tp @s ~ ~ ~ ~ 0
            
            if score $free decorinator.temp matches 0 function ~/../snap_rotation:
                store result score $rotation decorinator.temp data get entity @s Rotation[0] 10
                scoreboard players operation $rotation decorinator.temp /= #225 decorinator.temp
                scoreboard players operation $rotation decorinator.temp *= #225 decorinator.temp

                store result entity @s Rotation[0] float 0.1 scoreboard players get $rotation decorinator.temp

        tag @s remove decorinator.target
    

if score $holding_decorinator decorinator.temp matches 0 function ./put_down_object