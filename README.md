# ppx_cmdliner
Generates cmdliner definitions from types.

It allows the programmer to generates clean (and standard) command line interfaces from some configuration decribed by a type definition and its annotations.

# Quickstart

Assuming you want to build a binary using the command line to get its configuration (or at least a part of it), you simply define a record type which represent this configuration:

```ocaml
type config = {
  feature : bool;
  paths : string list;
  port : int;
}
```

where **feature** would stand for a flag activating, or not, a particular feature; **paths** would configure some lookup path for files and **port** for some communication port. You can now annotate this type using this specification:

```ocaml
type config = {
  feature : bool; (** Activates the feature *)
  paths : string list; (** Adds directories to include paths *) [@sep ':']
  port : int; (** The port to use *) [pos 0]
}
[@@deriving cmdliner]
[@@doc "This tool do something very interesting."]
```

Each annotation contributes to the command line parsing and man page generation. The **cmdliner** derivation will automatically generate the [Cmdliner](https://erratique.ch/software/cmdliner) terms and a function **cmdliner** that
takes the main function as parameter and acts as the binary entrypoint:

```ocaml
let main : config -> _ = fun cfg -> (* do the job *)
let () = cmdliner f
```
You can then compile with a **cmdliner** as library dependency and **ppx_cmdliner** as ppx tool and your binary will have a nice looking CLI with **--help** and other stuff automatically managed. See the documentation part for more information about annotations.

# Installation

This package isn't published to opam yet, simply install it from sources:

    # git clone https://github.com/Ninjapouet/ppx_cmdliner.git
    # cd ppx_cmdliner
    # opam install .
    
# Documentation

The documentation isn't published yet but I believe the quickstsart section or examples in test directory are self explaining about **ppx_cmdliner** usage. I only give here the available annotations for record labels:

Annotation | Description
--- | ---
[@aka ["f"; "foo"]] | Gives the command line option name that can be used
[@doc "doc"] | Overrides this option documentation which is by default given by ocamldoc
[@env "FOO"] | The option may take its value from the environment variable FOO
[@default 42] | Gives the option default value
[@pos 0] | The option is a positionnal argument with given index (starting at 0)
[@enum ["foo", 42; "bar", 24]] | Gives an explicit value mapping for this option
[@sep ':'] | Specifies the list separator for optional values that are lists (default is ',')

and for the record type:
Annotation | Description
--- | ---
[@@doc "My awesome tool"] | Overrides the default ocamldoc documentation
[@@version "1.2.3"] | Adds a version specification

There are others annotations but most useful ones are given above. The whole list will be documented at publication.

# Related Work

This PPX is roughtly a fork of [ppx_deriving_cmdliner](https://github.com/hammerlab/ppx_deriving_cmdliner) but completely rewrote using [ppxlib](https://github.com/ocaml-ppx/ppxlib) instead of [ppx_deriving](https://github.com/ocaml-ppx/ppx_deriving).

I first tried to really fork [ppx_deriving_cmdliner](https://github.com/hammerlab/ppx_deriving_cmdliner) but it comes that modifying it for my own needs would be more painful than simply rewrote it in a more concise and maintainable way. I usually don't like to rewrote things if I can avoid it but in this case, this decision saves me a significant time. When this project will be mature enough, I expect the two projects could merge in a near future to avoid duplication noise in OCaml ecosystem.
