---
name: personal-site-style
description: Viswa's personal-site (viswa.space) UI style — flat, monospace, zinc-grey, square-cornered cards with a blue accent. Use when building or styling a micro-site, page, or component that should match viswa.space.
---

# viswa.space style

Flat and monospaced. Square, bordered zinc cards. Blue is the only accent. No shadows and no gradients. Built with Tailwind CSS v4. Dark mode follows the OS setting.

Files:
- `SKILL.md`: rules and design tokens (this file)
- `setup.md`: fonts, Tailwind and the page skeleton
- `components.md`: copy-paste components (nav, section, cards, footer, article, modal)

Read `setup.md` first when starting a new site. Read `components.md` when building UI.

## Rules

1. Use **JetBrains Mono** for all text. Don't add a second typeface.
2. Build everything from the **zinc** greys. **Blue** is the only accent colour.
3. Cards use `rounded-none`, a 1px border and no shadow.
4. Keep weights light. Headings are mostly regular weight; set them apart with size, not boldness.
5. Keep spacing tight. Card grids use `gap-2`, and cards use `p-4`.
6. Keep motion subtle. Hover colour changes use `duration-200`; the press feedback is `active:opacity-75 duration-100`.
7. Every element needs a `dark:` variant.

## Tokens

### Colour

| Role | Light | Dark |
|---|---|---|
| Page background | `bg-white` | `dark:bg-zinc-900` |
| Card / surface | `bg-zinc-100` | `dark:bg-zinc-800` |
| Card border | `border-zinc-300` | `dark:border-zinc-700` |
| Divider | `bg-zinc-300` | `dark:bg-white/10` |
| Primary text | `text-zinc-900` (default) | `dark:text-white` |
| Body / secondary text | `text-zinc-600` | `dark:text-zinc-400` (`dark:text-zinc-300` in articles) |
| Meta (dates, reading time) | `text-zinc-400` | same |
| Muted / empty state | `text-zinc-500` | `dark:text-zinc-400` |
| Skeleton bar | `bg-zinc-200` | `dark:bg-zinc-700` |
| Inline code background | `zinc-200` | `zinc-800` |

### Accent (blue)

| Use | Classes |
|---|---|
| Emphasised link in prose | `text-blue-500 font-semibold underline hover:text-blue-700` |
| Article body link | `text-blue-400 hover:text-blue-600` |
| Nav hover / active | `md:hover:text-blue-600 md:dark:hover:text-blue-500` |
| Active table-of-contents item | `text-blue-400` |

Plain links are underlined in the text colour and fade on hover: `underline hover:text-zinc-400 duration-200`.

### Typography

| Element | Classes |
|---|---|
| Site title (nav) | `text-2xl font-semibold` |
| Section heading | `text-xl` (regular weight) |
| Article title | `text-lg font-semibold` |
| Article h1 / h2 / h3 | `text-xl font-bold` / `text-lg font-semibold` / `underline` |
| Card title | base size, regular weight, `dark:text-white` |
| Card title (feature/stack) | `text-lg font-bold` |
| Description | base size, `text-zinc-600 dark:text-zinc-400` |
| Meta | `text-xs text-zinc-400` |
| Status / WIP note | `text-sm italic text-zinc-600 dark:text-zinc-400`, prefixed with ⚠️ |

The body uses `antialiased`. Inline code gets a 5px padding with the zinc background above.

### Layout

- Container: `container mx-auto max-w-screen-xl p-8`.
- Sections are stacked with `<br />` between them.
- Grids are one column on mobile, then `md:grid-cols-2` / `3` / `4`, with `gap-2`.
- The navbar is sticky: `sticky top-0 z-40`.
- Breakpoints: `md` for grids and nav, `lg` for the article table-of-contents sidebar.

### Radius

| Element | Radius |
|---|---|
| Cards, panels | `rounded-none` |
| Buttons, nav items, small UI | `rounded-sm` |
| Photos, floated images | `rounded-md` |
| Lightbox image | `rounded-lg` |

### Motion

- Easing token: `--ease-out: cubic-bezier(0.23, 1, 0.32, 1)`.
- Colour hovers: `duration-200`.
- Clickable card press: `active:opacity-75 duration-100`.
- Image hover zoom: `group-hover:scale-110 transition-transform duration-200 ease-in-out`.
- Modal: 250ms fade plus scale from 0.95 using `--ease-out`. Honour `prefers-reduced-motion`.

## Don'ts

- No drop shadows, gradients, or glassmorphism.
- No rounded, pill-shaped cards.
- No accent colour other than blue. The one exception is data-driven colour, such as a GitHub language colour.
- No sans-serif body text.
- No large hero banners. Pages open straight into content.
