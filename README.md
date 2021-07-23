
# Spotifixer
A collection of launchers and scripts letting spotify links open with the desktop client instead
of via the web app.

Currently:
1. This supports using running clients or will spawn a new client if one isn't found running.
2. This will not interfere with manual launches of made via applications menu, etc. The script
supports manual launch cases in which no url is provided.
3. Will not load the web player in conjunction with the desktop client.
4. Will close the browser tab when done (thanks to cameron1729 for the extension to the greasemonkey script!)
5. Will not focus the desktop client when following a link - so no interruptions.

## Installation:
1. Install greasemonkey or tampermonkey in your default browser (the one that will open when
following a spotify song link).

2. Install the following script into greasemonkey/tampermonkey:

```javascript
// ==UserScript==
// @name         Spotify open in app
// @author       OrdinaryDog
// @description  This userscript redirects open.spotify.com links to the desktop app
// @version      1.2
// @license      MIT License
// @copyright    Copyright (C) 2019, by ordinarydog@protonmail.com
// @match        http://open.spotify.com/*
// @match        https://open.spotify.com/*
// @namespace    https://greasyfork.org/users/172431
// @run-at       document-start
// @noframes
// @grant window.close
// @grant window.focus
// ==/UserScript==

(function() {
    'use strict';
    var data=document.URL.match(/[\/\&](track|playlist|album|artist|show|episode)\/([^\&\#\/\?]+)/i);
    console.log("This is a "+data[1]+" with id:"+data[2]+"\nAttempting to redirect");
    window.location.replace('spotify:'+data[1]+':'+data[2]);
    window.close();
})();
```

   Note:
   This is based on an original script by OrdinaryDog:
   https://greasyfork.org/en/scripts/38920-spotify-open-in-app

   Modified to allow tab/window auto-close (thanks for cameron1729 for this addition!):  

   To the bottom of the ==UserScript== section:  
   // @grant window.close
   // @grant window.focus

   To the function, underneath window.location.replace:  
   window.close();

4. Move/copy spotify.desktop to ~/.local/share/applications/, which effectively overrides the
default desktop file at /usr/share/applications/spotify.desktop

5. Copy the script spotifixer.sh to the desired location.

6. Edit the desktop file, and set the script location to the one you just set:
   e.g. Modify the 'Exec=' line as follows:

   Exec=PATH/TO/SPOTIFIXER/spotifixer.sh %u

7. You may also need to allow scripts to close windows/tabs via about:config (for firefox) by setting:
dom.allow_scripts_to_close_windows = true. See also FAQ section.

8. Launch a spotify song URL and enjoy!

## FAQs:
Q: The song won't play after launching a new client instance. What's going on?

A: The script uses a 1 second delay, which is just to wait for the client to be ready, before
it issues the qdbus commands. You can extend this timeout, and that should resolve the issue.

Q: The browser tab doesn't close automatically. What can I do to fix it?

A: See point 7 in installation instructions. This is most likely a browser security measure.
