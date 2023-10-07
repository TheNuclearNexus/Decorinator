data modify storage decorinator:temp mode set value 'move'

data modify storage decorinator:temp lore set value [
    '{"text":""}'
]

data modify storage decorinator:temp lore append value '{"translate": "lore.decorinator.mode","color": "gray","italic": "false","with":[{"color": "green", "translate": "lore.decorinator.mode.move"}]}'

data modify storage smithed.actionbar:input message set value {
    json: '{"translate": "lore.decorinator.mode","with":[{"color": "green", "translate": "lore.decorinator.mode.move"}]}',
    priority: 'notification'
}

function #smithed.actionbar:message