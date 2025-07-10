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
    },
    ['colle_alien'] = {
        label = 'Alien',
        model = 'vw_prop_vw_colle_alien',
    },
    ['colle_beast'] = {
        label = 'Beast',
        model = 'vw_prop_vw_colle_beast',
    },
    ['colle_bigfoot'] = {
        label = 'Bigfoot',
        model = 'vw_prop_vw_colle_sasquatch',
    },
    ['colle_imporage'] = {
        label = 'Imporage',
        model = 'vw_prop_vw_colle_imporage',
    },
    ['colle_pogo'] = {
        label = 'Pogo',
        model = 'vw_prop_vw_colle_pogo',
    },
    ['colle_prbubble'] = {
        label = 'Prbubble',
        model = 'vw_prop_vw_colle_prbubble',
    },
    ['colle_rsrcomm'] = {
        label = 'Rsrcomm',
        model = 'vw_prop_vw_colle_rsrcomm',
    },
    ['colle_rsrgeneric'] = {
        label = 'Rsrgeneric',
        model = 'vw_prop_vw_colle_rsrgeneric',
    }
}