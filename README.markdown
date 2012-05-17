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
Add all files in CQMFloatingController/Classes to your project, and write code as below:

```Objective-C
// Import a required class
#import "CQMFloatingController.h"


- (void)show {
    // Prepare content view controller
    SomeViewController *viewController = [[[SomeViewController alloc] init] autorelease];
        
    // Show floating controller
    CQMFloatingController *floatingController = [CQMFloatingController sharedFloatingController];
    [floatingController presentWithContentViewController:viewController
                                                animated:YES];
}
```


Screenshots
-----------


License
-------
MIT License.
See LICENSE.txt for more information.
