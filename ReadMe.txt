CodeRedeemer
====================

Information
------------
This custom library can be used to redeem a custom promo code inside your app to unlock items, access hidden areas, etc. Essentially, you must have a UITextField in which the user enters the promo code. Then, CodeRedeemer checks it against a specified URL of a .txt file containing the promo code. CodeRedeemer will automatically save a copy of the most recently validated code to NSUserDefaults so you can reference it later (if, for instance, you wanted to make sure the user can’t use the same code twice, or if you wanted to see which promo code was used). The example project shows this in action.

CodeRedeemer uses ARC.

Usage
-----
1. Add the .h and .m files to your project
2. Import the library
	#import "CodeRedeemer.h"
3. Allocate CodeRedeemer
	CodeRedeemer *cRedeemer = [CodeRedeemer alloc];
4. Call the "submitCode:" method
	[cRedeemer submitCode:/*fill in method here*/];
5. CodeRedeemer will send a success or failure callback to the view controller that sent the request.