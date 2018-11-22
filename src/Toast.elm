module Toast exposing (Position(..), Toast, defaultToast, toast)

import Css exposing (Color, absolute, backgroundColor, borderRadius, bottom, calc, center, color, column, displayFlex, flexDirection, fontFamilies, fontSize, height, hex, int, justifyContent, left, margin, minus, padding, pct, position, px, right, textAlign, top, transform, translateX, translateY, width, zIndex, zero)
import Html.Styled as Styled exposing (Attribute, Html, styled)
import Theme exposing (ColorSetting(..), Size(..), Theme)


type alias Toast =
    { kind : ColorSetting
    , size : Size
    , text : Color
    , z : Int
    , width : Float
    , position : Position
    }


type Position
    = Top
    | Left
    | Bottom
    | Right
    | TopLeft
    | TopRight
    | BottomLeft
    | BottomRight


defaultToast : Toast
defaultToast =
    { kind = Primary
    , size = Medium
    , text = hex "#FFF"
    , z = 1
    , width = 100
    , position = Bottom
    }


{-| A toast notification
-}
toast : Theme -> Toast -> List (Attribute msg) -> List (Html msg) -> Html msg
toast theme model =
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

        p =
            case model.position of
                Top ->
                    [ top zero
                    , left (pct 50)
                    , transform <| translateX (pct -50)
                    ]

                Left ->
                    [ left zero
                    , top (pct 50)
                    , transform <| translateY (pct -50)
                    ]

                Bottom ->
                    [ bottom zero
                    , left (pct 50)
                    , transform <| translateX (pct -50)
                    ]

                Right ->
                    [ right zero
                    , top (pct 50)
                    , transform <| translateY (pct -50)
                    ]

                TopLeft ->
                    [ top zero
                    , left zero
                    ]

                TopRight ->
                    [ top zero
                    , right zero
                    ]

                BottomLeft ->
                    [ bottom zero
                    , left zero
                    ]

                BottomRight ->
                    [ bottom zero
                    , right zero
                    ]
    in
    styled Styled.div
        ([ backgroundColor bg
         , color model.text
         , fontFamilies theme.font
         , zIndex (int model.z)
         , textAlign center
         , borderRadius (px 2)
         , padding (px 4)
         , height (px 68)
         , width (px model.width)
         , displayFlex
         , flexDirection column
         , justifyContent center
         , position absolute
         , margin (px 10)
         ]
            ++ p
        )
