---
title: Introducing Alcove
date: '2026-05-17 19:19:44'
layout: post
categories:
- Alcove
- Apple
- Programming
tags: [swift, AppKit, Claude Code, ebooks]
author: mlilback
---

For the first time in a very long time, I'm working on a project for the Apple ecosystem. I'm now devoting my spare time to [Alcove](https://alcoveapp.app). It is an ebook library manager (and eventually a reader) for Mac, iPad, and eventually iPhone.

It uses iCloud to (optionally) sync libraries and their books. You can have multiple libraries and switch between them. It can import DRM-free ebooks, PDFs, and mobi/azw3 files (converting them to epub). It can lookup metadata, covers, and supports ratings, tags, read-status, series (with numbering), and later genres and custom collections like Smart Playlists from iTunes/Music.

It will eventually support subscriptions for expanded, server-based features including better metadata lookup (from [isbndb.com](https://isbndb.com/)), and AI-assistance in organizing your library (tagging, updating series, creating collections, and more). Eventually I'd like to support wish lists where it will notify you when a book (ebook or print) you want becomes available.

I'm coding this using Claude Code, but it is not vibe-coding. I use thousands of dollars of tokens a month for my day job, and I've become very good at getting Claude to do what I want, my way. I'll iterate for hours on getting UI-features just right, now it takes minutes or hours instead of days like it used to.

I'll be writing posts about interesting things that come up, especially related to how Apple's APIs and platforms have changed from the old days. I'm still using AppKit/UIKit with Swift, and still don't consider SwiftUI acceptable for a real-world application I want to use daily, especially on macOS.

