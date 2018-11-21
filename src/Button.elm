module Button exposing (Button, button, defaultButton)

import Css exposing (Color, backgroundColor, borderRadius, color, fontSize, height, hex, padding2, px)
import Html.Styled as Styled exposing (Attribute, Html, styled)
import Theme exposing (ColorSetting(..), Size(..), Theme)


type alias Button =
    { kind : ColorSetting
    , size : Size
    , text : Color
    }


defaultButton : Button
defaultButton =
    { kind = Primary
    , size = Medium
    , text = hex "#FFF"
    }


{-| A styled button
-}
button : Theme -> Button -> List (Attribute msg) -> List (Html msg) -> Html msg
button theme model =
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
                    ( px 16, px 12, px 26 )

                Medium ->
                    ( px 24, px 16, px 36 )

                Large ->
                    ( px 30, px 22, px 50 )
    in
    styled Styled.button
        [ backgroundColor bg
        , color model.text
        , borderRadius (px 2)
        , padding2 (px 0) p
        , height h
        , fontSize fs
        ]
