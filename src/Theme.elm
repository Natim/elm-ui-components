module Theme exposing (ColorSetting(..), Size(..), Theme, defaultTheme)

import Css exposing (Color, hex)


type Size
    = Small
    | Medium
    | Large


type ColorSetting
    = Primary
    | Secondary
    | Success
    | Warning
    | Danger


type alias Theme =
    { primary : Color
    , secondary : Color
    , success : Color
    , warning : Color
    , danger : Color
    }


defaultTheme : Theme
defaultTheme =
    { primary = hex "#158DD8"
    , secondary = hex "#5D7889"
    , success = hex "#4DC151"
    , warning = hex "#FF9730"
    , danger = hex "#E04141"
    }
