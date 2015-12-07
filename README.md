# OpenGL bindings for Crystal

**This is a work in progress based on the work of ggiraldez**

These are bindings for OpenGL and some other related libraries (GLFW, SOIL, GLM, etc.). Currently only tested on Mac OS X, but probably should work on Linux with minor modifications.

## Dependencies

* Crystal 0.9.1 (earlier might work but is untested)
* GLFW3
 * `brew install glfw3`
* libSOIL
 * `brew tap elthariel/libsoil && brew install libsoil`

## Testing

With all dependencies installed, run:

```sh
$ cd samples && crystal run --link-flags -L/usr/local/lib samples/test_glfw.cr
```
