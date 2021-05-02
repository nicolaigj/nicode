module Main exposing (main)

import Browser exposing (Document)
import Browser.Navigation as Nav
import Css
    exposing
        ( Color
        , Style
        , batch
        , block
        , border3
        , borderBottom2
        , borderBottomStyle
        , borderColor
        , borderRadius
        , display
        , fontSize
        , fontStyle
        , inline
        , inlineBlock
        , lineHeight
        , marginBottom
        , marginLeft
        , marginRight
        , marginTop
        , noWrap
        , normal
        , padding
        , pct
        , property
        , px
        , rem
        , solid
        , whiteSpace
        , width
        )
import Css.Global exposing (global)
import Html
import Html.Attributes exposing (class)
import Html.Styled exposing (Html, a, address, div, h1, h2, img, nav, p, section, span, text)
import Html.Styled.Attributes exposing (css, href, src)
import Markdown
import Url
import Url.Builder exposing (absolute)
import Url.Parser exposing ((</>), Parser, int, map, oneOf, s)
import Html.Styled.Attributes exposing (alt)



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


type alias BlogPostInfo =
    { title : String
    , body : String
    , image : Maybe Url.Url
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
        """Nurofy creates a digital marketing platform that enables users to run and manage advertisement campaigns
        across different social media networks and programmatic advertisement from a single interface. As a team lead
        for developers and designers we built API's and user interfaces, and a high performance real time bidder in
        Go."""
        "2019-02"
        "2020-12"
        [ ".NET Core", "Go", "Azure", "SQL", "Svelte", "CI/CD" ]
    , CvEntry "Avo Consulting"
        "Senior Consultant"
        """Avo Consulting helps businesses creating better ways to work and utilize their workforce by leveraging robot
        process automation (RPA) and AI. With RPA we can reduce costs, improve customer satisfaction and improve
        quality in critical business processes."""
        "2017-02"
        "2019-01"
        [ ".NET Core", "SQL", "Azure", "Blue Prism", "Python" ]
    , CvEntry "Candidator"
        "Consultant"
        """Candidator (formerly Knowit Services) is a managed services provider that manages everything from webhosting
        to complete IT infrastructures. With state of the art computer centres in Sweden and Norway we served thousands
        of users every day. I was technical manager for several accounting companies, managing everything from their
        computer networks to software maintenance and support."""
        "2013-10"
        "2017-01"
        [ "PowerShell", "Azure", "Windows Server", "Cisco", "Office365" ]
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
    | BlogPost Int
    | Contact
    | CV
    | NotFound


routeParser : Parser (Route -> a) a
routeParser =
    oneOf
        [ map Home Url.Parser.top
        , map Blog (s "blog")
        , map BlogPost (s "blog" </> int)
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
            , div [ css [ pageLayout ] ]
                [ div [ css [ contentArea, contentBottomStyle ] ] (pageLoader model.page) ]
            , p [ css [ marginNormalStyle, marginBottom (px 20) ] ] [ text "Created by Nicolai Gjellestad in Elm" ]
            , globalStyle
            ]
    }


pageLoader : Route -> List (Html Msg)
pageLoader page =
    case page of
        Contact ->
            [ text "Contact" ]

        Home ->
            [ section [ css [ heroLayout ] ] [ heroLeft, heroRight ]
            , availabilitySection
            , skillsSection
            , cvSection
            ]

        CV ->
            [ cvSection ]

        Blog ->
            [ bodyToMarkdown applePie.body, blogStyles ]

        BlogPost _ ->
            [ bodyToMarkdown applePie.body, blogStyles ]

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
                ]
            ]
        ]


heroLeft : Html msg
heroLeft =
    div [] [ img [ src "/assets/nicolai.jpg", css [ heroImageStyle ], alt "Nicolai Gjellestad" ] [] ]


heroRight : Html Msg
heroRight =
    div [ css [ heroTextStyle ] ]
        [ p []
            [ text
                """Hi! I’m Nicolai, a freelance developer with a passion for people and technology.
                """
            , contact
            ]
        ]


contact : Html Msg
contact =
    address [ css [ contactStyle ] ]
        [ text "Say hi to me by "
        , a [ href "mailto:nicolai@gjellestad.net", css [ linkStyle ] ] [ text "mail" ]
        , text ", "
        , a [ href "tel:+4799428603", css [ linkStyle ] ]
            [ text "telephone ", span [ css [ whiteSpace noWrap ] ] [ text "994 28 603" ] ]
        , text " or "
        , a [ href "https://www.linkedin.com/in/ngjellestad/", css [ linkStyle ] ] [ text "LinkedIn" ]
        , text "."
        ]


contactStyle : Style
contactStyle =
    Css.batch
        [ display inline
        , fontStyle normal
        ]


cvEntrySection : CvEntry -> Html Msg
cvEntrySection entry =
    section [ css [ cvEntryStyle ] ]
        [ text (entry.fromDate ++ "-" ++ entry.toDate)
        , h2 [] [ text (entry.position ++ " at " ++ entry.company) ]
        , p [] [ text entry.description ]
        , p [] [ text (technologiesToString entry.technologies) ]
        ]


technologiesToString : List String -> String
technologiesToString l =
    technologiesToString2 l "[ "


technologiesToString2 : List String -> String -> String
technologiesToString2 t s =
    case t of
        [] ->
            s ++ "]"

        first :: [] ->
            s ++ first ++ " ]"

        first :: rest ->
            technologiesToString2 rest (s ++ first ++ ", ")


cvSection : Html Msg
cvSection =
    section [ css [ contentSectionStyle, marginNormalStyle ] ]
         ((h1 [ css [ contentSectionHeadingStyle ] ] [ text "Experience and projects" ]) 
            :: List.map
                cvEntrySection
                cvEntries)
        


availabilitySection : Html Msg
availabilitySection =
    section [ css [ contentSectionStyle, marginNormalStyle ] ]
        [ h1 [ css [ contentSectionHeadingStyle ] ]
            [ text "Availability" ]
        , p [ css [ display block ] ]
            [ text """I'm available for full time projects from August 2022,
            but I may be open for smaller projects before this. Contact me!""" ]
        ]


skillsSection : Html Msg
skillsSection =
    section [ css [ contentSectionStyle, marginNormalStyle ] ]
        [ h1 [ css [ contentSectionHeadingStyle ] ] [ text "Skills" ]
        , p [ css [ display block ] ] [ text """I'm mainly a backend developer focusing on C# and Go, but I delve into functional front end
        programming with Elm on my spare time. Lately I've built API's and serverless functions in C# and a high
        performance real-time bidder in Go. I have experience as a project manager and tech lead, I care about
        making people and teams do great stuff while having a good time.""" ]
        ]


contentSectionStyle : Style
contentSectionStyle =
    batch
        [ marginTop (px 100)
        , lineHeight (rem 2)
        ]


contentSectionHeadingStyle : Style
contentSectionHeadingStyle =
    batch [ borderBottomStyle, borderPinkStyle, display inlineBlock ]


contentBottomStyle : Style
contentBottomStyle =
    batch
        [ marginBottom (px 200) ]


marginNormalStyle : Style
marginNormalStyle =
    batch
        [ marginLeft (px 20)
        , marginRight (px 20)
        ]


textSizeLarge : Style
textSizeLarge =
    fontSize (rem 1.5)


borderBottomStyle : Style
borderBottomStyle =
    batch
        [ borderBottom2 (px 1) solid ]


borderPinkStyle : Style
borderPinkStyle =
    borderColor colors.pink


cvEntryStyle : Style
cvEntryStyle =
    Css.batch
        [ border3 (px 1) solid colors.pink
        , borderRadius (px 10)
        , marginTop (px 40)
        , padding (px 15)
        , lineHeight (rem 1.5)
        ]


navLayout : Style
navLayout =
    Css.batch
        [ property "display" "grid"
        , property "grid-template-columns" "1fr minmax(200px, 500px) 2fr"
        , property "grid-template-areas" "'gutterLeft header gutterRight'"
        , Css.backgroundColor colors.darkPurple
        ]


bodyToMarkdown : String -> Html msg
bodyToMarkdown body =
    Markdown.toHtml [ class "blogpost" ] body |> Html.Styled.fromUnstyled



-- STYLES


blogStyles : Html msg
blogStyles =
    global
        [ Css.Global.class "blogpost"
            [ Css.fontFamilies [ "Roboto Mono" ]
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
        [ Css.marginRight (px 10)
        , Css.marginLeft (px 3)
        , linkStyle
        ]


linkStyle : Style
linkStyle =
    Css.batch
        [ Css.textDecoration Css.none
        , Css.color colors.green
        ]


fontFamily : Style
fontFamily =
    Css.fontFamilies [ "Roboto Mono" ]


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
            , Css.color colors.white
            ]
        ]


heroLayout : Style
heroLayout =
    Css.batch
        [ property "display" "grid"
        , property "grid-template-columns" "repeat(auto-fill, minmax(200px, 500px))"
        , marginTop (px 20)
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
        , Css.marginLeft (px 20)
        , Css.marginRight (px 20)
        , Css.fontFamilies [ "Roboto Mono" ]
        , Css.fontStyle Css.normal
        , Css.fontWeight Css.normal
        , textSizeLarge
        ]


contentArea : Style
contentArea =
    Css.batch
        [ property "grid-area" "content"
        ]


headerArea : Style
headerArea =
    Css.batch
        [ property "grid-area" "header"
        ]


applePie : BlogPostInfo
applePie =
    BlogPostInfo "Apple Pie Recipe"
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
        (absolute
            [ "assets", "applePie.jpg" ]
            []
            |> Url.fromString
        )
