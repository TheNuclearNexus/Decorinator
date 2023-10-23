from typing import ClassVar

from beet import Context, FileDeserialize, JsonFileBase, TextFileBase
from pydantic import BaseModel


class Transformation(BaseModel):
    translation: list[float] = [0,0,0]
    left_rotation: list[float] = [0,0,0,1]
    right_rotation: list[float] = [0,0,0,1]
    scale: list[float] = [1,1,1]

class DecorationData(BaseModel):
    id: str|None
    item: str
    cmd: int
    transformation: Transformation
    cloneable: int = 0

class Decoration(JsonFileBase[DecorationData]):
    model = DecorationData

    scope: ClassVar[tuple[str, ...]] = ("decorations",)
    extension: ClassVar[str] = ".json"
    
    data: ClassVar[FileDeserialize[DecorationData]] = FileDeserialize()
    
def beet_default(ctx: Context):
    ctx.data.extend_namespace.append(Decoration)
