if score @s decorinator.selection matches 1 function ~/select_move:
    function decorinator:item/decorinator/notify_mode/move
    loot replace entity @s weapon.mainhand loot decorinator:technical/update_decorinator
    playsound minecraft:ui.button.click master @s ~ ~ ~ 0.25 1

if score @s decorinator.selection matches 2 function ~/select_rotate:
    function decorinator:item/decorinator/notify_mode/rotate
    loot replace entity @s weapon.mainhand loot decorinator:technical/update_decorinator
    playsound minecraft:ui.button.click master @s ~ ~ ~ 0.25 1

if score @s decorinator.selection matches 3 function ~/select_remove:
    function decorinator:item/decorinator/notify_mode/remove
    loot replace entity @s weapon.mainhand loot decorinator:technical/update_decorinator
    playsound minecraft:ui.button.click master @s ~ ~ ~ 0.25 1

if score @s decorinator.selection matches 4 function ~/select_settings:
    if score @s decorinator.snapping matches 0 scoreboard players set $snap decorinator.temp 2
    if score @s decorinator.snapping matches 2 scoreboard players set $snap decorinator.temp 4
    if score @s decorinator.snapping matches 4 scoreboard players set $snap decorinator.temp 8
    if score @s decorinator.snapping matches 8 scoreboard players set $snap decorinator.temp 16
    if score @s decorinator.snapping matches 16 scoreboard players set $snap decorinator.temp 0

    if score $snap decorinator.temp matches 1.. function ~/notify_snap_on:
        data modify storage smithed.actionbar:input message set value {
            json: '{"translate": "text.decorinator.snapping","with":[{"color": "green", "translate":"text.decorinator.fraction","with":["1",{"score": {"objective": "decorinator.temp", "name": "$snap"}}]}]}',
            priority: 'notification'
        }
    unless score $snap decorinator.temp matches 1.. function ~/notify_snap_off:
        data modify storage smithed.actionbar:input message set value {
            json: '{"translate": "text.decorinator.snapping","with":[{"color": "red", "text": "OFF"}]}',
            priority: 'notification'
        }


    function #smithed.actionbar:message

    scoreboard players operation @s decorinator.snapping = $snap decorinator.temp

    playsound minecraft:ui.button.click master @s ~ ~ ~ 0.25 1

function ./close