######################
#                    #
# dynami3/readme.txt #
#                    #
######################

What is this?

This is dynami3, which can be considered a sort of plugin manager for i3.



What does it do?

Broadly speaking, dynami3 allows on-the-fly yet persistent changes to your i3 configuration. These can be something like allowing you to toggle the visibility of your status bar, but also having that persist after a restart. If you're using i3-gaps, you could bind a key to toggle the gap size without editing any files, but still have that change persist through restarts.

More specifically, dynami3 lets you run scripts and append their output directly into your i3 config. Scripts can do all sorts of programmatic things and serve up all sorts of stuff in the i3 config language. You can build a config factory in any programming language you want and use that instead of



Why would you use it?

-Generate bind statements programmatically with any language you want.
-Toggle variables in your config on the fly and keep their new states forever.
-Have you ever wanted a "#include" statement for your i3 config? You can't do that literally, but you can write a plugin to include any files you want.



How do I use it?

There's two major parts to using it.
I assert that $I3 is your i3 directory, whether that be ~/.i3 or ~/.config/i3 (or something else).

The first is adding dynami3 to your i3 instance. This is fairly simple, but I strongly encourage you to read the full instructions before doing anything.



1. BACK UP YOUR $I3 DIRECTORY!
	Seriously, do this. It's not likely for anything to go wrong, but dynami3.sh *does* include commands that modify $I3/config, so it's best to be safe.


1. Clone dynami3 into $I3
	(In the future, this will use 'git clone'.)
	Copy the raw file for dynami3.sh into $I3/dynami3/dynami3.sh.
	Create an empty text file at $I3/dynami3/dynami3.conf.
	This file will be used to specify what plugins to load.


2. Move $I3/config to $I3/preconfig
	This script works by overwriting $I3/config, because that's what i3 loads from.
	Therefore, we want to store our base config somewhere else.
	While using dynami3, edit $I3/preconfig instead of $I3/config.


3. Modify $I3/preconfig:
	We want to run dynami3.sh whenever we reload or restart, as well as at startup.
	Therefore, the following must be done:
		a) Change 'reload' to 'exec $I3/dynami3/dynami3.sh && i3-msg reload'
		b) Change 'restart' to 'exec $I3/dynami3/dynami3.sh && i3-msg restart'
		c) Add 'exec $I3/dynami3/dynami3.sh && i3-msg restart'
	If you have an actual startup script for i3, you can also run dynami3.sh from there.
	Optionally, you can add bindings to reload and restart without running dynami3.sh.


4. Run $I3/dynami3/dynami3.sh once to initialize the new $I3/config
	$I3/config doesn't exist because we moved it, so we have to run this to create it again.

5. Test your config to make sure it works as expected.
	It's possible that something went wrong in one of the previous steps.
	This is just a precaution for a script that's as hacky as this is.



The second major part in setting up dynami3 is installing plugins.

I don't actually want to write this right now, so I'll just tell you to clone from my dotfiles on github, Dotfiles/i3/dynami3/plugins into $I3/dynami3/plugins.

I recommend editing dynami3.conf and only including 'vars', since 'vi3m' is stupid complicated and heavy and probably overrides your terminal bindsym anyway

uhhh, that's it for now, i think
