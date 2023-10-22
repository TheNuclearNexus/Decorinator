unless score @s decorinator.id matches (-pow(2, 31), pow(2,31)-1) function ./bump_id:
    scoreboard players add $globalId decorinator.id 1
    scoreboard players operation @s decorinator.id = $globalId decorinator.id
    scoreboard players set @s decorinator.snapping 16

if predicate decorinator:technical/is_holding_decorinator function ./highlight_decorations:
    if entity @s[tag=!decorinator.holding_object] at @e[type=item_display,tag=decorinator.decoration,tag=!decorinator.held_object]:
        particle dust 0 1 0 0.5 ~ ~0.5 ~ 0.2 0.2 0.2 0 10 normal @s 

    if entity @s[tag=decorinator.holding_object] function ~/held:
        scoreboard players operation $id decorinator.id = @s decorinator.id

        tag @s add decorinator.target
        as @e[type=item_display,tag=decorinator.decoration,tag=decorinator.held_object] at @s if score @s decorinator.id = $id decorinator.id:
            particle dust 0 0 1 0.5 ~ ~0.5 ~ 0.2 0.2 0.2 0 10 normal @p[tag=decorinator.target]
        tag @s remove decorinator.target