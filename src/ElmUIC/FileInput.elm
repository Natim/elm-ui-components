module ElmUIC.FileInput exposing (FileInput, defaultFileInput, fileInput)

import Css exposing (Color, backgroundColor, border3, borderRadius, color, cursor, displayFlex, ellipsis, flex, fontFamilies, fontSize, height, hex, hidden, int, lineHeight, noWrap, overflow, padding2, pointer, px, solid, textOverflow, whiteSpace, zero)
import ElmUIC.Theme exposing (ColorSetting(..), Size(..), Theme)
import File exposing (File)
import Html.Styled as Styled exposing (Attribute, Html, styled, text)


type alias FileInput =
    { kind : ColorSetting
    , size : Size
    , text : Color
    , file : Maybe File
    }


defaultFileInput : FileInput
defaultFileInput =
    { kind = Primary
    , size = Medium
    , text = hex "#FFF"
    , file = Nothing
    }


name : List (Attribute msg) -> List (Html msg) -> Html msg
name =
    styled Styled.div
        [ textOverflow ellipsis
        , whiteSpace noWrap
        , overflow hidden
        , padding2 zero (px 10)
        , lineHeight (px 34)
        , cursor pointer
        , flex (int 1)
        ]


{-| A styled button
-}
button : Theme -> FileInput -> List (Attribute msg) -> List (Html msg) -> Html msg
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
        , fontFamilies theme.font
        ]


{-| A styled button
-}
fileInput : Theme -> FileInput -> List (Attribute msg) -> List (Html msg) -> Html msg
fileInput theme model attr inner =
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

        fileName =
            case model.file of
                Just file ->
                    File.name file

                Nothing ->
                    "No file selected"
    in
    styled Styled.div
        [ border3 (px 1) solid (hex "#DDD")
        , backgroundColor (hex "#FDFDFD")
        , borderRadius (px 2)
        , color (hex "#707070")
        , fontFamilies theme.font
        , height h
        , displayFlex
        ]
        attr
        [ name [] [ text fileName ]
        , button theme model [] [ text "Browse" ]
        ]
