module Main exposing (main)

import Browser
import Button exposing (button, defaultButton)
import Html
import Html.Styled exposing (Html, nav, text, toUnstyled)
import Html.Styled.Events exposing (onClick)
import Input exposing (defaultInput, input)
import Theme exposing (Size(..), defaultTheme)


type Msg
    = NoOp
    | DoSomething


type alias Model =
    {}


initialModel : Model
initialModel =
    {}


view : Model -> Html Msg
view model =
    nav []
        [ button defaultTheme { defaultButton | size = Large } [ onClick DoSomething ] [ text "Click me!" ]
        , input defaultTheme defaultInput [] []
        ]


update msg model =
    case msg of
        _ ->
            model


main : Program () Model Msg
main =
    Browser.sandbox
        { view = view >> toUnstyled
        , update = update
        , init = initialModel
        }
