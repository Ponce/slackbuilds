.. RST source for scrabbleai(6) man page. Convert with:
..   rst2man.py scrabbleai.rst > scrabbleai.6

.. |version| replace:: 20150324_6f8db6b
.. |date| date::

==========
scrabbleai
==========

-----------------
Scrabble[TM] game
-----------------

:Manual section: 6
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

**scrabbleai**

DESCRIPTION
===========

**scrabbleai** is an application for Linux that lets you play
the popular word game against a computer opponent at varying
difficulties. It has a graphical user interface, and is played with
the mouse and keyboard.

There is no way to play against another human, either locally or
via the network. This is strictly a single-player game.

There are no command-line options.

GAMEPLAY
========

At startup, or after choosing **New Game** from the **File** menu, choose
a difficulty level (1 to 10; default is 5), then click **Start Game**.

You (the human) always go first. If you don't like this, you can click
**Pass Turn** to make the AI play first. Remember that on the first
turn, you have to place one of your tiles on the center square of the
board.

On your turn, use the mouse to drag letter tiles onto the board
to spell out a word in the usual Scrabble fashion. Your move isn't
finalized until you click **Make Move** and the game decides your word
is valid. Until then, you can move your tiles around as desired, or
click **Return Tiles to Rack** to start over.

When placing a blank tile, you'll be prompted to right-click on it and
set the letter it represents. If you return the blank tile to the rack
after doing this, don't forget to right-click on it and press Space,
to make it appear blank again. If you forget which tile was the blank
one, it's the one with no score number in the lower-right corner.

If your rack is empty at the end of the game, you still get a turn;
you must click **Pass Turn** to end the game. When the game is over,
click **File** => **New Game** to start a new one.

NOTES
=====

Note that the first time you start a new game, it will take
longer than usual to launch as the dictionary is cached for future
use. Subsequent games (even after relaunching the program) will be
able to skip this step and start up faster.

The AI is based on an algorithm from a paper written by Andrew
W. Appel and Guy J. Jacobson, which you can find here::
http://www.cs.cmu.edu/afs/cs/academic/class/15451-s06/www/lectures/scrabble.pdf

The AI is *really* good. However many words you know, it knows
more. On level 5, the AI beats the author of this man page about 50%
of the time, with final scores averaging above 250. The original
Scrabble rules say that a good player should be able to score 300, so
your mileage may vary.

If you want to peek at the dictionary, there are two of them located
in /usr/doc/scrabbleai-|version|/. **enable.txt** is used to validate
your words, and a smaller **ospd.txt** is used for the computer's
words.

The game board is the standard 15x15 version, with the bonus squares
in the regular locations. There's no way to customize the board or the
tile distribution.

SCREENSHOTS
===========

The intro screen: https://apikler.github.io/ScrabbleAI/intro_screen.png

The main game screen: https://apikler.github.io/ScrabbleAI/game_screen.png

A completed game: https://apikler.github.io/ScrabbleAI/finished_game.png

The help dialog: https://apikler.github.io/ScrabbleAI/help_dialog.png

VIDEOS
======

The AI makes a move: https://apikler.github.io/ScrabbleAI/ai_move.html

Resizing the window: http://apikler.github.io/ScrabbleAI/resize.html

FILES
=====

The directory **~/.config/ScrabbleAI/** contains the settings and
cached dictionary, as **perl**\(1) **Storable**\(3) files, which
means they're not human-reable or -editable. If the directory or its
contents do not exist at startup, **scrabbleai** will create them.

**settings**
  Application settings: default difficulty, window size and position.

**library**
  Cached dictionary, used to speed program startup.

COPYRIGHT
=========

See the file /usr/doc/scrabbleai-|version|/LICENSE for license information.

AUTHORS
=======

scrabbleai was written by apikler (GitHub username).

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.

DISCLAIMER
==========

This program is free, not for profit, and for educational purposes
only. Any usage of elements from the Scrabble board game is provided
only to illustrate the functioning of the AI. Scrabble is a registered
trademark belonging to Hasbro Inc in the US, and to J.W. Spear &
Sons Ltd., a subsidiary of Mattel Inc., throughout the rest of the
world. Neither the author nor this program are affiliated with the
Scrabble Crossword Game, Hasbro, Spear & Sons, or Mattel in any
fashion.

SEE ALSO
========

The scrabbleai homepage: https://github.com/apikler/ScrabbleAI

The Wikipedia entry on Scrabble: https://en.wikipedia.org/wiki/Scrabble
