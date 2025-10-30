extends Node
class_name CarsBatch

const Foods = DB.Food
const Cars = Car.CarID


#1
var stage_1_001 := [
    {
        'buy': [Foods.PACK_OF_TOFU],
        'car_type': Cars.CAR_001,
        'destination': Cars.CAR_FIRST_ROW,
        'delay': 0,
    },
];

#2, 6, 8
var stage_1_002 := [
    {
        'buy': [],
        'car_type': Cars.CAR_002,
        'destination': Cars.CAR_FIRST_ROW,
        'delay': 2 * 0,
    },
    {
        'buy': [Foods.TOFU_WITH_RICE_ROLL],
        'car_type': Cars.CAR_006,
        'destination': Cars.CAR_002,
        'delay': 2 * 2,
    },
    # SECOND ROW #
    {
        'buy': [],
        'car_type': Cars.CAR_008,
        'destination': Cars.CAR_SECOND_ROW,
        'delay': 2 * 1,
    },
];

# 3, 7, 16, 9
var stage_1_003 := [
    {
        'buy': [Foods.PACK_OF_TOFU],
        'car_type': Cars.CAR_003,
        'destination': Cars.CAR_FIRST_ROW,
        'delay': 2 * 0,
    },
    # SECOND ROW #
    {
        'buy': [],
        'car_type': Cars.CAR_007,
        'destination': Cars.CAR_SECOND_ROW,
        'delay': 2 * 0,
    },
    {
        'buy': [],
        'car_type': Cars.CAR_016,
        'destination': Cars.CAR_007,
        'delay': 2 * 1,
    },
    {
        'buy': [Foods.TOFU_WITH_RICE_ROLL],
        'car_type': Cars.CAR_009,
        'destination': Cars.CAR_016,
        'delay': 2 * 2,
    },
];

# {
#     'buy': [],
#     'car_type': Cars.CAR_001,
#     'destination': Cars.CAR_FIRST_ROW,
#     'delay': 2*0
# }

# 1, 4, 5, 10, 8, 13, 11
var stage_1_004 := [
    {
        'buy': [],
        'car_type': Cars.CAR_001,
        'destination': Cars.CAR_FIRST_ROW,
        'delay': 2 * 0,
    },
    {
        'buy': [],
        'car_type': Cars.CAR_004,
        'destination': Cars.CAR_001,
        'delay': 2 * 1,
    },
    {
        'buy': [],
        'car_type': Cars.CAR_005,
        'destination': Cars.CAR_004,
        'delay': 2 * 2,
    },
    # SECOND ROW #
    {
        'buy': [Foods.TOFU_WITH_RICE_ROLL],
        'car_type': Cars.CAR_010,
        'destination': Cars.CAR_SECOND_ROW,
        'delay': 2 * 0,
    },
    {
        'buy': [],
        'car_type': Cars.CAR_008,
        'destination': Cars.CAR_010,
        'delay': 2 * 1,
    },
    {
        'buy': [],
        'car_type': Cars.CAR_013,
        'destination': Cars.CAR_008,
        'delay': 2 * 2,
    },
    {
        'buy': [Foods.TOFU_WITH_RICE_ROLL],
        'car_type': Cars.CAR_011,
        'destination': Cars.CAR_013,
        'delay': 2 * 4,
    },
];

# 2
var stage_1_005 := [
    {
        'buy': [Foods.PACK_OF_TOFU],
        'car_type': Cars.CAR_002,
        'destination': Cars.CAR_SECOND_ROW,
        'delay': 0,
    },
];

# 12, 10, 14, 5, 15, 2,11
var stage_1_006 := [
    {
        'buy': [Foods.TOFU_WITH_RICE_ROLL],
        'car_type': Cars.CAR_012,
        'destination': Cars.CAR_FIRST_ROW,
        'delay': 2 * 0,
    },
    {
        'buy': [],
        'car_type': Cars.CAR_010,
        'destination': Cars.CAR_012,
        'delay': 2 * 1,
    },
    {
        'buy': [],
        'car_type': Cars.CAR_014,
        'destination': Cars.CAR_010,
        'delay': 2 * 3,
    },
    {
        'buy': [Foods.PACK_OF_TOFU],
        'car_type': Cars.CAR_005,
        'destination': Cars.CAR_014,
        'delay': 2 * 4,
    },
    # SECOND ROW #
    {
        'buy': [],
        'car_type': Cars.CAR_015,
        'destination': Cars.CAR_SECOND_ROW,
        'delay': 2 * 0,
    },
    {
        'buy': [],
        'car_type': Cars.CAR_002,
        'destination': Cars.CAR_015,
        'delay': 2 * 1,
    },
    {
        'buy': [Foods.TOFU_WITH_RICE_ROLL],
        'car_type': Cars.CAR_011,
        'destination': Cars.CAR_002,
        'delay': 2 * 2,
    },
];

#1, 6, 7 ,9 ,10 ,12, 13, 15
var stage_2_001 := [
    {
        'buy': [],
        'car_type': Cars.CAR_001,
        'delay': 2 * 0,
        'destination': Cars.CAR_FIRST_ROW,
    },
    {
        'buy': [],
        'car_type': Cars.CAR_006,
        'delay': 2 * 1,
        'destination': Cars.CAR_001,
    },
    {
        'buy': [],
        'car_type': Cars.CAR_007,
        'delay': 2 * 2,
        'destination': Cars.CAR_006,
    },
    {
        'buy': [],
        'car_type': Cars.CAR_009,
        'delay': 2 * 4,
        'destination': Cars.CAR_007,
    },
    {
        'buy': [],
        'car_type': Cars.CAR_010,
        'delay': 2 * 5,
        'destination': Cars.CAR_009,
    },
    #SECOND ROW
    {
        'buy': [],
        'car_type': Cars.CAR_012,
        'delay': 2 * 0,
        'destination': Cars.CAR_SECOND_ROW,
    },
    {
        'buy': [],
        'car_type': Cars.CAR_013,
        'delay': 2 * 1,
        'destination': Cars.CAR_012,
    },
    {
        'buy': [],
        'car_type': Cars.CAR_015,
        'delay': 2 * 3,
        'destination': Cars.CAR_013,
    },
];
#2, 3, 5, 7, 10
var stage_2_002 := [
    {
        'buy': [Foods.PACK_OF_TOFU],
        'car_type': Cars.CAR_002,
        'delay': 2 * 0,
        'destination': Cars.CAR_FIRST_ROW,
    },
    {
        'buy': [],
        'car_type': Cars.CAR_003,
        'delay': 2 * 1,
        'destination': Cars.CAR_002,
    },
    {
        'buy': [],
        'car_type': Cars.CAR_005,
        'delay': 2 * 2,
        'destination': Cars.CAR_003,
    },
    # second row
    {
        'buy': [],
        'car_type': Cars.CAR_007,
        'delay': 2 * 0,
        'destination': Cars.CAR_SECOND_ROW,
    },
    {
        'buy': [Foods.TOFU_WITH_RICE_ROLL],
        'car_type': Cars.CAR_010,
        'delay': 2 * 0,
        'destination': Cars.CAR_007,
    },
];
# 2, 3, 1, 16, 14, 11, 8
var stage_2_003 := [
    {
        'buy': [],
        'car_type': Cars.CAR_002,
        'destination': Cars.CAR_FIRST_ROW,
        'delay': 2 * 0,
    },
    {
        'buy': [],
        'car_type': Cars.CAR_003,
        'destination': Cars.CAR_002,
        'delay': 2 * 1,
    },
    {
        'buy': [Foods.COFFE],
        'car_type': Cars.CAR_001,
        'destination': Cars.CAR_003,
        'delay': 2 * 2,
    },
    #second row
    {
        'buy': [],
        'car_type': Cars.CAR_016,
        'destination': Cars.CAR_SECOND_ROW,
        'delay': 2 * 0,
    },
    {
        'buy': [],
        'car_type': Cars.CAR_014,
        'destination': Cars.CAR_016,
        'delay': 2 * 1,
    },
    {
        'buy': [],
        'car_type': Cars.CAR_011,
        'destination': Cars.CAR_014,
        'delay': 2 * 2,
    },
    {
        'buy': [],
        'car_type': Cars.CAR_008,
        'destination': Cars.CAR_011,
        'delay': 2 * 4,
    },
];
#16, 10, 11, 9, 7, 5, 3
var stage_2_004 := [
    {
        'buy': [],
        'car_type': Cars.CAR_016,
        'destination': Cars.CAR_FIRST_ROW,
        'delay': 2 * 0,
    },
    {
        'buy': [],
        'car_type': Cars.CAR_010,
        'destination': Cars.CAR_016,
        'delay': 2 * 2,
    },
    {
        'buy': [],
        'car_type': Cars.CAR_011,
        'destination': Cars.CAR_010,
        'delay': 2 * 3,
    },
    {
        'buy': [Foods.COFFE],
        'car_type': Cars.CAR_009,
        'destination': Cars.CAR_011,
        'delay': 2 * 5,
    },
    # second row
    {
        'buy': [],
        'car_type': Cars.CAR_007,
        'destination': Cars.CAR_SECOND_ROW,
        'delay': 2 * 2,
    },
    {
        'buy': [],
        'car_type': Cars.CAR_005,
        'destination': Cars.CAR_007,
        'delay': 2 * 3,
    },
    {
        'buy': [Foods.PACK_OF_TOFU],
        'car_type': Cars.CAR_003,
        'destination': Cars.CAR_005,
        'delay': 2 * 5,
    },
];
#3, 7, 8, 5, 10, 11, 15, 16, 12,
var stage_2_005 := [
    {
        'buy': [Foods.PACK_OF_TOFU],
        'car_type': Cars.CAR_003,
        'destination': Cars.CAR_FIRST_ROW,
        'delay': 2 * 2,
    },
    {
        'buy': [],
        'car_type': Cars.CAR_007,
        'destination': Cars.CAR_003,
        'delay': 2 * 4,
    },
    {
        'buy': [Foods.PACK_OF_TOFU],
        'car_type': Cars.CAR_008,
        'destination': Cars.CAR_007,
        'delay': 2 * 5,
    },
    {
        'buy': [],
        'car_type': Cars.CAR_005,
        'destination': Cars.CAR_008,
        'delay': 2 * 6,
    },
    {
        'buy': [Foods.COFFE],
        'car_type': Cars.CAR_010,
        'destination': Cars.CAR_005,
        'delay': 2 * 7,
    },
    # second row
    {
        'buy': [],
        'car_type': Cars.CAR_011,
        'destination': Cars.CAR_SECOND_ROW,
        'delay': 2 * 1,
    },
    {
        'buy': [],
        'car_type': Cars.CAR_015,
        'destination': Cars.CAR_011,
        'delay': 2 * 2,
    },
    {
        'buy': [],
        'car_type': Cars.CAR_016,
        'destination': Cars.CAR_015,
        'delay': 2 * 3,
    },
    {
        'buy': [Foods.TOFU_WITH_RICE_ROLL],
        'car_type': Cars.CAR_012,
        'destination': Cars.CAR_016,
        'delay': 2 * 4,
    },
];
#1, 7, 8, 10, 11, 12, 9
var stage_2_006 := [
    {
        'buy': [Foods.COFFE],
        'car_type': Cars.CAR_001,
        'destination': Cars.CAR_FIRST_ROW,
        'delay': 2 * 0,
    },
    {
        'buy': [Foods.TOFU_WITH_RICE_ROLL],
        'car_type': Cars.CAR_007,
        'destination': Cars.CAR_001,
        'delay': 2 * 1,
    },
    {
        'buy': [],
        'car_type': Cars.CAR_008,
        'destination': Cars.CAR_007,
        'delay': 2 * 2,
    },
    #second row
    {
        'buy': [],
        'car_type': Cars.CAR_010,
        'destination': Cars.CAR_SECOND_ROW,
        'delay': 2 * 0,
    },
    {
        'buy': [Foods.PACK_OF_TOFU],
        'car_type': Cars.CAR_011,
        'destination': Cars.CAR_010,
        'delay': 2 * 1,
    },
    {
        'buy': [],
        'car_type': Cars.CAR_012,
        'destination': Cars.CAR_011,
        'delay': 2 * 2,
    },
    {
        'buy': [],
        'car_type': Cars.CAR_009,
        'destination': Cars.CAR_012,
        'delay': 2 * 4,
    },
];
#6, 3, 1, 10, 11
var stage_2_007 := [
    {
        'buy': [],
        'car_type': Cars.CAR_006,
        'destination': Cars.CAR_FIRST_ROW,
        'delay': 2 * 2,
    },
    {
        'buy': [],
        'car_type': Cars.CAR_003,
        'destination': Cars.CAR_006,
        'delay': 2 * 4,
    },
    {
        'buy': [],
        'car_type': Cars.CAR_001,
        'destination': Cars.CAR_003,
        'delay': 2 * 5,
    },
    # second row
    {
        'buy': [],
        'car_type': Cars.CAR_010,
        'destination': Cars.CAR_SECOND_ROW,
        'delay': 2 * 0,
    },
    {
        'buy': [Foods.TOFU_WITH_RICE_ROLL],
        'car_type': Cars.CAR_011,
        'destination': Cars.CAR_010,
        'delay': 2 * 2,
    },
];

#10, 16, 11, 7, 8, 1, 3, 2
var stage_3_001 := [
    {
        'buy': [Foods.TOFU_WITH_RICE_ROLL],
        'car_type': Cars.CAR_010,
        'destination': Cars.CAR_FIRST_ROW,
        'delay': 2 * 0,
    },
    {
        'buy': [],
        'car_type': Cars.CAR_016,
        'destination': Cars.CAR_010,
        'delay': 2 * 2,
    },
    {
        'buy': [],
        'car_type': Cars.CAR_011,
        'destination': Cars.CAR_016,
        'delay': 2 * 4,
    },
    {
        'buy': [Foods.COFFE],
        'car_type': Cars.CAR_007,
        'destination': Cars.CAR_011,
        'delay': 2 * 5,
    },
    # second row
    {
        'buy': [],
        'car_type': Cars.CAR_008,
        'destination': Cars.CAR_SECOND_ROW,
        'delay': 2 * 0,
    },
    {
        'buy': [],
        'car_type': Cars.CAR_001,
        'destination': Cars.CAR_008,
        'delay': 2 * 1,
    },
    {
        'buy': [],
        'car_type': Cars.CAR_003,
        'destination': Cars.CAR_001,
        'delay': 2 * 2,
    },
    {
        'buy': [],
        'car_type': Cars.CAR_002,
        'destination': Cars.CAR_003,
        'delay': 2 * 3,
    },
];
#6, 8, 3, 1, 2, 7
var stage_3_002 := [
    {
        'buy': [],
        'car_type': Cars.CAR_006,
        'destination': Cars.CAR_FIRST_ROW,
        'delay': 2 * 0,
    },
    {
        'buy': [Foods.TOFU_WITH_RICE_ROLL],
        'car_type': Cars.CAR_008,
        'destination': Cars.CAR_006,
        'delay': 2 * 2,
    },
    # second row
    {
        'buy': [],
        'car_type': Cars.CAR_003,
        'destination': Cars.CAR_SECOND_ROW,
        'delay': 2 * 0,
    },
    {
        'buy': [],
        'car_type': Cars.CAR_001,
        'destination': Cars.CAR_003,
        'delay': 2 * 1,
    },
    {
        'buy': [],
        'car_type': Cars.CAR_002,
        'destination': Cars.CAR_001,
        'delay': 2 * 2,
    },
    {
        'buy': [Foods.PACK_OF_TOFU],
        'car_type': Cars.CAR_007,
        'destination': Cars.CAR_002,
        'delay': 2 * 3,
    },
];
#16, 8, 3, 1, 11, 14, 12, 13
var stage_3_003 := [
    {
        'buy': [Foods.COFFE],
        'car_type': Cars.CAR_016,
        'destination': Cars.CAR_FIRST_ROW,
        'delay': 2 * 1,
    },
    {
        'buy': [],
        'car_type': Cars.CAR_008,
        'destination': Cars.CAR_016,
        'delay': 2 * 2,
    },
    {
        'buy': [],
        'car_type': Cars.CAR_003,
        'destination': Cars.CAR_008,
        'delay': 2 * 3,
    },
    {
        'buy': [],
        'car_type': Cars.CAR_001,
        'destination': Cars.CAR_003,
        'delay': 2 * 4,
    },
    # second row
    {
        'buy': [],
        'car_type': Cars.CAR_011,
        'destination': Cars.CAR_SECOND_ROW,
        'delay': 2 * 0,
    },
    {
        'buy': [],
        'car_type': Cars.CAR_014,
        'destination': Cars.CAR_011,
        'delay': 2 * 1,
    },
    {
        'buy': [],
        'car_type': Cars.CAR_012,
        'destination': Cars.CAR_014,
        'delay': 2 * 2,
    },
    {
        'buy': [Foods.PACK_OF_TOFU],
        'car_type': Cars.CAR_013,
        'destination': Cars.CAR_012,
        'delay': 2 * 3,
    },
];
#16, 14, 12, 13, 11, 8, 1
var stage_3_004 := [
    {
        'buy': [],
        'car_type': Cars.CAR_016,
        'destination': Cars.CAR_FIRST_ROW,
        'delay': 2 * 0,
    },
    {
        'buy': [],
        'car_type': Cars.CAR_014,
        'destination': Cars.CAR_016,
        'delay': 2 * 1,
    },
    {
        'buy': [],
        'car_type': Cars.CAR_012,
        'destination': Cars.CAR_014,
        'delay': 2 * 2,
    },
    # second row
    {
        'buy': [],
        'car_type': Cars.CAR_013,
        'destination': Cars.CAR_SECOND_ROW,
        'delay': 2 * 0,
    },
    {
        'buy': [],
        'car_type': Cars.CAR_011,
        'destination': Cars.CAR_013,
        'delay': 2 * 1,
    },
    {
        'buy': [Foods.TOFU_WITH_RICE_ROLL],
        'car_type': Cars.CAR_008,
        'destination': Cars.CAR_011,
        'delay': 2 * 2,
    },
    {
        'buy': [],
        'car_type': Cars.CAR_001,
        'destination': Cars.CAR_008,
        'delay': 2 * 3,
    },
];

enum Batch {
    STAGE_1_001,
    STAGE_1_002,
    STAGE_1_003,
    STAGE_1_004,
    STAGE_1_005,
    STAGE_1_006,
    STAGE_2_001,
    STAGE_2_002,
    STAGE_2_003,
    STAGE_2_004,
    STAGE_2_005,
    STAGE_2_006,
    STAGE_2_007,
    STAGE_3_001,
    STAGE_3_002,
    STAGE_3_003,
    STAGE_3_004,
}

var batches = {
    Batch.STAGE_1_001: stage_1_001,
    Batch.STAGE_1_002: stage_1_002,
    Batch.STAGE_1_003: stage_1_003,
    Batch.STAGE_1_004: stage_1_004,
    Batch.STAGE_1_005: stage_1_005,
    Batch.STAGE_1_006: stage_1_006,
    Batch.STAGE_2_001: stage_2_001,
    Batch.STAGE_2_002: stage_2_002,
    Batch.STAGE_2_003: stage_2_003,
    Batch.STAGE_2_004: stage_2_004,
    Batch.STAGE_2_005: stage_2_005,
    Batch.STAGE_2_006: stage_2_006,
    Batch.STAGE_2_007: stage_2_007,
    Batch.STAGE_3_001: stage_3_001,
    Batch.STAGE_3_002: stage_3_002,
    Batch.STAGE_3_003: stage_3_003,
    Batch.STAGE_3_004: stage_3_004,
}
