# iSort
 A short Assembly program to highlight my exposure to the language. Written in NASM, iSort implements basic sorting algorithm in Assembly. I was able to finish this project in a week and it shows my fluency in low-level programming languages. 

A sample run of ./driver 4, will give the following output:

`./driver 4`
 initial configuration

         ooo|ooo
          oo|oo
           o|o
        oooo|oooo
  `XXXXXXXXXXXXXXXXXXXXXXXX`

         ooo|ooo
          oo|oo
           o|o
        oooo|oooo
  XXXXXXXXXXXXXXXXXXXXXXXX

          oo|oo
         ooo|ooo
           o|o
        oooo|oooo
 XXXXXXXXXXXXXXXXXXXXXXXX

           o|o
          oo|oo
         ooo|ooo
        oooo|oooo
 XXXXXXXXXXXXXXXXXXXXXXXX

 final configuration

           o|o
          oo|oo
         ooo|ooo
        oooo|oooo
 XXXXXXXXXXXXXXXXXXXXXXXX

The following commands will create a driver executable file called driver which we use to see the result: The following commands must be executed from the `src` directory.
1) `nasm -f elf sorthem.asm -o sorthem.o`
2) `nasm -f elf -d ELF_TYPE asm_io.asm`
3) `gcc -m32 -c ../util/driver.c -o driver.o`
4) `gcc -m32 ../util/driver.o sorthem.o asm_io.o -o driver`

