from nbtlib import Float
scoreboard players operation $id decorinator.id = @s decorinator.id

store result score $rotation decorinator.temp data get entity @s Rotation[0] 100
scoreboard players operation @s decorinator.rotation = $rotation decorinator.temp

scoreboard players set @s decorinator.selection 0

tag @s add decorinator.radial_menu_open

def transform(offset=0):
    return {
        translation: [Float(0.019),Float(0.076),Float(0.1 - offset)],
        left_rotation: [Float(0),Float(1),Float(0),Float(0)],
        right_rotation: [Float(0),Float(0),Float(0),Float(1)],
        scale: [Float(0.1+offset),Float(0.1+offset),Float(0.1+offset)],
    }

anchored eyes positioned ^ ^-0.001 ^ anchored feet function ~/create_display:
    view_range = Float(1 * pow(10, -4))
    summon text_display ~ ~ ~ {
        Tags: ["decorinator.radial_menu"],
        text: '{"text": "\\uf001","font":"decorinator:gui"}',
        view_range: view_range,
        transformation: transform(),
        teleport_duration: -1,
        background: 0
    }
    as @e[type=text_display,tag=decorinator.radial_menu,sort=nearest,limit=1,distance=..0.2] function ~/set_data:
        store result entity @s Rotation[0] float 0.01 scoreboard players get $rotation decorinator.temp
        # on passengers store result entity @s Rotation[0] float 0.01 scoreboard players get $rotation decorinator.temp
        scoreboard players operation @s decorinator.id = $id decorinator.id