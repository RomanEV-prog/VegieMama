# Delovni proces (iz skillov commit-msg, pr-review, error-triage)

Ta pravila veljajo za vse commite in razhroščevanje v VeggieMama.

## Commit sporočila (commit-msg)

Conventional commits: `type(scope): summary`

* vse male črke, brez pike na koncu, povzetek ≤ 50 znakov, velelnik (»add«, ne »added«)
* tipi: `feat` | `fix` | `refactor` | `test` | `docs` | `chore` | `perf` | `style`
* scope = modul/feature (npr. `profile`, `tracking`, `theme`, `l10n`); izpusti, če sprememba zajema celoten projekt
* primer: `feat(tracking): add water quick add with haptic feedback`

## Samopregled pred commitom (pr-review)

Pred vsakim commitom pregled `git diff --staged` kot senior review:

* **Correctness** — logične napake, manjkajoči null checki, mutacija deljenega stanja
* **Security** — brez hardcodanih skrivnosti; uporabniški vnos validiran
* **Tests** — ima novo vedenje test? (od Faze 8 dalje obvezno)
* **Scope** — nepovezane spremembe gredo v ločen commit
* **Readability** — imena razkrivajo namen; funkcija dela eno stvar; error handling na async

Izhod: MUST FIX / SHOULD FIX / NITPICK / LGTM. Commit šele, ko ni MUST FIX.

Poleg tega VeggieMama-specifično: `flutter analyze` čist, nova besedila skladna z UX tonom (docs/design-guidelines.md §6–7).

## Diagnostika napak (error-triage)

Ob vsakem runtime erroru ali stack trace-u:

1. najdi **vzrok**, ne simptoma (zakaj je vrglo, ne katera vrstica)
2. preberi implicirane datoteke
3. izhod: **Root cause** (en stavek) → **Why it happened** → **Fix** (minimalna sprememba, before/after)
4. ob negotovosti: 2–3 najverjetnejši vzroki po verjetnosti + diagnostični korak za vsakega
