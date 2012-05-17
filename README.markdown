CQMFloatingController
=====================


Overview
--------
CQMFloatingController is a floating UI component with navigation bar.
You can push/pop content view controllers on it.

This component is ported from [Calqum](http://www.dotapon.sakura.ne.jp/apps/calqum2/index_en.html), customizable calculator for iPhone.


Features
--------
- The appearance looks good in UIKit standard
- Customizable frame color


How to Use
----------
```Objective-C
// Prepare content view controller
UIViewController *viewController;
    
// Show floating controller
CQMFloatingController *floatingController = [CQMFloatingController sharedFloatingController];
[floatingController presentWithContentViewController:viewController
                                            animated:YES];
```


Screenshots
-----------


License
-------
MIT License.
See LICENSE.txt for more information.
