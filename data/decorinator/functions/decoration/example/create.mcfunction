
execute summon item_display function ~/set_data:
    data merge entity @s {
        Tags:["smithed.entity", "smithed.strict", "decorinator.decoration", "decorinator.example"],
        item: {id: "minecraft:structure_block", Count:1b, tag: {CustomModelData:4269001}},
        transformation: {
            translation: [0f,0.625f,0f],
            left_rotation: [0f,0f,0f,1f],
            right_rotation: [0f,0f,0f,1f],
            scale: [1f,1f,1f]
        }
    }

    if data storage decorinator:api owner function ~/pickup:
        store result score @s decorinator.id data get storage decorinator:api owner.id
        tag @s add decorinator.held_object
        scoreboard players set $created_object decorinator.temp 1