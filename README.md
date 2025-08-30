# Dome Care

A Flutter application.

---

## 🚀 Getting Started

### 1. Clone the repository

You can clone with HTTPS, SSH, or GitHub CLI:

```bash
# HTTPS (recommended for most)
git clone https://github.com/YahyaKreiyeh/dome-care.git

# SSH (requires GitHub SSH keys)
git clone git@github.com:YahyaKreiyeh/dome-care.git

# GitHub CLI
gh repo clone YahyaKreiyeh/dome-care

# Repo URL
https://github.com/YahyaKreiyeh/dome-care#

---

Domain Models & UI-Driven Rationale

These domain entities were derived directly from the Figma flows and the approved UI. They intentionally model only what the screens need now, while leaving room to evolve with backend and business rules.

you can see more on their properties inside their files (UserEntity, DoctorEntity, AppointmentEntity)

Design Decisions & Explanations

1. Clean Architecture × KISS × Divide & Conquer × Inheritance × DRY × SOLID

Clean Architecture: entities are UI-agnostic; use cases map between repositories and presentation.

KISS: prefer simple composition over complex inheritance; avoid over-abstraction until it hurts.

Divide & Conquer: break screens into small widgets and small use cases.

Inheritance: only where there’s a true “is-a” relationship; otherwise use composition.

DRY: share mappers, formatters, and UI atoms; don’t abstract prematurely.

SOLID: especially SRP (each widget/class has one reason to change) and DIP (UI depends on abstractions).\

2. I generally follow Clean Architecture standards (entities, use cases, repositories, presentation separation).

However, depending on business priorities and delivery speed, I sometimes adapt the structure — adding or removing

layers, combining classes, or skipping abstractions — when the overhead outweighs the benefits. The key is to keep

a balance: maintainability and scalability remain possible, while not over-engineering features that may never

evolve.

3. Balancing code length vs. widget count per file

i aim for small, focused files with cohesive widgets:

Screens (~200–300 lines) orchestrate layout/state, not low-level UI.

Reusable leaf widgets stay ~50–150 lines each.

If a file grows past ~400 lines or a widget past ~200 lines, we extract sub-widgets or split files by responsibility (header, list item, empty state).

The goal: readable diffs, faster reviews, manageable rebuild trees.

The stratgey is if the widget is only used in the view and can be extracted into a local widget for cleaner read

i would do that and if it's shared among multiple views in the same feature i would move it into widgets folder

and if it's shared among multiple features i would move it to the widgets fodler in the core folder

4. Delivery focus

I prioritized Login for the cleanest implementation (auth flow, persistence, error handling). For other areas, I focused on nailing the UI/requirements from Figma first, with a plan to tighten architecture as business rules stabilize.

5. flutter_gen usage (assets + localization)

i use flutter_gen to generate typed accessors for:

Images/SVGs: Assets.images.logo, Assets.icons.stethoscope.

Localization: strongly-typed keys via AppLocalizations.of(context).

This eliminates stringly-typed paths/keys, catches typos at compile time, and keeps refactors safe.

6. Localization note

Localization was implemented quickly; it works but introduced some noise. With more time we’d:

implement it using bloc cubit and handle date and time localization in a more robust and centralized way

7. Booking time slots: static now, dynamic later

Currently, time slots are static to match the prototype. In production we’ll:

Load available slots from the API either day-by-day (on tap) or month-by-month (on scroll/prefetch).

Cache locally (e.g., by doctorId + YYYY-MM or YYYY-MM-DD) to avoid re-fetching.

Respect business constraints: if near-real-time accuracy is required, cache TTL stays short or is bypassed; otherwise, caching improves perceived performance.

their ui can be improved using staggered gridview
```
