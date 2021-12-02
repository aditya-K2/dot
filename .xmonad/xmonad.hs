import XMonad

import XMonad.Util.EZConfig
import XMonad.Util.Ungrab
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.DynamicLog
import qualified XMonad.StackSet as W
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.NoBorders
import XMonad.Hooks.ManageDocks
import qualified Data.Map        as M
import XMonad.Util.NamedScratchpad
import Graphics.X11.ExtraTypes.XF86

rectCentered :: Rational -> W.RationalRect
rectCentered percentage = W.RationalRect offset offset percentage percentage
  where
    offset = (1 - percentage) / 2

myTerminal = "alacritty"
main :: IO()

main = xmonad . ewmh =<< xmobar myConfig
myConfig = def
    { modMask    = mod4Mask  -- Rebind Mod to the Super key
    , handleEventHook = fullscreenEventHook
    , terminal = myTerminal-- Use custom layouts
    , layoutHook = myLayout
    , manageHook =  myManageHooks <+> manageDocks <+> namedScratchpadManageHook myScratchPads
    }
 `additionalKeysP`
    [("M-f", sendMessage ToggleStruts >> toggleFull ) -- Toggles noborder/full
    ,("M-c", kill)
    ,("M-r", spawn "xmonad --recompile; xmonad --restart")
    ,("M-m", windows W.swapMaster)
    ,("M-<Return>", spawn (myTerminal))
    ,("M-u", spawn ("brave"))
    ,("M-q", namedScratchpadAction myScratchPads "torrent")
    ,("M-e", spawn ("getEmoji"))
    ]
  `additionalKeys`
    [  ((0                                      , 0x1008FF11)         , spawn "pamixer -d 5")
    ,  ((0                                      , 0x1008FF13)         , spawn "pamixer -i 5")
    ,  ((0                                      , 0x1008FF12)         , spawn "pamixer -t")
    ,  ((mod1Mask                               , xK_y      )         , namedScratchpadAction myScratchPads "music")
    ,  ((mod4Mask                               , xK_space  )         , namedScratchpadAction myScratchPads "scratch")
    ,  ((mod4Mask .|. controlMask .|. shiftMask , xK_c      )         , namedScratchpadAction myScratchPads "colorChooser")
    ,  ((0                                      , xF86XK_AudioPlay )  , spawn "mpc toggle")
    ,  ((0                                      , xF86XK_AudioNext)   , spawn "mpc next")
    ,  ((0                                      , xF86XK_AudioPrev)   , spawn "mpc prev")
    ,  ((mod4Mask .|. shiftMask                 , xK_F6)              , spawn "sxiv /D/Downloads/wallpapers/*.jpg")

    ]

myLayout =  avoidStruts ( tiled ||| Mirror tiled ||| Full )
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio
     -- The default number of windows in the master pane
     nmaster = 1
     -- Default proportion of screen occupied by master pane
     ratio   = 1/2
     -- Percent of screen to increment by when resizing panes
     delta   = 3/100

myManageHooks = composeAll
-- Allows focusing other monitors without killing the fullscreen
--  [ isFullscreen --> (doF W.focusDown <+> doFullFloat)

-- Single monitor setups, or if the previous hook doesn't work
    [ isFullscreen --> doFullFloat
    -- skipped
    ]

--Looks to see if focused window is floating and if it is the places it in the stack
--else it makes it floating but as full screen
toggleFull = withFocused (\windowId -> do
    { floats <- gets (W.floating . windowset);
        if windowId `M.member` floats
        then withFocused $ windows . W.sink
        else withFocused $ windows . (flip W.float $ W.RationalRect 0 0 1 1) })


myScratchPads = [ NS "music" spawnGOMP getGOMP manageGOMP
                , NS "torrent" spawnTorrent getTorrent manageTorrent
                , NS "scratch" spawnScratch getScratch manageScratch
                , NS "colorChooser" spawnChooser getChooser manageChooser
                ]
            where
                spawnGOMP = "st -t music -e /H/code/goMP/goMP"
                getGOMP = (title =? "music")
                manageGOMP = (customFloating $ rectCentered 0.6)

                spawnTorrent = myTerminal ++ " -t torrent -e tremc"
                getTorrent = ( title =? "torrent" )
                manageTorrent = (customFloating $ rectCentered 0.5)

                spawnScratch = myTerminal ++ " -t scratch"
                getScratch = ( title =? "scratch" )
                manageScratch = (customFloating $ rectCentered 0.5)

                spawnChooser = "kcolorchooser"
                getChooser = ( className =? "kcolorchooser" )
                manageChooser = (defaultFloating)
