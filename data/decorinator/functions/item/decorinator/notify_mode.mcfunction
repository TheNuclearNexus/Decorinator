def notify(mode, color):
    append function f"decorinator:item/decorinator/notify_mode/{mode}":
        data modify storage decorinator:temp "mode" set value mode

        data modify storage decorinator:temp lore set value [
            '{"text":""}'
        ]

        data modify storage decorinator:temp lore append value f'{{"translate": "lore.decorinator.mode","color": "gray","italic": "false","with":[{{"color": "{color}", "translate": "lore.decorinator.mode.{mode}"}}]}}'

        data modify storage smithed.actionbar:input message set value {
            json: f'{{"translate": "lore.decorinator.mode","with":[{{"color": "{color}", "translate": "lore.decorinator.mode.{mode}"}}]}}',
            priority: 'notification'
        }

        function #smithed.actionbar:message

notify("move", "green")
notify("rotate", "blue")
notify("remove", "red")
notify("settings", "yellow")