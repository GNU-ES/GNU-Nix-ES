

```
./run.sh
```

In one of these videos there is an explanation about the existence
of `/usr`, `/etc` and more. 
I am not sure in which, but it is in one of those.

[Embedded Linux Conference 2013 - Toybox: Writing a New Command Line From Scratch](https://www.youtube.com/watch?v=SGmtP5Lg_t0)

[Tutorial: Building the Simplest Possible Linux System - Rob Landley, se-instruments.com](https://www.youtube.com/watch?v=Sk9TatW9ino)

[Toybox vs BusyBox - Rob Landley, hobbyist](https://www.youtube.com/watch?v=MkJkyMuBm3g)


Why? Rather than create a file, create a [symlink](https://man7.org/linux/man-pages/man2/symlink.2.html), `ln --symbolic` [ln(1) — Linux manual page](https://man7.org/linux/man-pages/man1/ln.1.html)
of what is possible to be done. I mean, Rob Landley explains it in better words.
