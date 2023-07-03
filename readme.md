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

## objc on freebsd

* sudo pkg install gnustep
* sudo pkg install vscode

ctrl-p
* ext install webfreak.debug
* ext install llvm-vs-code-extensions.vscode-clangd
* ext install twxs.cmake
* ext install ms-vscode.cmake-tools
* ext install kuba-p.glsl-lsp

```
git clone https://github.com/lldb-tools/lldb-mi.git
cd lldb-mi
cmake .
cmake --build .
sudo cmake --install .
```
