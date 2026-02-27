---
description: Create a new blog post, edit in BBEdit, preview, and publish
allowed-tools: Bash, Read, Write, Edit, Glob, Grep, AskUserQuestion
user-invocable: true
---

# New Blog Post Workflow

You are helping the user create a new blog post for their Jekyll blog (Chirpy theme) at /Users/mlilback/working/mlilback.github.io.

## Step 1: Gather Post Details

Ask the user for:
- **Title** of the post
- **Category** (one of: Personal, Programming, Apple, Computers, Pet Peeves, Comedy, Society, General — or a new one)
- **Tags** (comma-separated, optional)

If the user provided any of these as arguments (e.g., `/blog-post My Post Title`), use them and ask for any missing details.

## Step 2: Create the Post File

Generate the filename using today's date and a slugified title:
- Format: `_posts/YYYY-MM-DD-slug-title.markdown`
- Slug: lowercase, spaces to hyphens, remove special characters

Create the file with this frontmatter:

```yaml
---
title: "The Post Title"
date: YYYY-MM-DD HH:MM:SS -0500
layout: post
categories: [Category]
tags: [tag1, tag2]
author: mlilback
---

Write your post here...
```

Use the current date and time. Timezone is America/New_York (-0500 or -0400 depending on DST).

## Step 3: Open in BBEdit

Run: `open -a BBEdit <filepath>`

Tell the user: "Your post is open in BBEdit. Edit it and save when you're done, then come back here and tell me you're ready to preview."

## Step 4: Wait for User

Wait for the user to say they're done editing. Do NOT proceed until they confirm.

## Step 5: Preview

Start the Jekyll preview server if not already running:

```bash
export PATH="$HOME/.rbenv/shims:$PATH" && eval "$(rbenv init -)"
# Check if Jekyll is already serving
if ! curl -s http://127.0.0.1:4000 > /dev/null 2>&1; then
  cd /Users/mlilback/working/mlilback.github.io
  bundle exec jekyll serve --host 127.0.0.1 --port 4000 &
  sleep 3
fi
```

Then open the post's URL in the browser. The URL will be `http://127.0.0.1:4000/slug-title/` (matching the permalink format `/:title/`).

```bash
open "http://127.0.0.1:4000/slug-title/"
```

Tell the user: "Preview is open in your browser. Let me know if you want to:
1. **Publish** — I'll commit and push to deploy
2. **Edit more** — I'll reopen in BBEdit
3. **Discard** — I'll delete the draft"

## Step 6: Publish (if requested)

```bash
cd /Users/mlilback/working/mlilback.github.io
git add "_posts/YYYY-MM-DD-slug-title.markdown"
# Also add any new images the user may have added
git add images/
git commit -m "Add post: The Post Title"
git push origin master
```

Tell the user their post will be live at `https://www.lilback.com/slug-title/` once GitHub Actions completes the build (usually 1-2 minutes).

## Important Notes

- Always use `export PATH="$HOME/.rbenv/shims:$PATH" && eval "$(rbenv init -)"` before any ruby/bundle/jekyll commands
- The blog is at /Users/mlilback/working/mlilback.github.io
- Posts use permalink format `/:title/`
- The site deploys via GitHub Actions on push to master
- The live URL is https://www.lilback.com
