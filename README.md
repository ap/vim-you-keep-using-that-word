You Keep Using That Word
========================

<i>A tiny little plugin for Vim</i>

When using word motion with the `c` command, it does not mean what Vim normally
thinks it means. As the documentation says:

> Special case: When the cursor is in a word, `cw` and `cW` do not include the
> white space after a word, they only change up to the end of the word. This is
> because Vim interprets `cw` as change-word, and a word does not include the
> following white space.

But you can already do the same yourself by using `ce` and `cE`, whereas this
supposedly helpful exception leaves you using workarounds such as `cf<Space>`
in order to do what you normally would use `cw` for.

This plugin removes the special exception for `cw`. It does nothing else, and
it has no configuration options.
