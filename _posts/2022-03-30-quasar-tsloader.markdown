---
date: '2022-03-30 9:48:37'
layout: post
slug: quasar-tsloader
title: Using a Typescript custom transformer in Quasar
author: mlilback
category: Programming
tags: 
- typescript
- quasar
---

I'm working on a few projects using [Quasar](https://quasar.dev) and 
[Typescript](https://www.typescriptlang.org). I got tired of writing
my own type guards, and found [ts-type-checked](https://github.com/janjakubnanista/ts-type-checked)
which ends up working great. They have an example for webpack,
but quasar does some tricks behind the scenes that required 
a different configuration.

Here's a snippet of my `quasar.config.js` that involves getting this to work:
```
const { configure } = require("quasar/wrappers")
const typeCheckedTransformer = require('ts-type-checked/transformer')

module.exports = configure((ctx) => ({
  supportTS: {
    tsLoaderConfig: {
      getCustomTransformers: (program) => ({
        before: [typeCheckedTransformer(program)],
      }),
    },
  },
...
```


I had been writing custom type guards for all of my model classes, but
now I can just use `if (isA<ItemGroup>(newGroup))`{:.code-bg}.
