# Vim plugins
This is essentially a copy of my `~/.vim/plugin/` directory. Right now it is only the one plugin - which is called demo.


## Demo
The point of demo is to take pre-written code, and then allow the user to fake typing it (randomly hit the keyboard) to populate the file with the code that has already been written. It works by making a seperate copy of the file,
and then see where your pointer is and import the character at that point in the file. It's not 100% perfect, but the command `:DO` will restore the file and quit so that you can run the code or file or whatever.

### Usage

```
:D - Turns Demo on for the whole file.
:DO - Restore the file (run this when you are done a demo).

// or

:.,+15D - Demo only specific files
:DO - Restore the file (run this when you are done a demo).

```