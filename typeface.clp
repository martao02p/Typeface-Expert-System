(deftemplate message
    (slot name (type STRING))
    (slot question (type STRING))
    (slot change (type INTEGER))
    (multislot answers (type STRING))
)

(deftemplate exit
    (slot ifExit (type STRING))
)

(deftemplate typeface
    (slot name (type STRING))
)

(defrule start
    =>
    (assert (message (name "start") (question "What kind of project is it for?") (answers "Logo" "Book" "Invitation" "Infographic" "Newspaper") (change 0)))
)

; logo
(defrule logo
    ?f <- (message (name "start") (answers "Logo") (change 1))
    =>
    (modify ?f (name "logo-first") (question "What do you prefer?") (answers "A sans serif, maybe?" "Or perhaps a serif?") (change 0))
)
(defrule logo-sansserif
    ?f <- (message (name "logo-first") (answers "A sans serif, maybe?") (change 1))
    =>
    (modify ?f (name "logo-geometrics") (question "You like geometrics?") (answers "Yes" "No") (change 0))
)
(defrule logo-geometrics-yes
    ?f <- (message (name "logo-geometrics") (answers "Yes") (change 1))
    =>
    (modify ?f (name "logo-futura") (question "Do you like futura?") (answers "Yes" "No") (change 0))
)
(defrule logo-futura-yes
    ?f <- (message (name "logo-futura") (answers "Yes") (change 1))
    =>
    (assert (typeface (name "Futura")))
)
(defrule logo-futura-no
    ?f <- (message (name "logo-futura") (answers "No") (change 1))
    =>
    (assert (typeface (name "Metro")))
)
(defrule logo-geometrics-no
    ?f <- (message (name "logo-geometrics") (answers "No") (change 1))
    =>
    (modify ?f (name "logo-neo-grotesk") (question "A neo-grotesk perhaps?") (answers "Yes" "No") (change 0))
)
(defrule logo-neo-grotesk-yes
    ?f <- (message (name "logo-neo-grotesk") (answers "Yes") (change 1))
    =>
    (modify ?f (name "logo-science-fiction") (question "If I say 'science fiction movies are my favourite'.") (answers "Good" "Bad") (change 0))
)
(defrule logo-science-fiction-good
    ?f <- (message (name "logo-science-fiction") (answers "Good") (change 1))
    =>
    (assert (typeface (name "Eurostile")))
)

; defrule newspaper-swiss-yes-science-fiction (logo-science-fiction-bad)

(defrule logo-neo-grotesk-no
    ?f <- (message (name "logo-neo-grotesk") (answers "No") (change 1))
    =>
    (modify ?f (name "logo-humanistic") (question "Something humanistic, then?") (answers "Yes" "No") (change 0))
)
(defrule logo-humanistic-yes
    ?f <- (message (name "logo-humanistic") (answers "Yes") (change 1))
    =>
    (modify ?f (name "logo-adobe") (question "Do you like the look of adobe?") (answers "Yes" "No") (change 0))
)
(defrule logo-adobe-yes
    ?f <- (message (name "logo-adobe") (answers "Yes") (change 1))
    =>
    (assert (typeface (name "Myriad")))
)
(defrule logo-adobe-no
    ?f <- (message (name "logo-adobe") (answers "No") (change 1))
    =>
    (assert (typeface (name "Frutiger")))
)
(defrule logo-humanistic-no
    ?f <- (message (name "logo-humanistic") (answers "No") (change 1))
    =>
    (modify ?f (name "logo-classic") (question "How about something classic?") (answers "Yes" "No") (change 0))
)
(defrule logo-classic-yes
    ?f <- (message (name "logo-classic") (answers "Yes") (change 1))
    =>
    (assert (typeface (name "Akzidenz Grotesk")))
)
(defrule logo-classic-no
    ?f <- (message (name "logo-classic") (answers "No") (change 1))
    =>
    (modify ?f (name "logo-decorative") (question "Then we only have something decorative.") (answers "Ok") (change 0))
)
(defrule logo-decorative-ok
    ?f <- (message (name "logo-decorative") (answers "Ok") (change 1))
    =>
    (assert (typeface (name "Peignot")))
)
(defrule logo-serif
    ?f <- (message (name "logo-first") (answers "Or perhaps a serif?") (change 1))
    =>
    (modify ?f (name "logo-sound") (question "How do the words semi-sans, semi-serif sound?") (answers "Good" "Bad") (change 0))
)
(defrule logo-sound-good
    ?f <- (message (name "logo-sound") (answers "Good") (change 1))
    =>
    (assert (typeface (name "Rotis")))
)
(defrule logo-sound-bad
    ?f <- (message (name "logo-sound") (answers "Bad") (change 1))
    =>
    (modify ?f (name "logo-new") (question "Something new, got serifs, got sans?") (answers "Good" "Bad") (change 0))
)
(defrule logo-new-good
    ?f <- (message (name "logo-new") (answers "Good") (change 1))
    =>
    (assert (typeface (name "Fedra")))
)
(defrule logo-new-bad
    ?f <- (message (name "logo-new") (answers "Bad") (change 1))
    =>
    (modify ?f (name "logo-italian") (question "Is it an italian restaurant?") (answers "Yes" "No") (change 0))
)

; defrule invitation-thin-hairlines-italian (logo-italian-yes)

(defrule logo-italian-no
    ?f <- (message (name "logo-italian") (answers "No") (change 1))
    =>
    (modify ?f (name "logo-office") (question "Got a whole bunch of office correspondence?") (answers "Yes" "No") (change 0))
)
(defrule logo-office-yes
    ?f <- (message (name "logo-office") (answers "Yes") (change 1))
    =>
    (assert (typeface (name "Lexicon")))
)
(defrule logo-office-no
    ?f <- (message (name "logo-office") (answers "No") (change 1))
    =>
    (modify ?f (name "logo-waiting-classic") (question "Here we have a classic waiting for you?") (answers "Ok") (change 0))
)
(defrule logo-waiting-classic-ok
    ?f <- (message (name "logo-waiting-classic") (answers "Ok") (change 1))
    =>
    (assert (typeface (name "Palatino")))
)

; book
(defrule book
    ?f <- (message (name "start") (question ?q) (answers "Book") (change 1))
    =>
    (modify ?f (name "book-doubt") (question "Are you completely in doubt?") (answers "Yes" "No") (change 0))
)
(defrule book-doubt-yes
    ?f <- (message (name "book-doubt") (answers "Yes") (change 1))
    =>
    (assert (typeface (name "Caslon")))
)
(defrule book-doubt-no
    ?f <- (message (name "book-doubt") (answers "No") (change 1))
    =>
    (modify ?f (name "book-usability") (question "A champion in usability, perhaps?") (answers "Yes" "No") (change 0))
)
(defrule book-usability-yes
    ?f <- (message (name "book-usability") (answers "Yes") (change 1))
    =>
    (assert (typeface (name "Minion")))
)
(defrule book-usability-no
    ?f <- (message (name "book-usability") (answers "No") (change 1))
    =>
    (modify ?f (name "book-garamond") (question "Everybody loves garamond?") (answers "Yes" "No") (change 0))
)
(defrule book-garamond-yes
    ?f <- (message (name "book-garamond") (answers "Yes") (change 1))
    =>
    (modify ?f (name "book-eye") (question "But perhaps one would want a larger eye?") (answers "Yes" "No") (change 0))
)
(defrule book-eye-yes
    ?f <- (message (name "book-eye") (answers "Yes") (change 1))
    =>
    (assert (typeface (name "Sabon")))
)
(defrule book-eye-no
    ?f <- (message (name "book-eye") (answers "No") (change 1))
    =>
    (assert (typeface (name "Garamond")))
)
(defrule book-garamond-no
    ?f <- (message (name "book-garamond") (answers "No") (change 1))
    =>
    (modify ?f (name "book-sansserif") (question "So you want a sans serif, is that the case?") (answers "Yes" "No") (change 0))
)
(defrule book-sansserif-yes
    ?f <- (message (name "book-sansserif") (answers "Yes") (change 1))
    =>
    (assert (typeface (name "Optima")))
)
(defrule book-sansserif-no
    ?f <- (message (name "book-sansserif") (answers "No") (change 1))
    =>
    (modify ?f (name "book-ericgill") (question "What is your opinion of eric gill?") (answers "Good" "Bad") (change 0))
)
(defrule book-ericgill-good
    ?f <- (message (name "book-ericgill") (answers "Good") (change 1))
    =>
    (assert (typeface (name "Joanna")))
)
(defrule book-ericgill-bad
    ?f <- (message (name "book-ericgill") (answers "Bad") (change 1))
    =>
    (modify ?f (name "book-humanistic") (question "Humanistic forms please your eye?") (answers "Yes" "No") (change 0))
)
(defrule book-humanistic-yes
    ?f <- (message (name "book-humanistic") (answers "Yes") (change 1))
    =>
    (modify ?f (name "book-food") (question "Okay to a question of food.")(answers "Gouda" "Emmental") (change 0))
)
(defrule book-food-gouda
    ?f <- (message (name "book-food") (answers "Gouda") (change 1))
    =>
    (assert (typeface (name "Ff Scala")))
)
(defrule book-food-emmental
    ?f <- (message (name "book-food") (answers "Emmental") (change 1))
    =>
    (assert (typeface (name "Syntax")))
)
(defrule book-humanistic-no
    ?f <- (message (name "book-humanistic") (answers "No") (change 1))
    =>
    (assert (typeface (name "Baskerville")))
)


; invitation
(defrule invitation
    ?f <- (message (name "start") (question ?q) (answers "Invitation") (change 1))
    =>
    (modify ?f (name "invitation-handwritten") (question "Like something handwritten, do you?") (answers "Yes" "No") (change 0))
)
(defrule invitation-handwritten-yes
    ?f <- (message (name "invitation-handwritten") (answers "Yes") (change 1))
    =>
    (modify ?f (name "invitation-calligraphic") (question "Something calligraphic, maybe?") (answers "Yes" "No") (change 0))
)
(defrule invitation-calligraphic-yes
    ?f <- (message (name "invitation-calligraphic") (answers "Yes") (change 1))
    =>
    (assert (typeface (name "Zapfino")))
)
(defrule invitation-calligraphic-no
    ?f <- (message (name "invitation-calligraphic") (answers "No") (change 1))
    =>
    (assert (typeface (name "FF Erikrighthand")))
)
(defrule invitation-handwritten-no
    ?f <- (message (name "invitation-handwritten") (answers "No") (change 1))
    =>
    (modify ?f (name "invitation-fancy") (question "How about something a bit fancy?") (answers "Yes" "No") (change 0))
)
(defrule invitation-fancy-yes
    ?f <- (message (name "invitation-fancy") (answers "Yes") (change 1))
    =>
    (modify ?f (name "invitation-thin") (question "What do you prefer??") (answers "Thin hairlines" "Thinner hairlines") (change 0))
)
(defrule invitation-thin-hairlines-italian
    (or
    ?f1 <- (message (name "logo-italian") (answers "Yes") (change 1))
    ?f2 <- (message (name "invitation-thin") (answers "Thin hairlines") (change 1))
    )
    =>
    (assert (typeface (name "Bodoni")))
)
(defrule invitation-thin-thinner
    ?f <- (message (name "invitation-thin") (answers "Thinner hairlines") (change 1))
    =>
    (modify ?f (name "invitation-readability") (question "Readability??") (answers "Yes" "No") (change 0))
)
(defrule invitation-readability-yes
    ?f <- (message (name "invitation-readability") (answers "Yes") (change 1))
    =>
    (assert (typeface (name "Walbaum")))
)
(defrule invitation-readability-no
    ?f <- (message (name "invitation-readability") (answers "No") (change 1))
    =>
    (assert (typeface (name "Didot")))
)
(defrule invitation-fancy-no
    ?f <- (message (name "invitation-fancy") (answers "No") (change 1))
    =>
    (modify ?f (name "invitation-fun") (question "Something fun, then?") (answers "Yes") (change 0))
)
(defrule invitation-fun-yes
    ?f <- (message (name "invitation-fun") (answers "Yes") (change 1))
    =>
    (modify ?f (name "invitation-alone") (question "Are you alone?") (answers "Yes") (change 0))
)
(defrule invitation-alone-yes
    ?f <- (message (name "invitation-alone") (answers "Yes") (change 1))
    =>
    (modify ?f (name "invitation-come") (question "Okay then, come with me.") (answers "Ok") (change 0))
)
(defrule invitation-come-ok
    ?f <- (message (name "invitation-come") (answers "Ok") (change 1))
    =>
    (assert (typeface (name "Comic Sans")))
)

; infographic
(defrule infographic
    ?f <- (message (name "start") (question ?q) (answers "Infographic") (change 1))
    =>
    (modify ?f (name "infographic-condensed") (question "We all like something very condensed, yes?") (answers "Yes" "No") (change 0))
)
(defrule infographic-condensed-yes
    ?f <- (message (name "infographic-condensed") (answers "Yes") (change 1))
    =>
    (assert (typeface (name "Univers")))
)
(defrule infographic-condensed-no
    ?f <- (message (name "infographic-condensed") (answers "No") (change 1))
    =>
    (modify ?f (name "infographic-tables") (question "Got a lot of tables, have you?") (answers "Yes" "No") (change 0))
)
(defrule infographic-tables-yes
    ?f <- (message (name "infographic-tables") (answers "Yes") (change 1))
    =>
    (assert (typeface (name "Letter Gothic")))
)
(defrule infographic-tables-no
    ?f <- (message (name "infographic-tables") (answers "No") (change 1))
    =>
    (modify ?f (name "infographic-terminator") (question "You cried when watching terminator?") (answers "Yes" "No") (change 0))
)
(defrule infographic-terminator-yes
    ?f <- (message (name "infographic-terminator") (answers "Yes") (change 1))
    =>
    (assert (typeface (name "Ocr")))
)
(defrule infographic-terminator-no
    ?f <- (message (name "infographic-terminator") (answers "No") (change 1))
    =>
    (modify ?f (name "infographic-flowchart") (question "I must say that this flowchart is looking hot.") (answers "Yes") (change 0))
)
(defrule infographic-flowchart-yes
    ?f <- (message (name "infographic-flowchart") (answers "Yes") (change 1))
    =>
    (assert (typeface (name "Ff din")))
)



; newspaper
(defrule newspaper
    ?f <- (message (name "start") (question ?q) (answers "Newspaper") (change 1))
    =>
    (modify ?f (name "newspaper-type") (question "What do you choose?") (answers "Text face" "Combination" "Display") (change 0))
)
(defrule newspaper-type-text-face
    ?f <- (message (name "newspaper-type") (answers "Text face") (change 1))
    =>
    (modify ?f (name "newspaper-boring") (question "Do people call you boring from time to time?") (answers "Yes" "No") (change 0))
)
(defrule newspaper-boring-yes
    ?f <- (message (name "newspaper-boring") (answers "Yes") (change 1))
    =>
    (assert (typeface (name "Times")))
)
(defrule newspaper-boring-no
    ?f <- (message (name "newspaper-boring") (answers "No") (change 1))
    =>
    (modify ?f (name "newspaper-used") (question "How about something heavily used?") (answers "Yes" "No") (change 0))
)
(defrule newspaper-used-yes
    ?f <- (message (name "newspaper-used") (answers "Yes") (change 1))
    =>
    (assert (typeface (name "Miller")))
)
(defrule newspaper-used-no
    ?f <- (message (name "newspaper-used") (answers "No") (change 1))
    =>
    (modify ?f (name "newspaper-award") (question "How about something award winning?") (answers "Good" "Bad") (change 0))
)
(defrule newspaper-award-good
    ?f <- (message (name "newspaper-award") (answers "Good") (change 1))
    =>
    (assert (typeface (name "Proforma")))
)
; defrule newspaper-award-bad-spiekermann-yes (defrule newspaper-award-bad)

(defrule newspaper-type-combination
    ?f <- (message (name "newspaper-type") (answers "Combination") (change 1))
    =>
    (modify ?f (name "newspaper-spiekermann") (question "Think Mr. Spiekermann is mostly right?") (answers "Yes" "No") (change 0))
)
(defrule newspaper-award-bad-spiekermann-yes
    (or
        ?f <- (message (name "newspaper-award") (answers "Bad") (change 1))
        ?f2 <- (message (name "newspaper-spiekermann") (answers "Yes") (change 1))
    )
    =>
    (assert (typeface (name "Arnhem")))
)
(defrule newspaper-spiekermann-no
    ?f <- (message (name "newspaper-spiekermann") (answers "No") (change 1))
    =>
    (modify ?f (name "newspaper-netherlands") (question "The Netherlands is nice, right?") (answers "Yes" "No") (change 0))
)
(defrule newspaper-netherlands-yes
    ?f <- (message (name "newspaper-netherlands") (answers "Yes") (change 1))
    =>
    (modify ?f (name "newspaper-spiky") (question "Mmm. Spiky serifs are nice.") (answers "Ok") (change 0))
)
(defrule newspaper-spiky-ok
    ?f <- (message (name "newspaper-spiky") (answers "Ok") (change 1))
    =>
    (assert (typeface (name "Swift")))
)
(defrule newspaper-netherlands-no
    ?f <- (message (name "newspaper-netherlands") (answers "No") (change 1))
    =>
    (assert (exit (ifExit "Get out of my flowchart!")))
)

(defrule newspaper-type-display
    ?f <- (message (name "newspaper-type") (answers "Display") (change 1))
    =>
    (modify ?f (name "newspaper-traditional") (question "Do you like it traditional?") (answers "Yes" "No") (change 0))
)
(defrule newspaper-traditional-yes
    ?f <- (message (name "newspaper-traditional") (answers "Yes") (change 1))
    =>
    (modify ?f (name "newspaper-swiss") (question "It's okay with you if it's swiss?") (answers "Yes" "No") (change 0))
)
; defrule newspaper-swiss-yes-science-fiction (newspaper-swiss-yes)

(defrule newspaper-swiss-no
    ?f <- (message (name "newspaper-swiss") (answers "No") (change 1))
    =>
    (modify ?f (name "newspaper-age") (question "Okay, to a question of age.") (answers "New" "Old") (change 0))
)
(defrule newspaper-age-new
    ?f <- (message (name "newspaper-age") (answers "New") (change 1))
    =>
    (assert (typeface (name "Interstate")))
)
(defrule newspaper-age-old
    ?f <- (message (name "newspaper-age") (answers "Old") (change 1))
    =>
    (assert (typeface (name "Franklin Gothic")))
)

(defrule newspaper-traditional-no
    ?f <- (message (name "newspaper-traditional") (answers "No") (change 1))
    =>
    (modify ?f (name "newspaper-modern") (question "Something modern, yet plainspoken?") (answers "Yes" "No") (change 0))
)
(defrule newspaper-modern-yes
    ?f <- (message (name "newspaper-modern") (answers "Yes") (change 1))
    =>
    (assert (typeface (name "Gotham")))
)
(defrule newspaper-modern-no
    ?f <- (message (name "newspaper-modern") (answers "No") (change 1))
    =>
    (modify ?f (name "newspaper-nineties") (question "Not afraid to be asked if you live in the nineties?") (answers "Yes" "No") (change 0))
)

(defrule newspaper-swiss-yes-science-fiction
    (or
        ?f0 <- (message (name "logo-science-fiction") (answers "Bad") (change 1))
        ?f1 <- (message (name "newspaper-swiss") (answers "Yes") (change 1))
        ?f2 <- (message (name "newspaper-nineties") (answers "Yes") (change 1))
    )
    =>
    (assert (typeface (name "Helvetica")))
)

(defrule newspaper-nineties-no
    ?f <- (message (name "newspaper-nineties") (answers "No") (change 1))
    =>
    (assert (typeface (name "Ff Meta")))
)
