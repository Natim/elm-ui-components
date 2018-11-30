module Modal exposing (Modal, defaultModal, modal)

import Css exposing (Color, absolute, backgroundColor, block, borderRadius, bottom, color, display, fixed, fontFamilies, fontSize, height, hex, int, left, minHeight, minWidth, none, num, opacity, padding2, pct, position, px, relative, rgba, right, top, transforms, translateX, translateY, vh, vw, width, zIndex, zero)
import Html.Styled as Styled exposing (Attribute, Html, styled)
import Html.Styled.Events exposing (stopPropagationOn)
import Json.Decode as Json
import Theme exposing (ColorSetting(..), Size(..), Theme)


onClick : msg -> Attribute msg
onClick msg =
    stopPropagationOn "click" (Json.map alwaysPreventDefault (Json.succeed msg))


alwaysPreventDefault : msg -> ( msg, Bool )
alwaysPreventDefault msg =
    ( msg, True )


type alias Modal =
    { kind : ColorSetting
    , size : Size
    , text : Color
    , open : Bool
    , closeOnOverlay : Bool
    }


defaultModal : Modal
defaultModal =
    { kind = Primary
    , size = Medium
    , text = hex "#FFF"
    , open = False
    , closeOnOverlay = False
    }


modalContent : Theme -> Modal -> List (Attribute msg) -> List (Html msg) -> Html msg
modalContent theme model =
    styled Styled.div
        [ backgroundColor (hex "#FDFDFD")
        , borderRadius (px 2)
        , color (hex "#707070")
        , zIndex (int 1)
        , minWidth (vw 10)
        , minHeight (vh 10)
        , position absolute
        , left (pct 50)
        , top (pct 50)
        , transforms
            [ translateY (pct -50)
            , translateX (pct -50)
            ]
        ]


modal : Theme -> Modal -> (Bool -> msg) -> List (Attribute msg) -> List (Html msg) -> Html msg
modal theme model msg attr inner =
    let
        openStyles =
            if model.open then
                [ display block ]

            else
                [ display none ]

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

        bga =
            rgba bg.red bg.green bg.blue 0.3
    in
    styled Styled.div
        ([ backgroundColor bga
         , fontSize fs
         , fontFamilies theme.font
         , position fixed
         , width (vw 100)
         , height (vh 100)
         , top zero
         , left zero
         ]
            ++ openStyles
        )
        [ onClick <| msg <| not model.closeOnOverlay ]
        [ modalContent theme model ([ onClick <| msg True ] ++ attr) inner ]
