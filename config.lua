Config = {}

Config.transl = {
    title = "Place Object",
    description = "Move the object with WASD, rotate with Q/E, confirm with Enter, cancel with X.",
    forward = "Forward",
    backward = "Backward",
    left = "Left",
    right = "Right",
    rotate_left = "Rotate Left",
    rotate_right = "Rotate Right",
    cancel = "Cancel",
    confirm = "Confirm",
    collect = "Pick up",

    cancel_title = "Cancelled",
    cancel_msg = "was not placed.",
    removed_title = "Object Removed",
    removed_msg = "was picked up.",
    placed_title = "Object Placed",
    placed_msg = "was successfully placed.",
}

Config.Objects = {
    ['traffic_cone'] = {
        label = 'Verkehrskegel',
        model = 'prop_roadcone02b',
    },
    ['barrier'] = {
        label = 'Absperrung',
        model = 'prop_barrier_work06a',
    }
}
