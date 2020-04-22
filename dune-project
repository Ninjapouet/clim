(lang dune 2.5)

(generate_opam_files true)

(name ppx_cmdliner)

(source (github Ninjapouet/ppx_cmdliner))

(package
 (name ppx_cmdliner)
 (synopsis "Derivates cmdliner terms from type definitions")
 (description "This PPX gives to your program a nice CLI using simple type annotations")
 (license "Apache 2.0")
 (authors "Julien Blond <julien.blond@gmail.com>")
 (maintainers "Julien Blond <julien.blond@gmail.com>")
 (homepage "https://github.com/Ninjapouet/ppx_cmdliner")
 (bug_reports "https://github.com/Ninjapouet/ppx_cmdliner/issues")
)
