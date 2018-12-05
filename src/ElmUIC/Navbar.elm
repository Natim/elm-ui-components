module ElmUIC.Navbar exposing
    ( Navbar
    , defaultNavbar
    , item
    , separator
    , navbar
    )

{-| A styled navbar

@docs Navbar

@docs defaultNavbar

@docs item

@docs separator

@docs navbar

-}

import Css exposing (Color, alignItems, auto, backgroundColor, backgroundImage, bold, borderRadius, boxShadow5, center, color, displayFlex, flex, flex3, fontFamilies, fontSize, fontWeight, height, hex, int, linearGradient, margin2, padding2, pct, position, px, relative, rgb, rgba, stop, stop2, textShadow4, width, zIndex, zero)
import ElmUIC.Theme exposing (ColorSetting(..), Size(..), Theme)
import Html.Styled as Styled exposing (Attribute, Html, styled, text)


lighten : Color -> Float -> Color
lighten color amount =
    let
        r =
            min 255
                (round
                    (toFloat color.red
                        + (amount * toFloat color.red)
                    )
                )

        g =
            min 255
                (round
                    (toFloat color.green
                        + (amount * toFloat color.green)
                    )
                )

        b =
            min 255
                (round
                    (toFloat color.blue
                        + (amount * toFloat color.blue)
                    )
                )
    in
    rgb r g b


{-| Base model for a navbar
-}
type alias Navbar =
    { kind : ColorSetting
    , size : Size
    , text : Color
    , title : String
    }


{-| Instantiates the default properties of a nav

    { defaultNavbar | title = "Hello, world!" }

-}
defaultNavbar : Navbar
defaultNavbar =
    { kind = Primary
    , size = Medium
    , text = hex "#FFF"
    , title = ""
    }


spacer : List (Attribute msg) -> List (Html msg) -> Html msg
spacer =
    styled Styled.div
        [ flex <| int 1
        ]


title : List (Attribute msg) -> List (Html msg) -> Html msg
title =
    styled Styled.div
        [ textShadow4 zero (px 1) zero (rgba 0 0 0 0.3)
        , color (hex "#FFF")
        , margin2 zero (px 2)
        , fontSize (px 18)
        , fontWeight bold
        ]


{-| An inidivual item in the navbar

    item defaultTheme [] [ text "Click me!" ]

-}
item : Theme -> List (Attribute msg) -> List (Html msg) -> Html msg
item theme =
    styled Styled.div
        [ textShadow4 zero (px 1) zero (rgba 0 0 0 0.3)
        , color (hex "#FFF")
        , margin2 zero (px 2)
        , fontSize (px 18)
        , fontWeight bold
        ]


{-| A vertical separator to place between items

    item defaultTheme [] [ text "One!" ]
            , separator defaultTheme [] []
            , item defaultTheme [] [ text "Two!" ]

-}
separator : Theme -> List (Attribute msg) -> List (Html msg) -> Html msg
separator theme =
    styled Styled.div
        [ backgroundColor (lighten theme.primary 0.1)
        , margin2 zero (px 8)
        , height (px 40)
        , width (px 2)
        ]


{-| A styled nav using items and separators

    navbar defaultTheme
        { defaultNavbar | title = "Hello, WORLD" }
        [ css [ width (px 600) ] ]
        [ item defaultTheme [] [ text "One" ]
        , separator defaultTheme [] []
        , item defaultTheme [] [ text "Two" ]
        , separator defaultTheme [] []
        , item defaultTheme [] [ text "Three" ]
        ]

-}
navbar : Theme -> Navbar -> List (Attribute msg) -> List (Html msg) -> Html msg
navbar theme model attr inner =
    let
        bg =
            case model.kind of
                Primary ->
                    theme.primary

                Secondary ->
                    theme.secondary

                Warning ->
                    theme.warning

                Success ->
                    theme.success

                Danger ->
                    theme.danger

        ( p, fs, h ) =
            case model.size of
                Small ->
                    ( px 16, px 12, px 30 )

                Medium ->
                    ( px 24, px 16, px 60 )

                Large ->
                    ( px 30, px 22, px 90 )
    in
    styled Styled.div
        [ color model.text
        , height h
        , fontSize fs
        , fontFamilies theme.font
        , padding2 zero (px 20)
        , zIndex (int 50)
        , position relative
        , displayFlex
        , backgroundImage (linearGradient (stop <| lighten theme.primary 0.035) (stop <| theme.primary) [])
        , alignItems center
        , boxShadow5 zero (px 2) (px 3) zero (rgba 0 0 0 0.1)
        ]
        attr
        ([ title [] [ text model.title ]
         , spacer [] []
         ]
            ++ inner
        )
