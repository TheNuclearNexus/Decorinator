scoreboard players operation $id decorinator.id = @s decorinator.id

store success score $is_holding_object decorinator.temp if entity @s[tag=decorinator.holding_object]
store success score $is_menu_open decorinator.temp if entity @s[tag=decorinator.radial_menu_open]
store success score $is_sneaking decorinator.temp if predicate decorinator:technical/is_sneaking

if score $is_menu_open decorinator.temp matches 0 function ~/menu_closed:
    if score $is_holding_object decorinator.temp matches 1 function ./put_down_object:
        tag @s remove decorinator.holding_object
        playsound minecraft:block.stone.place master @s ~ ~ ~ 1
        as @e[type=item_display,tag=decorinator.decoration] if score @s decorinator.id = $id decorinator.id at @s function ./reset_object:
            scoreboard players reset @s decorinator.id
            tag @s remove decorinator.held_object
            particle minecraft:cloud ~ ~ ~ 0.2 0.2 0.2 0 10

    # if score $is_sneaking decorinator.temp matches 0:
    if score $is_holding_object decorinator.temp matches 0 function ./select_object:
        scoreboard players set $found_object decorinator.temp 0
        anchored eyes positioned ^ ^ ^0.1 anchored feet function ./find_object:
            as @e[type=item_display,tag=decorinator.decoration, distance=..0.5] function ./copy_ids:
                scoreboard players set $found_object decorinator.temp 1
                scoreboard players operation @s decorinator.id = $id decorinator.id
                tag @s add decorinator.held_object
            if score $found_object decorinator.temp matches 0 positioned ^ ^ ^0.1 if entity @s[distance=..8] function ./find_object

        if score $found_object decorinator.temp matches 1:
            tag @s add decorinator.holding_object
            playsound minecraft:item.armor.equip_leather master @s ~ ~ ~ 1
        
        if score $found_object decorinator.temp matches 0 function ./no_object:
            data remove storage decorinator:temp offhand
            data modify storage decorinator:temp offhand set from entity @s Inventory[{Slot: -106b}]

            scoreboard players set $created_object decorinator.temp 0
            
            if data storage decorinator:temp offhand.tag.decoration function ~/create_object:
                anchored eyes positioned ^ ^ ^ anchored feet function ~/../find_block:
                    unless block ^ ^ ^0.1 #decorinator:raycast_ignore function ~/request_decoration:
                        data modify storage decorinator:api decoration.id set from storage decorinator:temp offhand.tag.decoration.id
                        store result storage decorinator:api owner.id int 1 scoreboard players get @s decorinator.id

                        function #decorinator:events/place
                        data remove storage decorinator:api owner

                        if score $created_object decorinator.temp matches 1:
                            tag @s add decorinator.holding_object
                            item modify entity @s[gamemode=!creative] weapon.offhand decorinator:technical/reduce_one
                            function ./notify_mode/move
                            playsound minecraft:block.stone.place master @s ~ ~ ~ 1
                            particle minecraft:cloud ~ ~ ~ 0.2 0.2 0.2 0 10
                            loot replace entity @s weapon.mainhand loot decorinator:technical/update_decorinator
                    if block ^ ^ ^0.1 #decorinator:raycast_ignore if entity @s[distance=..8] positioned ^ ^ ^0.1 function ~/

            if score $created_object decorinator.temp matches 0:
                function decorinator:entity/radial_menu/open

    # if score $is_sneaking decorinator.temp matches 1:
    #     if score $is_holding_object decorinator.temp matches 0 function decorinator:entity/radial_menu/open

if score $is_menu_open decorinator.temp matches 1 function decorinator:entity/radial_menu/confirm