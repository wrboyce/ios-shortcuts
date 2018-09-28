all: $(addsuffix .shortcut, $(addprefix build/, $(notdir $(basename $(wildcard src/*.xml)))))

build/%.shortcut: src/%.xml
	$(eval SRC := $(addsuffix .xml, $(addprefix src/, $(basename $(@F)))))
	$(eval TMP := $(shell mktemp))
	cp $(SRC) $(TMP)
	plutil -convert binary1 $(TMP)
	mv $(TMP) $(@)

clean:
	rm -f build/*.shortcut

.PHONY: clean
