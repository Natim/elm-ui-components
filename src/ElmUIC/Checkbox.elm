module ElmUIC.Checkbox exposing (Checkbox, checkbox, defaultCheckbox)

import Css exposing (alignItems, backgroundColor, border3, borderBox, borderRadius, boxShadow6, boxSizing, center, color, cursor, deg, display, displayFlex, fill, focus, height, hex, inlineBlock, inset, int, justifyContent, none, opacity, outline, padding, pointer, px, rotate, scale, solid, transform, transforms, translateX, translateY, transparent, width, zero)
import Css.Transitions exposing (linear, transition)
import ElmUIC.Theme exposing (ColorSetting(..), Size(..), Theme)
import Html.Styled as Styled exposing (Attribute, Html, styled)
import Svg.Styled exposing (path, svg)
import Svg.Styled.Attributes as Svg


type alias Checkbox =
    { checked : Bool
    , kind : ColorSetting
    , size : Size
    }


defaultCheckbox : Checkbox
defaultCheckbox =
    { checked = False
    , kind = Primary
    , size = Medium
    }


{-| A styled checkbox
-}
checkbox : Theme -> Checkbox -> List (Attribute msg) -> List (Html msg) -> Html msg
checkbox theme model attr inner =
    let
        checkboxColor =
            case model.kind of
                Primary ->
                    theme.primary

                Secondary ->
                    theme.secondary

                Success ->
                    theme.success

                Warning ->
                    theme.warning

                Danger ->
                    theme.danger

        ( checkSize, checkBoxSize ) =
            case model.size of
                Small ->
                    ( 12, 16 )

                Medium ->
                    ( 24, 32 )

                Large ->
                    ( 48, 64 )

        ( checkBoxScale, checkBoxTranslate ) =
            case model.size of
                Small ->
                    ( 0.5, -4 )

                Medium ->
                    ( 1, 0 )

                Large ->
                    ( 2, 0 )

        cb =
            styled Styled.button
                [ transition
                    [ Css.Transitions.boxShadow3 400 0 linear
                    ]
                , focus
                    [ transition
                        [ Css.Transitions.boxShadow3 200 0 linear
                        ]
                    , boxShadow6 inset zero zero zero (px 2) checkboxColor
                    , outline none
                    ]
                , padding zero
                , borderRadius (px 2)
                , justifyContent center
                , alignItems center
                , displayFlex
                , height (px checkBoxSize)
                , width (px checkBoxSize)
                , border3 (px 1) solid (hex "#DDD")
                , backgroundColor (hex "#FDFDFD")
                , color (hex "#707070")
                , display inlineBlock
                , cursor pointer
                , boxSizing borderBox
                , boxShadow6 inset zero zero zero (px 2) transparent
                ]

        checkmark =
            if model.checked then
                path
                    [ Svg.d "M35.792 5.332L31.04 1.584c-.147-.12-.33-.208-.537-.208-.207 0-.398.087-.545.217l-17.286 22.21S5.877 17.27 5.687 17.08c-.19-.19-.442-.51-.822-.51-.38 0-.554.268-.753.467-.148.156-2.57 2.7-3.766 3.964-.07.077-.112.12-.173.18-.104.148-.173.313-.173.494 0 .19.07.347.173.494l.242.225s12.058 11.582 12.257 11.78c.2.2.442.45.797.45.345 0 .63-.37.795-.536l21.562-27.7c.104-.146.173-.31.173-.5 0-.217-.087-.4-.208-.555z"
                    , Svg.css
                        [ transforms
                            [ scale checkBoxScale
                            , translateX (px checkBoxTranslate)
                            , translateY (px checkBoxTranslate)
                            ]
                        ]
                    ]
                    []

            else
                path [] []
    in
    cb attr
        [ svg
            [ Svg.viewBox ("0 0 " ++ String.fromInt checkBoxSize ++ " " ++ String.fromInt checkBoxSize)
            , Svg.css
                [ opacity (int 1)
                , fill checkboxColor
                , height (px checkSize)
                , width (px checkSize)
                ]
            ]
            [ checkmark ]
        ]
