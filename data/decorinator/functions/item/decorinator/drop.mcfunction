# Runs as the item
on origin store success score $is_correct decorinator.temp if score @s decorinator.id = $id decorinator.id

unless score $is_correct decorinator.temp matches 1 return 0


data modify storage decorinator:temp nbt set from entity @s Item.tag

if score $is_menu_open decorinator.temp matches 0 function ~/menu_closed:
    if score $is_sneaking decorinator.temp matches 1 function ./radial_menu:
        on origin function ~/toggle_menu:
            data modify storage decorinator:temp mode set from storage decorinator:temp nbt.decorinator.mode
            data modify storage decorinator:temp lore set from storage decorinator:temp nbt.display.Lore
            function ./return_item
    
            if score $is_menu_open decorinator.temp matches 1 function decorinator:entity/radial_menu/close
            if score $is_menu_open decorinator.temp matches 0 function decorinator:entity/radial_menu/open
        kill @s

    if score $is_sneaking decorinator.temp matches 0:
        if score $is_holding_object decorinator.temp matches 1 function ~/quick_swap_mode:
            if data storage decorinator:temp nbt.decorinator{mode: 'move'}:
                scoreboard players set $mode decorinator.temp 1
            if data storage decorinator:temp nbt.decorinator{mode: 'rotate'}:
                scoreboard players set $mode decorinator.temp 2

            if score $mode decorinator.temp matches 1 on origin function ./notify_mode/rotate
            if score $mode decorinator.temp matches 2 on origin function ./notify_mode/move

            on origin function ./return_item:
                if data entity @s SelectedItem loot give @s loot decorinator:technical/update_decorinator
                unless data entity @s SelectedItem loot replace entity @s weapon.mainhand loot decorinator:technical/update_decorinator
            kill @s

if score $is_menu_open decorinator.temp matches 1 function ./radial_menu
