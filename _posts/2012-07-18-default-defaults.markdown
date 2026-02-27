---
title: Default Defaults
date: '2012-07-18 11:52:27'
layout: post
categories:
- Programming
tags:
- NSUserDefaults
- preferences
author: mlilback
---
One of the first things I do on starting a new AppKit or UIKit project is add a few lines of code to set default values for NSUserDefaults. You'll never have to check to see if nil was returned from a call to NSUserDefaults once you do this.Add the following snippet to your application delegate's finished launching method.


```objc
NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
NSURL *url = [[NSBundle mainBundle] URLForResource:@"DefaultDefaults" 
	withExtension:@"plist"];
NSDictionary *d = [NSDictionary dictionaryWithContentsOfURL:url];
if (d)
	[defaults registerDefaults:d];
```

Then create a property list called "DefaultDefaults.plist" and add it as a resource. Anytime you add another preference/default to your application, add the default value to this plist.

		
		
