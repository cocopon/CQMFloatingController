CQMFloatingController
=====================


Overview
--------
CQMFloatingController is a floating UI component with navigation bar.
The appearance looks good in UIKit standard.


How to Use
----------
    // Prepare content view controller
    UIViewController *viewController;
    
    // Show floating controller
    CQMFloatingController *floatingController = [CQMFloatingController sharedFloatingController];
    [floatingController presentWithContentViewController:viewController
                                                animated:YES];


Screenshots
-----------


License
-------
MIT License.
See LICENSE.txt for more information.


