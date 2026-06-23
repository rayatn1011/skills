---
name: upgrade-dependencies
description: >
  Upgrade npm/pnpm/yarn dependencies safely and in order. Use when the user
  wants to upgrade or update packages, runs check-update, or has outdated or
  deprecated dependencies — including bare asks like "let's upgrade".
---

# Upgrade Dependencies

## Step 1 — Get the full picture first

Run `pnpm outdated` (or equivalent) to see everything at once. Never upgrade
package by package without first understanding the full scope.

## Step 2 — Triage into two buckets

**Safe to upgrade (first batch):**

- patch and minor bumps within the same major (e.g. `5.1.0 → 5.3.2`)
- major bumps where the breaking changes don't touch anything in the codebase

**Needs review (second batch):**

- any major version jump
- minor bumps on `0.x` packages (semver treats these as breaking)
- `deprecated` status — find the replacement before upgrading

The key distinction: a breaking change you don't use is not a breaking change
for your project. Always search the codebase before deciding something is
actually breaking.

## Step 3 — Research the "needs review" bucket

For each package in the second bucket:

1. Check the changelog / migration guide
2. Search the codebase for the specific APIs, props, or options that changed
3. Reclassify to "safe" if none of the breaking changes are used

## Step 4 — Upgrade in order

**First:** upgrade all safe packages in one batch. Run verification before
moving on. Fixing a type error from a "safe" upgrade is much easier when
breaking-change packages haven't been touched yet.

**Then:** handle each breaking-change package one at a time (or group tightly
coupled packages — e.g. all `@mui/*` together since they have peer deps on
each other).

## Step 5 — Verify after each batch

```
type-check → lint → build
```

All three matter:

- `type-check` catches API changes reflected in types
- `lint` catches usage of removed/renamed exports
- `build` catches runtime issues that static analysis misses

## Step 6 — Fix breaking changes

Apply the migrations you identified in Step 3 — update each renamed API,
removed prop, or restructured config option — then re-verify (Step 5).

## Step 7 — Check for free wins after upgrading

Build tools and frameworks sometimes absorb functionality from plugins on major
releases. After upgrading, look for deprecation warnings that say "this is now
built-in" — you may be able to remove a plugin entirely.

## Known gotchas

**Pin `@types/node` to the actual runtime version, not the minimum in `engines`.**
Check `engines.node` in `package.json` first (e.g. `>=20 <21` → use `@types/node@^20`). If it only specifies a lower bound (e.g. `>=20`), fall back to `.nvmrc`. If neither is definitive, ask before pinning.
