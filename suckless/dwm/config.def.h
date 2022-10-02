#include <X11/XF86keysym.h>
#include "layouts.c"
#include "fibonacci.c"

/* appearance */

#define ICONSIZE 16                                   /* icon size */
#define ICONSPACING 5                                 /* space between icon and title */
static const unsigned int borderpx         =   0;     /* border pixel of windows */
static const unsigned int gappx            =   4;     /* gaps between windows */
static const unsigned int snap             =   32;    /* snap pixel */
static const unsigned int systraypinning   =   0;     /* 0: sloppy systray follows selected monitor, >0: pin systray to monitor X */
static const unsigned int systrayonleft    =   0;     /* 0: systray in the right corner, >0: systray on left of status text */
static const unsigned int systrayspacing   =   4;     /* systray spacing */
static const int systraypinningfailfirst   =   1;     /* 1: if pinning fails, display systray on the first monitor, False: display systray on the last monitor*/
static const int showsystray               =   1;     /* 0 means no systray */
static const int showbar                   =   1;     /* 0 means no bar */
static const int topbar                    =   1;     /* 0 means bottom bar */
static const int vertpad                   =   0;     /* vertical padding of bar */
static const int sidepad                   =   0;     /* horizontal padding of bar */
static const int DFW                       =   800;
static const int DFH                       =   600;
static const int DFX                       =   550;
static const int DFY                       =   250;
static const char *fonts[]                 =   { "Sauce Code Pro Nerd Font:size=10" , "NotoColorEmoji:size=10"};
static const char dmenufont[]              =   "SourceCodeProMedium:size=10";
static const char col_Selected_FG[]        =   "#ffffff";
static const char col_statusbarBG[]        =   "#101010";
static const char col_statusbarMiddle[]    =   "#224488";
static const char col_selectedBorder[]     =   "#101010";
static const char col_notselectedBorder[]  =   "#101010";
static const char col_statusbarFG[]        =   "#ffffff";
static const char col_dmenuFG[]            =   "#bbbbbb";


static const char *colors[][3]      = {
    /*               fg         bg         border   */
   [SchemeNorm] = { col_Selected_FG,    col_statusbarBG    ,  col_notselectedBorder},
   [SchemeSel]  = { col_statusbarFG,    col_statusbarMiddle,  col_selectedBorder},
   [SchemeHid]  = { col_Selected_FG,    col_statusbarBG    ,  col_notselectedBorder  },
};

/* tagging */
static const char *tags[] = {"1", "2", "3", "4", "5", "6", "7", "8", "9" };
static const Rule rules[] = {

  /* class               instance    title       tags mask   isfloating   monitor    float x,y,w,h              floatborderpx      scratchKEY*/

 { "Gimp",               NULL,       NULL,      1<<4,       0,           -1 ,       DFX,   DFY,   DFW,   DFH,             5,         0},
 { "Inkscape",           NULL,       NULL,      1<<4,       0,           -1 ,       DFX,   DFY,   DFW,   DFH,             5,         0},
 { "Firefox",            NULL,       NULL,      3,          0,           -1 ,       DFX,   DFY,   DFW,   DFH,             5,         0},
 { "TelegramDesktop",    NULL,       NULL,      1<<2,       0,           -1 ,       DFX,   DFY,   DFW,   DFH,             5,         0},
 { "qBittorrent",        NULL,       NULL,      1<<3,       0,           -1 ,       DFX,   DFY,   DFW,   DFH,             5,         0},
 { "Spotify",            NULL,       NULL,      1<<5,       0,           -1 ,       DFX,   DFY,   DFW,   DFH,             5,         0},
 { "zoom",               NULL,       NULL,      1<<6,       0,           -1 ,       DFX,   DFY,   DFW,   DFH,             5,         0},
 { "figma-linux",        NULL,       NULL,      1<<4,       0,           -1 ,       DFX,   DFY,   DFW,   DFH,             5,         0},
 { "discord",            NULL,       NULL,      1<<7,       0,           -1 ,       DFX,   DFY,   DFW,   DFH,             5,         0},
 { "VSCodium",           NULL,       NULL,      1<<2,       0,           -1 ,       DFX,   DFY,   DFW,   DFH,             5,         0},
 { "Steam",              NULL,       NULL,      1<<3,       0,           -1 ,       DFX,   DFY,   DFW,   DFH,             5,         0},
 { "Tk",                 NULL,       NULL,      0,          1,           -1 ,       DFX,   DFY,   DFW,   DFH,             5,         0},
 { "Pavucontrol",        NULL,       NULL,      1<<8,       0,           -1 ,       DFX,   DFY,   DFW,   DFH,             5,         0},
 { "Pulseeffects",       NULL,       NULL,      1<<8,       0,           -1 ,       DFX,   DFY,   DFW,   DFH,             5,         0},
 { "Blender",            NULL,       NULL,      1<<4,       0,           -1 ,       DFX,   DFY,   DFW,   DFH,             5,         0},

                                                 /* Scratch Pads */

 { NULL,                 NULL,       "pcmanfm",              0,      1,           -1 ,       DFX,         DFY,   DFW,         DFH,             2,         'n'},
 { NULL,                 NULL,       "scratchpad",           0,      1,           -1,        DFX,         DFY,   DFW,         DFH,             2,         's'},
 { NULL,                 NULL,       "gomp",                 0,      1,           -1,        DFX - 50 ,   DFY,   DFW + 50 ,   DFH,             2,         'y'},
 { NULL,                 NULL,       "tremc",                0,      1,           -1,        DFX - 50 ,   DFY,   DFW + 50 ,   DFH,             2,         't'},
 { NULL,                 NULL,       "Select Color",         0,      1,           -1,        DFX - 50 ,   DFY,   DFW + 50 ,   DFH,             2,         'c'},
 { NULL,                 NULL,       "Ideas",                0,      1,           -1,        DFX - 50 ,   DFY,   DFW + 50 ,   DFH,             2,         'i'},

};

/* layout(s) */
static const float mfact     = 0.50; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */

static const Layout layouts[] = {
    /* symbol     arrange function */
    { "|  ",     tile },    /* first entry is default */
    { "|  ",     NULL },    /* no layout function means floating behavior */
    { "[M]",      monocle },
    { "HHH",      grid },
    { "[@]",      spiral },
    { "[\\]",     dwindle },
    { "TTT",      bstack },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
    { MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
    { Mod1Mask,                     KEY,      toggleview,     {.ui = 1 << TAG} }, \
    { MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
    { MODKEY|ControlMask,           KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/bash", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2]              = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[]        = { "dmenu_run", "-p", ">", "-m", dmenumon, "-fn", dmenufont};
static const char *termcmd[]         = { "/usr/bin/alacritty", NULL };
static const char *web[]             = { "/usr/bin/brave", NULL };
static const char *torrentcli[]      = { "t", "alacritty", "-t", "tremc" , "-e", "tremc", NULL};
static const char *fileManager[]     = { "n", "/usr/bin/pcmanfm", NULL };
static const char *colorChooser[]    = { "c", "/usr/bin/kcolorchooser", NULL };
static const char *scratchpadcmd[]   = { "s", "alacritty", "-t", "scratchpad" , "-e", "tmux", NULL};
static const char *ideascmd[]        = { "i", "alacritty", "-t", "Ideas" , "-e", "nvim", "/home/aditya/ideas", NULL};
static const char *gompcmd[]         = { "y", "st", "-t", "gomp" , "-e", "/H/code/gomp/gomp", NULL};

static Key keys[] = {
   /* modifier                               key                          function        argument */
  { MODKEY,                                 XK_p,                        spawn,                 {.v = dmenucmd } },
  { MODKEY,                                 XK_u,                        spawn,                 {.v = web} },
  { MODKEY,                                 XK_Return,                   spawn,                 {.v = termcmd } },
  { MODKEY|ShiftMask,                       XK_Return,                   spawn,                 SHCMD("alacritty -e tmux") },
  { MODKEY,                                 XK_space,                    togglescratch,         {.v = scratchpadcmd } },
  { Mod1Mask,                               XK_y,                        togglescratch,         {.v = gompcmd } },
  { MODKEY,                                 XK_n,                        togglescratch,         {.v = fileManager } },
  { MODKEY,                                 XK_q,                        togglescratch,         {.v = torrentcli } },
  { MODKEY|ControlMask|ShiftMask,           XK_c,                        togglescratch,         {.v = colorChooser } },
  { MODKEY,                                 XK_o,                        togglescratch,         {.v = ideascmd } },
  { Mod1Mask,                               XK_q,                        spawn,                 SHCMD("torrentInfo") },
  { MODKEY|ShiftMask,                       XK_y,                        spawn,                 SHCMD("spotify") },
  { MODKEY|ShiftMask,                       XK_p,                        spawn,                 SHCMD("openPDF") },
  { Mod1Mask,                               XK_F4,                       spawn,                 SHCMD("sd") },
  { 0,                                      XK_Print,                    spawn,                 SHCMD("screenshot") },
  { ControlMask,                            XK_Print,                    spawn,                 SHCMD("directoryName") },
  { ShiftMask,                              XK_Print,                    spawn,                 SHCMD("screenshotPart") },
  { 0,                                      XF86XK_AudioPrev,            spawn,                 SHCMD("mpc prev")},
  { 0,                                      XF86XK_AudioNext,            spawn,                 SHCMD("mpc next")},
  { 0,                                      XF86XK_AudioPlay,            spawn,                 SHCMD("mpc toggle")},
  { 0,                                      XF86XK_AudioStop,            spawn,                 SHCMD("mpc stop")},
  { MODKEY,                                 XK_F11,                      spawn,                 SHCMD("pamixer -d 5 ; pkill -RTMIN+10 dwmblocks")},
  { MODKEY,                                 XK_F12,                      spawn,                 SHCMD("pamixer -i 5 ; pkill -RTMIN+10 dwmblocks")},
  { MODKEY|ShiftMask,                       XK_F5,                       spawn,                 SHCMD("reloadKeys")},
  { MODKEY|ShiftMask,                       XK_F6,                       spawn,                 SHCMD("sxiv /D/Downloads/wallpapers/*.jpg")},
  { MODKEY,                                 XK_F10,                      spawn,                 SHCMD("xbacklight -inc 10 ; pkill -RTMIN+20 dwmblocks")},
  { MODKEY,                                 XK_F9,                       spawn,                 SHCMD("xbacklight -dec 10 ; pkill -RTMIN+20 dwmblocks")},
  { 0,                                      XF86XK_MonBrightnessUp,      spawn,                 SHCMD("xbacklight -inc 10 ; pkill -RTMIN+20 dwmblocks")},
  { 0,                                      XF86XK_MonBrightnessDown,    spawn,                 SHCMD("xbacklight -dec 10 ; pkill -RTMIN+20 dwmblocks")},
  { MODKEY,                                 XK_e,                        spawn,                 SHCMD("getEmoji")},
  { MODKEY,                                 XK_i,                        spawn,                 SHCMD("copyq menu")},
  { MODKEY,                                 XK_g,                        setlayout,             {.v = &layouts[3]} },
  { MODKEY,                                 XK_r,                        setlayout,             {.v = &layouts[4]} },
  { MODKEY|ShiftMask,                       XK_r,                        setlayout,             {.v = &layouts[5]} },
  { MODKEY,                                 XK_z,                        spawn,                 SHCMD("unzipFiles")},
  { MODKEY,                                 XK_b,                        togglebar,             {0} },
  { MODKEY,                                 XK_j,                        focusstackvis,         {.i = +1 } },
  { MODKEY,                                 XK_k,                        focusstackvis,         {.i = -1 } },
  { MODKEY|ShiftMask,                       XK_j,                        focusstackhid,         {.i = +1 } },
  { MODKEY|ShiftMask,                       XK_k,                        focusstackhid,         {.i = -1 } },
  { MODKEY|ShiftMask,                       XK_minus,                    incnmaster,            {.i = +1 } },
  { MODKEY,                                 XK_d,                        incnmaster,            {.i = -1 } },
  { MODKEY,                                 XK_h,                        setmfact,              {.f = -0.05} },
  { MODKEY,                                 XK_l,                        setmfact,              {.f = +0.05} },
  { MODKEY,                                 XK_Tab,                      view,                  {0} },
  { MODKEY|ShiftMask,                       XK_c,                        killclient,            {0} },
  { MODKEY,                                 XK_c,                        killclient,            {0} },
  { MODKEY|ShiftMask,                       XK_t,                        setlayout,             {.v = &layouts[0]} },
  { MODKEY|ShiftMask,                       XK_m,                        setlayout,             {.v = &layouts[2]} },
  { MODKEY,                                 XK_f,                        togglefullscr,         {0} },
  { MODKEY,                                 XK_m,                        zoom,                  {0} },
  { MODKEY,                                 XK_0,                        view,                  {.ui = ~0 } },
  { MODKEY|ShiftMask,                       XK_0,                        tag,                   {.ui = ~0 } },
  { MODKEY,                                 XK_comma,                    focusmon,              {.i = -1 } },
  { MODKEY,                                 XK_period,                   focusmon,              {.i = +1 } },
  { MODKEY|ShiftMask,                       XK_comma,                    tagmon,                {.i = -1 } },
  { MODKEY|ShiftMask,                       XK_period,                   tagmon,                {.i = +1 } },
  { MODKEY,                                 XK_minus,                    setgaps,               {.i = -1 } },
  { MODKEY,                                 XK_equal,                    setgaps,               {.i = +1 } },
  { MODKEY|ShiftMask,                       XK_equal,                    setgaps,               {.i = 0  } },
  { MODKEY|ShiftMask,                       XK_u,                        setlayout,             {.v = &layouts[6]} },
  { MODKEY|ShiftMask,                       XK_space,                    togglefloating,        {0} },
  { MODKEY,                                 XK_s,                        show,                  {0} },
  { MODKEY,                                 XK_t,                        hide,                  {0} },
  TAGKEYS(                                  XK_1,                        0)
  TAGKEYS(                                  XK_2,                        1)
  TAGKEYS(                                  XK_3,                        2)
  TAGKEYS(                                  XK_4,                        3)
  TAGKEYS(                                  XK_5,                        4)
  TAGKEYS(                                  XK_6,                        5)
  TAGKEYS(                                  XK_7,                        6)
  TAGKEYS(                                  XK_8,                        7)
  TAGKEYS(                                  XK_9,                        8)
  { MODKEY|ShiftMask|ControlMask,           XK_q,                        quit,           {0} },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
    /* click                event mask      button          function        argument */
    { ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
    { ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
    { ClkWinTitle,          0,              Button1,        togglewin,      {0} },
    { ClkWinTitle,          0,              Button2,        zoom,           {0} },
    { ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
    { ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
    { ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
    { ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
    { ClkTagBar,            0,              Button1,        view,           {0} },
    { ClkTagBar,            0,              Button3,        toggleview,     {0} },
    { ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
    { ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};
