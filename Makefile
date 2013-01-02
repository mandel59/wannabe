archive_files := \
	conf.lua $(patsubst %.moon,%.lua,$(wildcard *.moon)) \
	$(wildcard img/*.png)
love_file := wannabe.love
love_exec := /usr/bin/love
executable := wannabe

all: build
build: $(archive_files)
clean:
	-rm -f $(patsubst %.moon,%.lua,$(wildcard *.moon))
	-rm -f $(love_file) $(executable)
executable: $(executable)
release: $(love_file)
run: $(archive_files)
	$(love_exec) .
.PHONY: all build clean executable release run

$(love_file): $(archive_files)
	-rm -f $@
	zip -9 $@ $(archive_files)

$(executable): $(love_file)
	cat $(love_exec) $< > $@
	chmod +x $@

%.lua: %.moon
	moonc $<
