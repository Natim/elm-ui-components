module Checkbox exposing (Checkbox, checkbox, defaultCheckbox)

import Css exposing (alignItems, backgroundColor, border3, borderBox, borderRadius, boxShadow6, boxSizing, center, color, cursor, deg, display, displayFlex, fill, focus, height, hex, inlineBlock, inset, int, justifyContent, none, opacity, outline, pointer, px, rotate, scale, solid, transform, transparent, width, zero)
import Css.Transitions exposing (linear, transition)
import Html.Styled as Styled exposing (Attribute, Html, styled)
import Svg.Styled exposing (path, svg)
import Svg.Styled.Attributes as Svg
import Theme exposing (ColorSetting(..), Size(..), Theme)


type alias Checkbox =
    { checked : Bool
    }


defaultCheckbox : Checkbox
defaultCheckbox =
    { checked = False
    }


{-| A styled checkbox
-}
checkbox : Theme -> Checkbox -> List (Attribute msg) -> List (Html msg) -> Html msg
checkbox theme model attr inner =
    let
        cb =
            styled Styled.button
                [ transition
                    [ Css.Transitions.boxShadow3 400 0 linear
                    ]
                , focus
                    [ transition
                        [ Css.Transitions.boxShadow3 200 0 linear
                        ]
                    , boxShadow6 inset zero zero zero (px 2) (hex "#00C0FF")
                    , outline none
                    ]
                , borderRadius (px 2)
                , justifyContent center
                , alignItems center
                , displayFlex
                , height (px 36)
                , width (px 36)
                , border3 (px 1) solid (hex "#DDD")
                , backgroundColor (hex "#FDFDFD")
                , color (hex "#707070")
                , display inlineBlock
                , cursor pointer
                , boxSizing borderBox
                , boxShadow6 inset zero zero zero (px 2) transparent
                ]
    in
    cb attr
        [ svg
            [ Svg.width "36"
            , Svg.height "36"
            , Svg.viewBox "0 0 36 36"
            , Svg.css
                [ transition
                    [-- all 200ms 0ms ease;
                    ]
                , opacity (int 1)
                , fill (hex "#707070")
                , height (px 16)
                , width (px 16)
                ]
            ]
            [ path [ Svg.d "M35.792 5.332L31.04 1.584c-.147-.12-.33-.208-.537-.208-.207 0-.398.087-.545.217l-17.286 22.21S5.877 17.27 5.687 17.08c-.19-.19-.442-.51-.822-.51-.38 0-.554.268-.753.467-.148.156-2.57 2.7-3.766 3.964-.07.077-.112.12-.173.18-.104.148-.173.313-.173.494 0 .19.07.347.173.494l.242.225s12.058 11.582 12.257 11.78c.2.2.442.45.797.45.345 0 .63-.37.795-.536l21.562-27.7c.104-.146.173-.31.173-.5 0-.217-.087-.4-.208-.555z" ]
                []
            ]
        ]
