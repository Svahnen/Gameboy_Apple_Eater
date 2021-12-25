echo starting
'/home/svahnen/Projects/gbdk/bin/lcc' -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -c -o main.o main.c
'/home/svahnen/Projects/gbdk/bin/lcc' -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -o main.gb main.o
echo done build process, now cleaning
rm -f *.o *.lst *.map *.gb *.ihx *.sym *.cdb *.adb *.asm
echo done