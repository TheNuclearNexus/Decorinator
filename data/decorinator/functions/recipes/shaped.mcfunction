append function_tag smithed.crafter:event/recipes {
    "values": [
        "decorinator:recipes/shaped"
    ]
}

store result score @s smithed.data if entity @s[scores={smithed.data=0}] if data storage smithed.crafter:input recipe{
    0:[
        {Slot:0b,id: "minecraft:air"}, 
        {Slot:1b,id: "minecraft:redstone_torch"}, 
        {Slot:2b,id: "minecraft:air"}
    ],
    1:[
        {Slot:0b,id: "minecraft:iron_ingot"}, 
        {Slot:1b,id:"minecraft:redstone_block"}, 
        {Slot:2b,id: "minecraft:iron_ingot"}
    ],
    2:[
        {Slot:0b,id: "minecraft:iron_ingot"}, 
        {Slot:1b,id: "minecraft:iron_ingot"}, 
        {Slot:2b,id: "minecraft:iron_ingot"}
    ]} loot replace block ~ ~ ~ container.16 loot decorinator:items/decorinator

store result score @s smithed.data if entity @s[scores={smithed.data=0}] if data storage smithed.crafter:input recipe{
    0:[
        {Slot:0b, id: "minecraft:lapis_lazuli"}, 
        {Slot:1b, id: "minecraft:lapis_lazuli"}, 
        {Slot:2b, id: "minecraft:lapis_lazuli"}
    ],
    1:[
        {Slot:0b, id: "minecraft:lapis_lazuli"}, 
        {Slot:1b, tag: {smithed: {id: "decorinator:blueprint"}, decoration: {cloneable: 1b}}}, 
        {Slot:2b, id: "minecraft:lapis_lazuli"}
    ],
    2:[
        {Slot:0b, id: "minecraft:lapis_lazuli"}, 
        {Slot:1b, id: "minecraft:paper"}, 
        {Slot:2b, id: "minecraft:lapis_lazuli"}
    ]} function ~/copy_blueprint:
        data modify storage decorinator:temp output set from storage smithed.crafter:input recipe.1[1]
        data modify storage decorinator:temp output merge value {Slot: 16b, Count: 2b}
        item replace block ~ ~ ~ container.16 with air
        data modify block ~ ~ ~ Items append from storage decorinator:temp output