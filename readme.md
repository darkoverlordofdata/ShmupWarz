# shmupwarz-objc


Features:

* GNUstep objective-c framework
* a custom gl loader using sdl - no glew/glu/glut or anything else, just gl.h
* tglm (tiny glm) - clang native vector matrix math
* compiled using c18 std with clang 13

## preferred build
CMake Tools

or try:
```
./configure
cd Shmupwarz.app
cmake --build .
```

## compatabilty Ubuntu / FreeBSD

FreeBSD installs gnustep 2.0, and does not include libgnustep-corebase.so

Ubuntu compiles gnustep 2.1 with libgnustep-corebase.so

