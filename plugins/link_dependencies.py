import os
import shutil
from typing import Any
from beet import Cache, Context
from beet.contrib.link import LinkManager
from requests import get
import pathlib

def beet_default(ctx: Context):
    dependencies = ctx.meta.setdefault('dependencies', [])

    link_manager = ctx.inject(LinkManager)
    datapack_folder = link_manager.data_pack
    resourcepack_folder = link_manager.resource_pack

    if(datapack_folder == None or resourcepack_folder == None):
        return
    
    cache = ctx.cache.get('dependencies')

    for d in dependencies:

        check_file(datapack_folder, cache, d, d['id'] + '-dp.zip', 'datapack')
        check_file(resourcepack_folder, cache, d, d['id'] + '-rp.zip', 'resourcepack')

def check_file(folder: str, cache: Cache, dependency: Any, file_name: str, mode: str):
    target_path = pathlib.Path(folder, file_name)
    if not target_path.exists():
        url = f'https://api.smithed.dev/v2/download?pack={dependency["id"]}@{dependency["version"]}&mode={mode}'
        print(url)
        path = cache.get_path(file_name)

        if not path.exists():
            response = get(url)

            if not response.ok:
                raise Exception(response.content)
            
            with open(path, "wb") as f:
                f.write(response.content)

        shutil.copyfile(path, target_path)