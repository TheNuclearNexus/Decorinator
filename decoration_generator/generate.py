from beet import Context, subproject
from nbtlib import Float
from .resources import Decoration, DecorationData

def double_arr_to_float(arr):
    return [Float(n) for n in arr]

def fix_transformation(data: DecorationData):
    data.transformation.translation = double_arr_to_float(data.transformation.translation)
    data.transformation.left_rotation = double_arr_to_float(data.transformation.left_rotation)
    data.transformation.right_rotation = double_arr_to_float(data.transformation.right_rotation)
    data.transformation.scale = double_arr_to_float(data.transformation.scale)

    return data

def beet_default(ctx: Context):
    all_decorations = {
        name: fix_transformation(decoration.data) for name, decoration in ctx.data[Decoration].items()
    }
    ctx.data[Decoration].clear()

    ctx.require(
        subproject(
            {
                "require": ["bolt"],
                "data_pack": {"load": {"data/decoration_generator/modules": "@decoration_generator/modules"}},
                "pipeline": ["mecha"],
                "meta": {
                    "bolt": {"entrypoint": "decoration_generator:main"},
                    "decoration_generator": {"all_decorations": all_decorations},
                },
            }
        )
    )
