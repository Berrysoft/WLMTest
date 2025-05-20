CFLAGS=-F /Applications/Microsoft\ Word.app/Contents/Frameworks/ -framework WLMUser -framework WLMKernel -framework WLMGraphicsDevice -framework AppKit -Wl,-rpath,/Applications/Microsoft\ Word.app/Contents/Frameworks/ -std=c11

main: main.m
	clang $^ $(CFLAGS) -o $@
