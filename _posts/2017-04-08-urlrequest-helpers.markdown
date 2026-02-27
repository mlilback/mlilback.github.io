---
title: URLRequest helpers
date: '2017-04-08 11:41:37'
layout: post
categories:
- Programming
tags:
- swift
author: mlilback
---
I was working with sending REST calls to Docker via /var/run/docker.sock and needed to print out the text of the request to send via the file descriptor. This code converts a URLRequest into a CFHTTPMessage and then convert that to a string.

<script src="https://gist.github.com/mlilback/bcdd1c981d91ecfb808c231bb6dcb57d.js"></script>
