# Runs as the item
on origin store success score $is_correct decorinator.temp if score @s decorinator.id = $id decorinator.id

unless score $is_correct decorinator.temp matches 1 return 0


data modify storage decorinator:temp nbt set from entity @s Item.tag

if data storage decorinator:temp nbt.decorinator{mode: 'move'}:
    scoreboard players set $mode decorinator.temp 1
if data storage decorinator:temp nbt.decorinator{mode: 'rotate'}:
    scoreboard players set $mode decorinator.temp 2

data modify storage decorinator:temp lore set value [
    '{"text":""}'
]
if score $mode decorinator.temp matches 1 function ~/set_rotate:
    data modify storage decorinator:temp mode set value 'rotate'
    data modify storage decorinator:temp lore append value '{"translate": "lore.decorinator.mode","color": "gray","italic": "false","with":[{"color": "blue", "translate": "lore.decorinator.mode.rotate"}]}'

    data modify storage smithed.actionbar:input message set value {
        json: '{"translate": "lore.decorinator.mode","with":[{"color": "blue", "translate": "lore.decorinator.mode.rotate"}]}',
        priority: 'notification'
    }
    on origin function #smithed.actionbar:message


if score $mode decorinator.temp matches 2 function ~/set_move:
    data modify storage decorinator:temp mode set value 'move'
    data modify storage decorinator:temp lore append value '{"translate": "lore.decorinator.mode","color": "gray","italic": "false","with":[{"color": "green", "translate": "lore.decorinator.mode.move"}]}'

    data modify storage smithed.actionbar:input message set value {
        json: '{"translate": "lore.decorinator.mode","with":[{"color": "green", "translate": "lore.decorinator.mode.move"}]}',
        priority: 'notification'
    }
    on origin function #smithed.actionbar:message

on origin function ~/return_item:
    if data entity @s SelectedItem loot give @s loot decorinator:technical/update_decorinator
    unless data entity @s SelectedItem loot replace entity @s weapon.mainhand loot decorinator:technical/update_decorinator
kill @s