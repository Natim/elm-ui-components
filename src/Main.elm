module Main exposing (main)

import Browser
import Button exposing (button, defaultButton)
import Checkbox exposing (checkbox, defaultCheckbox)
import Css exposing (px, width)
import Html
import Html.Styled exposing (Html, nav, text, toUnstyled)
import Html.Styled.Attributes exposing (css, placeholder, value)
import Html.Styled.Events exposing (onClick, onInput)
import Input exposing (defaultInput, input)
import Selector exposing (Option, defaultSelector, dropdownItem, selector)
import Theme exposing (Size(..), defaultTheme)
import Toast exposing (Position(..), defaultToast, toast)


type Msg
    = NoOp
    | Click
    | Input String
    | Check
    | Select Option
    | OpenSelect Bool


type alias Model =
    { input : String
    , checked : Bool
    , selected : Option
    , options : List Option
    , selectedOpen : Bool
    }


initialModel : Model
initialModel =
    { input = ""
    , checked = False
    , selectedOpen = False
    , selected =
        { key = ""
        , value = ""
        }
    , options =
        [ { key = "Test"
          , value = "Test1"
          }
        , { key = "Test 2"
          , value = "Test2"
          }
        , { key = "Test 3"
          , value = "Tes"
          }
        , { key = "Test 4"
          , value = "Tes4"
          }
        , { key = "Test 5"
          , value = "Test5"
          }
        , { key = "Test 6"
          , value = "Test6"
          }
        , { key = "Test 7"
          , value = "Test7"
          }
        , { key = "Test 8"
          , value = "Test8"
          }
        , { key = "Test 9"
          , value = "Test9"
          }
        , { key = "Test 10"
          , value = "Test10"
          }
        ]
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
        , selector defaultTheme
            { defaultSelector
                | placeholder = "Select a choice"
                , open = model.selectedOpen
                , options = model.options
                , selected = model.selected
            }
            [ css
                [ width (px 200) ]
            ]
            [ onClick <| OpenSelect <| not model.selectedOpen ]
            (List.map
                (\option ->
                    dropdownItem option
                        model.selected
                        [ onClick (Select option) ]
                )
                model.options
            )
        ]


update : Msg -> Model -> Model
update msg model =
    case msg of
        Input val ->
            { model | input = val }

        Check ->
            { model | checked = not model.checked }

        Select option ->
            { model
                | selectedOpen = False
                , selected = option
            }

        OpenSelect direction ->
            { model | selectedOpen = direction }

        _ ->
            model


main : Program () Model Msg
main =
    Browser.sandbox
        { view = view >> toUnstyled
        , update = update
        , init = initialModel
        }
