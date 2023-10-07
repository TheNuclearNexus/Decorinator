
scoreboard players operation $id decorinator.id = @s decorinator.id
as @e[type=text_display, tag=decorinator.radial_menu] if score @s decorinator.id = $id decorinator.id:
    on passengers kill @s
    kill @s

tag @s remove decorinator.radial_menu_open