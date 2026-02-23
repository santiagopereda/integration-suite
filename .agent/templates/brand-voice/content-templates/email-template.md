# Email Template

Structure for email newsletters, campaigns, and announcements. For transactional emails, adapt the body section to be minimal and action-focused.

## Prerequisites

- Intent capture completed (`intent_capture` metadata available)
- Voice profile loaded from `.agent/system/brand-voice-profile.md`
- Mailings channel rules loaded from `channel-rules/mailings-rules.md`

## Subject Line Options

Generate 3-5 subject line options. A/B test the top 2 when possible.

| # | Subject Line | Characters | Pattern |
|---|-------------|:----------:|---------|
| 1 | [Subject] | [count] | [Benefit / Curiosity / Number / Question] |
| 2 | [Subject] | [count] | |
| 3 | [Subject] | [count] | |
| 4 | [Subject] | [count] | |
| 5 | [Subject] | [count] | |

**Subject line rules**:
- Under 50 characters (mobile-friendly)
- Front-load the value — what's in it for the reader?
- No ALL CAPS, excessive punctuation, or spam trigger words
- Test: would you open this from a sender you barely remember?

**Selected subject**: [Choose one or mark two for A/B test]

## Preview Text

The preview text extends the subject line in the inbox. Don't waste it.

- **Option A**: [40-90 characters — complements the subject]
- **Option B**: [Alternative]

**Rules**:
- Must make sense paired with the subject line
- Never repeat the subject line
- Never use "View in browser" or "Having trouble viewing?"

## Email Structure

### Header

```
From: [Name] <[email]>    ← Use a person's name when possible
Reply-to: [email]          ← Monitored inbox, not no-reply
Subject: [Selected subject]
Preview: [Selected preview text]
```

### Greeting

**Options by email type**:

| Type | Greeting |
|------|----------|
| Newsletter | "Hi [Name]," or no greeting (dive straight in) |
| Announcement | "Hi [Name]," |
| Transactional | "[Name]," |
| Re-engagement | "Hi [Name]," |

Personalization token: `[Name]` with fallback to "there" or "Hi," if name unavailable.

### Opening Line (1-2 sentences)

Reward the open immediately. The first line should deliver value or create engagement.

**Patterns**:
- **Stat hook**: "Last week, 73% of the pipelines we reviewed had the same flaw."
- **Story hook**: "I spent 4 hours debugging a deployment failure that had a 1-line fix."
- **Direct value**: "Here are 3 things that changed how I think about monitoring."
- **Callback**: "Remember the schema validation tip from last issue? Here's part 2."

**Avoid**: "I hope this email finds you well" / "Happy [day]!" / "Just checking in"

### Body

**For newsletters** (multi-topic):
```
## [Topic 1 — headline]
[2-3 sentences of insight or summary]
[Link to full content if applicable]

---

## [Topic 2 — headline]
[2-3 sentences]
[Link]

---

## [Topic 3 — headline]
[2-3 sentences]
[Link]
```

**For single-topic emails** (announcement, story, tip):
```
[Opening context — why this matters]

[Core content — the insight, news, or lesson]

[Supporting detail — example, data, or proof]

[CTA — clear next step]
```

**Formatting rules**:
- Paragraphs: 1-3 sentences max
- Bold key phrases, not full sentences
- Use horizontal rules or spacing between sections
- One primary CTA; secondary CTAs are text links only

### CTA Section

```
[Clear action statement — what they'll get]

[BUTTON: Action Verb + Object]
Example: "Download the Checklist" / "Read the Full Guide" / "Register Now"
```

**CTA rules**:
- One primary CTA button per email
- Button text: 2-5 words, starts with a verb
- Place CTA after providing enough context to motivate the click
- Repeat CTA as a text link near the footer for skimmers

### Sign-Off

**Options**:
- "[Name]" (minimal, professional)
- "— [Name], [Role]" (adds context)
- "Until next time, [Name]" (for regular newsletters)

### Footer

Required elements:
- Unsubscribe link (legally required)
- Company name and physical address (CAN-SPAM)
- Social media links
- Preference center link (optional but recommended)

## Email Metadata

```yaml
email:
  intent_ref: "[Link to intent capture]"
  type: "[newsletter / announcement / transactional / re-engagement / event]"
  subject: "[Selected subject]"
  preview_text: "[Selected preview]"
  segment: "[Audience segment]"
  send_date: "[YYYY-MM-DD]"
  send_time: "[HH:MM timezone]"
  primary_cta: "[Button text]"
  cta_url: "[Destination URL]"
  ab_test: "[Subject A vs Subject B, or none]"
  voice_check: false  # Set true after voice compliance review
```
