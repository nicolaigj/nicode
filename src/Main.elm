module Main exposing (main)

import Browser exposing (Document)
import Browser.Navigation as Nav
import Css
    exposing
        ( Color
        , Style
        , active
        , border3
        , borderBottom3
        , borderRadius
        , fontSize
        , fontStyle
        , marginLeft
        , marginRight
        , marginTop
        , padding
        , pct
        , property
        , px
        , rem
        , solid
        , width
        )
import Css.Global
import Html.Styled exposing (Html, a, br, div, h1, img, nav, section, span, text)
import Html.Styled.Attributes exposing (css, href, src)
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


type alias CvEntry =
    { company : String
    , position : String
    , description : String
    , fromDate : String
    , toDate : String
    , technologies : List String
    }


cvEntries : List CvEntry
cvEntries =
    [ CvEntry "Nurofy"
        "Team lead"
        """Some people have an ability to write placeholder text... It's an art you're 
            basically born with. 
            You either have it or you don't. All of the words in Lorem Ipsum have flirted with me - consciously or 
            unconsciously. That's to be expected."""
        "2019-02"
        "2020-12"
        [ ".NET Core", "SQL", "Svelte", "Sapper" ]
    , CvEntry "Nurofy"
        "Team lead"
        """Some people have an ability to write placeholder text... It's an art you're 
            basically born with. 
            You either have it or you don't. All of the words in Lorem Ipsum have flirted with me - consciously or 
            unconsciously. That's to be expected."""
        "2019-02"
        "2020-12"
        [ ".NET Core", "SQL", "Svelte", "Sapper" ]
    ]


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


pageLoader : Route -> List (Html Msg)
pageLoader page =
    case page of
        Contact ->
            [ text "Contact" ]

        Home ->
            [ div [ css [ heroLayout ] ] [ heroLeft, heroRight ]
            ]

        CV ->
            h1 [] [ text "Experience" ] :: cvSection

        Blog ->
            [ text "Blog" ]

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
                """Hi! I’m Nicolai, a developer with a passion for people and technology."""
            ]
        ]


cvEntrySection : CvEntry -> Html Msg
cvEntrySection entry =
    section [ css [ cvEntryStyle ] ]
        [ text (entry.fromDate ++ "-" ++ entry.toDate)
        , br [] []
        , h1 [] [ text (entry.position ++ " at " ++ entry.company)]
        , text entry.description
        , br [] []
        , text """[ .NET Core, SQL, Svelte, Sapper ]"""
        ]


technologies : List String -> String -> String
technologies t s =
    case t of 
        [] ->
            s
        first::[] ->
            s ++ ", " ++ first ++ "]"
        first::rest ->
            technologies rest (s ++ ", " ++ first)

cvSection : List (Html Msg)
cvSection = 
    List.map cvEntrySection cvEntries

cvEntryStyle : Style
cvEntryStyle =
    Css.batch
        [ marginTop (px 100)
        , border3 (px 1) solid colors.green
        , padding (px 15)
        , fontFamily
        , textBase
        ]


navLayout : Style
navLayout =
    Css.batch
        [ property "display" "grid"
        , property "grid-template-columns" "1fr minmax(200px, 500px) 2fr"
        , property "grid-template-areas" "'gutterLeft header gutterRight'"
        , Css.backgroundColor colors.darkPurple
        ]



-- STYLES


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
        , Css.fontSize (rem 1.2)
        , Css.marginLeft (px 3)
        , active [ borderBottom3 (px 1) solid colors.green ]
        ]


fontFamily : Style
fontFamily =
    Css.fontFamilies [ "Roboto Mono" ]


textBase : Style
textBase =
    Css.fontSize (rem 1)


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
            , fontFamily
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
