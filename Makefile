all: clean
	zip -9 -q -r hello.love .

clean:
	rm hello.love
