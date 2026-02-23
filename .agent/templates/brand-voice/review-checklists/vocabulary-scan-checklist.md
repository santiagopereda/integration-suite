# Vocabulary Scan Checklist

Systematic scan of content against the brand's vocabulary guide to enforce approved terms, catch forbidden words, and ensure consistent terminology.

## Prerequisites

- Voice profile loaded from `.agent/system/brand-voice-profile.md`
- Vocabulary guide available (from voice profile or `voice-profile/vocabulary-guide-template.md`)
- Content draft ready for review

## Step 1: Brand Term Verification

Check that all brand-specific terms are used correctly.

| Term | Rule | Found In Content | Correct? |
|------|------|:----------------:|:--------:|
| [Product name] | [Capitalize, no abbreviation] | [Yes/No] | [Y/N] |
| [Feature name] | [Exact name, no synonyms] | [Yes/No] | [Y/N] |
| [Company name] | [Full name on first mention] | [Yes/No] | [Y/N] |

- [ ] All brand terms appear exactly as documented
- [ ] No unauthorized abbreviations or nicknames
- [ ] Capitalization matches the brand style guide
- [ ] First mention uses the full term before any shorthand

## Step 2: Preferred Term Substitution

Scan for non-preferred terms and replace with approved alternatives.

| Found | Should Be | Replaced? |
|-------|-----------|:---------:|
| utilize | use | [ ] |
| leverage | use / build on | [ ] |
| synergy | collaboration | [ ] |
| [Add from vocabulary guide] | [Preferred term] | [ ] |

**Scan method**: Search the document for each word in the "avoid" column of the vocabulary guide.

- [ ] All non-preferred terms identified
- [ ] Replacements applied where appropriate
- [ ] Context verified — some substitutions don't work in every context

## Step 3: Forbidden Word Check

Scan for words and phrases that are explicitly excluded from the brand voice.

| Forbidden Word/Phrase | Found? | Action |
|-----------------------|:------:|--------|
| [Word from vocabulary guide] | [Yes/No] | [Remove / Rephrase] |
| [Hype words: revolutionary, game-changing, disruptive] | [Yes/No] | [Remove / Rephrase] |
| [Corporate jargon: circle back, move the needle, touch base] | [Yes/No] | [Remove / Rephrase] |
| [Filler: basically, actually, honestly, literally] | [Yes/No] | [Remove if unnecessary] |

- [ ] No forbidden words or phrases remain
- [ ] Hype and superlatives replaced with specific claims
- [ ] Corporate jargon replaced with plain language

## Step 4: Jargon Policy Compliance

Verify technical jargon follows the documented policy.

**Current jargon policy**: [Embrace / Translate / Avoid — from vocabulary guide]

| Jargon Term | First Use Defined? | Audience Appropriate? | Action |
|-------------|:------------------:|:--------------------:|--------|
| [Term] | [Yes/No] | [Yes/No] | [OK / Define / Replace] |
| [Term] | [Yes/No] | [Yes/No] | [OK / Define / Replace] |

- [ ] Jargon follows the documented policy for this content type
- [ ] First use includes definition in educational/marketing content
- [ ] Technical docs can use jargon freely for developer audiences
- [ ] No unexplained acronyms (spell out on first use)

## Step 5: Inclusive Language Scan

Check for exclusionary, biased, or non-inclusive language.

| Category | Check | Found Issues? |
|----------|-------|:------------:|
| Gender | No gendered defaults (guys, mankind) | [ ] |
| Technical | No exclusionary tech terms (whitelist/blacklist, master/slave) | [ ] |
| Ability | No casual ableism (crazy, blind spot, falling on deaf ears) | [ ] |
| Cultural | No assumptions about cultural context or idioms | [ ] |
| Age | No age-based assumptions (millennials don't..., boomers always...) | [ ] |

- [ ] All flagged terms replaced with inclusive alternatives
- [ ] Content accessible to the documented audience without cultural assumptions

## Step 6: Consistency Check

Verify the same concept is always referred to with the same term throughout the content.

| Concept | Terms Used | Consistent? |
|---------|-----------|:-----------:|
| [Concept] | [List all variants found] | [Yes/No] |
| [Concept] | [List all variants found] | [Yes/No] |

- [ ] One term per concept throughout the document
- [ ] No synonyms used interchangeably for the same thing (e.g., "users" vs "customers" vs "clients" for the same group)
- [ ] Acronyms defined on first use and used consistently after

## Step 7: Punctuation & Formatting

Verify formatting follows the vocabulary guide rules.

| Rule | Compliant? |
|------|:----------:|
| Oxford comma policy | [ ] |
| Exclamation mark usage within guidelines | [ ] |
| Emoji usage within guidelines | [ ] |
| Heading capitalization (title case / sentence case) | [ ] |
| List formatting (bullets vs. numbers) | [ ] |
| Bold/italic usage within guidelines | [ ] |

## Scan Summary

```yaml
vocabulary_scan:
  content_title: "[Title or identifier]"
  scanner: "[Name or role]"
  scan_date: "[YYYY-MM-DD]"
  brand_terms_correct: true/false
  preferred_substitutions: [count]
  forbidden_words_found: [count]
  jargon_violations: [count]
  inclusive_language_issues: [count]
  consistency_issues: [count]
  formatting_issues: [count]
  total_issues: [count]
  status: "[clean / minor_fixes / revision_needed]"
```

## Quick Reference: Common Substitutions

Keep this reference handy during scans:

| Avoid | Prefer | Reason |
|-------|--------|--------|
| utilize | use | Simpler |
| leverage | use, build on | Less corporate |
| synergy | collaboration, alignment | Overused |
| best-in-class | leading, proven, effective | Vague superlative |
| cutting-edge | modern, current, latest | Overused |
| paradigm shift | change, transformation | Buzzword |
| circle back | follow up, revisit | Corporate jargon |
| low-hanging fruit | quick wins, easy improvements | Cliche |
| move the needle | make a difference, improve | Vague |
| touch base | check in, connect | Informal jargon |
| deep dive | detailed look, thorough analysis | Overused |
| at the end of the day | ultimately, in summary | Filler |
| going forward | from now on, next | Filler |
| it goes without saying | [delete — just say it] | Contradictory |
