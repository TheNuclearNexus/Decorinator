from bolt_expressions import Scoreboard, Data

temp_storage = Data.storage("decorinator:temp")
temp_score = Scoreboard("decorinator.temp")
self = Data.entity("@s")


function ./load_mode

def handle_snap(pos, amount):
    temp_score["$x"] = pos[0] * amount
    temp_score["$y"] = pos[1] * amount
    temp_score["$z"] = pos[2] * amount
    
    pos[0] = temp_score["$x"] / amount
    pos[1] = temp_score["$y"] / amount
    pos[2] = temp_score["$z"] / amount
    self.Pos = pos
    at @s tp ~ ~ ~

function ~/mode/move/align_pos:
    tp @s ~ ~ ~
    temp_storage.pos = self.Pos
    pos = temp_storage.pos(type="double")
    if score $snap decorinator.temp matches 2 function ~/2:
        handle_snap(pos, 2)
    if score $snap decorinator.temp matches 4 function ~/4:
        handle_snap(pos, 4)
    if score $snap decorinator.temp matches 8 function ~/8:
        handle_snap(pos, 8)
    if score $snap decorinator.temp matches 16 function ~/16:
        handle_snap(pos, 16)


        
    
if data storage decorinator:temp {mode: 'move'} function ~/mode/move:
    scoreboard players operation $snap decorinator.temp = @s decorinator.snapping
    anchored eyes positioned ^ ^ ^0.1 anchored feet function ./position_object:
        if block ~ ~ ~ #decorinator:raycast_ignore unless block ^ ^ ^0.1 #decorinator:raycast_ignore positioned ^ ^ ^-0.1 function ~/adjust_object:
            unless block ^ ^ ^0.01 #decorinator:raycast_ignore function ~/tp_object:
                scoreboard players operation $id decorinator.id = @s decorinator.id
                store success score $is_sneaking decorinator.temp if predicate decorinator:technical/is_sneaking
                as @e[type=item_display,tag=decorinator.decoration] if score @s decorinator.id = $id decorinator.id:
                    if score $is_sneaking decorinator.temp matches 1 tp @s ~ ~ ~
                    if score $is_sneaking decorinator.temp matches 0 function ./tick/mode/move/align_pos
                        

            if block ^ ^ ^0.01 #decorinator:raycast_ignore positioned ^ ^ ^0.01 function ~/
        if entity @s[distance=..8] positioned ^ ^ ^0.1 if block ~ ~ ~ #decorinator:raycast_ignore function ./position_object

if data storage decorinator:temp {mode: 'rotate'} function ~/mode/rotate:
    scoreboard players operation $id decorinator.id = @s decorinator.id
    store success score $free decorinator.temp if predicate decorinator:technical/is_sneaking

    tag @s add decorinator.target
    as @e[type=item_display,tag=decorinator.decoration] positioned as @s if score @s decorinator.id = $id decorinator.id function ~/update_rotation:
        facing entity @p[tag=decorinator.target] feet rotated ~11.25 0 tp @s ~ ~ ~ ~ 0
        
        if score $free decorinator.temp matches 0 function ~/../snap_rotation:
            store result score $rotation decorinator.temp data get entity @s Rotation[0] 10
            scoreboard players operation $rotation decorinator.temp /= #225 decorinator.temp
            scoreboard players operation $rotation decorinator.temp *= #225 decorinator.temp

            store result entity @s Rotation[0] float 0.1 scoreboard players get $rotation decorinator.temp

    tag @s remove decorinator.target

if data storage decorinator:temp {mode: 'remove'} function ./delete_object
