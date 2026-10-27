---
name: pythonic-code
description: Use whenever writing Python.
---

# Pythonic code

## Process

1. Plan the split: which class owns each piece of data, and where each concern lives.
2. Write the code following the rules below.
3. Run `uv run ruff format`, `uv run ruff check` and `uv run ty check`. All three must pass.

## Structure

- **One owner per piece of data.** Put an operation on the class that owns the data it changes (`message.delete()`, `role.edit(name='x')`), so callers pass only what changes. Expect many small classes with short methods.
- **Free functions only for stateless helpers** on plain values, grouped in `utils.py`. Search there and in base classes before writing a new helper.
- **Values that travel together get a class** with a domain name (`Route`, `ExponentialBackoff`, `Paginator`) that owns their logic.
- **Layers import only downward.** For example, transport (HTTP calls), then state (cache and model construction), then models (domain logic), then a thin public facade.
- **Choke points.** Write each cross-cutting concern (retries, auth, rate limits, error mapping, logging) once, in the one method every call passes through. Endpoint methods stay declarative.
- **Small overrides.** A base class defines a few hook methods and subclasses override only what differs. Share sync and async variants through a base that holds the data handling and keep only the I/O separate.
- **One concept per module** (`errors.py`, `enums.py`, one module per domain object). Declare the public API in `__all__` and prefix everything else with an underscore.

## Readable functions

- Guard clauses first: handle invalid and trivial cases with an early `return` or `raise`.
- Normalize inputs to one form at the top, then run a single code path. Don't branch the loop body on every argument combination.
- Express mappings as data. Use a dict of handlers instead of an `if`/`elif` chain that maps a key to a value.
- Use builtins and comprehensions (`enumerate`, `reversed`, `dict.fromkeys`, filtered dict comprehensions).
- Keep a public method at one level of abstraction, with its steps as calls to well-named helpers.
- Group lines into paragraphs, one step each, separated by a blank line. When a function passes four or five paragraphs, move one into a helper named after its step.
- Comment only the quirks of external systems (`# API quirk: 101 is treated as 100`). Names carry the rest.

## Boundary data

- Type external payloads as `TypedDict`s that mirror the source, with `NotRequired[...]` for absent keys and `... | None` for nulls.
- Parse at the boundary. Convert IDs, timestamps, enums and flags when building the model, so no code past it reads raw dicts.
- When a model mirrors remote state, `__init__` sets identity and calls `self._update(data)`, and later changes call `_update` again.
- Give models a `__repr__` like `<User id=1 name='x'>`. Use `__slots__` on classes created in bulk.
- Make enums that read external data tolerant of unknown values instead of raising.

## Dataclass or TypedDict

- Use a `TypedDict` for data that stays a dict: JSON payloads coming in or going out, and `**kwargs` shapes. It only types the keys. It doesn't validate or convert anything at runtime.
- Use a `@dataclass` for data your own code creates and passes around, such as config, results and value objects. It gives attribute access, `__init__`, `__repr__` and `__eq__`. Add `frozen=True` for values that shouldn't change and `slots=True` for classes created in bulk.
- Use a plain class when the object needs a custom `__init__`, an `_update(data)` method, or properties over raw values. Models that mirror remote state fit here.
- Don't pass a `TypedDict` deep into the code. Convert it to a dataclass or model at the boundary.

## Signatures and types

- Make optional parameters keyword-only with `*`. Use `/` when a parameter name means nothing to callers.
- Use a `MISSING` sentinel when `None` is a valid value. In an update method, `None` clears a field and `MISSING` leaves it unchanged.
- Annotate every public signature and every attribute, in the syntax of the project's `requires-python`. Put annotation-only imports under `if TYPE_CHECKING:`.
- Use `Protocol` for duck types, `Self` for alternate constructors, `@overload` for distinct call shapes.

## Errors

- Root all package exceptions in one base class and subclass by meaning (`NotFound`, `Forbidden`), so callers catch at the level they need.
- Store what a handler needs as attributes on the exception (`status`, `code`).
- Raise `TypeError` for wrong types and `ValueError` for bad values, with a message that names the requirement.
- Use `raise ... from None` when the original traceback is noise.

## Async

- Expose paginated sources as async generators, so callers write `async for`.
- Make clients that own a session async context managers.
- Keep a reference to every background task and cancel it on exit.

## Tooling

- Use uv: `uv add` for packages, commit `uv.lock`, run tools through `uv run`.
- Configure ruff under `[tool.ruff]` and ty under `[tool.ty]` in `pyproject.toml`. A ty suppression is rule-specific (`# ty: ignore[rule-name]`) and gives a reason.
- Give each module its own logger, `_log = logging.getLogger(__name__)`, and use lazy `%s` arguments.
