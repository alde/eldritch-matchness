(lang dune 3.20)

(name eldritch_matchness)

(generate_opam_files true)

(source
 (github alde/eldritch-matchness))

(authors "Rickard Dybeck <r.dybeck@gmail.com>")

(maintainers "Rickard Dybeck <r.dybeck@gmail.com>")

(license LICENSE)

(documentation https://url/to/documentation)

(package
 (name eldritch_matchness)
 (synopsis "A short Call of C'tulhu scenario")
 (description "Trying to navigate eldritch horrors while learning OCaml.")
 (depends ocaml dune alcotest base)
 (tags
  ("rpg" "ctulhu")))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/reference/dune-project/index.html
