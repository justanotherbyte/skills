# Setup

## Astro (preferred, matches viswa.space)

Dependencies: `astro`, `tailwindcss@4`, `@tailwindcss/vite`.

`astro.config.mjs`:

```js
import tailwindcss from '@tailwindcss/vite';
import { defineConfig, fontProviders } from 'astro/config';

export default defineConfig({
	vite: { plugins: [tailwindcss()] },
	fonts: [
		{
			provider: fontProviders.google(),
			name: 'JetBrains Mono',
			cssVariable: '--font-jetbrains',
			weights: [400, 500, 700],
			styles: ['normal', 'italic'],
			subsets: ['latin'],
			fallbacks: ['monospace'],
		},
	],
});
```

In `<head>` (via a `BaseHead` component):

```astro
---
import '../styles/global.css';
import { Font } from 'astro:assets';
---
<Font cssVariable="--font-jetbrains" preload />
```

## Plain HTML (no build step)

```html
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link href="https://fonts.googleapis.com/css2?family=JetBrains+Mono:ital,wght@0,400;0,500;0,700;1,400&display=swap" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
<style type="text/tailwindcss">
	:root { --font-jetbrains: 'JetBrains Mono'; }
	/* then paste global.css below, minus the @import line */
</style>
```

## global.css

```css
@import "tailwindcss";

:root {
	--ease-out: cubic-bezier(0.23, 1, 0.32, 1);
}

body {
	font-family: var(--font-jetbrains), monospace;
}

html {
	scroll-behavior: smooth;
}

/* Inline code only; fenced blocks get their background from highlight.js */
:not(pre) > code:not(.latex) {
	background-color: var(--color-zinc-200);
	padding: 5px;
}

@media (prefers-color-scheme: dark) {
	:not(pre) > code:not(.latex) {
		background-color: var(--color-zinc-800);
	}
}
```

Dark mode uses Tailwind v4's default `dark:` variant, which follows `prefers-color-scheme`. There's no theme toggle.

## Page skeleton

```html
<!doctype html>
<html lang="en">
	<head><!-- meta, font, global.css --></head>
	<body class="dark:bg-zinc-900 antialiased">
		<!-- Navbar (components.md) -->
		<main class="container mx-auto max-w-screen-xl p-8">
			<!-- Sections, separated by <br /> -->
		</main>
		<!-- Footer (components.md) -->
	</body>
</html>
```

## Optional: articles with code and maths

- Syntax highlighting: highlight.js 11 on the client with the **`tokyo-night-dark`** theme, in both light and dark mode.
  ```html
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.11.1/styles/tokyo-night-dark.min.css" />
  <script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.11.1/highlight.min.js"></script>
  <script>hljs.highlightAll();</script>
  ```
  In Astro, set `markdown.syntaxHighlight: false` so Shiki doesn't run.
- Maths: KaTeX via `remark-math` and `rehype-katex`, plus the KaTeX CSS.
