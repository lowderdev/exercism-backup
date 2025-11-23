const std = @import("std");

pub const GameState = enum {
    win,
    draw,
    ongoing,
    impossible,
};

pub fn gameState(board: []const []const u8) GameState {
    var x_count: usize = 0;
    var o_count: usize = 0;
    var i: usize = 0;
    var j: usize = 0;
    var xwin: bool = false;
    var owin: bool = false;

    while (i < 3) {
        var xrow_count: usize = 0;
        var orow_count: usize = 0;
        var xcol_count: usize = 0;
        var ocol_count: usize = 0;

        while (j < 3) {
            // check rows
            switch (board[i][j]) {
                'X' => {
                    x_count += 1;
                    xrow_count += 1;
                },
                'O' => {
                    o_count += 1;
                    orow_count += 1;
                },
                ' ' => {},
                else => unreachable,
            }

            // check columns
            switch (board[j][i]) {
                'X' => xcol_count += 1,
                'O' => ocol_count += 1,
                ' ' => {},
                else => unreachable,
            }

            j += 1;
        }

        if (xrow_count == 3) xwin = true;
        if (xcol_count == 3) xwin = true;
        if (orow_count == 3) owin = true;
        if (ocol_count == 3) owin = true;

        i += 1;
        j = 0;
    }

    // check negative diagonal
    if ((board[0][0] == 'X') and (board[1][1] == 'X') and (board[2][2] == 'X')) xwin = true;
    if ((board[0][0] == 'O') and (board[1][1] == 'O') and (board[2][2] == 'O')) owin = true;

    // check positive diagonal
    if ((board[0][2] == 'X') and (board[1][1] == 'X') and (board[2][0] == 'X')) xwin = true;
    if ((board[0][2] == 'O') and (board[1][1] == 'O') and (board[2][0] == 'O')) owin = true;

    if ((xwin and owin) or (o_count > x_count) or (x_count > o_count + 1)) return GameState.impossible;
    if (xwin or owin) return GameState.win;
    if (x_count + o_count == 9) return GameState.draw;
    return GameState.ongoing;
}
