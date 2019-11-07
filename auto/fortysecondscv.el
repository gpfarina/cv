(TeX-add-style-hook
 "fortysecondscv"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("xcolor" "dvipsnames" "svgnames" "x11names") ("textpos" "absolute" "overlay") ("geometry" "	nohead" "	nofoot" "	nomarginpar" "") ("ClearSans" "sfdefault") ("hyperref" "hidelinks")))
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "path")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "url")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "nolinkurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperbaseurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperimage")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperref")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "path")
   (TeX-run-style-hooks
    "latex2e"
    "xcolor"
    "textpos"
    "xkeyval"
    "calc"
    "geometry"
    "article"
    "art10"
    "ClearSans"
    "background"
    "titlesec"
    "graphbox"
    "ifxetex"
    "fontawesome5"
    "fontawesome"
    "tikz"
    "xhfill"
    "ifthen"
    "etoolbox"
    "hyperref")
   (TeX-add-symbols
    '("wheelchart" ["argument"] 3)
    '("skill" ["argument"] 2)
    '("pointskill" ["argument"] 3)
    '("cvitem" 4)
    '("cvitemshort" 2)
    '("addtobacksidebar" 1)
    '("addtofrontsidebar" 1)
    '("membership" 2)
    '("chartlabell" 1)
    '("chartlabel" 1)
    '("barskill" 3)
    '("flag" 1)
    '("cvicon" 1)
    '("aboutme" 1)
    '("circleicon" 1)
    '("cvkey" 2)
    '("cvmail" 1)
    '("cvgit" 1)
    '("cvsite" 1)
    '("cvphone" 1)
    '("cvaddress" 1)
    '("cvbirthday" 1)
    '("cvjobtitle" 1)
    '("cvname" 1)
    '("cvprofilepic" 1)
    '("profilesection" 1)
    '("cvsection" 1)
    '("sectionline" 1)
    "nameandjob"
    "profileroundedcorners"
    "personaltable"
    "cvsignature"
    "frontsidebar"
    "backsidebar"
    "makefrontsidebar"
    "makebacksidebar"
    "outerradius"
    "innerradius"
    "totalnum"
    "cumnum")
   (LaTeX-add-environments
    '("personal" LaTeX-env-args ["argument"] 0)
    "memberships"
    "sidebar"
    "cvtable")
   (LaTeX-add-lengths
    "sidebarwidth"
    "topbottommargin"
    "leftrightmargin"
    "sidebartextwidth")
   (LaTeX-add-xcolor-definecolors
    "cvblue"
    "cvgreen"
    "cvred"
    "cvsidecolor"
    "cvsectioncolor"
    "cvsubsectioncolor"
    "maincolor"
    "sidecolor"
    "sectioncolor"
    "subsectioncolor"
    "pseccolor"
    "iconcolor"
    "wheelchartlabelcolor"
    "wheeltextcolor"
    "skillbg"))
 :latex)

