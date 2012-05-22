CQMFloatingController
=====================


Overview
--------
CQMFloatingController is a floating UI component with navigation bar.
You can push/pop a content view controller on it.

This component is ported from [Calqum](http://www.dotapon.sakura.ne.jp/apps/calqum2/index_en.html), customizable calculator for iPhone.


Features
--------
- The appearance looks good in UIKit standard
- Customizable frame color


How to Use
----------
1. Add all files in `CQMFloatingController/Classes` to your project
2. Write code as below:

```Objective-C
// Import a required class
#import "CQMFloatingController.h"

- (void)show {
    // Prepare content view controller
    SomeViewController *viewController = [[[SomeViewController alloc] init] autorelease];

    // Get shared floating controller, and customize if needed
    CQMFloatingController *floatingController = [CQMFloatingController sharedFloatingController];
    [floatingController setFrameColor:[UIColor orangeColor]];
        
    // Show floating controller with content
    [floatingController presentWithContentViewController:viewController
                                                animated:YES];
}
```


Screenshots
-----------
![Screenshot0](http://dotapon.sakura.ne.jp/github/CQMFloatingController/screenshots/0.png)
![Screenshot1](http://dotapon.sakura.ne.jp/github/CQMFloatingController/screenshots/1.png)


License
-------
MIT License.
See LICENSE.txt for more information.

