%{
  title: "What did I learn trying to build my blog post?",
  tags: ["phoenix", "nimble-publisher", "esbuild", "liveview", "tailwindcss"],
  description: """
  I build my own blog. What did I learn trying to build my blog post? And, yes, it's now powered by Phoenix LiveView with
  NimblerPublisher, and TailwindCSS.
  """
}
---

### Intro

Hello to everyone, yesterday, I decide to use Phoenix 1.6, LiveView 0.17,
NimblerPublisher, and look at some blog posts to get some ideas, to build my own
blog with these tecnologies.

And to be fair, my knowledge with front-end stuff it is almost zero. And looking
at some these examples I cannot bare understand how I install and consume
TailwindCSS, to started my new journey. And to be honest with myself, after
looking at some blog posts how to install and use TailwindCSS, with esbuild in
Phoenix, I spend a could time trying , but the final results was totally fail.

And how I can learn with my failure to build my own blog post and grasp my
knowledge to do this first step? I watched some youtube videos, and started some
local example to conquer this knowledge and push these into to my blog post, and
below you can look at my hands-on, now I have this setup locally, I will use as
my lab to learn TailwindCSS, and maybe apply a couple changes and a better
looking to my blog post.

### Hands-On

First, you will need to create a `package.json`, and this file will manage your front-end dependencies, versions, and many other things. And how we can do that? So let go start!

```elixir
npm init -y
```

After init our project and creating the `package.json`, this is the output:

```elixir
// package.json
{
  "name": "learn-tailwindcss",
  "version": "0.0.1",
  "description": "",
  "main": "index.js",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "keywords": [],
  "author": "Herminio Torres <...@...> (https://github.com/herminiotorres)",
  "license": "MIT"
}
```

After generating our `package.json`, we should install some dependencies to our project, and we will install these dependencies here:

```elixir
npm install tailwindcss postcss postcss-loader postcss-import postcss-nested autoprefixer
```

And our `package.json` will be this way:

```elixir
// package.json
{
  "name": "learn-tailwindcss",
  "version": "0.0.1",
  "description": "",
  "main": "index.js",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "keywords": [],
  "author": "Herminio Torres <...@...> (https://github.com/herminiotorres)",
  "license": "MIT",
  "dependencies": {
    "autoprefixer": "^10.3.7",
    "postcss": "^8.3.11",
    "postcss-import": "^14.0.2",
    "postcss-loader": "^6.2.0",
    "postcss-nested": "^5.0.6",
    "tailwindcss": "^2.2.17"
  }
}
```

After installing all dependencies we need, like Tailwind CSS, PostCSS, and Autoprefixer. Now we can create the TailwindCss and PostCSS config files, like this:

```elixir
npx tailwindcss init -p
```

This command, it will generate two files for us, `tailwind.config.js` and `postcss.config.js`. And for our project these both files will be like this:

```elixir
// tailwind.conf.js
module.exports = {
  purge: [],
  darkMode: false, // or 'media' or 'class'
  theme: {
    extend: {},
  },
  variants: {
    extend: {},
  },
  plugins: [],
}
```

We intend to use the `jit` mode and purge some files into the `tailwind.conf.js`, and after we change, the results will be like this:

```elixir
// tailwind.conf.js
module.exports = {
  mode: 'jit',
  purge: [
    './public/**/*.{html,js}',
    './public/index.html'
  ],
  darkMode: false, // or 'media' or 'class'
  theme: {
    extend: {},
  },
  variants: {
    extend: {},
  },
  plugins: [],
}
```

And for the `postcss.conf.js`, this is after we generate:

```elixir
// postcss.conf.js
module.exports = {
  plugins: {
    tailwindcss: {},
    autoprefixer: {},
  },
}
```

And we will apply some changes here, and the final result will be like this way:

```elixir
// postcss.conf.js
module.exports = {
  plugins: {
    "postcss-import": {},
    tailwindcss: {},
    autoprefixer: {},
    "postcss-nested": {}
  },
}
```

After all these configurations and installs, we could create a command to run
with `npm`, to generate our TailwindCSS final result, minified, and the `-i`
indicate the input file and path, and `-o`, it will be the output file and path,
and `-w` it the watch, so we will keep this running and watching for us, every
time we change our input file, the TailwindCSS will generate a new output
version to us. And to use this strategy, we will open the `package.json` and
delete the `"test"` `"scripts"` for `"build:css"`.

Before:

```elixir
// package.json
"scripts": {
  "test": "echo \"Error: no test specified\" && exit 1"
},
```

After:

```elixir
// package.json
"scripts": {
  "build:css": "tailwindcss --postcss --minify -i assets/css/app.css -o public/app.css -w"
}
```

And it is essential to quick a look at how our project is structured, so take a look:

```elixir
.
├── package.json
├── tailwind.config.js
├── postcss.config.js
├── assets
│   └── css
│       └── app.css
└── public
    └── app.css
    └── index.html
```

And in `assets/css/app.css`, we will `@import` our TailwindCSS files. Here:

```elixir
@import "tailwindcss/base";
@import "tailwindcss/components";
@import "tailwindcss/utilities";
```

And our `public/index.html` is a nice boilerplate, like this:

```elixir
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>TailwindCSS</title>
    <link rel="stylesheet" href="app.css">
  </head>
  <body>
  </body>
<html>
```

And for the last piece for this article, we will be running the `build:css`, with a `Python` `http-server`, on the root path to our project, run this:

```elixir
npm run build:css
```

And for the `Python` `http-server`, we go into the `public` folder and run:

```elixir
cd public
public$ python -m http.server
```

### References:

- [TailwindCSS - Boilerplate](https://github.com/herminiotorres/tailwind-boilerplate)
- [Elixirschool - Libraries - NimblerPublisher](https://elixirschool.com/en/lessons/libraries/nimble-publisher/)
- [Moving the blog to Elixir and Phoenix LiveView](https://bernheisel.com/blog/moving-blog)
- [Phoenix 1.6.0 Released](https://www.phoenixframework.org/blog/phoenix-1.6-released)
- [esbuild](https://esbuild.github.io/)
- [Phoenix LiveView](https://hexdocs.pm/phoenix_live_view/Phoenix.LiveView.html)
- [Phoenix 1.6.0 LiveView + esbuild + Tailwind JIT + AlpineJS - A brief tutorial](https://sergiotapia.com/phoenix-160-liveview-esbuild-tailwind-jit-alpinejs-a-brief-tutorial)
- [TailwindCSS - Docs](https://tailwindcss.com/docs)
- [PragmaticStudio - Phoenix LiveView](https://pragmaticstudio.com/courses/phoenix-liveview)
- [Beginner Tailwind by Chris Sev](https://learn.better.dev/)
