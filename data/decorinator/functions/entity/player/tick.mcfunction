
if score @s decorinator.wfoas matches 1.. function ./handle_wfoas:
    scoreboard players reset @s decorinator.wfoas
    if predicate decorinator:technical/is_holding_decorinator function decorinator:item/decorinator/click

if entity @s[tag=decorinator.holding_object] function decorinator:item/decorinator/tick

scoreboard players reset @s decorinator.drop