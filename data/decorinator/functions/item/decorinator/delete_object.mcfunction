tag @s remove decorinator.holding_object
scoreboard players operation $id decorinator.id = @s decorinator.id
as @e[type=item_display,tag=decorinator.decoration] if score @s decorinator.id = $id decorinator.id function ./return_object:
    data modify storage decorinator:api decoration.id set from entity @s item.tag.decoration.id
    tag @s remove decorinator.held_object
    kill @s
    
function #decorinator:events/return