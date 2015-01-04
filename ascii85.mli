(** This module implements the Ascii85 Encoding as specified by 
    Adobe's "PostScript LANGUAGE REFERENCE third edition". For the details
    of the format, see sections "ASCII Base-85 Strings" and "ASCII85Encode
    Filter".    
    
    @author Christian Lindig 

    Copyright (c) 2015, Christian Lindig <lindig@gmail.com>
    All rights reserved. See LICENSE.md.
*)

val encode: in_channel -> out_channel -> unit
(** [encode ic oc] reads a byte stream from [ic] until the end and emits
    its Ascii85 encode to [oc]. *)

val encode_file: string -> unit
(** [encode_file path] reads a named file [path] and emits its Ascii85
    encoding to standard output.  *)
