#include QMK_KEYBOARD_H

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
	[0] = LAYOUT(
        KC_GRV        , KC_1, KC_2     , KC_3   , KC_4   , KC_5 ,                   KC_6 , KC_7         , KC_8   , KC_9   , KC_0   , KC_MINS,
        KC_TAB        , KC_Q, KC_W     , KC_E   , KC_R   , KC_T ,                   KC_Y , KC_U         , KC_I   , KC_O   , KC_P   , KC_BSPC,
        LCTL_T(KC_ESC), KC_A, KC_S     , KC_D   , KC_F   , KC_G ,                   KC_H , KC_J         , KC_K   , KC_L   , KC_SCLN, KC_QUOT,
        KC_LSFT       , KC_Z, KC_X     , KC_C   , KC_V   , KC_B , KC_MUTE, XXXXXXX, KC_N , KC_M         , KC_COMM, KC_DOT , KC_SLSH, KC_RSFT,
                              C(KC_TAB), KC_LGUI, KC_LALT, MO(1), KC_SPC , KC_ENT , MO(2), OSM(MOD_RALT), KC_RGUI, KC_RCTL
    ),
	[1] = LAYOUT(
        _______, KC_F1  , KC_F2  , KC_F3  , KC_F4  , KC_F5  ,                   KC_F6  , KC_F7  , KC_F8  , KC_F9  , KC_F10 , KC_F11 ,
        KC_GRV , KC_EXLM, KC_AT  , KC_HASH, KC_DLR , KC_PERC,                   KC_CIRC, KC_AMPR, KC_ASTR, KC_BSLS, KC_PLUS, KC_F12 ,
        _______, _______, KC_DQUO, KC_EQL , _______, KC_CAPS,                   KC_TILD, KC_LPRN, KC_RPRN, KC_PIPE, KC_UNDS, _______,
        _______, _______, KC_QUOT, TG(4)  , _______, _______, _______, _______, KC_LBRC, KC_LCBR, KC_RCBR, KC_RBRC, KC_MINS, _______,
                          _______, _______, _______, _______, _______, _______, MO(2)  , _______, _______, _______
    ),
	[2] = LAYOUT(
        _______, _______, _______, _______, _______, _______,                   _______, _______   , _______, _______   , _______   , _______,
        _______, KC_INS , KC_PSCR, KC_APP , XXXXXXX, XXXXXXX,                   KC_PGUP, C(KC_LEFT), C(KC_RGHT), XXXXXXX, C(KC_BSPC), KC_BSPC,
        _______, KC_LALT, KC_LCTL, KC_LSFT, XXXXXXX, XXXXXXX,                   KC_LEFT, KC_DOWN   , KC_UP     , KC_RGHT, KC_DEL    , KC_BSPC,
        _______, C(KC_Z), C(KC_X), C(KC_C), C(KC_V), XXXXXXX, _______, _______, KC_PGDN, KC_HOME   , XXXXXXX   , KC_END , XXXXXXX   , _______,
                          _______, _______, _______, MO(3)  , _______, _______, _______, _______   , _______, _______
    ),
	[3] = LAYOUT(
        XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,                   XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,
        XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,                   XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,
        XXXXXXX, RGB_TOG, RGB_HUI, RGB_SAI, RGB_VAI, XXXXXXX,                   XXXXXXX, KC_VOLD, KC_MUTE, KC_VOLU, XXXXXXX, XXXXXXX,
        XXXXXXX, RGB_MOD, RGB_HUD, RGB_SAD, RGB_VAD, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, KC_MPRV, KC_MPLY, KC_MNXT, XXXXXXX, XXXXXXX,
                          _______, _______, _______, _______, _______, _______, _______, _______, _______, _______
    ),
	[4] = LAYOUT(
        _______, _______, _______, _______, _______, _______,                   _______, _______, _______, _______, _______, _______,
        _______, _______, _______, _______, _______, _______,                   KC_PPLS, KC_7   , KC_8   , KC_9   , KC_PMNS, _______,
        _______, _______, _______, _______, _______, _______,                   KC_PAST, KC_4   , KC_5   , KC_6   , KC_PSLS, _______,
        _______, _______, _______, _______, _______, _______, _______, _______, _______, KC_1   , KC_2   , KC_3   , _______, _______,
                          _______, _______, _______, _______, _______, _______, _______, KC_0   , KC_DOT , _______
    )
};

#ifdef ENCODER_ENABLE
bool encoder_update_user(uint8_t index, bool clockwise) {
    if (index == 0) {
        if (clockwise) {
            tap_code(KC_VOLU);
        } else {
            tap_code(KC_VOLD);
        }
    } else if (index == 1) {
        if (clockwise) {
            tap_code(KC_WH_D);
        } else {
            tap_code(KC_WH_U);
        }
    }
    return false;
}
#endif
