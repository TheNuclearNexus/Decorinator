if score @s decorinator.selection matches 1 function ~/select_move:
    function decorinator:item/decorinator/notify_mode/move
    loot replace entity @s weapon.mainhand loot decorinator:technical/update_decorinator

if score @s decorinator.selection matches 2 function ~/select_rotate:
    function decorinator:item/decorinator/notify_mode/rotate
    loot replace entity @s weapon.mainhand loot decorinator:technical/update_decorinator

if score @s[tag=decorinator.holding_object] decorinator.selection matches 3 function ~/remove:
    function decorinator:item/decorinator/delete_object
    loot replace entity @s weapon.mainhand loot decorinator:technical/update_decorinator

function ./close