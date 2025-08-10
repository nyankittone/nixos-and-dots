/* See LICENSE file for copyright and license details. */

#include <X11/X.h>
#include <X11/XF86keysym.h>

#define MAIN_FONT "ZedMono Nerd Font:size=26"

/* appearance */
static const unsigned int borderpx  = 6;        /* border pixel of windows */
static const unsigned int snap      = 16;       /* snap pixel */
static const unsigned int systraypinning = 0;   /* 0: sloppy systray follows selected monitor, >0: pin systray to monitor X */
static const unsigned int systrayonleft = 0;    /* 0: systray in the right corner, >0: systray on left of status text */
static const unsigned int systrayspacing = 2;   /* systray spacing */
static const int systraypinningfailfirst = 1;   /* 1: if pinning fails, display systray on the first monitor, False: display systray on the last monitor*/
static const int showsystray        = 1;        /* 0 means no systray */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 0;        /* 0 means bottom bar */
static const char *fonts[]          = { MAIN_FONT };
static const char *colors[][3]      = {
	/*               fg         bg         border   */
	[SchemeNorm] = { "#b7bdf8", "#26273a", "#494d64" },
	[SchemeSel]  = { "#26273a", "#f5bde6",  "#f5bde6"  },
};

/* tagging. I might add a 9th tag again in the future tbh... */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9"};

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class      instance    title       tags mask     isfloating   monitor */
	{ NULL,  NULL,       "Zen Browser",       1,       0,           0 },
	{ "vesktop",  NULL,       NULL,       2,       0,           1 },
	{ "discord",  NULL,       NULL,       2,       0,           1 },
	{ "steam",  NULL,       NULL,       4,       0,           1 },
};

/* layout(s) */
static const float mfact     = 0.50; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 0;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
	{ "TTT",      bstack },
	{ "===",      bstackhoriz },
    { "|M|",      centeredmaster },
};

/* key definitions */
#define MODKEY Mod4Mask
#define ALTKEY Mod1Mask
#define TAGKEYS(KEY,TAG)                                                                                               \
       &((Keychord){1, {{MODKEY, KEY}},                                        view,           {.ui = 1 << TAG} }), \
       &((Keychord){1, {{MODKEY|ControlMask, KEY}},                            toggleview,     {.ui = 1 << TAG} }), \
       &((Keychord){1, {{MODKEY|ShiftMask, KEY}},                              tag,            {.ui = 1 << TAG} }), \
       &((Keychord){1, {{MODKEY|ControlMask|ShiftMask, KEY}},                  toggletag,      {.ui = 1 << TAG} }),

#define SCREENSHOT(key, monitor) \
    &((Keychord){3, {{MODKEY, XK_p}, {0, XK_c}, {0, key}}, spawn, {.v = (const char*[]) {"scrot-meow", "clipboard", monitor, NULL}}}), \
    &((Keychord){3, {{MODKEY, XK_p}, {0, XK_f}, {0, key}}, spawn, {.v = (const char*[]) {"scrot-meow", "file", monitor, NULL}}}),

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* alias for the terminal emulator command */
static const char terminal[] = "st";

static const Keychord *keychords[] = {
	/* modifier                     key        function        argument */
    &((Keychord) {1, {{MODKEY, XK_Return}}, spawn, {.v = (const char*[]) {terminal, NULL}}}),
	&((Keychord){1, {{MODKEY,                       XK_b}},      togglebar,      {0} }),
	&((Keychord){1, {{MODKEY,                       XK_j}},      focusstack,     {.i = +1 } }),
	&((Keychord){1, {{MODKEY,                       XK_k}},      focusstack,     {.i = -1 } }),
	&((Keychord){1, {{MODKEY,                       XK_y}},      incnmaster,     {.i = +1 } }),
	&((Keychord){1, {{MODKEY,                       XK_n}},      incnmaster,     {.i = -1 } }),
	&((Keychord){1, {{MODKEY,                       XK_h}},      setmfact,       {.f = -0.05} }),
	&((Keychord){1, {{MODKEY,                       XK_l}},      setmfact,       {.f = +0.05} }),
	&((Keychord){1, {{MODKEY|ShiftMask,                       XK_Return}}, zoom,           {0} }),
	&((Keychord){1, {{MODKEY,                       XK_Tab}},    view,           {0} }),
	&((Keychord){1, {{MODKEY|ShiftMask,             XK_c}},      killclient,     {0} }),
	&((Keychord){1, {{MODKEY,                       XK_t}},      setlayout,      {.v = &layouts[0]} }),
	&((Keychord){1, {{MODKEY,                       XK_f}},      setlayout,      {.v = &layouts[1]} }),
	&((Keychord){1, {{MODKEY,                       XK_e}},      setlayout,      {.v = &layouts[2]} }),
	&((Keychord){1, {{MODKEY,                       XK_i}},      setlayout,      {.v = &layouts[3]} }),
	&((Keychord){1, {{MODKEY,                       XK_u}},      setlayout,      {.v = &layouts[4]} }),
	&((Keychord){1, {{MODKEY,                       XK_w}},      setlayout,      {.v = &layouts[5]} }),
	&((Keychord){1, {{MODKEY,                       XK_space}},  setlayout,      {0} }),
	&((Keychord){1, {{MODKEY|ShiftMask,             XK_space}},  togglefloating, {0} }),
	&((Keychord){1, {{MODKEY,                       XK_0}},      view,           {.ui = ~0 } }),
	&((Keychord){1, {{MODKEY|ShiftMask,             XK_0}},      tag,            {.ui = ~0 } }),
	&((Keychord){1, {{MODKEY,                       XK_comma}},  focusmon,       {.i = -1 } }),
	&((Keychord){1, {{MODKEY,                       XK_period}}, focusmon,       {.i = +1 } }),
	&((Keychord){1, {{MODKEY|ShiftMask,             XK_comma}},  tagmon,         {.i = -1 } }),
	&((Keychord){1, {{MODKEY|ShiftMask,             XK_period}}, tagmon,         {.i = +1 } }),
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
	&((Keychord){1, {{MODKEY|ShiftMask,             XK_h}},      setcfact,       {.f = -0.25} }),
	&((Keychord){1, {{MODKEY|ShiftMask,             XK_l}},      setcfact,       {.f = +0.25} }),
	&((Keychord){1, {{MODKEY,             XK_o}},      setcfact,       {.f =  0.00} }),
    &((Keychord){1,{{MODKEY|ShiftMask, XK_j}}, pushstack, {.i = INC(+1)}}),
    &((Keychord){1,{{MODKEY|ShiftMask, XK_k}}, pushstack, {.i = INC(-1)}}),

    // Stuff relating to exiting dwm and power management control.
	&((Keychord){2, {{ MODKEY|ShiftMask, XK_q}, {0, XK_q}},      quit,           {.i = 2} }),
	&((Keychord){2, {{ MODKEY|ShiftMask, XK_q}, {0, XK_w}},      quit,           {.i = 0} }),
	// &((Keychord){2, {{ MODKEY|ShiftMask, XK_q}, {0, XK_s}},      spawn,           SHCMD("systemctl suspend") }),
	&((Keychord){2, {{ MODKEY|ShiftMask, XK_q}, {0, XK_s}},      spawn, {.v = (const char*[]) {"systemctl", "suspend", NULL}}}),
	&((Keychord){2, {{ MODKEY|ShiftMask, XK_q}, {0, XK_h}},      spawn, {.v = (const char*[]) {"systemctl", "hibernate", NULL}}}),
	&((Keychord){2, {{ MODKEY|ShiftMask, XK_q}, {0, XK_r}},      spawn, {.v = (const char*[]) {"reboot", NULL}}}),
	&((Keychord){2, {{ MODKEY|ShiftMask, XK_q}, {0, XK_p}},      spawn, {.v = (const char*[]) {"poweroff", NULL}}}),
	&((Keychord){2, {{ MODKEY|ShiftMask, XK_q}, {0, XK_l}},      spawn, {.v = (const char*[]) {"xscreensaver-command", "--activate", NULL}}}),

    // Keybinds for controlling dmenu
    &((Keychord) {1, {{MODKEY, XK_c}}, spawn, SHCMD("exec dmenu_run -b -fn '"MAIN_FONT"' -p '  Run Command:' -F -z $(exec dmenu_find_xyw)")}),
    &((Keychord) {1, {{MODKEY, XK_x}}, spawn, {.v = (const char*[]) {"nixGL", "j4-dmenu-desktop", "--dmenu", "dmenu -shb '#f5bde6' -b -fn '"MAIN_FONT"' -p '󰲌  Run Application:' -sb '#c6a0f6' -i -z $(exec dmenu_find_xyw)", NULL}}}),
    &((Keychord) {1, {{MODKEY, XK_semicolon}}, spawn, {.v = (const char*[]) {"dmenu_emoji", NULL}}}),
    &((Keychord) {1, {{MODKEY | ALTKEY, XK_c}}, spawn, SHCMD("exec clipmenu -b -sb '#eed49f' -shb '#f4dbd6' -fn '"MAIN_FONT"' -p '  Clipboard:' -z $(exec dmenu_find_xyw) -l 12")}),

    // Keybinds for starting some common apps I use.
    &((Keychord) {1, {{MODKEY, XK_s}}, spawn, {.v = (const char*[]) {"flatpak", "run", "com.valvesoftware.Steam", NULL}}}),
    &((Keychord) {1, {{MODKEY, XK_d}}, spawn, {.v = (const char*[]) {"nixGL", "vesktop", NULL}}}),
    &((Keychord) {1, {{MODKEY, XK_g}}, spawn, {.v = (const char*[]) {"nixGL", "gimp", NULL}}}),
    &((Keychord) {1, {{MODKEY, XK_z}}, spawn, {.v = (const char*[]) {"nixGL", "zen", NULL}}}),
    &((Keychord) {1, {{MODKEY, XK_m}}, spawn, {.v = (const char*[]) {"flatpak", "run", "org.prismlauncher.PrismLauncher", NULL}}}),

    // Keybinds for controlling the sound and music player
    &((Keychord) {1, {{MODKEY, XK_equal}}, spawn, {.v = (const char*[]) {"change-volume", "+5%", NULL}}}),
    &((Keychord) {1, {{MODKEY, XK_minus}}, spawn, {.v = (const char*[]) {"change-volume", "-5%", NULL}}}),
    &((Keychord) {1, {{MODKEY|ShiftMask, XK_equal}}, spawn, {.v = (const char*[]) {"change-volume", "+1%", NULL}}}),
    &((Keychord) {1, {{MODKEY|ShiftMask, XK_minus}}, spawn, {.v = (const char*[]) {"change-volume", "-1%", NULL}}}),
    &((Keychord) {1, {{0, XF86XK_AudioRaiseVolume}}, spawn, {.v = (const char*[]) {"change-volume", "+5%", NULL}}}),
    &((Keychord) {1, {{0, XF86XK_AudioLowerVolume}}, spawn, {.v = (const char*[]) {"change-volume", "-5%", NULL}}}),
    &((Keychord) {1, {{0|ShiftMask, XF86XK_AudioRaiseVolume}}, spawn, {.v = (const char*[]) {"change-volume", "+1%", NULL}}}),
    &((Keychord) {1, {{0|ShiftMask, XF86XK_AudioLowerVolume}}, spawn, {.v = (const char*[]) {"change-volume", "-1%", NULL}}}),
    &((Keychord) {1, {{0, XF86XK_AudioMute}}, spawn, {.v = (const char*[]) {"change-volume", "mute", NULL}}}),
    &((Keychord) {1, {{0, XF86XK_AudioMedia}}, spawn, {.v = (const char*[]) {"playerctl", "play-pause", NULL}}}),
    &((Keychord) {1, {{0, XF86XK_AudioPlay}}, spawn, {.v = (const char*[]) {"playerctl", "play-pause", NULL}}}),
    &((Keychord) {1, {{0, XF86XK_AudioPrev}}, spawn, {.v = (const char*[]) {"playerctl", "previous", NULL}}}),
    &((Keychord) {1, {{0, XF86XK_AudioNext}}, spawn, {.v = (const char*[]) {"playerctl", "next", NULL}}}),

    // Keybinds for creating screenshots via `scrot`
    &((Keychord) {2, {{MODKEY, XK_p}, {ShiftMask, XK_c}}, spawn, {.v = (const char*[]) {"scrot-meow", "clipboard", "select", NULL}}}),
    &((Keychord) {2, {{MODKEY, XK_p}, {ShiftMask, XK_f}}, spawn, {.v = (const char*[]) {"scrot-meow", "file", "select", NULL}}}),
    &((Keychord) {3, {{MODKEY, XK_p}, {0, XK_c}, {0, XK_s}}, spawn, {.v = (const char*[]) {"scrot-meow", "clipboard", "select", NULL}}}),
    &((Keychord) {3, {{MODKEY, XK_p}, {0, XK_f}, {0, XK_s}}, spawn, {.v = (const char*[]) {"scrot-meow", "file", "select", NULL}}}),
    &((Keychord) {3, {{MODKEY, XK_p}, {0, XK_c}, {0, XK_a}}, spawn, {.v = (const char*[]) {"scrot-meow", "clipboard", "all", NULL}}}),
    &((Keychord) {3, {{MODKEY, XK_p}, {0, XK_f}, {0, XK_a}}, spawn, {.v = (const char*[]) {"scrot-meow", "file", "all", NULL}}}),

    // If you somehow have more than 10 monitors hooked up to your PC, you should contact a doctor.
    SCREENSHOT(XK_1, "0")
    SCREENSHOT(XK_2, "1")
    SCREENSHOT(XK_3, "2")
    SCREENSHOT(XK_4, "3")
    SCREENSHOT(XK_5, "4")
    SCREENSHOT(XK_6, "5")
    SCREENSHOT(XK_7, "6")
    SCREENSHOT(XK_8, "7")
    SCREENSHOT(XK_9, "8")
    SCREENSHOT(XK_0, "9")

    
    &((Keychord) {1, {{MODKEY, XK_r}}, spawn, SHCMD("record-thing --output-dir ~/Videos/Recordings --recording-sound ~/Sounds/EarthBound\\ Status\\ Sounds/begin_video_recording.wav --dmenu 'dmenu -b -fn \""MAIN_FONT"\" -p \"  Record Screen:\" -z $(dmenu_find_xyw) -sb \\#f5a97f -shb \\#ee99a0 -i -F' --audio-source-name analog-stereo.monitor")}),

    // Keybind to check the Dow Jones Industrial Average, bc why tf not?
    &((Keychord) {1, {{MODKEY|ControlMask, XK_d}}, spawn, {.v = (const char*[]) {"xdg-open", "https://duckduckgo.com/?t=ffab&q=dow+jones&ia=web", NULL}}}),
    &((Keychord) {1, {{MODKEY|ControlMask, XK_n}}, spawn, {.v = (const char*[]) {"xdg-open", "https://nixos.org/nixos/packages.html", NULL}}}),
};
/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static const Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = (const char*[]) {terminal, NULL}}},
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

