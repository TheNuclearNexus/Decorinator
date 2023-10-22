from bolt_expressions import Scoreboard

temp = Scoreboard("decorinator.temp")

store result score #rotation_x decorinator.temp data get entity @s Rotation[0] 100
store result score #rotation_y decorinator.temp data get entity @s Rotation[1] 100
scoreboard players operation #rotation_x decorinator.temp -= @s decorinator.rotation.x
scoreboard players operation #rotation_y decorinator.temp -= @s decorinator.rotation.y

positioned 0.0 0.0 0.0 summon marker function ~/do_trig:
    store result entity @s Rotation[0] float 0.01 scoreboard players get #rotation_x decorinator.temp
    store result entity @s Rotation[1] float 0.01 scoreboard players get #rotation_y decorinator.temp

    at @s tp @s ^ ^ ^1

    store result score $x decorinator.temp data get entity @s Pos[0] 200
    store result score $y decorinator.temp data get entity @s Pos[1] 200
    kill @s


x = temp["$x"]
y = temp["$y"]

x /= 1
y /= 1

def get_bounds(axis):
    temp[f"$upper_{axis}"] = temp[f"${axis}"]
    if score var temp[f"$upper_{axis}"] matches ..-1:
        temp[f"$upper_{axis}"] *= -1

    temp[f"$lower_{axis}"] = temp[f"$upper_{axis}"] * -1

get_bounds('x')
get_bounds('y')


selection = temp["$selection"]


selection = 0

if score var x < var temp["$upper_y"]:
    if score var x > var temp["$lower_y"] function ~/set_vertical_modes:
        if score var y matches -56..-1:
            selection = 3
        if score var y matches 0..56:
            selection = 1
if score var y < var temp["$upper_x"]:
    if score var y > var temp["$lower_x"] function ~/set_horizontal_modes:
        if score var x matches -56..-1:
            selection = 2
        if score var x matches 0..56:
            selection = 4

if score var x matches -6..6 if score var y matches -6..6:
    selection = 0
    
unless score var selection = @s decorinator.selection function ~/change_selection:
    scoreboard players operation @s decorinator.selection = $selection decorinator.temp
    playsound minecraft:ui.button.click master @s ~ ~ ~ 0.05 2

scoreboard players operation $id decorinator.id = @s decorinator.id


function ./set_highlight:
    chars = ['M','R','D','S']
    for i in range(5):  
        if score var temp["$selection"] matches i:
            data modify entity @s text set value f'{{"text": "  \\uf00{i+1}","font":"decorinator:gui"}}'

anchored eyes positioned ^ ^ ^ anchored feet:
    as @e[type=text_display, tag=decorinator.radial_menu] if score @s decorinator.id = $id decorinator.id function ~/reposition:
        tp @s ~ ~-0.001 ~

        function ./set_highlight

