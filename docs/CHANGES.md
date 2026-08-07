# v3.0.3 - 2026-08-07

## Changes
- TOC bump: Updated universal interface versions to 11509 (Classic Era), 20506 (TBC Anniversary), 50504 (MoP Classic), 120007 (Retail). Removed Cata (40402) and legacy Retail eras (110207, 120000, 120001).

# v3.0.2 - 2026-06-30

## Changes

- Updated for WoW Retail 12.0.7 (Interface 120007).

# v3.0.0 - 2026-04-30

## Changes

- **Migrated to RGX-Framework**: Added `RequiredDeps: RGX-Framework` to TOC. Core logic now uses `RGX:GetSound()`, `RGX:RegisterEvent()`, and `RGX:RegisterSlashCommand()` â€” eliminating ~160 lines of duplicated boilerplate.
- **RGXSound handle**: Sound playback, variant management, mute/unmute, settings, and welcome message are now handled by the RGXSound module in RGX-Framework.
