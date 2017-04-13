# vonlang

The first count-based programming language, ah, ah, ah!

## Quick Tour

### Program Structure

Every Von program starts with an introduction:

```
Ah hello there, it is I, the Count!
```

This is followed by zero or more statements, each on a separate line. The program
then ends with the block-end marker `*thunder*`.

For example, this program prints the number 42:

```
Ah hello there, it is I, the Count!
42! 42 bats, ah, ah, ah!
I love to count bats!
*thunder*
```

Single-line comments use the 🦇 emoji (`U+1F987 BAT`).

```
🦇 This is a single-line comment.
```

### Registers

In Von, counting is done using registers. There are two kinds of registers:
mutable and constant.

```
🦇 Mutable
2 Apples, ah, ah, ah!

🦇 Constant
2! 2 Apples, ah, ah, ah!
```

Mutable registers may be assigned a new value, but it is an error to assign to or
redefine a constant register.

Registers are *plurality sensitive*. That is, if a register is assigned the value
1, the actual register referred to has an 's' appended to it.

```
1 apple, ah, ah, ah! 🦇 'apples' is now 1
```

To circumvent this, one may use an exclamation mark, like so:

```
1 sheep! Ah, ah, ah! 🦇 'sheep' is now 1
```

### Printing

One may print the contents of a register either numerically, or interpreted as an
ASCII character.

```
65! 65 apples, ah, ah, ah!

🦇 Numeric
I love to count apples! 🦇 Prints '65'.

🦇 ASCII
I love to count apples, ah, ah, ah! 🦇 Prints 'A'.
```

To print multiple registers on one line, use semicolons.

```
72! 72 horses, ah, ah, ah!
73! 73 images, ah, ah, ah!
I love to count horses; images, ah, ah, ah! 🦇 Prints 'HI'.
```

<!--
Printing multiple registers on one line currently uses semicolons, but I would
personally prefer something in natural language. E.g.:

```
I love to count apples, bats and spiders!
```
-->

### Loops

This piece of code will print 'SPAM' 10 times.

```
10! 10 loops, ah, ah, ah!
83! 83 sticks, ah, ah, ah!
80! 80 parrots, ah, ah, ah!
65! 65 apples, ah, ah, ah!
77! 77 monkeys, ah, ah, ah!

I count loops:
    I love to count sticks; parrots; apples; monkeys, ah, ah, ah!
*thunder*
```

## Not Yet Implemented

The following language constructs are not implemented yet. In fact, the designs
are not final at all.

### Increment

```
1 bat, ah, ah, ah!
1 more bat, ah, ah, ah!
🦇 'bats' is now 2.
2 more bats, ah, ah, ah!
🦇 'bats' is now 4.
```

<!-- or something like that... -->

### If-else

```
1! 1 bat, ah, ah, ah!

Are there any bats?
    89! 89 yes, ah, ah, ah!
    I love to count yes, ah, ah, ah!
*organ music*
    78! 78 no, ah, ah, ah!
    I love to count no, ah, ah, ah!
*thunder*
```
