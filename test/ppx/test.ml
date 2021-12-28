
module M = struct
  type t = int
  let parser s = match int_of_string s with
    | i -> Ok i
    | exception _ -> Error (`Msg "parse error")
  let printer = Format.pp_print_int
end

(** Coucou *)
type t = {
  foo : int; [@default 42] (** prout *)
  bar : bool;
  goo : string list; [@sep ':']
  constr : M.t;
}
[@@deriving clim]
[@@xrefs [`Main]]
[@@envs ["PLOP", Some "It rules!", None]]
[@@version "4.2"]


let f t = t.foo + 1

let _ = clim f
