## What it is
A program to convert from and to morse code, done as an exercise from the book [Haskell Programming From First Principles](http://haskellbook.com/).


## Install

You need to have haskell stack installed.  If you are in a mac using homebrew just run ````brew install haskell-stack````

After that download repository and build it:

    git clone git@github.com/freefrancisco/morse
    cd morse
    stack build

## Usage
Enter the string you want to encode or decode to morse as a pipe to ````stack exec morse```` with the parameter "to" or "from" depending of whether you want to encode or decode.  

## Examples

    "hello" | stack exec morse to
    "... --- ..." | stack exec morse from
