# Components

Copy-paste Tailwind markup, taken from viswa.space. Each snippet stands on its own. `{…}` marks a placeholder.

## Card base

Every card starts from this class string:

```
bg-zinc-100 dark:bg-zinc-800 rounded-none p-4 border border-zinc-300 dark:border-zinc-700
```

For a clickable card, render it as an `<a>` and add:

```
block cursor-pointer active:opacity-75 duration-100
```

Cards have no hover effect. The only interaction feedback is the press state.

## Text card (publication / link)

```html
<a href="{url}" class="block bg-zinc-100 dark:bg-zinc-800 rounded-none p-4 cursor-pointer border border-zinc-300 dark:border-zinc-700 active:opacity-75 duration-100">
	<div class="dark:text-white">{title}</div>
	<p class="text-zinc-600 dark:text-zinc-400 mt-1">{description}</p>
</a>
```

## Image card (project)

```html
<a href="{url}" class="flex flex-col bg-zinc-100 dark:bg-zinc-800 rounded-none border border-zinc-300 dark:border-zinc-700 overflow-hidden cursor-pointer active:opacity-75 duration-100">
	<img src="{img}" alt="{title}" class="w-full h-40 object-cover object-center border-b border-zinc-700" />
	<div class="p-4">
		<div class="dark:text-white">{title}</div>
		<p class="text-zinc-600 dark:text-zinc-400 mt-1">{description}</p>
		<p class="text-zinc-400 text-xs mt-2">{meta, e.g. "4 min read"}</p>
	</div>
</a>
```

## Card with footer stats (repo)

```html
<a href="{url}" class="relative block bg-zinc-100 dark:bg-zinc-800 rounded-none p-4 cursor-pointer border border-zinc-300 dark:border-zinc-700 active:opacity-75 duration-100">
	<span class="dark:text-white"><span class="text-zinc-500 text-xs">{owner}/</span>{name}</span>
	<p class="text-zinc-600 dark:text-zinc-400 mt-1 mb-6">{description}</p>
	<h3 class="absolute left-4 bottom-2" style="color: {languageColor}">{language}</h3>
	<h3 class="absolute right-4 bottom-2 dark:text-white">{stars} ⭐</h3>
</a>
```

## Logo + text card (experience)

```html
<div class="flex flex-col bg-zinc-100 dark:bg-zinc-800 rounded-none p-4 border border-zinc-300 dark:border-zinc-700 gap-y-2">
	<div class="flex flex-row gap-x-3">
		<img class="rounded-sm w-15 h-auto" src="{logo}" alt="{org}" />
		<div>
			<a href="{url}" class="dark:text-white hover:underline active:text-zinc-400 duration-200">{role} @ {org}</a>
			<p class="text-zinc-400">{start} - {end}.</p>
		</div>
	</div>
	<p class="text-zinc-600 dark:text-zinc-400 whitespace-pre-line">{description}</p>
</div>
```

## Feature card (icon + heading)

```html
<div class="flex flex-row items-center bg-zinc-100 dark:bg-zinc-800 rounded-none p-4 border border-zinc-300 dark:border-zinc-700">
	<img src="{icon}" alt="{name}" class="w-auto h-16 mr-4" />
	<div>
		<h3 class="text-lg font-bold dark:text-white">{name}</h3>
		<p class="text-zinc-600 dark:text-zinc-400">{description}</p>
	</div>
</div>
```

## Skeleton card

```html
<div class="flex flex-col gap-y-2 bg-zinc-100 dark:bg-zinc-800 rounded-none p-4 border border-zinc-300 dark:border-zinc-700">
	<div class="h-4 w-full bg-zinc-200 dark:bg-zinc-700 rounded animate-pulse"></div>
	<div class="h-4 w-full bg-zinc-200 dark:bg-zinc-700 rounded animate-pulse"></div>
	<div class="h-4 w-full bg-zinc-200 dark:bg-zinc-700 rounded animate-pulse"></div>
</div>
```

## Section

A heading, an optional "View All →" link, a divider, an optional description, then the content.

```html
<section id="{id}">
	<div class="relative flex w-full">
		<h1 class="dark:text-white text-xl">{Name}</h1>
		<a href="{more}" class="dark:text-white absolute right-0 text-xl hover:text-zinc-400 duration-200 transition">
			View All
			<svg class="inline" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M5 12h14"/><path d="m12 5 7 7-7 7"/></svg>
		</a>
	</div>
	<hr class="my-4 h-0.5 border-t-0 bg-zinc-300 dark:bg-white/10" />
	<p class="text-zinc-600 dark:text-zinc-400 mt-1 mb-6">{description}</p>
	<div class="grid md:grid-cols-2 sm:grid-cols-1 gap-2"><!-- cards --></div>
</section>
```

Empty state for a section with no items:

```html
<p class="text-zinc-500 dark:text-zinc-400 text-sm italic">No {items} yet.</p>
```

## Hero / intro panel

A two-column panel. It uses the card surface but has no padding on the image side.

```html
<section class="grid md:grid-cols-2 sm:grid-cols-1 bg-zinc-100 dark:bg-zinc-800 rounded-none border border-zinc-300 dark:border-zinc-700">
	<img src="{photo}" alt="" class="w-full h-full object-cover" />
	<div class="p-8">
		<h1 class="text-xl dark:text-white">Hey!</h1>
		<br />
		<p class="dark:text-zinc-200">{paragraph}</p>
		<br />
		<p class="dark:text-zinc-200 [&>a]:text-blue-500 [&>a]:duration-200 [&>a]:hover:text-blue-700">
			<a href="mailto:{email}">Email</a> / <a href="{cv}">CV</a> / <a href="{github}">GitHub</a>
		</p>
	</div>
</section>
```

## Navbar

This is a sticky bar. The title sits on the left and the links on the right. On mobile, a hamburger button expands the menu.

```html
<nav class="bg-white dark:bg-zinc-900 sticky top-0 z-40">
	<div class="max-w-screen-xl flex flex-wrap items-center justify-between mx-auto p-4">
		<a href="/" class="text-2xl font-semibold whitespace-nowrap dark:text-white">{Site Title}</a>
		<button id="navbar-toggle" type="button" aria-controls="navbar-default" aria-expanded="false"
			class="inline-flex items-center p-2 w-10 h-10 justify-center text-sm text-zinc-500 rounded-lg md:hidden hover:bg-zinc-100 focus:outline-none focus:ring-2 focus:ring-zinc-200 dark:text-zinc-400 dark:hover:bg-zinc-700 dark:focus:ring-zinc-600">
			<span class="sr-only">Open main menu</span>
			<svg class="w-5 h-5" fill="none" viewBox="0 0 17 14"><path stroke="currentColor" stroke-linecap="round" stroke-width="2" d="M1 1h15M1 7h15M1 13h15"/></svg>
		</button>
		<div id="navbar-default" class="transition-all duration-300 ease-in-out overflow-hidden md:overflow-visible w-full md:block md:w-auto max-h-0 md:max-h-full">
			<ul class="font-medium flex flex-col p-4 md:p-0 mt-4 border border-zinc-100 rounded-sm bg-zinc-50 md:flex-row md:space-x-8 md:mt-0 md:border-0 md:bg-white dark:bg-zinc-800 md:dark:bg-zinc-900 dark:border-zinc-700">
				<!-- Active item -->
				<li><a href="#" aria-current="page" class="block py-2 px-3 text-white bg-blue-700 rounded-sm md:bg-transparent md:text-blue-600 md:p-0 dark:text-white md:dark:text-blue-500">Home</a></li>
				<!-- Other items -->
				<li><a href="#" class="block py-2 px-3 text-zinc-900 rounded-sm hover:bg-zinc-100 md:hover:bg-transparent md:hover:text-blue-600 md:p-0 dark:text-white md:dark:hover:text-blue-500 dark:hover:bg-zinc-700 md:dark:hover:bg-transparent">{Link}</a></li>
			</ul>
		</div>
	</div>
</nav>
<script>
	const toggle = document.getElementById('navbar-toggle');
	const menu = document.getElementById('navbar-default');
	const setOpen = (open) => {
		menu.classList.toggle('max-h-96', open);
		menu.classList.toggle('max-h-0', !open);
		toggle.setAttribute('aria-expanded', String(open));
	};
	toggle.addEventListener('click', () => setOpen(!menu.classList.contains('max-h-96')));
	menu.addEventListener('click', () => setOpen(!menu.classList.contains('max-h-96')));
</script>
```

## Footer

Three columns: © on the left, links in the centre and social icons on the right.

```html
<footer class="container mx-auto max-w-screen-xl p-8">
	<div class="grid grid-cols-3 dark:text-zinc-500">
		<div>© {year} {Name}</div>
		<div class="text-center justify-self-center">
			<a href="/" class="hover:text-zinc-300 duration-200">About</a> ·
			<a href="mailto:{email}" class="hover:text-zinc-300 duration-200">Contact</a>
		</div>
		<div class="flex space-x-3 justify-self-end"><!-- h-8 w-8 icons, with light/dark variants --></div>
	</div>
</footer>
```

## Article page

```html
<div>
	<img src="{hero}" class="w-full max-h-96 object-cover rounded-sm mb-4" /> <!-- optional -->
	<h1 class="dark:text-white text-lg font-semibold mb-2">{Title}</h1>
	<p class="text-zinc-600 dark:text-zinc-400 text-sm">{Date} · {N min read}</p>
	<hr class="my-4 h-0.5 border-t-0 bg-zinc-300 dark:bg-white/10" />
	<div class="lg:grid lg:grid-cols-[minmax(0,1fr)_14rem] lg:gap-8">
		<div class="flow-root dark:text-white [&_:is(h1,h2,h3,h4)]:scroll-mt-24 [&>*]:mb-4 [&_img]:mx-auto [&_h3]:underline [&_ul]:ml-3 [&_ul]:list-disc [&_a]:text-blue-400 [&_a]:hover:text-blue-600 [&>h1]:text-xl [&>h1]:font-bold [&>h2]:text-lg [&>h2]:font-semibold [&>p]:text-zinc-600 [&>p]:dark:text-zinc-300">
			{content}
		</div>
		<aside class="hidden lg:block"><div class="sticky top-24"><!-- TOC --></div></aside>
	</div>
</div>
```

Table of contents:
- Desktop sidebar: a "Contents" label (`font-semibold`) above an `<ol class="space-y-1.5 text-sm">`. Links use `text-zinc-600 hover:text-zinc-900 dark:text-zinc-400 dark:hover:text-white`; the active link gets `text-blue-400`. Indent sub-headings with `pl-3`.
- Mobile: a `<details class="rounded-sm border border-zinc-300 dark:border-white/10 px-3 py-2">` containing the same list, shown with `lg:hidden`.

## Image grid + lightbox

```html
<div class="grid lg:grid-cols-4 sm:grid-cols-2 gap-3">
	<button class="group rounded-md overflow-hidden cursor-pointer">
		<img class="rounded-sm h-full w-full object-cover transition-transform duration-200 ease-in-out group-hover:scale-110" />
	</button>
</div>

<div id="modal" class="fixed inset-0 bg-zinc-900/90 z-50 items-center justify-center p-4">
	<button class="absolute top-4 right-4 text-white text-4xl font-bold hover:text-zinc-300 transition-colors">✕</button>
	<img class="max-w-[95vw] max-h-[95vh] object-contain rounded-lg" />
</div>
```

The modal's CSS uses `display: none` plus opacity 0, and switches to `display: flex` plus opacity 1 when open. Use `transition-behavior: allow-discrete` and `@starting-style` so the fade runs on entry. The image scales from 0.95 to 1 over 250ms with `var(--ease-out)`. Under `prefers-reduced-motion`, drop the scale and shorten the fade to 150ms.
