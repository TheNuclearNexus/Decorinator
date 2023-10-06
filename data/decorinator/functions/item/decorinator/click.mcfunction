scoreboard players operation $id decorinator.id = @s decorinator.id

store success score $holding_object decorinator.temp if entity @s[tag=decorinator.holding_object]

if score $holding_object decorinator.temp matches 1 function ./put_down_object:
    tag @s remove decorinator.holding_object
    as @e[type=item_display,tag=decorinator.decoration] if score @s decorinator.id = $id decorinator.id function ./reset_object:
        scoreboard players reset @s decorinator.id
        tag @s remove decorinator.held_object

if score $holding_object decorinator.temp matches 0 function ./select_object:
    data remove storage decorinator:temp offhand
    data modify storage decorinator:temp offhand set from entity @s Inventory[{Slot: -106b}]

    scoreboard players set $created_object decorinator.temp 0
    if data storage decorinator:temp offhand.tag.decoration function ~/create_object:
        data modify storage decorinator:api decoration.id set from storage decorinator:temp offhand.tag.decoration.id
        store result storage decorinator:api owner.id int 1 scoreboard players get @s decorinator.id

        function #decorinator:events/place
        data remove storage decorinator:api owner

        if score $created_object decorinator.temp matches 1:
            tag @s add decorinator.holding_object


    if score $created_object decorinator.temp matches 0 function ./pick_up_object:
        scoreboard players set $found_object decorinator.temp 0
        anchored eyes positioned ^ ^ ^0.1 anchored feet function ./find_object:
            as @e[type=item_display,tag=decorinator.decoration, distance=..0.2] function ./copy_ids:
                scoreboard players set $found_object decorinator.temp 1
                scoreboard players operation @s decorinator.id = $id decorinator.id
                tag @s add decorinator.held_object
            if score $found_object decorinator.temp matches 0 positioned ^ ^ ^0.1 if entity @s[distance=..8] function ./find_object

        if score $found_object decorinator.temp matches 1:
            tag @s add decorinator.holding_object