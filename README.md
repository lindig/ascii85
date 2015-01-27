
# README

This source code provides the Ascii85 module in OCaml for encoding files in
the Ascii85 encoding as specified by Adobe's _PostScript LANGUAGE REFERENCE
third edition_. In addition, it comes with a small command line utility to
encode files from the command line.  For the details of the format, see
sections _ASCII Base-85 Strings_ and _ASCII85Encode Filter_.    
     
# Building

Ascii85 is implemented in OCaml. It does not rely on libraries outside
of the standard library and was developed with OCaml 4.02.1. The default
for the `PREFIX` is `$HOME`.

    make
    make PREFIX=/usr/local install

# Command line tool

The command line tool `ascii85enc` is installed into `$PREFIX/bin`. It
encodes a named file or stdin:

    ascii85enc file.txt

# Using as a library    



# Documentation

The ascii85enc utility comes with a Unix manual part which is installed by
the install target. It is built from ascii85enc.pod in the repository.

The interface of Ascii85 is documented with comments for the OCamldoc
utility that generates documentation.

For using the module, all you need are the two source files: 

    ascii85.ml
    ascii85.mli

# License

BSD License. See [LICENSE.md](LICENSE.md).

# Author

Christian Lindig <lindig@gmail.com>

# Opam Description

ascii85 - Adobe's Ascii85 encoding as a module and a command line tool

The ascii85 module implements the Ascii85 encoding as defined by Adobe for
use in the PostScript language. The module is accompanied by a small
utility ascii85enc to encode files from the command line.


