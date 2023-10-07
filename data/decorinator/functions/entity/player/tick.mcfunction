
if score @s decorinator.wfoas matches 1.. function ./handle_wfoas:
    scoreboard players reset @s decorinator.wfoas
    
    if predicate decorinator:technical/is_holding_decorinator function decorinator:item/decorinator/click

if entity @s[tag=decorinator.holding_decorinator] function ~/test_drop:
    if score @s decorinator.drop matches 1.. function ~/handle_drop:

        store success score $is_sneaking decorinator.temp if predicate decorinator:technical/is_sneaking
        store success score $is_holding_object decorinator.temp if entity @s[tag=decorinator.holding_object]
        store success score $is_menu_open decorinator.temp if entity @s[tag=decorinator.radial_menu_open]

        scoreboard players operation $id decorinator.id = @s decorinator.id
        as @e[type=item,nbt={Item:{id: "minecraft:warped_fungus_on_a_stick", tag:{smithed:{id: "decorinator:decorinator"}}}, Age: 0s}]:
            function decorinator:item/decorinator/drop

scoreboard players reset @s decorinator.drop

store success score $holding_decorinator decorinator.temp if predicate decorinator:technical/is_holding_decorinator
if score $holding_decorinator decorinator.temp matches 1 function ~/holding_decorinator:
    tag @s add decorinator.holding_decorinator

    if entity @s[tag=decorinator.holding_object] function decorinator:item/decorinator/tick
    if entity @s[tag=decorinator.radial_menu_open] function decorinator:entity/radial_menu/tick

if score $holding_decorinator decorinator.temp matches 0 if entity @s[tag=decorinator.holding_decorinator] function ~/reset_decorinator:
    tag @s remove decorinator.holding_decorinator
    
    if entity @s[tag=decorinator.holding_object] function decorinator:item/decorinator/put_down_object
    if entity @s[tag=decorinator.radial_menu_open] function decorinator:entity/radial_menu/close
