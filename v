_T_M_U_X(1)                                                                                                     General Commands Manual                                                                                                    _T_M_U_X(1)

NNAAMMEE
       tmux — terminal multiplexer

SSYYNNOOPPSSIISS
       ttmmuuxx [--22CCDDllNNuuVVvv] [--cc _s_h_e_l_l_-_c_o_m_m_a_n_d] [--ff _f_i_l_e] [--LL _s_o_c_k_e_t_-_n_a_m_e] [--SS _s_o_c_k_e_t_-_p_a_t_h] [--TT _f_e_a_t_u_r_e_s] [_c_o_m_m_a_n_d [_f_l_a_g_s]]

DDEESSCCRRIIPPTTIIOONN
       ttmmuuxx is a terminal multiplexer: it enables a number of terminals to be created, accessed, and controlled from a single screen.  ttmmuuxx may be detached from a screen and continue running in the background, then later reattached.

       When ttmmuuxx is started, it creates a new _s_e_s_s_i_o_n with a single _w_i_n_d_o_w and displays it on screen.  A status line at the bottom of the screen shows information on the current session and is used to enter interactive commands.

       A session is a single collection of _p_s_e_u_d_o _t_e_r_m_i_n_a_l_s under the management of ttmmuuxx.  Each session has one or more windows linked to it.  A window occupies the entire screen and may be split into rectangular panes, each of which is a
       separate  pseudo  terminal  (the  _p_t_y(4) manual page documents the technical details of pseudo terminals).  Any number of ttmmuuxx instances may connect to the same session, and any number of windows may be present in the same session.
       Once all sessions are killed, ttmmuuxx exits.

       Each session is persistent and will survive accidental disconnection (such as _s_s_h(1) connection timeout) or intentional detaching (with the ‘C-b d’ key strokes).  ttmmuuxx may be reattached using:

             $$ ttmmuuxx aattttaacchh

       In ttmmuuxx, a session is displayed on screen by a _c_l_i_e_n_t and all sessions are managed by a single _s_e_r_v_e_r.  The server and each client are separate processes which communicate through a socket in _/_t_m_p.

       The options are as follows:

       --22            Force ttmmuuxx to assume the terminal supports 256 colours.  This is equivalent to --TT _2_5_6.

       --CC            Start in control mode (see the “CONTROL MODE” section).  Given twice (--CCCC) disables echo.

       --cc _s_h_e_l_l_-_c_o_m_m_a_n_d
                     Execute _s_h_e_l_l_-_c_o_m_m_a_n_d using the default shell.  If necessary, the ttmmuuxx server will be started to retrieve the ddeeffaauulltt--sshheellll option.  This option is for compatibility with _s_h(1) when ttmmuuxx is used as a login shell.

       --DD            Do not start the ttmmuuxx server as a daemon.  This also turns the eexxiitt--eemmppttyy option off.  With --DD, _c_o_m_m_a_n_d may not be specified.

       --ff _f_i_l_e       Specify  an  alternative  configuration  file.   By  default,  ttmmuuxx  loads  the  system  configuration  file  from  _/_e_t_c_/_t_m_u_x_._c_o_n_f,  if  present,  then  looks  for  a  user  configuration  file  at   _~_/_._t_m_u_x_._c_o_n_f   or
                     _$_X_D_G___C_O_N_F_I_G___H_O_M_E_/_t_m_u_x_/_t_m_u_x_._c_o_n_f.

                     The  configuration file is a set of ttmmuuxx commands which are executed in sequence when the server is first started.  ttmmuuxx loads configuration files once when the server process has started.  The ssoouurrccee--ffiillee command may
                     be used to load a file later.

                     ttmmuuxx shows any error messages from commands in configuration files in the first session created, and continues to process the rest of the configuration file.

       --LL _s_o_c_k_e_t_-_n_a_m_e
                     ttmmuuxx stores the server socket in a directory under TMUX_TMPDIR or _/_t_m_p if it is unset.  The default socket is named _d_e_f_a_u_l_t.  This option allows a different socket name to be specified,  allowing  several  independent
                     ttmmuuxx  servers to be run.  Unlike --SS a full path is not necessary: the sockets are all created in a directory _t_m_u_x_-_U_I_D under the directory given by TMUX_TMPDIR or in _/_t_m_p.  The _t_m_u_x_-_U_I_D directory is created by ttmmuuxx and
                     must not be world readable, writable or executable.

                     If the socket is accidentally removed, the SIGUSR1 signal may be sent to the ttmmuuxx server process to recreate it (note that this will fail if any parent directories are missing).

       --ll            Behave as a login shell.  This flag currently has no effect and is for compatibility with other shells when using tmux as a login shell.

       --NN            Do not start the server even if the command would normally do so (for example nneeww--sseessssiioonn or ssttaarrtt--sseerrvveerr).

       --SS _s_o_c_k_e_t_-_p_a_t_h
                     Specify a full alternative path to the server socket.  If --SS is specified, the default socket directory is not used and any --LL flag is ignored.

       --TT _f_e_a_t_u_r_e_s   Set terminal features for the client.  This is a comma-separated list of features.  See the tteerrmmiinnaall--ffeeaattuurreess option.

       --uu            Write UTF-8 output to the terminal even if the first environment variable of LC_ALL, LC_CTYPE, or LANG that is set does not contain "UTF-8" or "UTF8".

       --VV            Report the ttmmuuxx version.

       --vv            Request verbose logging.  Log messages will be saved into _t_m_u_x_-_c_l_i_e_n_t_-_P_I_D_._l_o_g and _t_m_u_x_-_s_e_r_v_e_r_-_P_I_D_._l_o_g files in the current directory, where _P_I_D is the PID of the server or client process.  If --vv is specified twice, an
                     additional _t_m_u_x_-_o_u_t_-_P_I_D_._l_o_g file is generated with a copy of everything ttmmuuxx writes to the terminal.

                     The SIGUSR2 signal may be sent to the ttmmuuxx server process to toggle logging between on (as if --vv was given) and off.

       _c_o_m_m_a_n_d [_f_l_a_g_s]
                     This specifies one of a set of commands used to control ttmmuuxx, as described in the following sections.  If no commands are specified, the nneeww--sseessssiioonn command is assumed.

DDEEFFAAUULLTT KKEEYY BBIINNDDIINNGGSS
       ttmmuuxx may be controlled from an attached client by using a key combination of a prefix key, ‘C-b’ (Ctrl-b) by default, followed by a command key.

       The default command key bindings are:

             C-b         Send the prefix key (C-b) through to the application.
             C-o         Rotate the panes in the current window forwards.
             C-z         Suspend the ttmmuuxx client.
             !           Break the current pane out of the window.
             "           Split the current pane into two, top and bottom.
             #           List all paste buffers.
             $           Rename the current session.
             %           Split the current pane into two, left and right.
             &           Kill the current window.
             '           Prompt for a window index to select.
             (           Switch the attached client to the previous session.
             )           Switch the attached client to the next session.
             ,           Rename the current window.
             -           Delete the most recently copied buffer of text.
             .           Prompt for an index to move the current window.
             0 to 9      Select windows 0 to 9.
             :           Enter the ttmmuuxx command prompt.
             ;           Move to the previously active pane.
             =           Choose which buffer to paste interactively from a list.
             ?           List all key bindings.
             D           Choose a client to detach.
             L           Switch the attached client back to the last session.
             [           Enter copy mode to copy text or view the history.
             ]           Paste the most recently copied buffer of text.
             c           Create a new window.
             d           Detach the current client.
             f           Prompt to search for text in open windows.
             i           Display some information about the current window.
             l           Move to the previously selected window.
             m           Mark the current pane (see sseelleecctt--ppaannee --mm).
             M           Clear the marked pane.
             n           Change to the next window.
             o           Select the next pane in the current window.
             p           Change to the previous window.
             q           Briefly display pane indexes.
             r           Force redraw of the attached client.
             s           Select a new session for the attached client interactively.
             t           Show the time.
             w           Choose the current window interactively.
             x           Kill the current pane.
             z           Toggle zoom state of the current pane.
             {           Swap the current pane with the previous pane.
             }           Swap the current pane with the next pane.
             ~           Show previous messages from ttmmuuxx, if any.
             Page Up     Enter copy mode and scroll one page up.
             Up, Down
             Left, Right
                         Change to the pane above, below, to the left, or to the right of the current pane.
             M-1 to M-5  Arrange panes in one of the seven preset layouts: even-horizontal, even-vertical, main-horizontal, main-horizontal-mirrored, main-vertical, main-vertical, or tiled.
             Space       Arrange the current window in the next preset layout.
             M-n         Move to the next window with a bell or activity marker.
             M-o         Rotate the panes in the current window backwards.
             M-p         Move to the previous window with a bell or activity marker.
             C-Up, C-Down
             C-Left, C-Right
                         Resize the current pane in steps of one cell.
             M-Up, M-Down
             M-Left, M-Right
                         Resize the current pane in steps of five cells.

       Key bindings may be changed with the bbiinndd--kkeeyy and uunnbbiinndd--kkeeyy commands.

CCOOMMMMAANNDD PPAARRSSIINNGG AANNDD EEXXEECCUUTTIIOONN
       ttmmuuxx supports a large number of commands which can be used to control its behaviour.  Each command is named and can accept zero or more flags and arguments.  They may be bound to a key with the bbiinndd--kkeeyy  command  or  run  from  the
       shell prompt, a shell script, a configuration file or the command prompt.  For example, the same sseett--ooppttiioonn command run from the shell prompt, from _~_/_._t_m_u_x_._c_o_n_f and bound to a key may look like:

             $ tmux set-option -g status-style bg=cyan

             set-option -g status-style bg=cyan

             bind-key C set-option -g status-style bg=cyan

       Here, the command name is ‘set-option’, ‘--gg’ is a flag and ‘status-style’ and ‘bg=cyan’ are arguments.

       ttmmuuxx distinguishes between command parsing and execution.  In order to execute a command, ttmmuuxx needs it to be split up into its name and arguments.  This is command parsing.  If a command is run from the shell, the shell parses it;
       from inside ttmmuuxx or from a configuration file, ttmmuuxx does.  Examples of when ttmmuuxx parses commands are:

             --   in a configuration file;

             --   typed at the command prompt (see ccoommmmaanndd--pprroommpptt);

             --   given to bbiinndd--kkeeyy;

             --   passed as arguments to iiff--sshheellll or ccoonnffiirrmm--bbeeffoorree.

       To  execute  commands,  each  client has a ‘command queue’.  A global command queue not attached to any client is used on startup for configuration files like _~_/_._t_m_u_x_._c_o_n_f.  Parsed commands added to the queue are executed in order.
       Some commands, like iiff--sshheellll and ccoonnffiirrmm--bbeeffoorree, parse their argument to create a new command which is inserted immediately after themselves.  This means that arguments can be parsed twice or more - once  when  the  parent  command
       (such  as  iiff--sshheellll)  is  parsed  and  again  when  it  parses and executes its command.  Commands like iiff--sshheellll, rruunn--sshheellll and ddiissppllaayy--ppaanneess stop execution of subsequent commands on the queue until something happens - iiff--sshheellll and
       rruunn--sshheellll until a shell command finishes and ddiissppllaayy--ppaanneess until a key is pressed.  For example, the following commands:

             new-session; new-window
             if-shell "true" "split-window"
             kill-session

       Will execute nneeww--sseessssiioonn, nneeww--wwiinnddooww, iiff--sshheellll, the shell command _t_r_u_e(1), sspplliitt--wwiinnddooww and kkiillll--sseessssiioonn in that order.

       The “COMMANDS” section lists the ttmmuuxx commands and their arguments.

PPAARRSSIINNGG SSYYNNTTAAXX
       This section describes the syntax of commands parsed by ttmmuuxx, for example in a configuration file or at the command prompt.  Note that when commands are entered into the shell, they are parsed by the shell - see for example  _k_s_h(1)
       or _c_s_h(1).

       Each command is terminated by a newline or a semicolon (;).  Commands separated by semicolons together form a ‘command sequence’ - if a command in the sequence encounters an error, no subsequent commands are executed.

       It is recommended that a semicolon used as a command separator should be written as an individual token, for example from _s_h(1):

             $ tmux neww \; splitw

       Or:

             $ tmux neww ';' splitw

       Or from the tmux command prompt:

             neww ; splitw

       However, a trailing semicolon is also interpreted as a command separator, for example in these _s_h(1) commands:

             $ tmux neww\; splitw

       Or:

             $ tmux 'neww;' splitw

       As in these examples, when running tmux from the shell extra care must be taken to properly quote semicolons:

             1.   Semicolons  that  should  be  interpreted  as  a  command separator should be escaped according to the shell conventions.  For _s_h(1) this typically means quoted (such as ‘neww ';' splitw’) or escaped (such as ‘neww \\\\;
                  splitw’).

             2.   Individual semicolons or trailing semicolons that should be interpreted as arguments should be escaped twice: once according to the shell conventions and a second time for ttmmuuxx; for example:

                        $ tmux neww 'foo\\;' bar
                        $ tmux neww foo\\\\; bar

             3.   Semicolons that are not individual tokens or trailing another token should only be escaped once according to shell conventions; for example:

                        $ tmux neww 'foo-;-bar'
                        $ tmux neww foo-\\;-bar

       Comments are marked by the unquoted # character - any remaining text after a comment is ignored until the end of the line.

       If the last character of a line is \, the line is joined with the following line (the \ and the newline are completely removed).  This is called line continuation and applies both inside and outside quoted strings and in  comments,
       but not inside braces.

       Command arguments may be specified as strings surrounded by single (') quotes, double quotes (") or braces ({}).  This is required when the argument contains any special character.  Single and double quoted strings cannot span mul‐
       tiple lines except with line continuation.  Braces can span multiple lines.

       Outside of quotes and inside double quotes, these replacements are performed:

             --   Environment variables preceded by $ are replaced with their value from the global environment (see the “GLOBAL AND SESSION ENVIRONMENT” section).

             --   A leading ~ or ~user is expanded to the home directory of the current or specified user.

             --   \uXXXX or \uXXXXXXXX is replaced by the Unicode codepoint corresponding to the given four or eight digit hexadecimal number.

             --   When preceded (escaped) by a \, the following characters are replaced: \e by the escape character; \r by a carriage return; \n by a newline; and \t by a tab.

             --   \ooo is replaced by a character of the octal value ooo.  Three octal digits are required, for example \001.  The largest valid character is \377.

             --   Any  other  characters  preceded by \ are replaced by themselves (that is, the \ is removed) and are not treated as having any special meaning - so for example \; will not mark a command sequence and \$ will not expand an
                 environment variable.

       Braces are parsed as a configuration file (so conditions such as ‘%if’ are processed) and then converted into a string.  They are designed to avoid the need for additional escaping when passing a group of ttmmuuxx commands as an  argu‐
       ment (for example to iiff--sshheellll).  These two examples produce an identical command - note that no escaping is needed when using {}:

             if-shell true {
                 display -p 'brace-dollar-foo: }$foo'
             }

             if-shell true "display -p 'brace-dollar-foo: }\$foo'"

       Braces may be enclosed inside braces, for example:

             bind x if-shell "true" {
                 if-shell "true" {
                     display "true!"
                 }
             }

       Environment variables may be set by using the syntax ‘name=value’, for example ‘HOME=/home/user’.  Variables set during parsing are added to the global environment.  A hidden variable may be set with ‘%hidden’, for example:

             %hidden MYVAR=42

       Hidden variables are not passed to the environment of processes created by tmux.  See the “GLOBAL AND SESSION ENVIRONMENT” section.

       Commands may be parsed conditionally by surrounding them with ‘%if’, ‘%elif’, ‘%else’ and ‘%endif’.  The argument to ‘%if’ and ‘%elif’ is expanded as a format (see “FORMATS”) and if it evaluates to false (zero or empty), subsequent
       text is ignored until the closing ‘%elif’, ‘%else’ or ‘%endif’.  For example:

             %if "#{==:#{host},myhost}"
             set -g status-style bg=red
             %elif "#{==:#{host},myotherhost}"
             set -g status-style bg=green
             %else
             set -g status-style bg=blue
             %endif

       Will change the status line to red if running on ‘myhost’, green if running on ‘myotherhost’, or blue if running on another host.  Conditionals may be given on one line, for example:

             %if #{==:#{host},myhost} set -g status-style bg=red %endif

CCOOMMMMAANNDDSS
       This  section describes the commands supported by ttmmuuxx.  Most commands accept the optional --tt (and sometimes --ss) argument with one of _t_a_r_g_e_t_-_c_l_i_e_n_t, _t_a_r_g_e_t_-_s_e_s_s_i_o_n, _t_a_r_g_e_t_-_w_i_n_d_o_w, or _t_a_r_g_e_t_-_p_a_n_e.  These specify the client, session,
       window or pane which a command should affect.

       _t_a_r_g_e_t_-_c_l_i_e_n_t should be the name of the client, typically the _p_t_y(4) file to which the client is connected, for example either of _/_d_e_v_/_t_t_y_p_1 or _t_t_y_p_1 for the client attached to _/_d_e_v_/_t_t_y_p_1.  If no client is specified, ttmmuuxx  attempts
       to work out the client currently in use; if that fails, an error is reported.  Clients may be listed with the lliisstt--cclliieennttss command.

       _t_a_r_g_e_t_-_s_e_s_s_i_o_n is tried as, in order:

             1.   A session ID prefixed with a $.

             2.   An exact name of a session (as listed by the lliisstt--sseessssiioonnss command).

             3.   The start of a session name, for example ‘mysess’ would match a session named ‘mysession’.

             4.   An _f_n_m_a_t_c_h(3) pattern which is matched against the session name.

       If the session name is prefixed with an ‘=’, only an exact match is accepted (so ‘=mysess’ will only match exactly ‘mysess’, not ‘mysession’).

       If  a  single  session is found, it is used as the target session; multiple matches produce an error.  If a session is omitted, the current session is used if available; if no current session is available, the most recently used is
       chosen.

       _t_a_r_g_e_t_-_w_i_n_d_o_w (or _s_r_c_-_w_i_n_d_o_w or _d_s_t_-_w_i_n_d_o_w) specifies a window in the form _s_e_s_s_i_o_n:_w_i_n_d_o_w.  _s_e_s_s_i_o_n follows the same rules as for _t_a_r_g_e_t_-_s_e_s_s_i_o_n, and _w_i_n_d_o_w is looked for in order as:

             1.   A special token, listed below.

             2.   A window index, for example ‘mysession:1’ is window 1 in session ‘mysession’.

             3.   A window ID, such as @1.

             4.   An exact window name, such as ‘mysession:mywindow’.

             5.   The start of a window name, such as ‘mysession:mywin’.

             6.   As an _f_n_m_a_t_c_h(3) pattern matched against the window name.

       Like sessions, a ‘=’ prefix will do an exact match only.  An empty window name specifies the next unused index if appropriate (for example the nneeww--wwiinnddooww and lliinnkk--wwiinnddooww commands) otherwise the current window in _s_e_s_s_i_o_n is chosen.

       The following special tokens are available to indicate particular windows.  Each has a single-character alternative form.

       TTookkeenn              MMeeaanniinngg
       {{ssttaarrtt}}       ^    The lowest-numbered window
       {{eenndd}}         $    The highest-numbered window
       {{llaasstt}}        !    The last (previously current) window
       {{nneexxtt}}        +    The next window by number
       {{pprreevviioouuss}}    -    The previous window by number

       _t_a_r_g_e_t_-_p_a_n_e (or _s_r_c_-_p_a_n_e or _d_s_t_-_p_a_n_e) may be a pane ID or takes a similar form to _t_a_r_g_e_t_-_w_i_n_d_o_w but with the optional addition of a period followed by a pane index or pane ID, for example: ‘mysession:mywindow.1’.  If the pane index
       is omitted, the currently active pane in the specified window is used.  The following special tokens are available for the pane index:

       TTookkeenn                  MMeeaanniinngg
       {{llaasstt}}            !    The last (previously active) pane
       {{nneexxtt}}            +    The next pane by number
       {{pprreevviioouuss}}        -    The previous pane by number
       {{ttoopp}}                  The top pane
       {{bboottttoomm}}               The bottom pane
       {{lleefftt}}                 The leftmost pane
       {{rriigghhtt}}                The rightmost pane
       {{ttoopp--lleefftt}}             The top-left pane
       {{ttoopp--rriigghhtt}}            The top-right pane
       {{bboottttoomm--lleefftt}}          The bottom-left pane
       {{bboottttoomm--rriigghhtt}}         The bottom-right pane
       {{uupp--ooff}}                The pane above the active pane
       {{ddoowwnn--ooff}}              The pane below the active pane
       {{lleefftt--ooff}}              The pane to the left of the active pane
       {{rriigghhtt--ooff}}             The pane to the right of the active pane

       The tokens ‘+’ and ‘-’ may be followed by an offset, for example:

             select-window -t:+2

       In addition, _t_a_r_g_e_t_-_s_e_s_s_i_o_n, _t_a_r_g_e_t_-_w_i_n_d_o_w or _t_a_r_g_e_t_-_p_a_n_e may consist entirely of the token ‘{mouse}’ (alternative form ‘=’) to specify the session, window or pane where the most recent mouse event occurred (see the “MOUSE SUPPORT”
       section) or ‘{marked}’ (alternative form ‘~’) to specify the marked pane (see sseelleecctt--ppaannee --mm).

       Sessions, window and panes are each numbered with a unique ID; session IDs are prefixed with a ‘$’, windows with a ‘@’, and panes with a ‘%’.  These are unique and are unchanged for the life of the session, window or  pane  in  the
       ttmmuuxx  server.   The  pane  ID  is  passed  to  the child process of the pane in the TMUX_PANE environment variable.  IDs may be displayed using the ‘session_id’, ‘window_id’, or ‘pane_id’ formats (see the “FORMATS” section) and the
       ddiissppllaayy--mmeessssaaggee, lliisstt--sseessssiioonnss, lliisstt--wwiinnddoowwss or lliisstt--ppaanneess commands.

       _s_h_e_l_l_-_c_o_m_m_a_n_d arguments are _s_h(1) commands.  This may be a single argument passed to the shell, for example:

             new-window 'vi ~/.tmux.conf'

       Will run:

             /bin/sh -c 'vi ~/.tmux.conf'

       Additionally, the nneeww--wwiinnddooww, nneeww--sseessssiioonn, sspplliitt--wwiinnddooww, rreessppaawwnn--wwiinnddooww and rreessppaawwnn--ppaannee commands allow _s_h_e_l_l_-_c_o_m_m_a_n_d to be given as multiple arguments and executed directly (without ‘sh -c’).  This  can  avoid  issues  with  shell
       quoting.  For example:

             $ tmux new-window vi ~/.tmux.conf

       Will run _v_i(1) directly without invoking the shell.

       _c_o_m_m_a_n_d [_a_r_g_u_m_e_n_t _._._.] refers to a ttmmuuxx command, either passed with the command and arguments separately, for example:

             bind-key F1 set-option status off

       Or passed as a single string argument in _._t_m_u_x_._c_o_n_f, for example:

             bind-key F1 { set-option status off }

       Example ttmmuuxx commands include:

             refresh-client -t/dev/ttyp2

             rename-session -tfirst newname

             set-option -wt:0 monitor-activity on

             new-window ; split-window -d

             bind-key R source-file ~/.tmux.conf \; \
                     display-message "source-file done"

       Or from _s_h(1):

             $ tmux kill-window -t :1

             $ tmux new-window \; split-window -d

             $ tmux new-session -d 'vi ~/.tmux.conf' \; split-window -d \; attach

CCLLIIEENNTTSS AANNDD SSEESSSSIIOONNSS
       The  ttmmuuxx server manages clients, sessions, windows and panes.  Clients are attached to sessions to interact with them, either when they are created with the nneeww--sseessssiioonn command, or later with the aattttaacchh--sseessssiioonn command.  Each ses‐
       sion has one or more windows _l_i_n_k_e_d into it.  Windows may be linked to multiple sessions and are made up of one or more panes, each of which contains a pseudo terminal.  Commands for creating,  linking  and  otherwise  manipulating
       windows are covered in the “WINDOWS AND PANES” section.

       The following commands are available to manage clients and sessions:

       aattttaacchh--sseessssiioonn [--ddEErrxx] [--cc _w_o_r_k_i_n_g_-_d_i_r_e_c_t_o_r_y] [--ff _f_l_a_g_s] [--tt _t_a_r_g_e_t_-_s_e_s_s_i_o_n]
                     (alias: aattttaacchh)
               If  run  from  outside  ttmmuuxx,  attach to _t_a_r_g_e_t_-_s_e_s_s_i_o_n in the current terminal.  _t_a_r_g_e_t_-_s_e_s_s_i_o_n must already exist - to create a new session, see the nneeww--sseessssiioonn command (with --AA to create or attach).  If used from inside,
               switch the currently attached session to _t_a_r_g_e_t_-_s_e_s_s_i_o_n.  If --dd is specified, any other clients attached to the session are detached.  If --xx is given, send SIGHUP to the parent process of the client as well as detaching the
               client, typically causing it to exit.  --ff sets a comma-separated list of client flags.  The flags are:

               active-pane
                       the client has an independent active pane

               ignore-size
                       the client does not affect the size of other clients

               no-output
                       the client does not receive pane output in control mode

               pause-after=seconds
                       output is paused once the pane is _s_e_c_o_n_d_s behind in control mode

               read-only
                       the client is read-only

               wait-exit
                       wait for an empty line input before exiting in control mode

               A leading ‘!’ turns a flag off if the client is already attached.  --rr is an alias for --ff _r_e_a_d_-_o_n_l_y_,_i_g_n_o_r_e_-_s_i_z_e.  When a client is read-only, only keys bound to the ddeettaacchh--cclliieenntt or sswwiittcchh--cclliieenntt commands have any effect.  A
               client with the _a_c_t_i_v_e_-_p_a_n_e flag allows the active pane to be selected independently of the window's active pane used by clients without the flag.  This only affects the cursor position and commands issued from the  client;
               other features such as hooks and styles continue to use the window's active pane.

               If no server is started, aattttaacchh--sseessssiioonn will attempt to start it; this will fail unless sessions are created in the configuration file.

               The _t_a_r_g_e_t_-_s_e_s_s_i_o_n rules for aattttaacchh--sseessssiioonn are slightly adjusted: if ttmmuuxx needs to select the most recently used session, it will prefer the most recently used _u_n_a_t_t_a_c_h_e_d session.

               --cc will set the session working directory (used for new windows) to _w_o_r_k_i_n_g_-_d_i_r_e_c_t_o_r_y.

               If --EE is used, the uuppddaattee--eennvviirroonnmmeenntt option will not be applied.

       ddeettaacchh--cclliieenntt [--aaPP] [--EE _s_h_e_l_l_-_c_o_m_m_a_n_d] [--ss _t_a_r_g_e_t_-_s_e_s_s_i_o_n] [--tt _t_a_r_g_e_t_-_c_l_i_e_n_t]
                     (alias: ddeettaacchh)
               Detach  the  current  client  if  bound  to a key, the client specified with --tt, or all clients currently attached to the session specified by --ss.  The --aa option kills all but the client given with --tt.  If --PP is given, send
               SIGHUP to the parent process of the client, typically causing it to exit.  With --EE, run _s_h_e_l_l_-_c_o_m_m_a_n_d to replace the client.

       hhaass--sseessssiioonn [--tt _t_a_r_g_e_t_-_s_e_s_s_i_o_n]
                     (alias: hhaass)
               Report an error and exit with 1 if the specified session does not exist.  If it does exist, exit with 0.

       kkiillll--sseerrvveerr
               Kill the ttmmuuxx server and clients and destroy all sessions.

       kkiillll--sseessssiioonn [--aaCC] [--tt _t_a_r_g_e_t_-_s_e_s_s_i_o_n]
               Destroy the given session, closing any windows linked to it and no other sessions, and detaching all clients attached to it.  If --aa is given, all sessions but the specified one is killed.  The --CC flag clears  alerts  (bell,
               activity, or silence) in all windows linked to the session.

       lliisstt--cclliieennttss [--FF _f_o_r_m_a_t] [--ff _f_i_l_t_e_r] [--tt _t_a_r_g_e_t_-_s_e_s_s_i_o_n]
                     (alias: llsscc)
               List  all  clients  attached to the server.  --FF specifies the format of each line and --ff a filter.  Only clients for which the filter is true are shown.  See the “FORMATS” section.  If _t_a_r_g_e_t_-_s_e_s_s_i_o_n is specified, list only
               clients connected to that session.

       lliisstt--ccoommmmaannddss [--FF _f_o_r_m_a_t] [_c_o_m_m_a_n_d]
                     (alias: llssccmm)
               List the syntax of _c_o_m_m_a_n_d or - if omitted - of all commands supported by ttmmuuxx.

       lliisstt--sseessssiioonnss [--FF _f_o_r_m_a_t] [--ff _f_i_l_t_e_r]
                     (alias: llss)
               List all sessions managed by the server.  --FF specifies the format of each line and --ff a filter.  Only sessions for which the filter is true are shown.  See the “FORMATS” section.

       lloocckk--cclliieenntt [--tt _t_a_r_g_e_t_-_c_l_i_e_n_t]
                     (alias: lloocckkcc)
               Lock _t_a_r_g_e_t_-_c_l_i_e_n_t, see the lloocckk--sseerrvveerr command.

       lloocckk--sseessssiioonn [--tt _t_a_r_g_e_t_-_s_e_s_s_i_o_n]
                     (alias: lloocckkss)
               Lock all clients attached to _t_a_r_g_e_t_-_s_e_s_s_i_o_n.

       nneeww--sseessssiioonn [--AAddDDEEPPXX] [--cc _s_t_a_r_t_-_d_i_r_e_c_t_o_r_y] [--ee _e_n_v_i_r_o_n_m_e_n_t] [--ff _f_l_a_g_s] [--FF _f_o_r_m_a_t] [--nn _w_i_n_d_o_w_-_n_a_m_e] [--ss _s_e_s_s_i_o_n_-_n_a_m_e] [--tt _g_r_o_u_p_-_n_a_m_e] [--xx _w_i_d_t_h] [--yy _h_e_i_g_h_t] [_s_h_e_l_l_-_c_o_m_m_a_n_d]
                     (alias: nneeww)
               Create a new session with name _s_e_s_s_i_o_n_-_n_a_m_e.

               The new session is attached to the current terminal unless --dd is given.  _w_i_n_d_o_w_-_n_a_m_e and _s_h_e_l_l_-_c_o_m_m_a_n_d are the name of and shell command to execute in the initial window.  With --dd, the initial size  comes  from  the  global
               ddeeffaauulltt--ssiizzee option; --xx and --yy can be used to specify a different size.  ‘-’ uses the size of the current client if any.  If --xx or --yy is given, the ddeeffaauulltt--ssiizzee option is set for the session.  --ff sets a comma-separated list
               of client flags (see aattttaacchh--sseessssiioonn).

               If run from a terminal, any _t_e_r_m_i_o_s(4) special characters are saved and used for new windows in the new session.

               The --AA flag makes nneeww--sseessssiioonn behave like aattttaacchh--sseessssiioonn if _s_e_s_s_i_o_n_-_n_a_m_e already exists; if --AA is given, --DD behaves like --dd to aattttaacchh--sseessssiioonn, and --XX behaves like --xx to aattttaacchh--sseessssiioonn.

               If  --tt  is  given, it specifies a sseessssiioonn ggrroouupp.  Sessions in the same group share the same set of windows - new windows are linked to all sessions in the group and any windows closed removed from all sessions.  The current
               and previous window and any session options remain independent and any session in a group may be killed without affecting the others.  The _g_r_o_u_p_-_n_a_m_e argument may be:

               1.      the name of an existing group, in which case the new session is added to that group;

               2.      the name of an existing session - the new session is added to the same group as that session, creating a new group if necessary;

               3.      the name for a new group containing only the new session.

               --nn and _s_h_e_l_l_-_c_o_m_m_a_n_d are invalid if --tt is used.

               The --PP option prints information about the new session after it has been created.  By default, it uses the format ‘#{session_name}:’ but a different format may be specified with --FF.

               If --EE is used, the uuppddaattee--eennvviirroonnmmeenntt option will not be applied.  --ee takes the form ‘VARIABLE=value’ and sets an environment variable for the newly created session; it may be specified multiple times.

       rreeffrreesshh--cclliieenntt [--ccDDLLRRSSUU] [--AA _p_a_n_e_:_s_t_a_t_e] [--BB _n_a_m_e_:_w_h_a_t_:_f_o_r_m_a_t] [--CC _s_i_z_e] [--ff _f_l_a_g_s] [--ll [_t_a_r_g_e_t_-_p_a_n_e]] [--rr _p_a_n_e_:_r_e_p_o_r_t] [--tt _t_a_r_g_e_t_-_c_l_i_e_n_t] [_a_d_j_u_s_t_m_e_n_t]
                     (alias: rreeffrreesshh)
               Refresh the current client if bound to a key, or a single client if one is given with --tt.  If --SS is specified, only update the client's status line.

               The --UU, --DD, --LL --RR, and --cc flags allow the visible portion of a window which is larger than the client to be changed.  --UU moves the visible part up by _a_d_j_u_s_t_m_e_n_t rows and --DD down, --LL left by _a_d_j_u_s_t_m_e_n_t columns and --RR  right.
               --cc  returns to tracking the cursor automatically.  If _a_d_j_u_s_t_m_e_n_t is omitted, 1 is used.  Note that the visible position is a property of the client not of the window, changing the current window in the attached session will
               reset it.

               --CC sets the width and height of a control mode client or of a window for a control mode client, _s_i_z_e must be one of ‘widthxheight’ or ‘window ID:widthxheight’, for example ‘80x24’ or ‘@0:80x24’.  --AA allows  a  control  mode
               client  to  trigger  actions  on  a  pane.   The argument is a pane ID (with leading ‘%’), a colon, then one of ‘on’, ‘off’, ‘continue’ or ‘pause’.  If ‘off’, ttmmuuxx will not send output from the pane to the client and if all
               clients have turned the pane off, will stop reading from the pane.  If ‘continue’, ttmmuuxx will return to sending output to the pane if it was paused (manually or with the _p_a_u_s_e_-_a_f_t_e_r flag).  If ‘pause’, ttmmuuxx  will  pause  the
               pane.  --AA may be given multiple times for different panes.

               --BB  sets  a  subscription to a format for a control mode client.  The argument is split into three items by colons: _n_a_m_e is a name for the subscription; _w_h_a_t is a type of item to subscribe to; _f_o_r_m_a_t is the format.  After a
               subscription is added, changes to the format are reported with the %%ssuubbssccrriippttiioonn--cchhaannggeedd notification, at most once a second.  If only the name is given, the subscription is removed.  _w_h_a_t may be empty to check  the  format
               only for the attached session, or one of: a pane ID such as ‘%0’; ‘%*’ for all panes in the attached session; a window ID such as ‘@0’; or ‘@*’ for all windows in the attached session.

               --ff  sets  a  comma-separated  list  of client flags, see aattttaacchh--sseessssiioonn.  --rr allows a control mode client to provide information about a pane via a report (such as the response to OSC 10).  The argument is a pane ID (with a
               leading ‘%’), a colon, then a report escape sequence.

               --ll requests the clipboard from the client using the _x_t_e_r_m(1) escape sequence.  If _t_a_r_g_e_t_-_p_a_n_e is given, the clipboard is sent (in encoded form), otherwise it is stored in a new paste buffer.

               --LL, --RR, --UU and --DD move the visible portion of the window left, right, up or down by _a_d_j_u_s_t_m_e_n_t, if the window is larger than the client.  --cc resets so that the position follows the cursor.  See the wwiinnddooww--ssiizzee option.

       rreennaammee--sseessssiioonn [--tt _t_a_r_g_e_t_-_s_e_s_s_i_o_n] _n_e_w_-_n_a_m_e
                     (alias: rreennaammee)
               Rename the session to _n_e_w_-_n_a_m_e.

       sseerrvveerr--aacccceessss [--aaddllrrww] [_u_s_e_r]
               Change the access or read/write permission of _u_s_e_r.  The user running the ttmmuuxx server (its owner) and the root user cannot be changed and are always permitted access.

               --aa and --dd are used to give or revoke access for the specified user.  If the user is already attached, the --dd flag causes their clients to be detached.

               --rr and --ww change the permissions for _u_s_e_r: --rr makes their clients read-only and --ww writable.  --ll lists current access permissions.

               By default, the access list is empty and ttmmuuxx creates sockets with file system permissions preventing access by any user other than the owner (and root).  These permissions must be changed manually.  Great  care  should  be
               taken not to allow access to untrusted users even read-only.

       sshhooww--mmeessssaaggeess [--JJTT] [--tt _t_a_r_g_e_t_-_c_l_i_e_n_t]
                     (alias: sshhoowwmmssggss)
               Show server messages or information.  Messages are stored, up to a maximum of the limit set by the _m_e_s_s_a_g_e_-_l_i_m_i_t server option.  --JJ and --TT show debugging information about jobs and terminals.

       ssoouurrccee--ffiillee [--FFnnqqvv] [--tt _t_a_r_g_e_t_-_p_a_n_e] _p_a_t_h _._._.
                     (alias: ssoouurrccee)
               Execute  commands  from one or more files specified by _p_a_t_h (which may be _g_l_o_b(7) patterns).  If --FF is present, then _p_a_t_h is expanded as a format.  If --qq is given, no error will be returned if _p_a_t_h does not exist.  With --nn,
               the file is parsed but no commands are executed.  --vv shows the parsed commands and line numbers if possible.

       ssttaarrtt--sseerrvveerr
                     (alias: ssttaarrtt)
               Start the ttmmuuxx server, if not already running, without creating any sessions.

               Note that as by default the ttmmuuxx server will exit with no sessions, this is only useful if a session is created in _~_/_._t_m_u_x_._c_o_n_f, eexxiitt--eemmppttyy is turned off, or another command is run as part of the same command sequence.  For
               example:

                     $ tmux start \; show -g

       ssuussppeenndd--cclliieenntt [--tt _t_a_r_g_e_t_-_c_l_i_e_n_t]
                     (alias: ssuussppeennddcc)
               Suspend a client by sending SIGTSTP (tty stop).

       sswwiittcchh--cclliieenntt [--EEllnnpprrZZ] [--cc _t_a_r_g_e_t_-_c_l_i_e_n_t] [--tt _t_a_r_g_e_t_-_s_e_s_s_i_o_n] [--TT _k_e_y_-_t_a_b_l_e]
                     (alias: sswwiittcchhcc)
               Switch the current session for client _t_a_r_g_e_t_-_c_l_i_e_n_t to _t_a_r_g_e_t_-_s_e_s_s_i_o_n.  As a special case, --tt may refer to a pane (a target that contains ‘:’, ‘.’ or ‘%’), to change session, window and pane.  In that  case,  --ZZ  keeps  the
               window zoomed if it was zoomed.  If --ll, --nn or --pp is used, the client is moved to the last, next or previous session respectively.  --rr toggles the client rreeaadd--oonnllyy and iiggnnoorree--ssiizzee flags (see the aattttaacchh--sseessssiioonn command).

               If --EE is used, uuppddaattee--eennvviirroonnmmeenntt option will not be applied.

               --TT  sets  the  client's key table; the next key from the client will be interpreted from _k_e_y_-_t_a_b_l_e.  This may be used to configure multiple prefix keys, or to bind commands to sequences of keys.  For example, to make typing
               ‘abc’ run the lliisstt--kkeeyyss command:

                     bind-key -Ttable2 c list-keys
                     bind-key -Ttable1 b switch-client -Ttable2
                     bind-key -Troot   a switch-client -Ttable1

WWIINNDDOOWWSS AANNDD PPAANNEESS
       Each window displayed by ttmmuuxx may be split into one or more _p_a_n_e_s; each pane takes up a certain area of the display and is a separate terminal.  A window may be split into panes using the sspplliitt--wwiinnddooww command.  Windows may be split
       horizontally (with the --hh flag) or vertically.  Panes may be resized with the rreessiizzee--ppaannee command (bound to ‘C-Up’, ‘C-Down’ ‘C-Left’ and ‘C-Right’ by default), the current pane may be changed with the sseelleecctt--ppaannee command  and  the
       rroottaattee--wwiinnddooww and sswwaapp--ppaannee commands may be used to swap panes without changing their position.  Panes are numbered beginning from zero in the order they are created.

       By default, a ttmmuuxx pane permits direct access to the terminal contained in the pane.  A pane may also be put into one of several modes:

             --   Copy mode, which permits a section of a window or its history to be copied to a _p_a_s_t_e _b_u_f_f_e_r for later insertion into another window.  This mode is entered with the ccooppyy--mmooddee command, bound to ‘[’ by default.  Copied text
                 can be pasted with the ppaassttee--bbuuffffeerr command, bound to ‘]’.

             --   View mode, which is like copy mode but is entered when a command that produces output, such as lliisstt--kkeeyyss, is executed from a key binding.

             --   Choose mode, which allows an item to be chosen from a list.  This may be a client, a session or window or pane, or a buffer.  This mode is entered with the cchhoooossee--bbuuffffeerr, cchhoooossee--cclliieenntt and cchhoooossee--ttrreeee commands.

       In copy mode an indicator is displayed in the top-right corner of the pane with the current position and the number of lines in the history.

       Commands  are sent to copy mode using the --XX flag to the sseenndd--kkeeyyss command.  When a key is pressed, copy mode automatically uses one of two key tables, depending on the mmooddee--kkeeyyss option: ccooppyy--mmooddee for emacs, or ccooppyy--mmooddee--vvii for vi.
       Key tables may be viewed with the lliisstt--kkeeyyss command.

       The following commands are supported in copy mode:

       aappppeenndd--sseelleeccttiioonn
               Append the selection to the top paste buffer.

       aappppeenndd--sseelleeccttiioonn--aanndd--ccaanncceell (vi: A)
               Append the selection to the top paste buffer and exit copy mode.

       bbaacckk--ttoo--iinnddeennttaattiioonn (vi: ^) (emacs: M-m)
               Move the cursor back to the indentation.

       bbeeggiinn--sseelleeccttiioonn (vi: Space) (emacs: C-Space)
               Begin selection.

       bboottttoomm--lliinnee (vi: L)
               Move to the bottom line.

       ccaanncceell (vi: q) (emacs: Escape)
               Exit copy mode.

       cclleeaarr--sseelleeccttiioonn (vi: Escape) (emacs: C-g)
               Clear the current selection.

       ccooppyy--eenndd--ooff--lliinnee [_p_r_e_f_i_x]
               Copy from the cursor position to the end of the line.  _p_r_e_f_i_x is used to name the new paste buffer.

       ccooppyy--eenndd--ooff--lliinnee--aanndd--ccaanncceell [_p_r_e_f_i_x]
               Copy from the cursor position and exit copy mode.

       ccooppyy--ppiippee--eenndd--ooff--lliinnee [_c_o_m_m_a_n_d] [_p_r_e_f_i_x]
               Copy from the cursor position to the end of the line and pipe the text to _c_o_m_m_a_n_d.  _p_r_e_f_i_x is used to name the new paste buffer.

       ccooppyy--ppiippee--eenndd--ooff--lliinnee--aanndd--ccaanncceell [_c_o_m_m_a_n_d] [_p_r_e_f_i_x]
               Same as ccooppyy--ppiippee--eenndd--ooff--lliinnee but also exit copy mode.

       ccooppyy--lliinnee [_p_r_e_f_i_x]
               Copy the entire line.

       ccooppyy--lliinnee--aanndd--ccaanncceell [_p_r_e_f_i_x]
               Copy the entire line and exit copy mode.

       ccooppyy--ppiippee--lliinnee [_c_o_m_m_a_n_d] [_p_r_e_f_i_x]
               Copy the entire line and pipe the text to _c_o_m_m_a_n_d.  _p_r_e_f_i_x is used to name the new paste buffer.

       ccooppyy--ppiippee--lliinnee--aanndd--ccaanncceell [_c_o_m_m_a_n_d] [_p_r_e_f_i_x]
               Same as ccooppyy--ppiippee--lliinnee but also exit copy mode.

       ccooppyy--ppiippee [_c_o_m_m_a_n_d] [_p_r_e_f_i_x]
               Copy the selection, clear it and pipe its text to _c_o_m_m_a_n_d.  _p_r_e_f_i_x is used to name the new paste buffer.

       ccooppyy--ppiippee--nnoo--cclleeaarr [_c_o_m_m_a_n_d] [_p_r_e_f_i_x]
               Same as ccooppyy--ppiippee but do not clear the selection.

       ccooppyy--ppiippee--aanndd--ccaanncceell [_c_o_m_m_a_n_d] [_p_r_e_f_i_x]
               Same as ccooppyy--ppiippee but also exit copy mode.

       ccooppyy--sseelleeccttiioonn [_p_r_e_f_i_x]
               Copies the current selection.

       ccooppyy--sseelleeccttiioonn--nnoo--cclleeaarr [_p_r_e_f_i_x]
               Same as ccooppyy--sseelleeccttiioonn but do not clear the selection.

       ccooppyy--sseelleeccttiioonn--aanndd--ccaanncceell [_p_r_e_f_i_x] (vi: Enter) (emacs: M-w)
               Copy the current selection and exit copy mode.

       ccuurrssoorr--ddoowwnn (vi: j) (emacs: Down)
               Move the cursor down.

       ccuurrssoorr--ddoowwnn--aanndd--ccaanncceell
               Same as ccuurrssoorr--ddoowwnn but also exit copy mode if reaching the bottom.

       ccuurrssoorr--lleefftt (vi: h) (emacs: Left)
               Move the cursor left.

       ccuurrssoorr--rriigghhtt (vi: l) (emacs: Right)
               Move the cursor right.

       ccuurrssoorr--uupp (vi: k) (emacs: Up)
               Move the cursor up.

       eenndd--ooff--lliinnee (vi: $) (emacs: C-e)
               Move the cursor to the end of the line.

       ggoottoo--lliinnee _l_i_n_e (vi: :) (emacs: g)
               Move the cursor to a specific line.

       hhaallffppaaggee--ddoowwnn (vi: C-d) (emacs: M-Down)
               Scroll down by half a page.

       hhaallffppaaggee--ddoowwnn--aanndd--ccaanncceell
               Same as hhaallffppaaggee--ddoowwnn but also exit copy mode if reaching the bottom.

       hhaallffppaaggee--uupp (vi: C-u) (emacs: M-Up)
               Scroll up by half a page.

       hhiissttoorryy--bboottttoomm (vi: G) (emacs: M->)
               Scroll to the bottom of the history.

       hhiissttoorryy--ttoopp (vi: g) (emacs: M-<)
               Scroll to the top of the history.

       jjuummpp--aaggaaiinn (vi: ;) (emacs: ;)
               Repeat the last jump.

       jjuummpp--bbaacckkwwaarrdd _t_o (vi: F) (emacs: F)
               Jump backwards to the specified text.

       jjuummpp--ffoorrwwaarrdd _t_o (vi: f) (emacs: f)
               Jump forward to the specified text.

       jjuummpp--rreevveerrssee (vi: ,) (emacs: ,)
               Repeat the last jump in the reverse direction (forward becomes backward and backward becomes forward).

       jjuummpp--ttoo--bbaacckkwwaarrdd _t_o (vi: T)
               Jump backwards, but one character less, placing the cursor on the character after the target.

       jjuummpp--ttoo--ffoorrwwaarrdd _t_o (vi: t)
               Jump forward, but one character less, placing the cursor on the character before the target.

       jjuummpp--ttoo--mmaarrkk (vi: M-x) (emacs: M-x)
               Jump to the last mark.

       mmiiddddllee--lliinnee (vi: M) (emacs: M-r)
               Move to the middle line.

       nneexxtt--mmaattcchhiinngg--bbrraacckkeett (vi: %) (emacs: M-C-f)
               Move to the next matching bracket.

       nneexxtt--ppaarraaggrraapphh (vi: }) (emacs: M-})
               Move to the next paragraph.

       nneexxtt--pprroommpptt [--oo]
               Move to the next prompt.

       nneexxtt--wwoorrdd (vi: w)
               Move to the next word.

       nneexxtt--wwoorrdd--eenndd (vi: e) (emacs: M-f)
               Move to the end of the next word.

       nneexxtt--ssppaaccee (vi: W)
               Same as nneexxtt--wwoorrdd but use a space alone as the word separator.

       nneexxtt--ssppaaccee--eenndd (vi: E)
               Same as nneexxtt--wwoorrdd--eenndd but use a space alone as the word separator.

       ootthheerr--eenndd (vi: o)
               Switch at which end of the selection the cursor sits.

       ppaaggee--ddoowwnn (vi: C-f) (emacs: PageDown)
               Scroll down by one page.

       ppaaggee--ddoowwnn--aanndd--ccaanncceell
               Same as ppaaggee--ddoowwnn but also exit copy mode if reaching the bottom.

       ppaaggee--uupp (vi: C-b) (emacs: PageUp)
               Scroll up by one page.

       ppiippee [_c_o_m_m_a_n_d]
               Pipe the selected text to _c_o_m_m_a_n_d and clear the selection.

       ppiippee--nnoo--cclleeaarr [_c_o_m_m_a_n_d]
               Same as ppiippee but do not clear the selection.

       ppiippee--aanndd--ccaanncceell [_c_o_m_m_a_n_d] [_p_r_e_f_i_x]
               Same as ppiippee but also exit copy mode.

       pprreevviioouuss--mmaattcchhiinngg--bbrraacckkeett (emacs: M-C-b)
               Move to the previous matching bracket.

       pprreevviioouuss--ppaarraaggrraapphh (vi: {) (emacs: M-{)
               Move to the previous paragraph.

       pprreevviioouuss--pprroommpptt [--oo]
               Move to the previous prompt.

       pprreevviioouuss--wwoorrdd (vi: b) (emacs: M-b)
               Move to the previous word.

       pprreevviioouuss--ssppaaccee (vi: B)
               Same as pprreevviioouuss--wwoorrdd but use a space alone as the word separator.

       rreeccttaannggllee--oonn
               Turn on rectangle selection mode.

       rreeccttaannggllee--ooffff
               Turn off rectangle selection mode.

       rreeccttaannggllee--ttooggggllee (vi: v) (emacs: R)
               Toggle rectangle selection mode.

       rreeffrreesshh--ffrroomm--ppaannee (vi: r) (emacs: r)
               Refresh the content from the pane.

       ssccrroollll--bboottttoomm
               Scroll up until the current line is at the bottom while keeping the cursor on that line.

       ssccrroollll--ddoowwnn (vi: C-e) (emacs: C-Down)
               Scroll down.

       ssccrroollll--ddoowwnn--aanndd--ccaanncceell
               Same as ssccrroollll--ddoowwnn but also exit copy mode if the cursor reaches the bottom.

       ssccrroollll--mmiiddddllee (vi: z)
               Scroll so that the current line becomes the middle one while keeping the cursor on that line.

       ssccrroollll--ttoopp
               Scroll down until the current line is at the top while keeping the cursor on that line.

       ssccrroollll--uupp (vi: C-y) (emacs: C-Up)
               Scroll up.

       sseeaarrcchh--aaggaaiinn (vi: n) (emacs: n)
               Repeat the last search.

       sseeaarrcchh--bbaacckkwwaarrdd _t_e_x_t (vi: ?)
               Search backwards for the specified text.

       sseeaarrcchh--bbaacckkwwaarrdd--iinnccrreemmeennttaall _t_e_x_t (emacs: C-r)
               Search backwards incrementally for the specified text.  Is expected to be used with the --ii flag to the ccoommmmaanndd--pprroommpptt command.

       sseeaarrcchh--bbaacckkwwaarrdd--tteexxtt _t_e_x_t
               Search backwards for the specified plain text.

       sseeaarrcchh--ffoorrwwaarrdd _t_e_x_t (vi: /)
               Search forward for the specified text.

       sseeaarrcchh--ffoorrwwaarrdd--iinnccrreemmeennttaall _t_e_x_t (emacs: C-s)
               Search forward incrementally for the specified text.  Is expected to be used with the --ii flag to the ccoommmmaanndd--pprroommpptt command.

       sseeaarrcchh--ffoorrwwaarrdd--tteexxtt _t_e_x_t
               Search forward for the specified plain text.

       sseeaarrcchh--rreevveerrssee (vi: N) (emacs: N)
               Repeat the last search in the reverse direction (forward becomes backward and backward becomes forward).

       sseelleecctt--lliinnee (vi: V)
               Select the current line.

       sseelleecctt--wwoorrdd
               Select the current word.

       sseett--mmaarrkk (vi: X) (emacs: X)
               Mark the current line.

       ssttaarrtt--ooff--lliinnee (vi: 0) (emacs: C-a)
               Move the cursor to the start of the line.

       ssttoopp--sseelleeccttiioonn
               Stop selecting without clearing the current selection.

       ttooggggllee--ppoossiittiioonn (vi: P) (emacs: P)
               Toggle the visibility of the position indicator in the top right.

       ttoopp--lliinnee (vi: H) (emacs: M-R)
               Move to the top line.

       The search commands come in several varieties: ‘search-forward’ and ‘search-backward’ search for a regular expression; the ‘-text’ variants search for a plain text string rather than a regular expression; ‘-incremental’ perform  an
       incremental  search  and expect to be used with the --ii flag to the ccoommmmaanndd--pprroommpptt command.  ‘search-again’ repeats the last search and ‘search-reverse’ does the same but reverses the direction (forward becomes backward and backward
       becomes forward).

       The ‘next-prompt’ and ‘previous-prompt’ move between shell prompts, but require the shell to emit an escape sequence (\033]133;A\033\\) to tell ttmmuuxx where the prompts are located; if the shell does not do this, these commands  will
       do nothing.  The --oo flag jumps to the beginning of the command output instead of the shell prompt.

       Copy  commands may take an optional buffer prefix argument which is used to generate the buffer name (the default is ‘buffer’ so buffers are named ‘buffer0’, ‘buffer1’ and so on).  Pipe commands take a command argument which is the
       command to which the selected text is piped.  ‘copy-pipe’ variants also copy the selection.  The ‘-and-cancel’ variants of some commands exit copy mode after they have completed (for copy commands) or when the  cursor  reaches  the
       bottom (for scrolling commands).  ‘-no-clear’ variants do not clear the selection.

       The  next  and  previous word keys skip over whitespace and treat consecutive runs of either word separators or other letters as words.  Word separators can be customized with the _w_o_r_d_-_s_e_p_a_r_a_t_o_r_s session option.  Next word moves to
       the start of the next word, next word end to the end of the next word and previous word to the start of the previous word.  The three next and previous space keys work similarly but use a space alone as the word separator.  Setting
       _w_o_r_d_-_s_e_p_a_r_a_t_o_r_s to the empty string makes next/previous word equivalent to next/previous space.

       The jump commands enable quick movement within a line.  For instance, typing ‘f’ followed by ‘/’ will move the cursor to the next ‘/’ character on the current line.  A ‘;’ will then jump to the next occurrence.

       Commands in copy mode may be prefaced by an optional repeat count.  With vi key bindings, a prefix is entered using the number keys; with emacs, the Alt (meta) key and a number begins prefix entry.

       The synopsis for the ccooppyy--mmooddee command is:

       ccooppyy--mmooddee [--ddeeHHMMqquu] [--ss _s_r_c_-_p_a_n_e] [--tt _t_a_r_g_e_t_-_p_a_n_e]
               Enter copy mode.  --uu also scrolls one page up after entering and --dd one page down if already in copy mode.  --MM begins a mouse drag (only valid if bound to a mouse key binding, see “MOUSE SUPPORT”).  --HH  hides  the  position
               indicator in the top right.  --qq cancels copy mode and any other modes.  --ss copies from _s_r_c_-_p_a_n_e instead of _t_a_r_g_e_t_-_p_a_n_e.

               --ee  specifies that scrolling to the bottom of the history (to the visible screen) should exit copy mode.  While in copy mode, pressing a key other than those used for scrolling will disable this behaviour.  This is intended
               to allow fast scrolling through a pane's history, for example with:

                     bind PageUp copy-mode -eu
                     bind PageDown copy-mode -ed

       A number of preset arrangements of panes are available, these are called layouts.  These may be selected with the sseelleecctt--llaayyoouutt command or cycled with nneexxtt--llaayyoouutt (bound to ‘Space’ by default); once a layout is chosen, panes within
       it may be moved and resized as normal.

       The following layouts are supported:

       eevveenn--hhoorriizzoonnttaall
               Panes are spread out evenly from left to right across the window.

       eevveenn--vveerrttiiccaall
               Panes are spread evenly from top to bottom.

       mmaaiinn--hhoorriizzoonnttaall
               A large (main) pane is shown at the top of the window and the remaining panes are spread from left to right in the leftover space at the bottom.  Use the _m_a_i_n_-_p_a_n_e_-_h_e_i_g_h_t window option to specify the height of the top pane.

       mmaaiinn--hhoorriizzoonnttaall--mmiirrrroorreedd
               The same as mmaaiinn--hhoorriizzoonnttaall but mirrored so the main pane is at the bottom of the window.

       mmaaiinn--vveerrttiiccaall
               A large (main) pane is shown on the left of the window and the remaining panes are spread from top to bottom in the leftover space on the right.  Use the _m_a_i_n_-_p_a_n_e_-_w_i_d_t_h window option to specify the width of the left pane.

       mmaaiinn--vveerrttiiccaall--mmiirrrroorreedd
               The same as mmaaiinn--vveerrttiiccaall but mirrored so the main pane is on the right of the window.

       ttiilleedd   Panes are spread out as evenly as possible over the window in both rows and columns.

       In addition, sseelleecctt--llaayyoouutt may be used to apply a previously used layout - the lliisstt--wwiinnddoowwss command displays the layout of each window in a form suitable for use with sseelleecctt--llaayyoouutt.  For example:

             $ tmux list-windows
             0: ksh [159x48]
                 layout: bb62,159x48,0,0{79x48,0,0,79x48,80,0}
             $ tmux select-layout 'bb62,159x48,0,0{79x48,0,0,79x48,80,0}'

       ttmmuuxx automatically adjusts the size of the layout for the current window size.  Note that a layout cannot be applied to a window with more panes than that from which the layout was originally defined.

       Commands related to windows and panes are as follows:

       bbrreeaakk--ppaannee [--aabbddPP] [--FF _f_o_r_m_a_t] [--nn _w_i_n_d_o_w_-_n_a_m_e] [--ss _s_r_c_-_p_a_n_e] [--tt _d_s_t_-_w_i_n_d_o_w]
                     (alias: bbrreeaakkpp)
               Break _s_r_c_-_p_a_n_e off from its containing window to make it the only pane in _d_s_t_-_w_i_n_d_o_w.  With --aa or --bb, the window is moved to the next index after or before (existing windows are moved if necessary).  If --dd is given, the new
               window does not become the current window.  The --PP option prints information about the new window after it has been created.  By default, it uses the format ‘#{session_name}:#{window_index}.#{pane_index}’  but  a  different
               format may be specified with --FF.

       ccaappttuurree--ppaannee [--aaAAeeppPPqqCCJJNN] [--bb _b_u_f_f_e_r_-_n_a_m_e] [--EE _e_n_d_-_l_i_n_e] [--SS _s_t_a_r_t_-_l_i_n_e] [--tt _t_a_r_g_e_t_-_p_a_n_e]
                     (alias: ccaappttuurreepp)
               Capture  the contents of a pane.  If --pp is given, the output goes to stdout, otherwise to the buffer specified with --bb or a new buffer if omitted.  If --aa is given, the alternate screen is used, and the history is not acces‐
               sible.  If no alternate screen exists, an error will be returned unless --qq is given.  If --ee is given, the output includes escape sequences for text and background attributes.  --CC also escapes non-printable characters as oc‐
               tal \xxx.  --TT ignores trailing positions that do not contain a character.  --NN preserves trailing spaces at each line's end and --JJ preserves trailing spaces and joins any wrapped lines; --JJ implies --TT.  --PP captures  only  any
               output that the pane has received that is the beginning of an as-yet incomplete escape sequence.

               --SS and --EE specify the starting and ending line numbers, zero is the first line of the visible pane and negative numbers are lines in the history.  ‘-’ to --SS is the start of the history and to --EE the end of the visible pane.
               The default is to capture only the visible contents of the pane.

       cchhoooossee--cclliieenntt [--NNrrZZ] [--FF _f_o_r_m_a_t] [--ff _f_i_l_t_e_r] [--KK _k_e_y_-_f_o_r_m_a_t] [--OO _s_o_r_t_-_o_r_d_e_r] [--tt _t_a_r_g_e_t_-_p_a_n_e] [_t_e_m_p_l_a_t_e]
               Put  a pane into client mode, allowing a client to be selected interactively from a list.  Each client is shown on one line.  A shortcut key is shown on the left in brackets allowing for immediate choice, or the list may be
               navigated and an item chosen or otherwise manipulated using the keys below.  --ZZ zooms the pane.  The following keys may be used in client mode:

                     KKeeyy    FFuunnccttiioonn
                     EEnntteerr  Choose selected client
                     UUpp     Select previous client
                     DDoowwnn   Select next client
                     CC--ss    Search by name
                     nn      Repeat last search forwards
                     NN      Repeat last search backwards
                     tt      Toggle if client is tagged
                     TT      Tag no clients
                     CC--tt    Tag all clients
                     dd      Detach selected client
                     DD      Detach tagged clients
                     xx      Detach and HUP selected client
                     XX      Detach and HUP tagged clients
                     zz      Suspend selected client
                     ZZ      Suspend tagged clients
                     ff      Enter a format to filter items
                     OO      Change sort field
                     rr      Reverse sort order
                     vv      Toggle preview
                     qq      Exit mode

               After a client is chosen, ‘%%’ is replaced by the client name in _t_e_m_p_l_a_t_e and the result executed as a command.  If _t_e_m_p_l_a_t_e is not given, "detach-client -t '%%'" is used.

               --OO specifies the initial sort field: one of ‘name’, ‘size’, ‘creation’ (time), or ‘activity’ (time).  --rr reverses the sort order.  --ff specifies an initial filter: the filter is a format - if it evaluates to zero,  the  item
               in the list is not shown, otherwise it is shown.  If a filter would lead to an empty list, it is ignored.  --FF specifies the format for each item in the list and --KK a format for each shortcut key; both are evaluated once for
               each line.  --NN starts without the preview.  This command works only if at least one client is attached.

       cchhoooossee--ttrreeee [--GGNNrrsswwZZ] [--FF _f_o_r_m_a_t] [--ff _f_i_l_t_e_r] [--KK _k_e_y_-_f_o_r_m_a_t] [--OO _s_o_r_t_-_o_r_d_e_r] [--tt _t_a_r_g_e_t_-_p_a_n_e] [_t_e_m_p_l_a_t_e]
               Put a pane into tree mode, where a session, window or pane may be chosen interactively from a tree.  Each session, window or pane is shown on one line.  A shortcut key is shown on the left in brackets allowing for immediate
               choice, or the tree may be navigated and an item chosen or otherwise manipulated using the keys below.  --ss starts with sessions collapsed and --ww with windows collapsed.  --ZZ zooms the pane.  The following keys may be used in
               tree mode:

                     KKeeyy    FFuunnccttiioonn
                     EEnntteerr  Choose selected item
                     UUpp     Select previous item
                     DDoowwnn   Select next item
                     ++      Expand selected item
                     --      Collapse selected item
                     MM--++    Expand all items
                     MM----    Collapse all items
                     xx      Kill selected item
                     XX      Kill tagged items
                     <<      Scroll list of previews left
                     >>      Scroll list of previews right
                     CC--ss    Search by name
                     mm      Set the marked pane
                     MM      Clear the marked pane
                     nn      Repeat last search forwards
                     NN      Repeat last search backwards
                     tt      Toggle if item is tagged
                     TT      Tag no items
                     CC--tt    Tag all items
                     ::      Run a command for each tagged item
                     ff      Enter a format to filter items
                     HH      Jump to the starting pane
                     OO      Change sort field
                     rr      Reverse sort order
                     vv      Toggle preview
                     qq      Exit mode

               After a session, window or pane is chosen, the first instance of ‘%%’ and all instances of ‘%1’ are replaced by the target in _t_e_m_p_l_a_t_e and the result executed as a command.  If _t_e_m_p_l_a_t_e is not given, "switch-client -t '%%'"
               is used.

               --OO  specifies the initial sort field: one of ‘index’, ‘name’, or ‘time’ (activity).  --rr reverses the sort order.  --ff specifies an initial filter: the filter is a format - if it evaluates to zero, the item in the list is not
               shown, otherwise it is shown.  If a filter would lead to an empty list, it is ignored.  --FF specifies the format for each item in the tree and --KK a format for each shortcut key; both are evaluated once  for  each  line.   --NN
               starts without the preview.  --GG includes all sessions in any session groups in the tree rather than only the first.  This command works only if at least one client is attached.

       ccuussttoommiizzee--mmooddee [--NNZZ] [--FF _f_o_r_m_a_t] [--ff _f_i_l_t_e_r] [--tt _t_a_r_g_e_t_-_p_a_n_e] [_t_e_m_p_l_a_t_e]
               Put a pane into customize mode, where options and key bindings may be browsed and modified from a list.  Option values in the list are shown for the active pane in the current window.  --ZZ zooms the pane.  The following keys
               may be used in customize mode:

                     KKeeyy    FFuunnccttiioonn
                     EEnntteerr  Set pane, window, session or global option value
                     UUpp     Select previous item
                     DDoowwnn   Select next item
                     ++      Expand selected item
                     --      Collapse selected item
                     MM--++    Expand all items
                     MM----    Collapse all items
                     ss      Set option value or key attribute
                     SS      Set global option value
                     ww      Set window option value, if option is for pane and window
                     dd      Set an option or key to the default
                     DD      Set tagged options and tagged keys to the default
                     uu      Unset an option (set to default value if global) or unbind a key
                     UU      Unset tagged options and unbind tagged keys
                     CC--ss    Search by name
                     nn      Repeat last search forwards
                     NN      Repeat last search backwards
                     tt      Toggle if item is tagged
                     TT      Tag no items
                     CC--tt    Tag all items
                     ff      Enter a format to filter items
                     vv      Toggle option information
                     qq      Exit mode

               --ff  specifies  an initial filter: the filter is a format - if it evaluates to zero, the item in the list is not shown, otherwise it is shown.  If a filter would lead to an empty list, it is ignored.  --FF specifies the format
               for each item in the tree.  --NN starts without the option information.  This command works only if at least one client is attached.

       ddiissppllaayy--ppaanneess [--bbNN] [--dd _d_u_r_a_t_i_o_n] [--tt _t_a_r_g_e_t_-_c_l_i_e_n_t] [_t_e_m_p_l_a_t_e]
                     (alias: ddiissppllaayypp)
               Display a visible indicator of each pane shown by _t_a_r_g_e_t_-_c_l_i_e_n_t.  See the ddiissppllaayy--ppaanneess--ccoolloouurr and ddiissppllaayy--ppaanneess--aaccttiivvee--ccoolloouurr session options.  The indicator is closed when a key is pressed (unless --NN is given) or _d_u_r_a_t_i_o_n
               milliseconds have passed.  If --dd is not given, ddiissppllaayy--ppaanneess--ttiimmee is used.  A duration of zero means the indicator stays until a key is pressed.  While the indicator is on screen, a pane may be chosen with the  ‘0’  to  ‘9’
               keys,  which will cause _t_e_m_p_l_a_t_e to be executed as a command with ‘%%’ substituted by the pane ID.  The default _t_e_m_p_l_a_t_e is "select-pane -t '%%'".  With --bb, other commands are not blocked from running until the indicator is
               closed.

       ffiinndd--wwiinnddooww [--iiCCNNrrTTZZ] [--tt _t_a_r_g_e_t_-_p_a_n_e] _m_a_t_c_h_-_s_t_r_i_n_g
                     (alias: ffiinnddww)
               Search for a _f_n_m_a_t_c_h(3) pattern or, with --rr, regular expression _m_a_t_c_h_-_s_t_r_i_n_g in window names, titles, and visible content (but not history).  The flags control matching behavior: --CC matches only visible window contents,  --NN
               matches only the window name and --TT matches only the window title.  --ii makes the search ignore case.  The default is --CCNNTT.  --ZZ zooms the pane.

               This command works only if at least one client is attached.

       jjooiinn--ppaannee [--bbddffhhvv] [--ll _s_i_z_e] [--ss _s_r_c_-_p_a_n_e] [--tt _d_s_t_-_p_a_n_e]
                     (alias: jjooiinnpp)
               Like  sspplliitt--wwiinnddooww,  but  instead  of splitting _d_s_t_-_p_a_n_e and creating a new pane, split it and move _s_r_c_-_p_a_n_e into the space.  This can be used to reverse bbrreeaakk--ppaannee.  The --bb option causes _s_r_c_-_p_a_n_e to be joined to left of or
               above _d_s_t_-_p_a_n_e.

               If --ss is omitted and a marked pane is present (see sseelleecctt--ppaannee --mm), the marked pane is used rather than the current pane.

       kkiillll--ppaannee [--aa] [--tt _t_a_r_g_e_t_-_p_a_n_e]
                     (alias: kkiillllpp)
               Destroy the given pane.  If no panes remain in the containing window, it is also destroyed.  The --aa option kills all but the pane given with --tt.

       kkiillll--wwiinnddooww [--aa] [--tt _t_a_r_g_e_t_-_w_i_n_d_o_w]
                     (alias: kkiillllww)
               Kill the current window or the window at _t_a_r_g_e_t_-_w_i_n_d_o_w, removing it from any sessions to which it is linked.  The --aa option kills all but the window given with --tt.

       llaasstt--ppaannee [--ddeeZZ] [--tt _t_a_r_g_e_t_-_w_i_n_d_o_w]
                     (alias: llaassttpp)
               Select the last (previously selected) pane.  --ZZ keeps the window zoomed if it was zoomed.  --ee enables or --dd disables input to the pane.

       llaasstt--wwiinnddooww [--tt _t_a_r_g_e_t_-_s_e_s_s_i_o_n]
                     (alias: llaasstt)
               Select the last (previously selected) window.  If no _t_a_r_g_e_t_-_s_e_s_s_i_o_n is specified, select the last window of the current session.

       lliinnkk--wwiinnddooww [--aabbddkk] [--ss _s_r_c_-_w_i_n_d_o_w] [--tt _d_s_t_-_w_i_n_d_o_w]
                     (alias: lliinnkkww)
               Link the window at _s_r_c_-_w_i_n_d_o_w to the specified _d_s_t_-_w_i_n_d_o_w.  If _d_s_t_-_w_i_n_d_o_w is specified and no such window exists, the _s_r_c_-_w_i_n_d_o_w is linked there.  With --aa or --bb the window  is  moved  to  the  next  index  after  or  before
               _d_s_t_-_w_i_n_d_o_w (existing windows are moved if necessary).  If --kk is given and _d_s_t_-_w_i_n_d_o_w exists, it is killed, otherwise an error is generated.  If --dd is given, the newly linked window is not selected.

       lliisstt--ppaanneess [--aass] [--FF _f_o_r_m_a_t] [--ff _f_i_l_t_e_r] [--tt _t_a_r_g_e_t]
                     (alias: llsspp)
               If  --aa  is  given, _t_a_r_g_e_t is ignored and all panes on the server are listed.  If --ss is given, _t_a_r_g_e_t is a session (or the current session).  If neither is given, _t_a_r_g_e_t is a window (or the current window).  --FF specifies the
               format of each line and --ff a filter.  Only panes for which the filter is true are shown.  See the “FORMATS” section.

       lliisstt--wwiinnddoowwss [--aa] [--FF _f_o_r_m_a_t] [--ff _f_i_l_t_e_r] [--tt _t_a_r_g_e_t_-_s_e_s_s_i_o_n]
                     (alias: llssww)
               If --aa is given, list all windows on the server.  Otherwise, list windows in the current session or in _t_a_r_g_e_t_-_s_e_s_s_i_o_n.  --FF specifies the format of each line and --ff a filter.  Only windows for which the  filter  is  true  are
               shown.  See the “FORMATS” section.

       mmoovvee--ppaannee [--bbddffhhvv] [--ll _s_i_z_e] [--ss _s_r_c_-_p_a_n_e] [--tt _d_s_t_-_p_a_n_e]
                     (alias: mmoovveepp)
               Does the same as jjooiinn--ppaannee.

       mmoovvee--wwiinnddooww [--aabbrrddkk] [--ss _s_r_c_-_w_i_n_d_o_w] [--tt _d_s_t_-_w_i_n_d_o_w]
                     (alias: mmoovveeww)
               This is similar to lliinnkk--wwiinnddooww, except the window at _s_r_c_-_w_i_n_d_o_w is moved to _d_s_t_-_w_i_n_d_o_w.  With --rr, all windows in the session are renumbered in sequential order, respecting the bbaassee--iinnddeexx option.

       nneeww--wwiinnddooww [--aabbddkkPPSS] [--cc _s_t_a_r_t_-_d_i_r_e_c_t_o_r_y] [--ee _e_n_v_i_r_o_n_m_e_n_t] [--FF _f_o_r_m_a_t] [--nn _w_i_n_d_o_w_-_n_a_m_e] [--tt _t_a_r_g_e_t_-_w_i_n_d_o_w] [_s_h_e_l_l_-_c_o_m_m_a_n_d]
                     (alias: nneewwww)
               Create a new window.  With --aa or --bb, the new window is inserted at the next index after or before the specified _t_a_r_g_e_t_-_w_i_n_d_o_w, moving windows up if necessary; otherwise _t_a_r_g_e_t_-_w_i_n_d_o_w is the new window location.

               If  --dd  is given, the session does not make the new window the current window.  _t_a_r_g_e_t_-_w_i_n_d_o_w represents the window to be created; if the target already exists an error is shown, unless the --kk flag is used, in which case it
               is destroyed.  If --SS is given and a window named _w_i_n_d_o_w_-_n_a_m_e already exists, it is selected (unless --dd is also given in which case the command does nothing).

               _s_h_e_l_l_-_c_o_m_m_a_n_d is the command to execute.  If _s_h_e_l_l_-_c_o_m_m_a_n_d is not specified, the value of the ddeeffaauulltt--ccoommmmaanndd option is used.  --cc specifies the working directory in which the new window is created.

               When the shell command completes, the window closes.  See the rreemmaaiinn--oonn--eexxiitt option to change this behaviour.

               --ee takes the form ‘VARIABLE=value’ and sets an environment variable for the newly created window; it may be specified multiple times.

               The TERM environment variable must be set to ‘screen’ or ‘tmux’ for all programs running _i_n_s_i_d_e ttmmuuxx.  New windows will automatically have ‘TERM=screen’ added to their environment, but care must be taken not to  reset  this
               in shell start-up files or by the --ee option.

               The --PP option prints information about the new window after it has been created.  By default, it uses the format ‘#{session_name}:#{window_index}’ but a different format may be specified with --FF.

       nneexxtt--llaayyoouutt [--tt _t_a_r_g_e_t_-_w_i_n_d_o_w]
                     (alias: nneexxttll)
               Move a window to the next layout and rearrange the panes to fit.

       nneexxtt--wwiinnddooww [--aa] [--tt _t_a_r_g_e_t_-_s_e_s_s_i_o_n]
                     (alias: nneexxtt)
               Move to the next window in the session.  If --aa is used, move to the next window with an alert.

       ppiippee--ppaannee [--IIOOoo] [--tt _t_a_r_g_e_t_-_p_a_n_e] [_s_h_e_l_l_-_c_o_m_m_a_n_d]
                     (alias: ppiippeepp)
               Pipe  output  sent  by  the  program  in _t_a_r_g_e_t_-_p_a_n_e to a shell command or vice versa.  A pane may only be connected to one command at a time, any existing pipe is closed before _s_h_e_l_l_-_c_o_m_m_a_n_d is executed.  The _s_h_e_l_l_-_c_o_m_m_a_n_d
               string may contain the special character sequences supported by the ssttaattuuss--lleefftt option.  If no _s_h_e_l_l_-_c_o_m_m_a_n_d is given, the current pipe (if any) is closed.

               --II and --OO specify which of the _s_h_e_l_l_-_c_o_m_m_a_n_d output streams are connected to the pane: with --II stdout is connected (so anything _s_h_e_l_l_-_c_o_m_m_a_n_d prints is written to the pane as if it were typed); with --OO  stdin  is  connected
               (so any output in the pane is piped to _s_h_e_l_l_-_c_o_m_m_a_n_d).  Both may be used together and if neither are specified, --OO is used.

               The --oo option only opens a new pipe if no previous pipe exists, allowing a pipe to be toggled with a single key, for example:

                     bind-key C-p pipe-pane -o 'cat >>~/output.#I-#P'

       pprreevviioouuss--llaayyoouutt [--tt _t_a_r_g_e_t_-_w_i_n_d_o_w]
                     (alias: pprreevvll)
               Move to the previous layout in the session.

       pprreevviioouuss--wwiinnddooww [--aa] [--tt _t_a_r_g_e_t_-_s_e_s_s_i_o_n]
                     (alias: pprreevv)
               Move to the previous window in the session.  With --aa, move to the previous window with an alert.

       rreennaammee--wwiinnddooww [--tt _t_a_r_g_e_t_-_w_i_n_d_o_w] _n_e_w_-_n_a_m_e
                     (alias: rreennaammeeww)
               Rename the current window, or the window at _t_a_r_g_e_t_-_w_i_n_d_o_w if specified, to _n_e_w_-_n_a_m_e.

       rreessiizzee--ppaannee [--DDLLMMRRTTUUZZ] [--tt _t_a_r_g_e_t_-_p_a_n_e] [--xx _w_i_d_t_h] [--yy _h_e_i_g_h_t] [_a_d_j_u_s_t_m_e_n_t]
                     (alias: rreessiizzeepp)
               Resize  a  pane,  up,  down,  left or right by _a_d_j_u_s_t_m_e_n_t with --UU, --DD, --LL or --RR, or to an absolute size with --xx or --yy.  The _a_d_j_u_s_t_m_e_n_t is given in lines or columns (the default is 1); --xx and --yy may be a given as a number of
               lines or columns or followed by ‘%’ for a percentage of the window size (for example ‘-x 10%’).  With --ZZ, the active pane is toggled between zoomed (occupying the whole of the window) and unzoomed (its  normal  position  in
               the layout).

               --MM begins mouse resizing (only valid if bound to a mouse key binding, see “MOUSE SUPPORT”).

               --TT trims all lines below the current cursor position and moves lines out of the history to replace them.

       rreessiizzee--wwiinnddooww [--aaAADDLLRRUU] [--tt _t_a_r_g_e_t_-_w_i_n_d_o_w] [--xx _w_i_d_t_h] [--yy _h_e_i_g_h_t] [_a_d_j_u_s_t_m_e_n_t]
                     (alias: rreessiizzeeww)
               Resize  a  window,  up,  down, left or right by _a_d_j_u_s_t_m_e_n_t with --UU, --DD, --LL or --RR, or to an absolute size with --xx or --yy.  The _a_d_j_u_s_t_m_e_n_t is given in lines or cells (the default is 1).  --AA sets the size of the largest session
               containing the window; --aa the size of the smallest.  This command will automatically set wwiinnddooww--ssiizzee to manual in the window options.

       rreessppaawwnn--ppaannee [--kk] [--cc _s_t_a_r_t_-_d_i_r_e_c_t_o_r_y] [--ee _e_n_v_i_r_o_n_m_e_n_t] [--tt _t_a_r_g_e_t_-_p_a_n_e] [_s_h_e_l_l_-_c_o_m_m_a_n_d]
                     (alias: rreessppaawwnnpp)
               Reactivate a pane in which the command has exited (see the rreemmaaiinn--oonn--eexxiitt window option).  If _s_h_e_l_l_-_c_o_m_m_a_n_d is not given, the command used when the pane was created or last respawned is executed.  The pane must  be  already
               inactive, unless --kk is given, in which case any existing command is killed.  --cc specifies a new working directory for the pane.  The --ee option has the same meaning as for the nneeww--wwiinnddooww command.

       rreessppaawwnn--wwiinnddooww [--kk] [--cc _s_t_a_r_t_-_d_i_r_e_c_t_o_r_y] [--ee _e_n_v_i_r_o_n_m_e_n_t] [--tt _t_a_r_g_e_t_-_w_i_n_d_o_w] [_s_h_e_l_l_-_c_o_m_m_a_n_d]
                     (alias: rreessppaawwnnww)
               Reactivate a window in which the command has exited (see the rreemmaaiinn--oonn--eexxiitt window option).  If _s_h_e_l_l_-_c_o_m_m_a_n_d is not given, the command used when the window was created or last respawned is executed.  The window must be al‐
               ready inactive, unless --kk is given, in which case any existing command is killed.  --cc specifies a new working directory for the window.  The --ee option has the same meaning as for the nneeww--wwiinnddooww command.

       rroottaattee--wwiinnddooww [--DDUUZZ] [--tt _t_a_r_g_e_t_-_w_i_n_d_o_w]
                     (alias: rroottaatteeww)
               Rotate the positions of the panes within a window, either upward (numerically lower) with --UU or downward (numerically higher).  --ZZ keeps the window zoomed if it was zoomed.

       sseelleecctt--llaayyoouutt [--EEnnoopp] [--tt _t_a_r_g_e_t_-_p_a_n_e] [_l_a_y_o_u_t_-_n_a_m_e]
                     (alias: sseelleeccttll)
               Choose  a  specific  layout  for a window.  If _l_a_y_o_u_t_-_n_a_m_e is not given, the last preset layout used (if any) is reapplied.  --nn and --pp are equivalent to the nneexxtt--llaayyoouutt and pprreevviioouuss--llaayyoouutt commands.  --oo applies the last set
               layout if possible (undoes the most recent layout change).  --EE spreads the current pane and any panes next to it out evenly.

       sseelleecctt--ppaannee [--DDddeeLLllMMmmRRUUZZ] [--TT _t_i_t_l_e] [--tt _t_a_r_g_e_t_-_p_a_n_e]
                     (alias: sseelleeccttpp)
               Make pane _t_a_r_g_e_t_-_p_a_n_e the active pane in its window.  If one of --DD, --LL, --RR, or --UU is used, respectively the pane below, to the left, to the right, or above the target pane is used.  --ZZ keeps the  window  zoomed  if  it  was
               zoomed.  --ll is the same as using the llaasstt--ppaannee command.  --ee enables or --dd disables input to the pane.  --TT sets the pane title.

               --mm  and  --MM  are  used  to  set and clear the _m_a_r_k_e_d _p_a_n_e.  There is one marked pane at a time, setting a new marked pane clears the last.  The marked pane is the default target for --ss to jjooiinn--ppaannee, mmoovvee--ppaannee, sswwaapp--ppaannee and
               sswwaapp--wwiinnddooww.

       sseelleecctt--wwiinnddooww [--llnnppTT] [--tt _t_a_r_g_e_t_-_w_i_n_d_o_w]
                     (alias: sseelleeccttww)
               Select the window at _t_a_r_g_e_t_-_w_i_n_d_o_w.  --ll, --nn and --pp are equivalent to the llaasstt--wwiinnddooww, nneexxtt--wwiinnddooww and pprreevviioouuss--wwiinnddooww commands.  If --TT is given and the selected window is already the current window, the command behaves like
               llaasstt--wwiinnddooww.

       sspplliitt--wwiinnddooww [--bbddffhhIIvvPPZZ] [--cc _s_t_a_r_t_-_d_i_r_e_c_t_o_r_y] [--ee _e_n_v_i_r_o_n_m_e_n_t] [--ll _s_i_z_e] [--tt _t_a_r_g_e_t_-_p_a_n_e] [_s_h_e_l_l_-_c_o_m_m_a_n_d] [--FF _f_o_r_m_a_t]
                     (alias: sspplliittww)
               Create a new pane by splitting _t_a_r_g_e_t_-_p_a_n_e: --hh does a horizontal split and --vv a vertical split; if neither is specified, --vv is assumed.  The --ll option specifies the size of the new pane in lines (for vertical split)  or  in
               columns  (for horizontal split); _s_i_z_e may be followed by ‘%’ to specify a percentage of the available space.  The --bb option causes the new pane to be created to the left of or above _t_a_r_g_e_t_-_p_a_n_e.  The --ff option creates a new
               pane spanning the full window height (with --hh) or full window width (with --vv), instead of splitting the active pane.  --ZZ zooms if the window is not zoomed, or keeps it zoomed if already zoomed.

               An empty _s_h_e_l_l_-_c_o_m_m_a_n_d ('') will create a pane with no command running in it.  Output can be sent to such a pane with the ddiissppllaayy--mmeessssaaggee command.  The --II flag (if _s_h_e_l_l_-_c_o_m_m_a_n_d is not specified or  empty)  will  create  an
               empty pane and forward any output from stdin to it.  For example:

                     $ make 2>&1|tmux splitw -dI &

               All other options have the same meaning as for the nneeww--wwiinnddooww command.

       sswwaapp--ppaannee [--ddDDUUZZ] [--ss _s_r_c_-_p_a_n_e] [--tt _d_s_t_-_p_a_n_e]
                     (alias: sswwaapppp)
               Swap  two  panes.   If  --UU  is  used and no source pane is specified with --ss, _d_s_t_-_p_a_n_e is swapped with the previous pane (before it numerically); --DD swaps with the next pane (after it numerically).  --dd instructs ttmmuuxx not to
               change the active pane and --ZZ keeps the window zoomed if it was zoomed.

               If --ss is omitted and a marked pane is present (see sseelleecctt--ppaannee --mm), the marked pane is used rather than the current pane.

       sswwaapp--wwiinnddooww [--dd] [--ss _s_r_c_-_w_i_n_d_o_w] [--tt _d_s_t_-_w_i_n_d_o_w]
                     (alias: sswwaappww)
               This is similar to lliinnkk--wwiinnddooww, except the source and destination windows are swapped.  It is an error if no window exists at _s_r_c_-_w_i_n_d_o_w.  If --dd is given, the new window does not become the current window.

               If --ss is omitted and a marked pane is present (see sseelleecctt--ppaannee --mm), the window containing the marked pane is used rather than the current window.

       uunnlliinnkk--wwiinnddooww [--kk] [--tt _t_a_r_g_e_t_-_w_i_n_d_o_w]
                     (alias: uunnlliinnkkww)
               Unlink _t_a_r_g_e_t_-_w_i_n_d_o_w.  Unless --kk is given, a window may be unlinked only if it is linked to multiple sessions - windows may not be linked to no sessions; if --kk is specified and the window is linked to only one  session,  it
               is unlinked and destroyed.

KKEEYY BBIINNDDIINNGGSS
       ttmmuuxx  allows  a  command  to  be bound to most keys, with or without a prefix key.  When specifying keys, most represent themselves (for example ‘A’ to ‘Z’).  Ctrl keys may be prefixed with ‘C-’ or ‘^’, Shift keys with ‘S-’ and Alt
       (meta) with ‘M-’.  In addition, the following special key names are accepted: _U_p, _D_o_w_n, _L_e_f_t, _R_i_g_h_t, _B_S_p_a_c_e, _B_T_a_b, _D_C (Delete), _E_n_d, _E_n_t_e_r, _E_s_c_a_p_e, _F_1 to _F_1_2, _H_o_m_e, _I_C (Insert), _N_P_a_g_e_/_P_a_g_e_D_o_w_n_/_P_g_D_n,  _P_P_a_g_e_/_P_a_g_e_U_p_/_P_g_U_p,  _S_p_a_c_e,  and
       _T_a_b.  Note that to bind the ‘"’ or ‘'’ keys, quotation marks are necessary, for example:

             bind-key '"' split-window
             bind-key "'" new-window

       A command bound to the _A_n_y key will execute for all keys which do not have a more specific binding.

       Commands related to key bindings are as follows:

       bbiinndd--kkeeyy [--nnrr] [--NN _n_o_t_e] [--TT _k_e_y_-_t_a_b_l_e] _k_e_y _c_o_m_m_a_n_d [_a_r_g_u_m_e_n_t _._._.]
                     (alias: bbiinndd)
               Bind key _k_e_y to _c_o_m_m_a_n_d.  Keys are bound in a key table.  By default (without -T), the key is bound in the _p_r_e_f_i_x key table.  This table is used for keys pressed after the prefix key (for example, by default ‘c’ is bound to
               nneeww--wwiinnddooww  in the _p_r_e_f_i_x table, so ‘C-b c’ creates a new window).  The _r_o_o_t table is used for keys pressed without the prefix key: binding ‘c’ to nneeww--wwiinnddooww in the _r_o_o_t table (not recommended) means a plain ‘c’ will create
               a new window.  --nn is an alias for --TT _r_o_o_t.  Keys may also be bound in custom key tables and the sswwiittcchh--cclliieenntt --TT command used to switch to them from a key binding.  The --rr  flag  indicates  this  key  may  repeat,  see  the
               rreeppeeaatt--ttiimmee option.  --NN attaches a note to the key (shown with lliisstt--kkeeyyss --NN).

               To view the default bindings and possible commands, see the lliisstt--kkeeyyss command.

       lliisstt--kkeeyyss [--11aaNN] [--PP _p_r_e_f_i_x_-_s_t_r_i_n_g --TT _k_e_y_-_t_a_b_l_e] [_k_e_y]
                     (alias: llsskk)
               List key bindings.  There are two forms: the default lists keys as bbiinndd--kkeeyy commands; --NN lists only keys with attached notes and shows only the key and note for each key.

               With the default form, all key tables are listed by default.  --TT lists only keys in _k_e_y_-_t_a_b_l_e.

               With  the --NN form, only keys in the _r_o_o_t and _p_r_e_f_i_x key tables are listed by default; --TT also lists only keys in _k_e_y_-_t_a_b_l_e.  --PP specifies a prefix to print before each key and --11 lists only the first matching key.  --aa lists
               the command for keys that do not have a note rather than skipping them.

       sseenndd--kkeeyyss [--FFHHKKllMMRRXX] [--cc _t_a_r_g_e_t_-_c_l_i_e_n_t] [--NN _r_e_p_e_a_t_-_c_o_u_n_t] [--tt _t_a_r_g_e_t_-_p_a_n_e] _k_e_y _._._.
                     (alias: sseenndd)
               Send a key or keys to a window or client.  Each argument _k_e_y is the name of the key (such as ‘C-a’ or ‘NPage’) to send; if the string is not recognised as a key, it is sent as a series of characters.  If --KK is  given,  keys
               are  sent to _t_a_r_g_e_t_-_c_l_i_e_n_t, so they are looked up in the client's key table, rather than to _t_a_r_g_e_t_-_p_a_n_e.  All arguments are sent sequentially from first to last.  If no keys are given and the command is bound to a key, then
               that key is used.

               The --ll flag disables key name lookup and processes the keys as literal UTF-8 characters.  The --HH flag expects each key to be a hexadecimal number for an ASCII character.

               The --RR flag causes the terminal state to be reset.

               --MM passes through a mouse event (only valid if bound to a mouse key binding, see “MOUSE SUPPORT”).

               --XX is used to send a command into copy mode - see the “WINDOWS AND PANES” section.  --NN specifies a repeat count and --FF expands formats in arguments where appropriate.

       sseenndd--pprreeffiixx [--22] [--tt _t_a_r_g_e_t_-_p_a_n_e]
               Send the prefix key, or with --22 the secondary prefix key, to a window as if it was pressed.

       uunnbbiinndd--kkeeyy [--aannqq] [--TT _k_e_y_-_t_a_b_l_e] _k_e_y
                     (alias: uunnbbiinndd)
               Unbind the command bound to _k_e_y.  --nn and --TT are the same as for bbiinndd--kkeeyy.  If --aa is present, all key bindings are removed.  The --qq option prevents errors being returned.

OOPPTTIIOONNSS
       The appearance and behaviour of ttmmuuxx may be modified by changing the value of various options.  There are four types of option: _s_e_r_v_e_r _o_p_t_i_o_n_s, _s_e_s_s_i_o_n _o_p_t_i_o_n_s, _w_i_n_d_o_w _o_p_t_i_o_n_s, and _p_a_n_e _o_p_t_i_o_n_s.

       The ttmmuuxx server has a set of global server options which do not apply to any particular window or session or pane.  These are altered with the sseett--ooppttiioonn --ss command, or displayed with the sshhooww--ooppttiioonnss --ss command.

       In addition, each individual session may have a set of session options, and there is a separate set of global session options.  Sessions which do not have a particular option configured inherit the value from the global session op‐
       tions.  Session options are set or unset with the sseett--ooppttiioonn command and may be listed with the sshhooww--ooppttiioonnss command.  The available server and session options are listed under the sseett--ooppttiioonn command.

       Similarly, a set of window options is attached to each window and a set of pane options to each pane.  Pane options inherit from window options.  This means any pane option may be set as a window option to apply the option  to  all
       panes in the window without the option set, for example these commands will set the background colour to red for all panes except pane 0:

             set -w window-style bg=red
             set -pt:.0 window-style bg=blue

       There is also a set of global window options from which any unset window or pane options are inherited.  Window and pane options are altered with sseett--ooppttiioonn --ww and --pp commands and displayed with sshhooww--ooppttiioonn --ww and --pp.

       ttmmuuxx also supports user options which are prefixed with a ‘@’.  User options may have any name, so long as they are prefixed with ‘@’, and be set to any string.  For example:

             $ tmux set -wq @foo "abc123"
             $ tmux show -wv @foo
             abc123

       Commands which set options are as follows:

       sseett--ooppttiioonn [--aaFFggooppqqssuuUUww] [--tt _t_a_r_g_e_t_-_p_a_n_e] _o_p_t_i_o_n _v_a_l_u_e
                     (alias: sseett)
               Set  a pane option with --pp, a window option with --ww, a server option with --ss, otherwise a session option.  If the option is not a user option, --ww or --ss may be unnecessary - ttmmuuxx will infer the type from the option name, as‐
               suming --ww for pane options.  If --gg is given, the global session or window option is set.

               --FF expands formats in the option value.  The --uu flag unsets an option, so a session inherits the option from the global options (or with --gg, restores a global option to the default).  --UU unsets an option (like  --uu)  but  if
               the option is a pane option also unsets the option on any panes in the window.  _v_a_l_u_e depends on the option and may be a number, a string, or a flag (on, off, or omitted to toggle).

               The --oo flag prevents setting an option that is already set and the --qq flag suppresses errors about unknown or ambiguous options.

               With --aa, and if the option expects a string or a style, _v_a_l_u_e is appended to the existing setting.  For example:

                     set -g status-left "foo"
                     set -ag status-left "bar"

               Will result in ‘foobar’.  And:

                     set -g status-style "bg=red"
                     set -ag status-style "fg=blue"

               Will result in a red background _a_n_d blue foreground.  Without --aa, the result would be the default background and a blue foreground.

       sshhooww--ooppttiioonnss [--AAggHHppqqssvvww] [--tt _t_a_r_g_e_t_-_p_a_n_e] [_o_p_t_i_o_n]
                     (alias: sshhooww)
               Show  the pane options (or a single option if _o_p_t_i_o_n is provided) with --pp, the window options with --ww, the server options with --ss, otherwise the session options.  If the option is not a user option, --ww or --ss may be unneces‐
               sary - ttmmuuxx will infer the type from the option name, assuming --ww for pane options.  Global session or window options are listed if --gg is used.  --vv shows only the option value, not the name.  If --qq is set, no error will  be
               returned if _o_p_t_i_o_n is unset.  --HH includes hooks (omitted by default).  --AA includes options inherited from a parent set of options, such options are marked with an asterisk.

       Available server options are:

       bbaacckkssppaaccee _k_e_y
               Set the key sent by ttmmuuxx for backspace.

       bbuuffffeerr--lliimmiitt _n_u_m_b_e_r
               Set the number of buffers; as new buffers are added to the top of the stack, old ones are removed from the bottom if necessary to maintain this maximum length.

       ccoommmmaanndd--aalliiaass[[]] _n_a_m_e_=_v_a_l_u_e
               This is an array of custom aliases for commands.  If an unknown command matches _n_a_m_e, it is replaced with _v_a_l_u_e.  For example, after:

                     sseett --ss ccoommmmaanndd--aalliiaass[[110000]] zzoooomm==''rreessiizzee--ppaannee --ZZ''

               Using:

                     zzoooomm --tt::..11

               Is equivalent to:

                     rreessiizzee--ppaannee --ZZ --tt::..11

               Note that aliases are expanded when a command is parsed rather than when it is executed, so binding an alias with bbiinndd--kkeeyy will bind the expanded form.

       ccooppyy--ccoommmmaanndd _s_h_e_l_l_-_c_o_m_m_a_n_d
               Give the command to pipe to if the ccooppyy--ppiippee copy mode command is used without arguments.

       ddeeffaauulltt--tteerrmmiinnaall _t_e_r_m_i_n_a_l
               Set the default terminal for new windows created in this session - the default value of the TERM environment variable.  For ttmmuuxx to work correctly, this _m_u_s_t be set to ‘screen’, ‘tmux’ or a derivative of them.

       eessccaappee--ttiimmee _t_i_m_e
               Set the time in milliseconds for which ttmmuuxx waits after an escape is input to determine if it is part of a function or meta key sequences.

       eeddiittoorr _s_h_e_l_l_-_c_o_m_m_a_n_d
               Set the command used when ttmmuuxx runs an editor.

       eexxiitt--eemmppttyy [oonn | ooffff]
               If enabled (the default), the server will exit when there are no active sessions.

       eexxiitt--uunnaattttaacchheedd [oonn | ooffff]
               If enabled, the server will exit when there are no attached clients.

       eexxtteennddeedd--kkeeyyss [oonn | ooffff | aallwwaayyss]
               Controls how modified keys (keys pressed together with Control, Meta, or Shift) are reported.  This is the equivalent of the mmooddiiffyyOOtthheerrKKeeyyss _x_t_e_r_m(1) resource.

               When  set to oonn, the program inside the pane can request one of two modes: mode 1 which changes the sequence for only keys which lack an existing well-known representation; or mode 2 which changes the sequence for all keys.
               When set to aallwwaayyss, modes 1 and 2 can still be requested by applications, but mode 1 will be forced instead of the standard mode.  When set to ooffff, this feature is disabled and only standard keys are reported.

               ttmmuuxx will always request extended keys itself if the terminal supports them.  See also the eexxttkkeeyyss feature for the tteerrmmiinnaall--ffeeaattuurreess option, the eexxtteennddeedd--kkeeyyss--ffoorrmmaatt option and the ppaannee__kkeeyy__mmooddee variable.

       eexxtteennddeedd--kkeeyyss--ffoorrmmaatt [ccssii--uu | xxtteerrmm]
               Selects one of the two possible formats for reporting modified keys to applications.  This is the equivalent of the ffoorrmmaattOOtthheerrKKeeyyss _x_t_e_r_m(1) resource.  For example, C-S-a will be reported as ‘^[[27;6;65~’ when set to xxtteerrmm,
               and as ‘^[[65;6u’ when set to ccssii--uu.

       ffooccuuss--eevveennttss [oonn | ooffff]
               When enabled, focus events are requested from the terminal if supported and passed through to applications running in ttmmuuxx.  Attached clients should be detached and attached again after changing this option.

       hhiissttoorryy--ffiillee _p_a_t_h
               If not empty, a file to which ttmmuuxx will write command prompt history on exit and load it from on start.

       mmeessssaaggee--lliimmiitt _n_u_m_b_e_r
               Set the number of error or information messages to save in the message log for each client.

       pprroommpptt--hhiissttoorryy--lliimmiitt _n_u_m_b_e_r
               Set the number of history items to save in the history file for each type of command prompt.

       sseett--cclliippbbooaarrdd [oonn | eexxtteerrnnaall | ooffff]
               Attempt to set the terminal clipboard content using the _x_t_e_r_m(1) escape sequence, if there is an _M_s entry in the _t_e_r_m_i_n_f_o(5) description (see the “TERMINFO EXTENSIONS” section).

               If set to oonn, ttmmuuxx will both accept the escape sequence to create a buffer and attempt to set the terminal clipboard.  If set to eexxtteerrnnaall, ttmmuuxx will attempt to set the terminal clipboard but ignore attempts by  applications
               to set ttmmuuxx buffers.  If ooffff, ttmmuuxx will neither accept the clipboard escape sequence nor attempt to set the clipboard.

               Note that this feature needs to be enabled in _x_t_e_r_m(1) by setting the resource:

                     disallowedWindowOps: 20,21,SetXprop

               Or changing this property from the _x_t_e_r_m(1) interactive menu when required.

       tteerrmmiinnaall--ffeeaattuurreess[[]] _s_t_r_i_n_g
               Set terminal features for terminal types read from _t_e_r_m_i_n_f_o(5).  ttmmuuxx has a set of named terminal features.  Each will apply appropriate changes to the _t_e_r_m_i_n_f_o(5) entry in use.

               ttmmuuxx can detect features for a few common terminals; this option can be used to easily tell tmux about features supported by terminals it cannot detect.  The tteerrmmiinnaall--oovveerrrriiddeess option allows individual _t_e_r_m_i_n_f_o(5) capabili‐
               ties  to be set instead, tteerrmmiinnaall--ffeeaattuurreess is intended for classes of functionality supported in a standard way but not reported by _t_e_r_m_i_n_f_o(5).  Care must be taken to configure this only with features the terminal actually
               supports.

               This is an array option where each entry is a colon-separated string made up of a terminal type pattern (matched using _f_n_m_a_t_c_h(3)) followed by a list of terminal features.  The available features are:

               256     Supports 256 colours with the SGR escape sequences.

               clipboard
                       Allows setting the system clipboard.

               ccolour
                       Allows setting the cursor colour.

               cstyle  Allows setting the cursor style.

               extkeys
                       Supports extended keys.

               focus   Supports focus reporting.

               hyperlinks
                       Supports OSC 8 hyperlinks.

               ignorefkeys
                       Ignore function keys from _t_e_r_m_i_n_f_o(5) and use the ttmmuuxx internal set only.

               margins
                       Supports DECSLRM margins.

               mouse   Supports _x_t_e_r_m(1) mouse sequences.

               osc7    Supports the OSC 7 working directory extension.

               overline
                       Supports the overline SGR attribute.

               rectfill
                       Supports the DECFRA rectangle fill escape sequence.

               RGB     Supports RGB colour with the SGR escape sequences.

               sixel   Supports SIXEL graphics.

               strikethrough
                       Supports the strikethrough SGR escape sequence.

               sync    Supports synchronized updates.

               title   Supports _x_t_e_r_m(1) title setting.

               usstyle
                       Allows underscore style and colour to be set.

       tteerrmmiinnaall--oovveerrrriiddeess[[]] _s_t_r_i_n_g
               Allow terminal descriptions read using _t_e_r_m_i_n_f_o(5) to be overridden.  Each entry is a colon-separated string made up of a terminal type pattern (matched using _f_n_m_a_t_c_h(3)) and a set of _n_a_m_e_=_v_a_l_u_e entries.

               For example, to set the ‘clear’ _t_e_r_m_i_n_f_o(5) entry to ‘\e[H\e[2J’ for all terminal types matching ‘rxvt*’:

                     rrxxvvtt**::cclleeaarr==\\ee[[HH\\ee[[22JJ

               The terminal entry value is passed through _s_t_r_u_n_v_i_s(3) before interpretation.

       uusseerr--kkeeyyss[[]] _k_e_y
               Set list of user-defined key escape sequences.  Each item is associated with a key named ‘User0’, ‘User1’, and so on.

               For example:

                     set -s user-keys[0] "\e[5;30012~"
                     bind User0 resize-pane -L 3

       Available session options are:

       aaccttiivviittyy--aaccttiioonn [aannyy | nnoonnee | ccuurrrreenntt | ootthheerr]
               Set action on window activity when mmoonniittoorr--aaccttiivviittyy is on.  aannyy means activity in any window linked to a session causes a bell or message (depending on vviissuuaall--aaccttiivviittyy) in the current window of that session, nnoonnee means  all
               activity  is  ignored  (equivalent  to mmoonniittoorr--aaccttiivviittyy being off), ccuurrrreenntt means only activity in windows other than the current window are ignored and ootthheerr means activity in the current window is ignored but not those in
               other windows.

       aassssuummee--ppaassttee--ttiimmee _m_i_l_l_i_s_e_c_o_n_d_s
               If keys are entered faster than one in _m_i_l_l_i_s_e_c_o_n_d_s, they are assumed to have been pasted rather than typed and ttmmuuxx key bindings are not processed.  The default is one millisecond and zero disables.

       bbaassee--iinnddeexx _i_n_d_e_x
               Set the base index from which an unused index should be searched when a new window is created.  The default is zero.

       bbeellll--aaccttiioonn [aannyy | nnoonnee | ccuurrrreenntt | ootthheerr]
               Set action on a bell in a window when mmoonniittoorr--bbeellll is on.  The values are the same as those for aaccttiivviittyy--aaccttiioonn.

       ddeeffaauulltt--ccoommmmaanndd _s_h_e_l_l_-_c_o_m_m_a_n_d
               Set the command used for new windows (if not specified when the window is created) to _s_h_e_l_l_-_c_o_m_m_a_n_d, which may be any _s_h(1) command.  The default is an empty string, which instructs ttmmuuxx to create a login  shell  using  the
               value of the ddeeffaauulltt--sshheellll option.

       ddeeffaauulltt--sshheellll _p_a_t_h
               Specify  the default shell.  This is used as the login shell for new windows when the ddeeffaauulltt--ccoommmmaanndd option is set to empty, and must be the full path of the executable.  When started ttmmuuxx tries to set a default value from
               the first suitable of the SHELL environment variable, the shell returned by _g_e_t_p_w_u_i_d(3), or _/_b_i_n_/_s_h.  This option should be configured when ttmmuuxx is used as a login shell.

       ddeeffaauulltt--ssiizzee _X_x_Y
               Set the default size of new windows when the wwiinnddooww--ssiizzee option is set to manual or when a session is created with nneeww--sseessssiioonn --dd.  The value is the width and height separated by an ‘x’ character.  The default is 80x24.

       ddeessttrrooyy--uunnaattttaacchheedd [ooffff | oonn | kkeeeepp--llaasstt | kkeeeepp--ggrroouupp]
               If oonn, destroy the session after the last client has detached.  If ooffff (the default), leave the session orphaned.  If kkeeeepp--llaasstt, destroy the session only if it is in a group  and  has  other  sessions  in  that  group.   If
               kkeeeepp--ggrroouupp, destroy the session unless it is in a group and is the only session in that group.

       ddeettaacchh--oonn--ddeessttrrooyy [ooffff | oonn | nnoo--ddeettaacchheedd | pprreevviioouuss | nneexxtt]
               If  oonn  (the  default),  the client is detached when the session it is attached to is destroyed.  If ooffff, the client is switched to the most recently active of the remaining sessions.  If nnoo--ddeettaacchheedd, the client is detached
               only if there are no detached sessions; if detached sessions exist, the client is switched to the most recently active.  If pprreevviioouuss or nneexxtt, the client is switched to the previous or next session in alphabetical order.

       ddiissppllaayy--ppaanneess--aaccttiivvee--ccoolloouurr _c_o_l_o_u_r
               Set the colour used by the ddiissppllaayy--ppaanneess command to show the indicator for the active pane.

       ddiissppllaayy--ppaanneess--ccoolloouurr _c_o_l_o_u_r
               Set the colour used by the ddiissppllaayy--ppaanneess command to show the indicators for inactive panes.

       ddiissppllaayy--ppaanneess--ttiimmee _t_i_m_e
               Set the time in milliseconds for which the indicators shown by the ddiissppllaayy--ppaanneess command appear.

       ddiissppllaayy--ttiimmee _t_i_m_e
               Set the amount of time for which status line messages and other on-screen indicators are displayed.  If set to 0, messages and indicators are displayed until a key is pressed.  _t_i_m_e is in milliseconds.

       hhiissttoorryy--lliimmiitt _l_i_n_e_s
               Set the maximum number of lines held in window history.  This setting applies only to new windows - existing window histories are not resized and retain the limit at the point they were created.

       kkeeyy--ttaabbllee _k_e_y_-_t_a_b_l_e
               Set the default key table to _k_e_y_-_t_a_b_l_e instead of _r_o_o_t.

       lloocckk--aafftteerr--ttiimmee _n_u_m_b_e_r
               Lock the session (like the lloocckk--sseessssiioonn command) after _n_u_m_b_e_r seconds of inactivity.  The default is not to lock (set to 0).

       lloocckk--ccoommmmaanndd _s_h_e_l_l_-_c_o_m_m_a_n_d
               Command to run when locking each client.  The default is to run _l_o_c_k(1) with --nnpp.

       mmeennuu--ssttyyllee _s_t_y_l_e
               Set the menu style.  See the “STYLES” section on how to specify _s_t_y_l_e.  Attributes are ignored.

       mmeennuu--sseelleecctteedd--ssttyyllee _s_t_y_l_e
               Set the selected menu item style.  See the “STYLES” section on how to specify _s_t_y_l_e.  Attributes are ignored.

       mmeennuu--bboorrddeerr--ssttyyllee _s_t_y_l_e
               Set the menu border style.  See the “STYLES” section on how to specify _s_t_y_l_e.  Attributes are ignored.

       mmeennuu--bboorrddeerr--lliinneess _t_y_p_e
               Set the type of characters used for drawing menu borders.  See ppooppuupp--bboorrddeerr--lliinneess for possible values for _b_o_r_d_e_r_-_l_i_n_e_s.

       mmeessssaaggee--ccoommmmaanndd--ssttyyllee _s_t_y_l_e
               Set status line message command style.  This is used for the command prompt with _v_i(1) keys when in command mode.  For how to specify _s_t_y_l_e, see the “STYLES” section.

       mmeessssaaggee--lliinnee [00 | 11 | 22 | 33 | 44]
               Set line on which status line messages and the command prompt are shown.

       mmeessssaaggee--ssttyyllee _s_t_y_l_e
               Set status line message style.  This is used for messages and for the command prompt.  For how to specify _s_t_y_l_e, see the “STYLES” section.

       mmoouussee [oonn | ooffff]
               If on, ttmmuuxx captures the mouse and allows mouse events to be bound as key bindings.  See the “MOUSE SUPPORT” section for details.

       pprreeffiixx _k_e_y
               Set the key accepted as a prefix key.  In addition to the standard keys described under “KEY BINDINGS”, pprreeffiixx can be set to the special key ‘None’ to set no prefix.

       pprreeffiixx22 _k_e_y
               Set a secondary key accepted as a prefix key.  Like pprreeffiixx, pprreeffiixx22 can be set to ‘None’.

       pprreeffiixx--ttiimmeeoouutt _t_i_m_e
               Set the time in milliseconds for which ttmmuuxx waits after pprreeffiixx is input before dismissing it.  Can be set to zero to disable any timeout.

       rreennuummbbeerr--wwiinnddoowwss [oonn | ooffff]
               If on, when a window is closed in a session, automatically renumber the other windows in numerical order.  This respects the bbaassee--iinnddeexx option if it has been set.  If off, do not renumber the windows.

       rreeppeeaatt--ttiimmee _t_i_m_e
               Allow multiple commands to be entered without pressing the prefix-key again in the specified _t_i_m_e milliseconds (the default is 500).  Whether a key repeats may be set when it is bound using the --rr flag to bbiinndd--kkeeyy.   Repeat
               is enabled for the default keys bound to the rreessiizzee--ppaannee command.

       sseett--ttiittlleess [oonn | ooffff]
               Attempt  to  set  the client terminal title using the _t_s_l and _f_s_l _t_e_r_m_i_n_f_o(5) entries if they exist.  ttmmuuxx automatically sets these to the \e]0;...\007 sequence if the terminal appears to be _x_t_e_r_m(1).  This option is off by
               default.

       sseett--ttiittlleess--ssttrriinngg _s_t_r_i_n_g
               String used to set the client terminal title if sseett--ttiittlleess is on.  Formats are expanded, see the “FORMATS” section.

       ssiilleennccee--aaccttiioonn [aannyy | nnoonnee | ccuurrrreenntt | ootthheerr]
               Set action on window silence when mmoonniittoorr--ssiilleennccee is on.  The values are the same as those for aaccttiivviittyy--aaccttiioonn.

       ssttaattuuss [ooffff | oonn | 22 | 33 | 44 | 55]
               Show or hide the status line or specify its size.  Using oonn gives a status line one row in height; 22, 33, 44 or 55 more rows.

       ssttaattuuss--ffoorrmmaatt[[]] _f_o_r_m_a_t
               Specify the format to be used for each line of the status line.  The default builds the top status line from the various individual status options below.

       ssttaattuuss--iinntteerrvvaall _i_n_t_e_r_v_a_l
               Update the status line every _i_n_t_e_r_v_a_l seconds.  By default, updates will occur every 15 seconds.  A setting of zero disables redrawing at interval.

       ssttaattuuss--jjuussttiiffyy [lleefftt | cceennttrree | rriigghhtt | aabbssoolluuttee--cceennttrree]
               Set the position of the window list in the status line: left, centre or right.  centre puts the window list in the relative centre of the available free space; absolute-centre uses the centre of the entire horizontal space.

       ssttaattuuss--kkeeyyss [vvii | eemmaaccss]
               Use vi or emacs-style key bindings in the status line, for example at the command prompt.  The default is emacs, unless the VISUAL or EDITOR environment variables are set and contain the string ‘vi’.

       ssttaattuuss--lleefftt _s_t_r_i_n_g
               Display _s_t_r_i_n_g (by default the session name) to the left of the status line.  _s_t_r_i_n_g will be passed through _s_t_r_f_t_i_m_e(3).  Also see the “FORMATS” and “STYLES” sections.

               For details on how the names and titles can be set see the “NAMES AND TITLES” section.

               Examples are:

                     #(sysctl vm.loadavg)
                     #[fg=yellow,bold]#(apm -l)%%#[default] [#S]

               The default is ‘[#S] ’.

       ssttaattuuss--lleefftt--lleennggtthh _l_e_n_g_t_h
               Set the maximum _l_e_n_g_t_h of the left component of the status line.  The default is 10.

       ssttaattuuss--lleefftt--ssttyyllee _s_t_y_l_e
               Set the style of the left part of the status line.  For how to specify _s_t_y_l_e, see the “STYLES” section.

       ssttaattuuss--ppoossiittiioonn [ttoopp | bboottttoomm]
               Set the position of the status line.

       ssttaattuuss--rriigghhtt _s_t_r_i_n_g
               Display _s_t_r_i_n_g to the right of the status line.  By default, the current pane title in double quotes, the date and the time are shown.  As with ssttaattuuss--lleefftt, _s_t_r_i_n_g will be passed to _s_t_r_f_t_i_m_e(3) and character pairs  are  re‐
               placed.

       ssttaattuuss--rriigghhtt--lleennggtthh _l_e_n_g_t_h
               Set the maximum _l_e_n_g_t_h of the right component of the status line.  The default is 40.

       ssttaattuuss--rriigghhtt--ssttyyllee _s_t_y_l_e
               Set the style of the right part of the status line.  For how to specify _s_t_y_l_e, see the “STYLES” section.

       ssttaattuuss--ssttyyllee _s_t_y_l_e
               Set status line style.  For how to specify _s_t_y_l_e, see the “STYLES” section.

       uuppddaattee--eennvviirroonnmmeenntt[[]] _v_a_r_i_a_b_l_e
               Set  list of environment variables to be copied into the session environment when a new session is created or an existing session is attached.  Any variables that do not exist in the source environment are set to be removed
               from the session environment (as if --rr was given to the sseett--eennvviirroonnmmeenntt command).

       vviissuuaall--aaccttiivviittyy [oonn | ooffff | bbootthh]
               If on, display a message instead of sending a bell when activity occurs in a window for which the mmoonniittoorr--aaccttiivviittyy window option is enabled.  If set to both, a bell and a message are produced.

       vviissuuaall--bbeellll [oonn | ooffff | bbootthh]
               If on, a message is shown on a bell in a window for which the mmoonniittoorr--bbeellll window option is enabled instead of it being passed through to the terminal (which normally makes a sound).  If set to both, a bell  and  a  message
               are produced.  Also see the bbeellll--aaccttiioonn option.

       vviissuuaall--ssiilleennccee [oonn | ooffff | bbootthh]
               If mmoonniittoorr--ssiilleennccee is enabled, prints a message after the interval has expired on a given window instead of sending a bell.  If set to both, a bell and a message are produced.

       wwoorrdd--sseeppaarraattoorrss _s_t_r_i_n_g
               Sets the session's conception of what characters are considered word separators, for the purposes of the next and previous word commands in copy mode.

       Available window options are:

       aaggggrreessssiivvee--rreessiizzee [oonn | ooffff]
               Aggressively  resize the chosen window.  This means that ttmmuuxx will resize the window to the size of the smallest or largest session (see the wwiinnddooww--ssiizzee option) for which it is the current window, rather than the session to
               which it is attached.  The window may resize when the current window is changed on another session; this option is good for full-screen programs which support SIGWINCH and poor for interactive programs such as shells.

       aauuttoommaattiicc--rreennaammee [oonn | ooffff]
               Control automatic window renaming.  When this setting is enabled, ttmmuuxx will rename the window automatically using the format specified by aauuttoommaattiicc--rreennaammee--ffoorrmmaatt.  This flag is automatically disabled for an individual  win‐
               dow when a name is specified at creation with nneeww--wwiinnddooww or nneeww--sseessssiioonn, or later with rreennaammee--wwiinnddooww, or with a terminal escape sequence.  It may be switched off globally with:

                     set-option -wg automatic-rename off

       aauuttoommaattiicc--rreennaammee--ffoorrmmaatt _f_o_r_m_a_t
               The format (see “FORMATS”) used when the aauuttoommaattiicc--rreennaammee option is enabled.

       cclloocckk--mmooddee--ccoolloouurr _c_o_l_o_u_r
               Set clock colour.

       cclloocckk--mmooddee--ssttyyllee [1122 | 2244]
               Set clock hour format.

       ffiillll--cchhaarraacctteerr _c_h_a_r_a_c_t_e_r
               Set the character used to fill areas of the terminal unused by a window.

       mmaaiinn--ppaannee--hheeiigghhtt _h_e_i_g_h_t
       mmaaiinn--ppaannee--wwiiddtthh _w_i_d_t_h
               Set the width or height of the main (left or top) pane in the mmaaiinn--hhoorriizzoonnttaall, mmaaiinn--hhoorriizzoonnttaall--mmiirrrroorreedd, mmaaiinn--vveerrttiiccaall, or mmaaiinn--vveerrttiiccaall--mmiirrrroorreedd layouts.  If suffixed by ‘%’, this is a percentage of the window size.

       ccooppyy--mmooddee--mmaattcchh--ssttyyllee _s_t_y_l_e
               Set the style of search matches in copy mode.  For how to specify _s_t_y_l_e, see the “STYLES” section.

       ccooppyy--mmooddee--mmaarrkk--ssttyyllee _s_t_y_l_e
               Set the style of the line containing the mark in copy mode.  For how to specify _s_t_y_l_e, see the “STYLES” section.

       ccooppyy--mmooddee--ccuurrrreenntt--mmaattcchh--ssttyyllee _s_t_y_l_e
               Set the style of the current search match in copy mode.  For how to specify _s_t_y_l_e, see the “STYLES” section.

       mmooddee--kkeeyyss [vvii | eemmaaccss]
               Use vi or emacs-style key bindings in copy mode.  The default is emacs, unless VISUAL or EDITOR contains ‘vi’.

       mmooddee--ssttyyllee _s_t_y_l_e
               Set window modes style.  For how to specify _s_t_y_l_e, see the “STYLES” section.

       mmoonniittoorr--aaccttiivviittyy [oonn | ooffff]
               Monitor for activity in the window.  Windows with activity are highlighted in the status line.

       mmoonniittoorr--bbeellll [oonn | ooffff]
               Monitor for a bell in the window.  Windows with a bell are highlighted in the status line.

       mmoonniittoorr--ssiilleennccee [iinntteerrvvaall]
               Monitor for silence (no activity) in the window within iinntteerrvvaall seconds.  Windows that have been silent for the interval are highlighted in the status line.  An interval of zero disables the monitoring.

       ootthheerr--ppaannee--hheeiigghhtt _h_e_i_g_h_t
               Set  the  height  of  the  other  panes  (not  the main pane) in the mmaaiinn--hhoorriizzoonnttaall and mmaaiinn--hhoorriizzoonnttaall--mmiirrrroorreedd layouts.  If this option is set to 0 (the default), it will have no effect.  If both the mmaaiinn--ppaannee--hheeiigghhtt and
               ootthheerr--ppaannee--hheeiigghhtt options are set, the main pane will grow taller to make the other panes the specified height, but will never shrink to do so.  If suffixed by ‘%’, this is a percentage of the window size.

       ootthheerr--ppaannee--wwiiddtthh _w_i_d_t_h
               Like ootthheerr--ppaannee--hheeiigghhtt, but set the width of other panes in the mmaaiinn--vveerrttiiccaall and mmaaiinn--vveerrttiiccaall--mmiirrrroorreedd layouts.

       ppaannee--aaccttiivvee--bboorrddeerr--ssttyyllee _s_t_y_l_e
               Set the pane border style for the currently active pane.  For how to specify _s_t_y_l_e, see the “STYLES” section.  Attributes are ignored.

       ppaannee--bbaassee--iinnddeexx _i_n_d_e_x
               Like bbaassee--iinnddeexx, but set the starting index for pane numbers.

       ppaannee--bboorrddeerr--ffoorrmmaatt _f_o_r_m_a_t
               Set the text shown in pane border status lines.

       ppaannee--bboorrddeerr--iinnddiiccaattoorrss [ooffff | ccoolloouurr | aarrrroowwss | bbootthh]
               Indicate active pane by colouring only half of the border in windows with exactly two panes, by displaying arrow markers, by drawing both or neither.

       ppaannee--bboorrddeerr--lliinneess _t_y_p_e
               Set the type of characters used for drawing pane borders.  _t_y_p_e may be one of:

               single  single lines using ACS or UTF-8 characters

               double  double lines using UTF-8 characters

               heavy   heavy lines using UTF-8 characters

               simple  simple ASCII characters

               number  the pane number

               ‘double’ and ‘heavy’ will fall back to standard ACS line drawing when UTF-8 is not supported.

       ppaannee--bboorrddeerr--ssttaattuuss [ooffff | ttoopp | bboottttoomm]
               Turn pane border status lines off or set their position.

       ppaannee--bboorrddeerr--ssttyyllee _s_t_y_l_e
               Set the pane border style for panes aside from the active pane.  For how to specify _s_t_y_l_e, see the “STYLES” section.  Attributes are ignored.

       ppooppuupp--ssttyyllee _s_t_y_l_e
               Set the popup style.  See the “STYLES” section on how to specify _s_t_y_l_e.  Attributes are ignored.

       ppooppuupp--bboorrddeerr--ssttyyllee _s_t_y_l_e
               Set the popup border style.  See the “STYLES” section on how to specify _s_t_y_l_e.  Attributes are ignored.

       ppooppuupp--bboorrddeerr--lliinneess _t_y_p_e
               Set the type of characters used for drawing popup borders.  _t_y_p_e may be one of:

               single  single lines using ACS or UTF-8 characters (default)

               rounded
                       variation of single with rounded corners using UTF-8 characters

               double  double lines using UTF-8 characters

               heavy   heavy lines using UTF-8 characters

               simple  simple ASCII characters

               padded  simple ASCII space character

               none    no border

               ‘double’ and ‘heavy’ will fall back to standard ACS line drawing when UTF-8 is not supported.

       wwiinnddooww--ssttaattuuss--aaccttiivviittyy--ssttyyllee _s_t_y_l_e
               Set status line style for windows with an activity alert.  For how to specify _s_t_y_l_e, see the “STYLES” section.

       wwiinnddooww--ssttaattuuss--bbeellll--ssttyyllee _s_t_y_l_e
               Set status line style for windows with a bell alert.  For how to specify _s_t_y_l_e, see the “STYLES” section.

       wwiinnddooww--ssttaattuuss--ccuurrrreenntt--ffoorrmmaatt _s_t_r_i_n_g
               Like _w_i_n_d_o_w_-_s_t_a_t_u_s_-_f_o_r_m_a_t, but is the format used when the window is the current window.

       wwiinnddooww--ssttaattuuss--ccuurrrreenntt--ssttyyllee _s_t_y_l_e
               Set status line style for the currently active window.  For how to specify _s_t_y_l_e, see the “STYLES” section.

       wwiinnddooww--ssttaattuuss--ffoorrmmaatt _s_t_r_i_n_g
               Set the format in which the window is displayed in the status line window list.  See the “FORMATS” and “STYLES” sections.

       wwiinnddooww--ssttaattuuss--llaasstt--ssttyyllee _s_t_y_l_e
               Set status line style for the last active window.  For how to specify _s_t_y_l_e, see the “STYLES” section.

       wwiinnddooww--ssttaattuuss--sseeppaarraattoorr _s_t_r_i_n_g
               Sets the separator drawn between windows in the status line.  The default is a single space character.

       wwiinnddooww--ssttaattuuss--ssttyyllee _s_t_y_l_e
               Set status line style for a single window.  For how to specify _s_t_y_l_e, see the “STYLES” section.

       wwiinnddooww--ssiizzee _l_a_r_g_e_s_t | _s_m_a_l_l_e_s_t | _m_a_n_u_a_l | _l_a_t_e_s_t
               Configure how ttmmuuxx determines the window size.  If set to _l_a_r_g_e_s_t, the size of the largest attached session is used; if _s_m_a_l_l_e_s_t, the size of the smallest.  If _m_a_n_u_a_l, the size of a new window is set from  the  ddeeffaauulltt--ssiizzee
               option and windows are resized automatically.  With _l_a_t_e_s_t, ttmmuuxx uses the size of the client that had the most recent activity.  See also the rreessiizzee--wwiinnddooww command and the aaggggrreessssiivvee--rreessiizzee option.

       wwrraapp--sseeaarrcchh [oonn | ooffff]
               If this option is set, searches will wrap around the end of the pane contents.  The default is on.

       Available pane options are:

       aallllooww--ppaasssstthhrroouugghh [oonn | ooffff | aallll]
               Allow  programs  in  the pane to bypass ttmmuuxx using a terminal escape sequence (\ePtmux;...\e\\).  If set to oonn, passthrough sequences will be allowed only if the pane is visible.  If set to aallll, they will be allowed even if
               the pane is invisible.

       aallllooww--rreennaammee [oonn | ooffff]
               Allow programs in the pane to change the window name using a terminal escape sequence (\ek...\e\\).

       aallllooww--sseett--ttiittllee [oonn | ooffff]
               Allow programs in the pane to change the title using the terminal escape sequences (\e]2;...\e\\ or \e]0;...\e\\).

       aalltteerrnnaattee--ssccrreeeenn [oonn | ooffff]
               This option configures whether programs running inside the pane may use the terminal alternate screen feature, which allows the _s_m_c_u_p and _r_m_c_u_p _t_e_r_m_i_n_f_o(5) capabilities.  The alternate screen feature preserves the  contents
               of the window when an interactive application starts and restores it on exit, so that any output visible before the application starts reappears unchanged after it exits.

       ccuurrssoorr--ccoolloouurr _c_o_l_o_u_r
               Set the colour of the cursor.

       ppaannee--ccoolloouurrss[[]] _c_o_l_o_u_r
               The default colour palette.  Each entry in the array defines the colour ttmmuuxx uses when the colour with that index is requested.  The index may be from zero to 255.

       ccuurrssoorr--ssttyyllee _s_t_y_l_e
               Set the style of the cursor.  Available styles are: ddeeffaauulltt, bblliinnkkiinngg--bblloocckk, bblloocckk, bblliinnkkiinngg--uunnddeerrlliinnee, uunnddeerrlliinnee, bblliinnkkiinngg--bbaarr, bbaarr.

       rreemmaaiinn--oonn--eexxiitt [oonn | ooffff | ffaaiilleedd]
               A pane with this flag set is not destroyed when the program running in it exits.  If set to ffaaiilleedd, then only when the program exit status is not zero.  The pane may be reactivated with the rreessppaawwn