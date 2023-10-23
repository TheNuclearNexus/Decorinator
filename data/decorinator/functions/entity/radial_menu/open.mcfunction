from nbtlib import Float
scoreboard players operation $id decorinator.id = @s decorinator.id

data modify storage decorinator:temp rotation set from entity @s Rotation

store result score $rotation_x decorinator.temp data get storage decorinator:temp rotation[0] 100
scoreboard players operation @s decorinator.rotation.x = $rotation_x decorinator.temp

store result score $rotation_y decorinator.temp data get storage decorinator:temp rotation[1] 100
scoreboard players operation @s decorinator.rotation.y = $rotation_y decorinator.temp

scoreboard players set @s decorinator.selection 0

tag @s add decorinator.radial_menu_open

SCALE = 0.5

def transform(offset=0):
    return {
        translation: [Float(0.019 * SCALE),Float(0.076 * SCALE),Float(0.1 - offset)],
        left_rotation: [Float(0),Float(1),Float(0),Float(0)],
        right_rotation: [Float(0),Float(0),Float(0),Float(1)],
        scale: [Float(SCALE * 0.1 + offset),Float(SCALE * 0.1 + offset),Float(SCALE * 0.1 + offset)],
    }

anchored eyes positioned ^ ^-0.001 ^ anchored feet function ~/create_display:
    view_range = Float(2 * pow(10, -5))
    summon text_display ~ ~ ~ {
        Tags: ["decorinator.radial_menu"],
        text: '',
        view_range: view_range,
        transformation: transform(),
        teleport_duration: -1,
        background: 0,  
        alignment: center
    }
    as @e[type=text_display,tag=decorinator.radial_menu,sort=nearest,limit=1,distance=..0.2] function ~/set_data:
        data modify entity @s Rotation set from storage decorinator:temp rotation

        # on passengers store result entity @s Rotation[0] float 0.01 scoreboard players get $rotation decorinator.temp
        scoreboard players operation @s decorinator.id = $id decorinator.id