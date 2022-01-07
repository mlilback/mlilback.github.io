---
date: '2022-01-07 13:35:17'
layout: post
slug: typescript-yup-tree
title: Validating a Tree in Yup with Typescript
author: mlilback
category: Programming
tags: 
- typescript
- yup
---

I've been working in [Typescript](https://www.typescriptlang.org) 
lately using [Yup](https://github.com/jquense/yup) for validating my
objects. 

The site I'm working on has a tree of categories, so I needed
a way to model this and validate the objects. I couldn't find
an example of how to do this, so I figured it out and this post
is to document this for my future self and others.

```TypeScript
import * as yup from 'yup'

const baseSchema = yup.object({
  name: yup.string().required(),
  age: yup.number().integer().positive().required(),
})

const schema = baseSchema.shape({  
  children: yup.array().of(baseSchema).typeError("invalid children")
})

// test function
const schemaTest = (theSchema: typeof schema, object: any) => {
  try {
    process.stdout.write(`testing ${object['name']}: ...`);
    theSchema.validateSync(object, {});
    console.log('success');
  } catch (e) {
    if (e instanceof Error) {
      console.log(`failed: ${e.message}`);
    }
  }
}

// test cases
const mark = { name: 'undefined children', age: 49, children: undefined }
const trish = { name: '0 children', age: 42, children: [] }
const m1child = { ...mark, children: [trish], name: '1 child' }
const multikids = { name: '2 children', age: 65, children: [mark, trish] }
const granddad = { name: 'grandchild', age: 99, children: [m1child] }
const m1nullChild = { ...mark, childen: null, name: 'null children' }
const m1badChild = { ...trish, children: 'bob', name: 'string instead of array' }
const badChildren  = { ...mark, children: ['bob', 'janet'], name: 'multiple strings' }

// perform tests
schemaTest(schema, mark);
schemaTest(schema, trish);
schemaTest(schema, m1child);
schemaTest(schema, multikids);
schemaTest(schema, granddad);
schemaTest(schema, m1nullChild);
schemaTest(schema, m1badChild);
schemaTest(schema, badChildren);

// try using as formalized types
interface PersonI extends yup.InferType<typeof schema> {}

class Person implements PersonI {
  name: string = ''
  age: number = 0
  children: Person[] = []
  
  constructor(data: PersonI) {
    this.name = data.name
    this.age = data.age
    if (data.children) 
      this.children = data.children.map((kid) => new Person(kid as PersonI))
  }
}

let pops = new Person(granddad)
let child1 = pops.children[0]
let child2 = child1.children[0]
console.log(`grandkid name is correct: ${child2.name == trish.name}`)
```
When run, the output is:

```
esting undefined children: ...success
testing 0 children: ...success
testing 1 child: ...success
testing 2 children: ...success
testing grandchild: ...success
testing null children: ...success
testing string instead of array: ...failed: invalid children
testing multiple strings: ...failed: children[0] must be a `object` type, but the final value was: `null` (cast from the value `"bob"`).
 If "null" is intended as an empty value be sure to mark the schema as `.nullable()`
grandkid name is correct: true
```


