# FinalFantasyLevelUp

FinalFantasyLevelUp is a standalone WoW addon that plays a Final Fantasy sound on `PLAYER_LEVEL_UP`. It is not a Better Level-Up sound pack. The single `FinalFantasyLevelUp.toc` supports Classic Era (`11509`), Burning Crusade Classic (`20506`), Mists of Pandaria Classic (`50504`), and Retail (`120007`), and requires `RGX-Framework`.

## Layout And Runtime

- The TOC loads `data/locales.lua` before `data/core.lua`; preserve that order.
- `data/core.lua` registers the addon with `RGX:GetSound()` and owns events and `/fflu` commands.
- `sounds/` contains the high, medium, and low sound variants; `media/` contains branding assets.
- `docs/CHANGES.md` and `docs/changelogs/` contain release notes.

## Development Rules

- Use the existing RGX sound handle, event registration, and slash-command APIs rather than duplicating sound state or lifecycle plumbing.
- Keep localization fallbacks intact and match the surrounding Lua style.
- Keep `FinalFantasyLevelUp.toc` and `ADDON_VERSION` in `data/core.lua` synchronized when changing versions.

## Testing And Release

- There is no build step or automated test suite. Install the addon and `RGX-Framework` in each supported client flavor being changed. Verify `/fflu help`, `/fflu test`, enable/disable, all three sound variants, persistence after `/reload`, and an actual or simulated level-up event.
- Stable releases use `vX.Y.Z` tags. `.github/workflows/release.yml` validates the tag against the TOC version and packages with BigWigsMods/packager; pushes to `dev` and `alpha` use those release channels. Update `docs/CHANGES.md` and the matching `docs/changelogs/<version>.md` entry for a release.
