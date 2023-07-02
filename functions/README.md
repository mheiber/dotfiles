I don't use these anymore.
I've found it much easier to maintain to have:
- an rc file has functions
- the two most important are bp() and src()


```
src() {
    source ~/.zshenv
}

bp() {
    nvim ~/.zshenv
    src
}
```

Then, to add a function I run `bp`, which pops open the rc file so I can write the function, then sources.
For other shells I have open, run `src` to source the rc file
