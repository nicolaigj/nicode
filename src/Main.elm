module Main exposing (main)

import Browser exposing (Document)
import Browser.Navigation as Nav
import Css exposing (Color, Style, borderRadius, fontSize, pct, property, px, rem, width)
import Css.Global exposing (Snippet, global)
import Html
import Html.Attributes exposing (class)
import Html.Styled exposing (Html, a, br, div, h1, img, nav, section, span, text)
import Html.Styled.Attributes exposing (css, href, src)
import Markdown
import Url
import Url.Parser exposing (Parser, map, oneOf, s)



-- MAIN


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlChange = UrlChanged
        , onUrlRequest = LinkClicked
        }



-- MODEL


type alias Model =
    { key : Nav.Key
    , url : Url.Url
    , page : Route
    }


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url key =
    ( Model key url (fromUrl url), Cmd.none )


type Msg
    = LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url


type Route
    = Home
    | Blog
    | Contact
    | CV
    | NotFound


routeParser : Parser (Route -> a) a
routeParser =
    oneOf
        [ map Home Url.Parser.top
        , map Blog (s "blog")
        , map Contact (s "contact")
        , map CV (s "cv")
        ]


fromUrl : Url.Url -> Route
fromUrl url =
    { url | path = Maybe.withDefault "" url.fragment, fragment = Nothing }
        |> Url.Parser.parse routeParser
        |> Maybe.withDefault NotFound



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.key (Url.toString url) )

                Browser.External href ->
                    ( model, Nav.load href )

        UrlChanged url ->
            ( { model | url = url, page = fromUrl url }, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- VIEW


view : Model -> Document Msg
view model =
    { title = "Nicode"
    , body =
        List.map Html.Styled.toUnstyled
            [ header
            , br [] []
            , div [ css [ pageLayout ] ]
                [ div [ css [ contentArea ] ] (pageLoader model.page) ]
            , globalStyle
            ]
    }


pageLoader : Route -> List (Html msg)
pageLoader page =
    case page of
        Contact ->
            [ text "Contact" ]

        Home ->
            [ section [ css [ heroLayout ] ] [ heroLeft, heroRight ]
            ]

        CV ->
            [ text "CV" ]

        Blog ->
            [ blogpost applePie, global [ blogStyles ] ]

        NotFound ->
            [ text "404" ]



-- COMPONENTS


header : Html msg
header =
    nav [ css [ navLayout ] ]
        [ div [ css [ headerArea ] ]
            [ h1 []
                [ a [ href "/#/", css [ navItemStyle ] ]
                    [ span [ css [ bracketStyle ] ] [ text "{" ]
                    , text "Nicode"
                    , span [ css [ bracketStyle ] ] [ text "}" ]
                    ]
                , a [ href "/#/blog", css [ navItemStyle ] ] [ text "Blog" ]
                , a [ href "/#/cv", css [ navItemStyle ] ] [ text "CV" ]
                , a [ href "/#/contact", css [ navItemStyle ] ] [ text "Contact" ]
                ]
            ]
        ]


heroLeft : Html msg
heroLeft =
    div [] [ img [ src "/assets/nicolai.jpg", css [ heroImageStyle ] ] [] ]


heroRight : Html msg
heroRight =
    div [ css [ heroTextStyle ] ]
        [ h1 []
            [ text
                """Hi! I’m Nicolai, a developer with a passion for people and technology.
            I know how to exit vim."""
            ]
        ]


navLayout : Style
navLayout =
    Css.batch
        [ property "display" "grid"
        , property "grid-template-columns" "1fr minmax(200px, 500px) 2fr"
        , property "grid-template-areas" "'gutterLeft header gutterRight'"
        , Css.backgroundColor colors.darkPurple
        ]


blogpost : String -> Html msg
blogpost text =
    Markdown.toHtml [ class "blogpost" ] text |> Html.Styled.fromUnstyled



-- STYLES


blogStyles : Snippet
blogStyles =
    Css.Global.class "blogpost"
        [ Css.fontFamilies [ "Roboto Mono" ]
        , Css.fontSize (rem 1)
        , Css.Global.children
            [ Css.Global.p
                [ Css.Global.children
                    [ Css.Global.a
                        [ Css.textDecoration Css.none
                        , Css.color colors.green
                        ]
                    ]
                ]
            ]
        ]


colors : { darkPurple : Color, green : Color, pink : Color, white : Color }
colors =
    { darkPurple = Css.hex "282A36"
    , green = Css.hex "32D97B"
    , pink = Css.hex "F25169"
    , white = Css.hsla 301 0.71 0.96 1.0
    }


navItemStyle : Style
navItemStyle =
    Css.batch
        [ Css.textDecoration Css.none
        , Css.color colors.green
        , Css.marginRight (px 10)
        , Css.fontFamilies [ "Roboto Mono" ]
        , Css.fontSize (rem 1.2)
        , Css.marginLeft (px 3)
        ]


bracketStyle : Style
bracketStyle =
    Css.batch
        [ Css.color colors.pink
        , Css.marginRight (px 4)
        , Css.marginLeft (px 4)
        ]


globalStyle : Html msg
globalStyle =
    Css.Global.global
        [ Css.Global.body
            [ Css.margin (px 0)
            , Css.padding (px 0)
            , Css.backgroundColor colors.darkPurple
            ]
        ]


heroLayout : Style
heroLayout =
    Css.batch
        [ property "display" "grid"
        , property "grid-template-columns" "repeat(auto-fill, minmax(200px, 500px))"
        ]


pageLayout : Style
pageLayout =
    Css.batch
        [ property "display" "grid"
        , property "grid-template-columns" "1fr minmax(320px, 1000px) 1fr"
        , property "grid-template-areas" "'gutterLeft content gutterRight'"
        ]


heroImageStyle : Style
heroImageStyle =
    Css.batch
        [ borderRadius (px 360)
        , width (pct 80)
        , Css.margin Css.auto
        , Css.display Css.block
        ]


heroTextStyle : Style
heroTextStyle =
    Css.batch
        [ Css.marginTop Css.auto
        , Css.marginBottom Css.auto
        , fontSize (rem 0.8)
        , Css.marginLeft (px 20)
        , Css.marginRight (px 20)
        , Css.fontFamilies [ "Roboto Mono" ]
        , Css.fontStyle Css.normal
        , Css.fontWeight Css.normal
        , Css.color colors.white
        ]


contentArea : Style
contentArea =
    Css.batch
        [ property "grid-area" "content"
        , fontSize (rem 1.375)
        , Css.color colors.white
        ]


headerArea : Style
headerArea =
    Css.batch
        [ property "grid-area" "header"
        ]


applePie : String
applePie =
    """
# Apple Pie Recipe

1. Invent the universe.
2. Bake an apple pie.

## Allergies
- Cake
- Eggs
- Apples

> My placeholder text, I think, is going to end up being very good with women. 
Look at that text! Would anyone use that? Can you imagine that, the text of your next webpage?! 
Lorem Ipsum is the single greatest threat. We are not - we are not keeping up with other websites.

The quote above is from [Trump Ipsum](https://trumpipsum.net)
"""
