const std = @import("std");

const BoolMap = enum(u8) {
    auto_left_margin = 0,
    auto_right_margin = 1,
    no_esc_ctlc = 2,
    ceol_standout_glitch = 3,
    eat_newline_glitch = 4,
    erase_overstrike = 5,
    generic_type = 6,
    hard_copy = 7,
    has_meta_key = 8,
    has_status_line = 9,
    insert_null_glitch = 10,
    memory_above = 11,
    memory_below = 12,
    move_insert_mode = 13,
    move_standout_mode = 14,
    over_strike = 15,
    status_line_esc_ok = 16,
    dest_tabs_magic_smso = 17,
    tilde_glitch = 18,
    transparent_underline = 19,
    xon_xoff = 20,
    needs_xon_xoff = 21,
    prtr_silent = 22,
    hard_cursor = 23,
    non_rev_rmcup = 24,
    no_pad_char = 25,
    non_dest_scroll_region = 26,
    can_change = 27,
    back_color_erase = 28,
    hue_lightness_saturation = 29,
    col_addr_glitch = 30,
    cr_cancels_micro_mode = 31,
    has_print_wheel = 32,
    row_addr_glitch = 33,
    semi_auto_right_margin = 34,
    cpi_changes_res = 35,
    lpi_changes_res = 36,
};

const NumberMap = enum(u8) {
    columns = 0,
    init_tabs = 1,
    lines = 2,
    lines_of_memory = 3,
    magic_cookie_glitch = 4,
    padding_baud_rate = 5,
    virtual_terminal = 6,
    width_status_line = 7,
    num_labels = 8,
    label_height = 9,
    label_width = 10,
    max_attributes = 11,
    maximum_windows = 12,
    max_colors = 13,
    max_pairs = 14,
    no_color_video = 15,
    buffer_capacity = 16,
    dot_vert_spacing = 17,
    dot_horz_spacing = 18,
    max_micro_address = 19,
    max_micro_jump = 20,
    micro_col_size = 21,
    micro_line_size = 22,
    number_of_pins = 23,
    output_res_char = 24,
    output_res_line = 25,
    output_res_horz_inch = 26,
    output_res_vert_inch = 27,
    print_rate = 28,
    wide_char_size = 29,
    buttons = 30,
    bit_image_entwining = 31,
    bit_image_type = 32,
};

const StringMap = enum(u16) {
    back_tab = 0,
    bell = 1,
    carriage_return = 2,
    change_scroll_region = 3,
    clear_all_tabs = 4,
    clear_screen = 5,
    clr_eol = 6,
    clr_eos = 7,
    column_address = 8,
    command_character = 9,
    cursor_address = 10,
    cursor_down = 11,
    cursor_home = 12,
    cursor_invisible = 13,
    cursor_left = 14,
    cursor_mem_address = 15,
    cursor_normal = 16,
    cursor_right = 17,
    cursor_to_ll = 18,
    cursor_up = 19,
    cursor_visible = 20,
    delete_character = 21,
    delete_line = 22,
    dis_status_line = 23,
    down_half_line = 24,
    enter_alt_charset_mode = 25,
    enter_blink_mode = 26,
    enter_bold_mode = 27,
    enter_ca_mode = 28,
    enter_delete_mode = 29,
    enter_dim_mode = 30,
    enter_insert_mode = 31,
    enter_secure_mode = 32,
    enter_protected_mode = 33,
    enter_reverse_mode = 34,
    enter_standout_mode = 35,
    enter_underline_mode = 36,
    erase_chars = 37,
    exit_alt_charset_mode = 38,
    exit_attribute_mode = 39,
    exit_ca_mode = 40,
    exit_delete_mode = 41,
    exit_insert_mode = 42,
    exit_standout_mode = 43,
    exit_underline_mode = 44,
    flash_screen = 45,
    form_feed = 46,
    from_status_line = 47,
    init_1string = 48,
    init_2string = 49,
    init_3string = 50,
    init_file = 51,
    insert_character = 52,
    insert_line = 53,
    insert_padding = 54,
    key_backspace = 55,
    key_catab = 56,
    key_clear = 57,
    key_ctab = 58,
    key_dc = 59,
    key_dl = 60,
    key_down = 61,
    key_eic = 62,
    key_eol = 63,
    key_eos = 64,
    key_f0 = 65,
    key_f1 = 66,
    key_f10 = 67,
    key_f2 = 68,
    key_f3 = 69,
    key_f4 = 70,
    key_f5 = 71,
    key_f6 = 72,
    key_f7 = 73,
    key_f8 = 74,
    key_f9 = 75,
    key_home = 76,
    key_ic = 77,
    key_il = 78,
    key_left = 79,
    key_ll = 80,
    key_npage = 81,
    key_ppage = 82,
    key_right = 83,
    key_sf = 84,
    key_sr = 85,
    key_stab = 86,
    key_up = 87,
    keypad_local = 88,
    keypad_xmit = 89,
    lab_f0 = 90,
    lab_f1 = 91,
    lab_f10 = 92,
    lab_f2 = 93,
    lab_f3 = 94,
    lab_f4 = 95,
    lab_f5 = 96,
    lab_f6 = 97,
    lab_f7 = 98,
    lab_f8 = 99,
    lab_f9 = 100,
    meta_off = 101,
    meta_on = 102,
    newline = 103,
    pad_char = 104,
    parm_dch = 105,
    parm_delete_line = 106,
    parm_down_cursor = 107,
    parm_ich = 108,
    parm_index = 109,
    parm_insert_line = 110,
    parm_left_cursor = 111,
    parm_right_cursor = 112,
    parm_rindex = 113,
    parm_up_cursor = 114,
    pkey_key = 115,
    pkey_local = 116,
    pkey_xmit = 117,
    print_screen = 118,
    prtr_off = 119,
    prtr_on = 120,
    repeat_char = 121,
    reset_1string = 122,
    reset_2string = 123,
    reset_3string = 124,
    reset_file = 125,
    restore_cursor = 126,
    row_address = 127,
    save_cursor = 128,
    scroll_forward = 129,
    scroll_reverse = 130,
    set_attributes = 131,
    set_tab = 132,
    set_window = 133,
    tab = 134,
    to_status_line = 135,
    underline_char = 136,
    up_half_line = 137,
    init_prog = 138,
    key_a1 = 139,
    key_a3 = 140,
    key_b2 = 141,
    key_c1 = 142,
    key_c3 = 143,
    prtr_non = 144,
    char_padding = 145,
    acs_chars = 146,
    plab_norm = 147,
    key_btab = 148,
    enter_xon_mode = 149,
    exit_xon_mode = 150,
    enter_am_mode = 151,
    exit_am_mode = 152,
    xon_character = 153,
    xoff_character = 154,
    ena_acs = 155,
    label_on = 156,
    label_off = 157,
    key_beg = 158,
    key_cancel = 159,
    key_close = 160,
    key_command = 161,
    key_copy = 162,
    key_create = 163,
    key_end = 164,
    key_enter = 165,
    key_exit = 166,
    key_find = 167,
    key_help = 168,
    key_mark = 169,
    key_message = 170,
    key_move = 171,
    key_next = 172,
    key_open = 173,
    key_options = 174,
    key_previous = 175,
    key_print = 176,
    key_redo = 177,
    key_reference = 178,
    key_refresh = 179,
    key_replace = 180,
    key_restart = 181,
    key_resume = 182,
    key_save = 183,
    key_suspend = 184,
    key_undo = 185,
    key_sbeg = 186,
    key_scancel = 187,
    key_scommand = 188,
    key_scopy = 189,
    key_screate = 190,
    key_sdc = 191,
    key_sdl = 192,
    key_select = 193,
    key_send = 194,
    key_seol = 195,
    key_sexit = 196,
    key_sfind = 197,
    key_shelp = 198,
    key_shome = 199,
    key_sic = 200,
    key_sleft = 201,
    key_smessage = 202,
    key_smove = 203,
    key_snext = 204,
    key_soptions = 205,
    key_sprevious = 206,
    key_sprint = 207,
    key_sredo = 208,
    key_sreplace = 209,
    key_sright = 210,
    key_srsume = 211,
    key_ssave = 212,
    key_ssuspend = 213,
    key_sundo = 214,
    req_for_input = 215,
    key_f11 = 216,
    key_f12 = 217,
    key_f13 = 218,
    key_f14 = 219,
    key_f15 = 220,
    key_f16 = 221,
    key_f17 = 222,
    key_f18 = 223,
    key_f19 = 224,
    key_f20 = 225,
    key_f21 = 226,
    key_f22 = 227,
    key_f23 = 228,
    key_f24 = 229,
    key_f25 = 230,
    key_f26 = 231,
    key_f27 = 232,
    key_f28 = 233,
    key_f29 = 234,
    key_f30 = 235,
    key_f31 = 236,
    key_f32 = 237,
    key_f33 = 238,
    key_f34 = 239,
    key_f35 = 240,
    key_f36 = 241,
    key_f37 = 242,
    key_f38 = 243,
    key_f39 = 244,
    key_f40 = 245,
    key_f41 = 246,
    key_f42 = 247,
    key_f43 = 248,
    key_f44 = 249,
    key_f45 = 250,
    key_f46 = 251,
    key_f47 = 252,
    key_f48 = 253,
    key_f49 = 254,
    key_f50 = 255,
    key_f51 = 256,
    key_f52 = 257,
    key_f53 = 258,
    key_f54 = 259,
    key_f55 = 260,
    key_f56 = 261,
    key_f57 = 262,
    key_f58 = 263,
    key_f59 = 264,
    key_f60 = 265,
    key_f61 = 266,
    key_f62 = 267,
    key_f63 = 268,
    clr_bol = 269,
    clear_margins = 270,
    set_left_margin = 271,
    set_right_margin = 272,
    label_format = 273,
    set_clock = 274,
    display_clock = 275,
    remove_clock = 276,
    create_window = 277,
    goto_window = 278,
    hangup = 279,
    dial_phone = 280,
    quick_dial = 281,
    tone = 282,
    pulse = 283,
    flash_hook = 284,
    fixed_pause = 285,
    wait_tone = 286,
    user0 = 287,
    user1 = 288,
    user2 = 289,
    user3 = 290,
    user4 = 291,
    user5 = 292,
    user6 = 293,
    user7 = 294,
    user8 = 295,
    user9 = 296,
    orig_pair = 297,
    orig_colors = 298,
    initialize_color = 299,
    initialize_pair = 300,
    set_color_pair = 301,
    set_foreground = 302,
    set_background = 303,
    change_char_pitch = 304,
    change_line_pitch = 305,
    change_res_horz = 306,
    change_res_vert = 307,
    define_char = 308,
    enter_doublewide_mode = 309,
    enter_draft_quality = 310,
    enter_italics_mode = 311,
    enter_leftward_mode = 312,
    enter_micro_mode = 313,
    enter_near_letter_quality = 314,
    enter_normal_quality = 315,
    enter_shadow_mode = 316,
    enter_subscript_mode = 317,
    enter_superscript_mode = 318,
    enter_upward_mode = 319,
    exit_doublewide_mode = 320,
    exit_italics_mode = 321,
    exit_leftward_mode = 322,
    exit_micro_mode = 323,
    exit_shadow_mode = 324,
    exit_subscript_mode = 325,
    exit_superscript_mode = 326,
    exit_upward_mode = 327,
    micro_column_address = 328,
    micro_down = 329,
    micro_left = 330,
    micro_right = 331,
    micro_row_address = 332,
    micro_up = 333,
    order_of_pins = 334,
    parm_down_micro = 335,
    parm_left_micro = 336,
    parm_right_micro = 337,
    parm_up_micro = 338,
    select_char_set = 339,
    set_bottom_margin = 340,
    set_bottom_margin_parm = 341,
    set_left_margin_parm = 342,
    set_right_margin_parm = 343,
    set_top_margin = 344,
    set_top_margin_parm = 345,
    start_bit_image = 346,
    start_char_set_def = 347,
    stop_bit_image = 348,
    stop_char_set_def = 349,
    subscript_characters = 350,
    superscript_characters = 351,
    these_cause_cr = 352,
    zero_motion = 353,
    char_set_names = 354,
    key_mouse = 355,
    mouse_info = 356,
    req_mouse_pos = 357,
    get_mouse = 358,
    set_a_foreground = 359,
    set_a_background = 360,
    pkey_plab = 361,
    device_type = 362,
    code_set_init = 363,
    set0_des_seq = 364,
    set1_des_seq = 365,
    set2_des_seq = 366,
    set3_des_seq = 367,
    set_lr_margin = 368,
    set_tb_margin = 369,
    bit_image_repeat = 370,
    bit_image_newline = 371,
    bit_image_carriage_return = 372,
    color_names = 373,
    define_bit_image_region = 374,
    end_bit_image_region = 375,
    set_color_band = 376,
    set_page_length = 377,
    display_pc_char = 378,
    enter_pc_charset_mode = 379,
    exit_pc_charset_mode = 380,
    enter_scancode_mode = 381,
    exit_scancode_mode = 382,
    pc_term_options = 383,
    scancode_escape = 384,
    alt_scancode_esc = 385,
    enter_horizontal_hl_mode = 386,
    enter_left_hl_mode = 387,
    enter_low_hl_mode = 388,
    enter_right_hl_mode = 389,
    enter_top_hl_mode = 390,
    enter_vertical_hl_mode = 391,
    set_a_attributes = 392,
    set_pglen_inch = 393,
};

const TerminfoHeader = packed struct {
    // LE storage
    const LEGACY_MAGIC: u16 = 0o432;
    const EXTENDED_MAGIC: u16 = 0o1036;

    magic: u16,
    terminal_names_size: u16,
    boolean_flags_size: u16,
    numbers_length: u16,
    offsets_length: u16,
    string_size: u16,
};

comptime {
    std.debug.assert(@sizeOf(TerminfoHeader) == 12);
}

pub const TermInfo = struct {
    alloc: *std.mem.Allocator,
    name: []const u8,
    strings: [394]?[]const u8,
    numbers: [32]u32,
    bool_caps: std.StaticBitSet(256),
    string_buffer: []const u8,

    pub fn getString(self: @This(), string: StringMap) ?[]const u8 {
        return self.strings[@enumToInt(string)];
    }

    pub fn getNumber(self: @This(), number: NumberMap) u32 {
        return self.numbers[@enumToInt(number)];
    }

    pub fn getName(self: @This()) []const u8 {
        return self.name;
    }

    pub fn getBoolCap(self: @This(), cap: BoolMap) bool {
        return self.bool_caps.isSet(@enumToInt(cap));
    }

    pub fn deinit(self: *@This()) void {
        self.alloc.free(self.name);
        self.alloc.free(self.string_buffer);
    }
};

pub fn loadDefinition(alloc: *std.mem.Allocator, source: anytype) !TermInfo {
    const header = try source.reader().readStruct(TerminfoHeader);
    const is_legacy = switch (header.magic) {
        TerminfoHeader.LEGACY_MAGIC => true,
        TerminfoHeader.EXTENDED_MAGIC => false,
        else => {
            std.debug.print("Invalid magic\n", .{});
            return error.InvalidMagic;
        },
    };
    const names = try source.reader().readUntilDelimiterAlloc(alloc, '\x00', 256);

    var bool_map = std.StaticBitSet(256).initEmpty();

    // Load boolean flags
    {
        var i: usize = 0;
        while (i < header.boolean_flags_size) : (i += 1) {
            const value = try source.reader().readInt(u8, .Little);
            bool_map.setValue(i, value != 0);
        }
    }

    // Align to 2
    {
        var stream = source.seekableStream();
        const offset = try stream.getPos();
        try stream.seekTo(std.mem.alignForward(offset, 2));
    }

    // Load numbers
    var numbers = [_]u32{0} ** 32;
    {
        var i: usize = 0;
        while (i < header.numbers_length) : (i += 1) {
            if (is_legacy) {
                const value = try source.reader().readInt(u16, .Little);
                numbers[i] = @as(u32, value);
            } else {
                const value = try source.reader().readInt(u32, .Little);
                numbers[i] = value;
            }
        }
    }

    // Load offsets
    var offsets = std.ArrayList(u16).init(alloc);
    defer offsets.deinit();
    {
        var i: usize = 0;
        while (i < header.offsets_length) : (i += 1) {
            const value = try source.reader().readInt(u16, .Little);
            try offsets.append(value);
        }
    }

    // Load strings
    var string_buffer = try alloc.alloc(u8, header.string_size);
    try source.reader().readNoEof(string_buffer);

    var string_map: [394]?[]const u8 = undefined;
    {
        for (string_map) |*entry| {
            entry.* = null;
        }

        for (offsets.items) |offset, i| {
            if (offset == 0xffff or i >= string_map.len) {
                continue;
            }
            string_map[i] = std.mem.sliceTo(string_buffer[offset..], '\x00');
        }
    }

    return TermInfo{
        .alloc = alloc,
        .name = names,
        .strings = string_map,
        .string_buffer = string_buffer,
        .bool_caps = bool_map,
        .numbers = numbers,
    };
}

pub fn loadTerm(alloc: *std.mem.Allocator) !TermInfo {
    // TODO implement search algorithm
    const terminal = std.os.getenv("TERM") orelse "ansi";
    const path = try std.fmt.allocPrint(alloc, "/usr/share/terminfo/{c}/{s}", .{ terminal[0], terminal });
    defer alloc.free(path);
    const file = try std.fs.cwd().openFile(path, .{});
    defer file.close();
    return loadDefinition(alloc, file);
}

// Search algorithm
// man 5 terminfo
//
// if TERMINFO is set
//   use it as the only search directory
//   return
//
//  try $HOME/.terminfo for a description
//
//  if TERMINFO_DIRS is set
//    use it as colon-separated list of search directories
//    empty directory is interpreted as compiled-in default
//  otherwise use compiled-in locations + /usr/share/terminfo
//
