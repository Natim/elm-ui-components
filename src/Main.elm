module Main exposing (main)

import Browser
import Button exposing (button, defaultButton)
import Checkbox exposing (checkbox, defaultCheckbox)
import Html
import Html.Styled exposing (Html, nav, text, toUnstyled)
import Html.Styled.Attributes exposing (placeholder, value)
import Html.Styled.Events exposing (onClick, onInput)
import Input exposing (defaultInput, input)
import Theme exposing (Size(..), defaultTheme)
import Toast exposing (Position(..), defaultToast, toast)


type Msg
    = NoOp
    | Click
    | Input String
    | Check


type alias Model =
    { input : String
    , checked : Bool
    }


initialModel : Model
initialModel =
    { input = ""
    , checked = False
    }


view : Model -> Html Msg
view model =
    nav []
        [ button
            defaultTheme
            { defaultButton | size = Large }
            [ onClick Click ]
            [ text "Click me!" ]
        , input
            defaultTheme
            defaultInput
            [ onInput Input, value model.input, placeholder "Input things" ]
            []
        , checkbox
            defaultTheme
            { defaultCheckbox | size = Medium, checked = model.checked }
            [ onClick Check ]
            []
        , toast
            defaultTheme
            { defaultToast
                | position = TopRight
                , transitionDirection = TopRight
                , visible = model.checked
            }
            []
            [ text "Notify things!" ]
        ]


update msg model =
    case msg of
        Input val ->
            { model | input = val }

        Check ->
            { model | checked = not model.checked }

        _ ->
            model


main : Program () Model Msg
main =
    Browser.sandbox
        { view = view >> toUnstyled
        , update = update
        , init = initialModel
        }
