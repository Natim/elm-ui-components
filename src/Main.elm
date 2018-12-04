module Main exposing (main)

import Browser
import Css exposing (height, px, width)
import ElmUIC.Button exposing (button, defaultButton)
import ElmUIC.Checkbox exposing (checkbox, defaultCheckbox)
import ElmUIC.FileInput exposing (defaultFileInput, fileInput)
import ElmUIC.Input exposing (defaultInput, input)
import ElmUIC.Modal exposing (defaultModal, modal)
import ElmUIC.Navbar exposing (defaultNavbar, item, navbar, separator)
import ElmUIC.Selector exposing (Option, defaultSelector, dropdownItem, selector)
import ElmUIC.Theme as Theme exposing (ColorSetting(..), Size(..), defaultTheme)
import ElmUIC.Toast exposing (Position(..), defaultToast, toast)
import File exposing (File)
import File.Select as Select
import Html
import Html.Styled exposing (Attribute, Html, nav, text, toUnstyled)
import Html.Styled.Attributes exposing (css, placeholder, value)
import Html.Styled.Events exposing (onInput, stopPropagationOn)
import Json.Decode as Json


onClick : msg -> Attribute msg
onClick msg =
    stopPropagationOn "click" (Json.map alwaysPreventDefault (Json.succeed msg))


alwaysPreventDefault : msg -> ( msg, Bool )
alwaysPreventDefault msg =
    ( msg, True )


selectFile : Cmd Msg
selectFile =
    Select.file [ "text/plain" ] FileLoaded


type Msg
    = NoOp
    | Click
    | Input String
    | Check
    | Select Option
    | ToggleModal Bool
    | SelectFile
    | FileLoaded File


type alias Model =
    { input : String
    , checked : Bool
    , selected : Option
    , options : List Option
    , selectedOpen : Bool
    , modalOpen : Bool
    , selectedFile : Maybe File
    }


initialModel : Model
initialModel =
    { input = ""
    , checked = False
    , selectedOpen = False
    , modalOpen = False
    , selectedFile = Nothing
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
                , kind = Theme.Danger
            }
            Select
            [ css
                [ width (px 200) ]
            ]
            []
        , button
            defaultTheme
            defaultButton
            [ onClick <| ToggleModal True ]
            [ text "OpenModal" ]
        , modal
            defaultTheme
            { defaultModal
                | open = model.modalOpen
            }
            ToggleModal
            [ css [ width (px 400), height (px 400) ] ]
            [ button
                defaultTheme
                defaultButton
                [ onClick <| ToggleModal False ]
                [ text "Close it!" ]
            ]
        , navbar defaultTheme
            { defaultNavbar | title = "Hello, WORLD" }
            [ css [ width (px 600) ] ]
            [ item defaultTheme [] [ text "Sad" ]
            , separator defaultTheme [] []
            , item defaultTheme [] [ text "Sad 2" ]
            , separator defaultTheme [] []
            , item defaultTheme [] [ text "Sad 3" ]
            ]
        , fileInput defaultTheme
            { defaultFileInput | file = model.selectedFile, kind = Danger }
            [ onClick SelectFile ]
            []
        ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Input val ->
            ( { model | input = val }, Cmd.none )

        Check ->
            ( { model | checked = not model.checked }, Cmd.none )

        Select option ->
            ( { model
                | selectedOpen = not model.selectedOpen
                , selected = option
              }
            , Cmd.none
            )

        ToggleModal direction ->
            ( { model | modalOpen = direction }, Cmd.none )

        SelectFile ->
            ( model, selectFile )

        FileLoaded file ->
            ( { model | selectedFile = Just file }, Cmd.none )

        _ ->
            ( model, Cmd.none )


init : () -> ( Model, Cmd Msg )
init _ =
    ( initialModel
    , Cmd.none
    )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view >> toUnstyled
        }
