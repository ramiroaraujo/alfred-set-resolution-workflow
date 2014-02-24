# Set Resolution Workflow for Alfred App

Handy workflow to change between available screen resolutions, even between normal and HiDPI mode (Retina).

It allows you to list and search available resolutions, and action the result to do the change. The change persists between logout (ex: restart, shutdown, etc).

It filter's out duplicated resolutions where a retina resolution is available, for example, if you have available 1280x960 in both retina and non-retina, you'll only see the retina option; no need to set the pixelated one.

## Usage

Type the keyword ```setres``` to show a list of resolutions. You'll see that the first result is actually a non-actionable result which shows the current resolution.

![list](https://raw.github.com/ramiroaraujo/alfred-set-resolution-workflow/master/screenshots/list.png)

You can also type after the space to search for resolutions (searches the numbers).

![search](https://raw.github.com/ramiroaraujo/alfred-set-resolution-workflow/master/screenshots/search.png)

The available resolutions list is usually quite large. You can delete available resolutions from the list by action the result while holding the ```⌥ (alt)``` key.

![remove](https://raw.github.com/ramiroaraujo/alfred-set-resolution-workflow/master/screenshots/remove.png)

If you connect a different display, or want to undo a deleted resolution you need to reset the list by actioning the keyword `setreset`

![reset](https://raw.github.com/ramiroaraujo/alfred-set-resolution-workflow/master/screenshots/reset.png)


## Multiple Displays

The workflow does not support multiple displays, although the cli app does. Since I don't have a second display to develop and test, I haven't implemented it. Happy to accept PL from others here.

## Installation
For OS X 10.9 Mavericks, Download the [alfred-set-resolution.alfredworkflow](https://github.com/ramiroaraujo/alfred-set-resolution/raw/master/alfred-set-resolution.alfredworkflow) and import to Alfred 2.

For Previous OS X Versions, Download the [alfred-set-resolution.alfredworkflow](https://github.com/ramiroaraujo/alfred-set-resolution/raw/pre-mavericks/alfred-set-resolution.alfredworkflow) and import to Alfred 2.

## Credits

Built around the setresx command line app by [Paul Griffin](https://twitter.com/phoenixdev)

## Changelog
* _2014-02-24_ - Released
