#ifndef KEYS_H
#define KEYS_H

// Listed are keyboard scan code constants (in decimal), taken from dinput.h

procedure char_to_dik(variable char) begin
  variable charmap, dik_code;
  charmap = {
    "ESCAPE":         1,
    "ESC":            1,
    "1":              2,
    "2":              3,
    "3":              4,
    "4":              5,
    "5":              6,
    "6":              7,
    "7":              8,
    "8":              9,
    "9":              10,
    "0":              11,
    "-":              12,   /* - on main keyboard */
    "=":              13,
    "BACK":           14,   /* backspace */
    "BACKSPACE":      14,   /* backspace */
    "TAB":            15,
    "Q":              16,
    "W":              17,
    "E":              18,
    "R":              19,
    "T":              20,
    "Y":              21,
    "U":              22,
    "I":              23,
    "O":              24,
    "P":              25,
    "LBRACKET":       26,
    "LEFTBRACKET":    26,
    "RIGHTBRACKET":   27,
    "RETURN":         28,   /* Enter on main keyboard */
    "ENTER":          28,   /* Enter on main keyboard */
    "LCONTROL":       29,
    "LEFTCONTROL":    29,
    "A":              30,
    "S":              31,
    "D":              32,
    "F":              33,
    "G":              34,
    "H":              35,
    "J":              36,
    "K":              37,
    "L":              38,
    ";":              39,
    "'":              40,
    "`":              41,    /* accent grave */
    "LSHIFT":         42,
    "LEFTSHIFT":      42,
    "\\":             43,
    "Z":              44,
    "X":              45,
    "C":              46,
    "V":              47,
    "B":              48,
    "N":              49,
    "M":              50,
    ",":              51,
    ".":              52,   /* . on main keyboard */
    "/":              53,   /* / on main keyboard */
    "RSHIFT":         54,
    "RIGHTSHIFT":     54,
    "*":              55,   /* * on numeric keypad */
    "LMENU":          56,   /* left Alt */
    "LEFTALT":        56,   /* left Alt */
    "SPACE":          57,
    "CAPITAL":        58,
    "F1":             59,
    "F2":             60,
    "F3":             61,
    "F4":             62,
    "F5":             63,
    "F6":             64,
    "F7":             65,
    "F8":             66,
    "F9":             67,
    "F10":            68,
    "NUMLOCK":        69,
    "SCROLL":         70,   /* Scroll Lock */
    "SCROLLOCK":      70,   /* Scroll Lock */
    "NUMPAD7":        71,
    "NUMPAD8":        72,
    "NUMPAD9":        73,
    "SUBTRACT":       74,   /* - on numeric keypad */
    "NUMPAD4":        75,
    "NUMPAD5":        76,
    "NUMPAD6":        77,
    "ADD":            78,   /* + on numeric keypad */
    "NUMPAD1":        79,
    "NUMPAD2":        80,
    "NUMPAD3":        81,
    "NUMPAD0":        82,
    "DECIMAL":        83,   /* . on numeric keypad */
    "F11":            87,
    "F12":            88,

    "NUMPADEQUALS":   0x8D,    /* = on numeric keypad (NEC PC98) */
    "AT":             0x91,    /*                     (NEC PC98) */
    "COLON":          0x92,    /*                     (NEC PC98) */
    "UNDERLINE":      0x93,    /*                     (NEC PC98) */
    "STOP":           0x95,    /*                     (NEC PC98) */
    "AX":             0x96,    /*                     (Japan AX) */
    "UNLABELED":      0x97,    /*                        (J3100) */
    "NUMPADENTER":    0x9C,    /* Enter on numeric keypad */
    "RCONTROL":       0x9D,
    "NUMPADCOMMA":    0xB3,    /* , on numeric keypad (NEC PC98) */
    "DIVIDE":         0xB5,    /* / on numeric keypad */
    "SYSRQ":          0xB7,
    "RMENU":          0xB8,    /* right Alt */
    "RIGHTALT":       0xB8,    /* right Alt */
    "HOME":           0xC7,    /* Home on arrow keypad */
    "UP":             0xC8,    /* UpArrow on arrow keypad */
    "PRIOR":          0xC9,    /* PgUp on arrow keypad */
    "PGUP":           0xC9,    /* PgUp on arrow keypad */
    "PAGEUP":         0xC9,    /* PgUp on arrow keypad */
    "LEFT":           0xCB,    /* LeftArrow on arrow keypad */
    "RIGHT":          0xCD,    /* RightArrow on arrow keypad */
    "END":            0xCF,    /* End on arrow keypad */
    "DOWN":           0xD0,    /* DownArrow on arrow keypad */
    "NEXT":           0xD1,    /* PgDn on arrow keypad */
    "PGDN":           0xD1,    /* PgDn on arrow keypad */
    "PAGEDOWN":       0xD1,    /* PgDn on arrow keypad */
    "INSERT":         0xD2,    /* Insert on arrow keypad */
    "INS":            0xD2,    /* Insert on arrow keypad */
    "DELETE":         0xD3,    /* Delete on arrow keypad */
    "DEL":            0xD3,    /* Delete on arrow keypad */
    "LWIN":           0xDB,    /* Left Windows key */
    "LEFTWIN":        0xDB,    /* Left Windows key */
    "RWIN":           0xDC,    /* Right Windows key */
    "RIGHTWIN":       0xDC,    /* Right Windows key */
    "APPS":           0xDD,    /* AppMenu key */

    "BACKSPACE":      "BACK",        /* backspace */
    "NUMPADSTAR":     "MULTIPLY",    /* * on numeric keypad */
    "LALT":           "LMENU",       /* left Alt */
    "CAPSLOCK":       "CAPITAL",     /* CapsLock */
    "NUMPADMINUS":    "SUBTRACT",    /* - on numeric keypad */
    "NUMPADPLUS":     "ADD",         /* + on numeric keypad */
    "NUMPADPERIOD":   "DECIMAL",     /* . on numeric keypad */
    "NUMPADSLASH":    "DIVIDE",      /* / on numeric keypad */
//    "RALT":           "RMENU",       /* right Alt */
    "UPARROW":        "UP",          /* UpArrow on arrow keypad */
    "LEFTARROW":      "LEFT",        /* LeftArrow on arrow keypad */
    "RIGHTARROW":     "RIGHT",       /* RightArrow on arrow keypad */
    "DOWNARROW":      "DOWN"        /* DownArrow on arrow keypad */
//    "PGDN":           "NEXT"         /* PgDn on arrow keypad */

 };

  char = string_toupper(char);
  dik_code = charmap[char];
  if dik_code == 0 then begin
    ndebug("failed to parse character " + char);
    return false;
  end
  return dik_code;
end


#endif
