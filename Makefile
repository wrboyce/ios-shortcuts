all: $(addsuffix .shortcut, $(addprefix build/, $(notdir $(basename $(wildcard src/*.xml)))))

build/%.shortcut: src/%.xml
	$(eval SRC := $(addsuffix .xml, $(addprefix src/, $(basename $(@F)))))
	$(eval TMP := $(shell mktemp))
	cp $(SRC) $(TMP)
	plutil -convert binary1 $(TMP)
	mv $(TMP) $(@)

clean:
	rm -f build/*.shortcut

SHELL := zsh
import:
	mkdir -p import
	cp ~/Library/Mobile\ Documents/iCloud~is~workflow~my~workflows/Documents/*.shortcut import/
	(autoload zmv; cd import; zmv '*.shortcut' '$${(L)f:gs/ /-/}')
	(autoload zmv; cd import; zmv '*.shortcut' '$${f:gs/:/_/}')
	(autoload zmv; cd import; zmv '*.shortcut' '$${f:gs/)//}')
	(autoload zmv; cd import; zmv '*.shortcut' '$${f:gs/(//}')
	find import -name '*.shortcut' -exec plutil -convert xml1 {} \;
	(autoload zmv; cd import; zmv -f '*.shortcut' '../src/$${f:r}.xml')

.PHONY: clean import
