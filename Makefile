#
# Makfile for ascii85 encoder binary and library
#

# You can override the PREFIX from the command line:
#
# make PREFIX=/usr/local

PREFIX =	$(HOME)
BINDIR =	$(PREFIX)/bin
MANDIR =	$(PREFIX)/man/man1
LIBDIR =	$(PREFIX)/lib/ago

LIBFILES =
LIBFILES +=	ascii85.cma ascii85.cmxa ascii85.cmxs
LIBFILES +=	ascii85.mli ascii85.cmi

P2M_OPTS =	-s 1 -r "Alpha" -c "opam.ocaml.org"

OCB_OPTS =
OCB_OPTS +=	-use-ocamlfind

OCB =		ocamlbuild $(OCB_OPTS)

all:		main.native lib doc

main.native:	FORCE
		$(OCB) $@

lib:		FORCE
		$(OCB) $(LIBFILES)

doc:		ascii85enc.1
		$(OCB) ascii85.docdir/index.html

clean:		FORCE
		$(OCB) -clean
		rm -f ascii85enc.1
		rm -f url descr

install:	ascii85enc.1 main.native lib
		install -d $(BINDIR)
		install -d $(MANDIR)
		install -d $(LIBDIR)
		install main.native $(BINDIR)/ascii85enc
		install ascii85enc.1 $(MANDIR)
		for f in $(LIBFILES); do install _build/$$f $(LIBDIR); done
		install META $(LIBDIR)

remove:		FORCE
		rm -f  $(BINDIR)/ascii85enc
		rm -f  $(MANDIR)/ascii85enc.1
		rm -rf $(LIBDIR)

ascii85enc.1:	ascii85enc.pod Makefile
		pod2man $(P2M_OPTS) $< > $@

# OPAM - the targets below help to publish this code via opam.ocaml.org

NAME =		ascii85
VERSION =	0.3
TAG =		v$(VERSION)
GITHUB =	https://github.com/lindig/$(NAME)
ZIP =		$(GITHUB)/archive/$(TAG).zip
OPAM =		$(HOME)/Development/opam-repository/packages/$(NAME)/$(NAME).$(VERSION)

tag:
		git tag $(TAG)

descr:		README.md
		sed -n '/^# Opam/,$$ { /^#/n; p;}' $< >$@

url:		FORCE
		echo	"archive: \"$(ZIP)\"" > url
		echo	"checksum: \"`curl -L $(ZIP)| md5 -q`\"" >> url

release:	url opam descr sanity
		test -d "$(OPAM)" || mkdir -p $(OPAM)
		cp opam url descr $(OPAM)

sanity:		descr opam
		grep -q 'version: "$(VERSION)"' opam
		sed -n 1p descr | grep -q $(NAME)

# pseudo target

FORCE:;
