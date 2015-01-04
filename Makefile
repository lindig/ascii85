#
#
#

PREFIX =	$(HOME)
BINDIR =	$(PREFIX)/bin
MANDIR =	$(PREFIX)/man/man1

P2M_OPTS =	-s 1 -r "Alpha" -c "opam.ocaml.org"

OCB =		ocamlbuild

all:		main.native ascii85enc.1

main.native:	FORCE
		$(OCB) $@

clean:		FORCE
		$(OCB) -clean
		rm -f ascii85enc.1
		rm -f url descr

install:	ascii85enc.1 main.native
		install -d $(BINDIR)
		install -d $(MANDIR)
		install main.native $(BINDIR)/ascii85enc
		install ascii85enc.1 $(MANDIR)

remove:		FORCE
		rm -f $(BINDIR)/ascii85enc
		rm -f $(MANDIR)/ascii85enc.1

ascii85enc.1:	ascii85enc.pod Makefile
		pod2man $(P2M_OPTS) $< > $@

# OPAM - the targets below help to publish this code via opam.ocaml.org

NAME =		ascii85
VERSION =	0.1
TAG =		v$(VERSION)
GITHUB =	https://github.com/lindig/$(NAME)
ZIP =		$(GITHUB)/archive/$(TAG).zip
OPAM =		$(HOME)/Development/opam-repository/packages/$(NAME)/$(NAME).$(VERSION)

descr:		README.md
		sed -n '/^# Opam/,$$ { /^#/n; p;}' $< >$@

url:		FORCE
		echo	"archive: \"$(ZIP)\"" > url
		echo	"checksum: \"`curl -L $(ZIP)| md5 -q`\"" >> url

release:	url opam descr
		test -d "$(OPAM)" || mkdir -p $(OPAM)
		cp opam url descr $(OPAM)

# pseudo target

FORCE:;
