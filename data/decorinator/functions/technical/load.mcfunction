append function_tag minecraft:load {
    "values": [
        "decorinator:technical/load"
    ]
}

scoreboard objectives add decorinator.id dummy
scoreboard objectives add decorinator.rotation dummy
scoreboard objectives add decorinator.selection dummy
scoreboard objectives add decorinator.temp dummy
scoreboard objectives add decorinator.pickup trigger

scoreboard objectives add decorinator.drop minecraft.custom:minecraft.drop
scoreboard objectives add decorinator.wfoas minecraft.used:minecraft.warped_fungus_on_a_stick

scoreboard players set #225 decorinator.temp 225

schedule function ./5tick 5t replace