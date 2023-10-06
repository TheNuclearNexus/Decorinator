data modify storage decorinator:temp item set from entity @s SelectedItem
if data storage decorinator:temp item.tag.smithed{id: "decorinator:decorinator"} function ~/mainhand:
    data modify storage decorinator:temp mode set from storage decorinator:temp item.tag.decorinator.mode
    data modify storage decorinator:temp hand set value 'mainhand'
