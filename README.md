csKeyboardUIResize Cordova Plugin
=================================

This plugin's purpose is to disable the iOS behaviour of pushing the app UI
upwards and off-screen when the soft-keyboard is displayed. Instead, the app's
main View is resized so that:

1. the keyboard does not obscure any part of the app,
2. no part of the app is pushed off-screen, and
3. any UI elements which are designed to stick to the bottom of the app's UI
   remain visible and stuck to the bottom of the app UI, above the keyboard.


Status
------

Only works on iOS. Does nothing on Android, which seems to behave this way
already (_need to double check with HTC devices_).


Usage
-----

Run the following __after__ the `deviceready` event fires.

```javascript
cloudSky.UIResizeOnKeyboard.preventPan(
    function () {
        // Success callback.
        // Once here, the app's UI will not be resized upon displaying the soft
        // keyboard. WARNING: Does not resize the app if the keyboard was
        // already displayed when this function was called.
    },
    function () {
        // Failure callback.
        // Should not happen...
    }
)
```

You can disable the UI resize prevention like this:

```javascript
cloudSky.UIResizeOnKeyboard.unpreventPan(
    function () {}, // Success callback.
    function () {}  // Failure callback.
)
```

Make sure your &lt;body&gt; element does not overflow the viewport.
