data modify storage decorinator:temp mode set value 'rotate'

data modify storage decorinator:temp lore set value [
    '{"text":""}'
]

data modify storage decorinator:temp lore append value '{"translate": "lore.decorinator.mode","color": "gray","italic": "false","with":[{"color": "blue", "translate": "lore.decorinator.mode.rotate"}]}'

data modify storage smithed.actionbar:input message set value {
    json: '{"translate": "lore.decorinator.mode","with":[{"color": "blue", "translate": "lore.decorinator.mode.rotate"}]}',
    priority: 'notification'
}

function #smithed.actionbar:message
