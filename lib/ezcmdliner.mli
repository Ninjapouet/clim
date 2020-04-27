(** Easier interface to Cmdliner. *)

type 'a conv = 'a Cmdliner.Arg.conv

type spec

type final

type ('a, 'b) arg

val flag : ?docs:string -> ?docv:string -> ?doc:string -> ?env:string -> string list ->
  (bool, spec) arg

val opt : ?docs:string -> ?docv:string -> ?doc:string -> ?env:string ->
  ?vopt:'a -> conv:'a conv -> default:'a -> string list ->
  ('a, spec) arg

val opt_all : ?docs:string -> ?docv:string -> ?doc:string -> ?env:string ->
  ?vopt:'a -> conv:'a conv -> default:'a list -> string list ->
  ('a list, spec) arg

val pos : ?docs:string -> ?docv:string -> ?doc:string -> ?env:string ->
  ?rev:bool -> conv:'a conv -> default:'a -> index:int -> string list ->
  ('a, spec) arg

val pos_all : ?docs:string -> ?docv:string -> ?doc:string -> ?env:string ->
  conv:'a conv -> default:'a list -> string list ->
  ('a list, spec) arg

val value : ('a, spec) arg -> ('a, final) arg
val required : ('a option, spec) arg -> ('a, final) arg
val non_empty : ('a list, spec) arg -> ('a list, final) arg
val last : ('a list, spec) arg -> ('a, final) arg

type env = Cmdliner.Term.env_info

val env : ?docs:string -> ?doc:string -> string -> env

type cfg

val create : unit -> cfg

val register : cfg -> ('a, final) arg -> unit -> 'a

type 'a command = {
  cfg : cfg;
  cmd : (unit -> 'a);
  man_xrefs : Cmdliner.Manpage.xref list;
  man : Cmdliner.Manpage.block list;
  envs : Cmdliner.Term.env_info list;
  doc : string;
  version : string option;
  name : string;
}

val command :
  ?cfg:cfg ->
  ?man_xrefs:Cmdliner.Manpage.xref list ->
  ?man:Cmdliner.Manpage.block list ->
  ?envs:env list ->
  ?doc:string ->
  ?version:string option ->
  ?name:string ->
  (unit -> 'b) ->
  'b command

val term : 'a command -> ('a Cmdliner.Term.t * Cmdliner.Term.info)

val run : 'a command -> unit

val bool : bool conv
val char : char conv
val int : int conv
val nativeint : nativeint conv
val int32 : int32 conv
val int64 : int64 conv
val float : float conv
val string : string conv
val enum : (string * 'a) list -> 'a conv
val file : string conv
val dir : string conv
val non_dir_file : string conv
val list : ?sep:char -> 'a conv -> 'a list conv
val array : ?sep:char -> 'a conv -> 'a array conv
val pair : ?sep:char -> 'a conv -> 'b conv -> ('a * 'b) conv
val t2 : ?sep:char -> 'a conv -> 'b conv -> ('a * 'b) conv
val t3 : ?sep:char -> 'a conv -> 'b conv -> 'c conv -> ('a * 'b * 'c) conv
val t4 : ?sep:char -> 'a conv -> 'b conv -> 'c conv -> 'd conv -> ('a * 'b * 'c * 'd) conv
