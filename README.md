# Screencapture enhancer for Alfred App

Workflow to enhance OS X screencapture capabilities, particularly with the option to capture _last captured_ area and naming options.

The screencapture app that ships with OS X is quite Ok, but I've always missed being able to keep capturing the same previously captured region, for example for taking screenshots of different pages, where you define a region by taking the first screenshot, and then keep taking new ones in different pages.

This workflow allows this by disabling the original OS X shortcuts and implementing the same shortcuts within the workflow. There're same caveats to install, basically manually removing the original shortcuts and manually adding the same ones to the workflow, since installing workflows does not allow you to import the defined shortcuts (see below).

In the _area mode_ the workflow performs a normal area screenshot, and at the same time runs a custom made cli app in Objective-C that listen for mouse and keyboard events and saves the proper screen coordinates for later use. It also circumvents a few bugs from the cli screenshot app.

Additionally, the workflow works by keywords. The keywords way has the advantage of allowing to specify a custom name for the screenshot, instead of the default one.

## Usage

* ```⌘+⇧+3``` to take a full screen capture, or write the keyword ```capturescreen``` and optionally specify a filename.
* ```⌘+⌃+⇧+3``` to save a full screen capture to the clipboard, or write the keyword ```capturescreen``` and action it while holding control.

![capturescreen](https://raw.github.com/ramiroaraujo/alfred-screencapture-enhancer-workflow/master/screenshots/capturescreen.png)

* ```⌘+⇧+4``` to take an area screen capture interactively, or write the keyword ```capture``` and optionally specify a filename.
* ```⌘+⌃+⇧+4``` to save an area screen capture interactively to the clipboard, or write the keyword ```capture``` and action it while holding control.

![capture](https://raw.github.com/ramiroaraujo/alfred-screencapture-enhancer-workflow/master/screenshots/capture.png)

* ```⌘+⇧+⌥+4``` to take a screen capture of the previously used area, or write the keyword ```capturelast``` and optionally specify a filename.
* ```⌘+⇧+⌥+⌃+4``` to save a screen capture of the previously used area to the clipboard, or write the keyword ```capturelast``` and action it while holding control.

![capturelast](https://raw.github.com/ramiroaraujo/alfred-screencapture-enhancer-workflow/master/screenshots/capturelast.png)

As shown in all examples, the keyword version is capable of specifying a name for the captured image.

## Installation

_First_, go to ```System Preferences -> Keyboard```, there to the ```Shortcuts``` tab, select ```Screenshots``` in the left list and uncheck all the shortcuts on the right, as shown below.

![preferences](https://raw.github.com/ramiroaraujo/alfred-screencapture-enhancer-workflow/master/screenshots/preferences.png)

Then install the workflow and fill the 6 shortcuts with the desired key-combos. The workflow is imported without key combos. It should look like this:

![no-shortcuts](https://raw.github.com/ramiroaraujo/alfred-screencapture-enhancer-workflow/master/screenshots/no-shortcuts.png)

This are the recommended key-combos, the same ones disabled earlier, plus two new ones:

1. ```⌘+⇧+4```, to capture an area
2. ```⌘+⌃+⇧+4```, to capture an area to the clipboard
3. ```⌘+⇧+⌥+4```, to capture the last area
4. ```⌘+⇧+⌥+⌃+4```, to capture the last area to the clipboard
5. ```⌘+⇧+3```, to capture the full screen
6. ```⌘+⌃+⇧+3```, to capture the full screen to the clipboard

After configuring the shortcuts it should look like this:

![shortcuts](https://raw.github.com/ramiroaraujo/alfred-screencapture-enhancer-workflow/master/screenshots/shortcuts.png)


## Configuration

You can configure the _image format_, _base name_, _location_ and _drop shadow_ (in window mode) within the workflow. This procedure is done manually by opening the workflow folder and editing the ```config.yml``` file, the options are self explanatory, but please save a backup of the file before changing it.

In the future I'll implement the configuration within the workflow.

## Changelog

* _2014-02-22_ - Released
* _2014-02-23_ - Check for process running to avoid multiple consecutive screenshots