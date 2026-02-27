---
title: Dependency Injection with Storyboards
date: '2017-04-08 12:02:37'
layout: post
categories:
- Programming
tags:
- swift
author: mlilback
---
I'd been using [Swinject](https://github.com/Swinject/Swinject) for a while, but was never satisfied. All I need for DI is the ability to inject into ViewControllers, including subclasses. After way too much time trying to add subclass support, it was much simpler to just write my own implementation.

[SBInjector](https://github.com/mlilback/SBInjector)

It includes unit tests for macOS, and it should work for iOS, but I haven't tested that yet (the iOS version of my current app is pretty far behind).
