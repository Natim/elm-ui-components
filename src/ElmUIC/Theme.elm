module ElmUIC.Theme exposing
    ( Size(..)
    , ColorSetting(..)
    , Theme
    , defaultTheme
    )

{-| Basic theming functions for components

@docs Size

@docs ColorSetting

@docs Theme

@docs defaultTheme

-}

import Css exposing (Color, hex)


{-| Used to standardize the size of your component
-}
type Size
    = Small
    | Medium
    | Large


{-| Basic color options for components
-}
type ColorSetting
    = Primary
    | Secondary
    | Success
    | Warning
    | Danger


{-| Colors used to map to each ColorSetting
-}
type alias Theme =
    { primary : Color
    , secondary : Color
    , success : Color
    , warning : Color
    , danger : Color
    , font : List String
    }


{-| The default theme for elm-ui-components
-}
defaultTheme : Theme
defaultTheme =
    { primary = hex "#158DD8"
    , secondary = hex "#5D7889"
    , success = hex "#4DC151"
    , warning = hex "#FF9730"
    , danger = hex "#E04141"
    , font = [ "-apple-system", "system-ui", "BlinkMacSystemFont", "Segoe UI", "Roboto", "Helvetica Neue", "Arial", "sans-serif" ]
    }
