# Team Onboarding Guide

A facilitator guide for introducing the human-centered AI operating model to your team.

This session works for a 5-person startup and a 50-person department. It does not require technical knowledge. It requires honest conversation.

**Time:** 90 minutes
**Who facilitates:** Anyone who completed `ORG-SETUP.md` and believes in what it says
**Who attends:** Everyone who will use AI tools in their work

---

## Before the session

**Prepare the room — physical or virtual:**
- If virtual, use a shared whiteboard (Miro, Lucidspark, or even a shared doc)
- If physical, have sticky notes and wall space
- Have `USAGE.md` available for people to reference

**Send this to attendees 24 hours before:**

> We're meeting to talk about how we use AI together — not which tools to use, but how we want to relate to them as a team. No technical background needed. Come with one thing you're excited about AI helping you with, and one thing you're nervous about.

**Have these ready:**
- Your completed `ORG-SETUP.md` answers
- A printed or shared copy of the seven principles from `PRINCIPLES.md`
- The three-question test from `USAGE.md`

---

## Session structure

### Opening — 10 minutes

Start with the question you asked people to think about:

> "What's one thing you're excited about AI helping you with? And one thing you're nervous about?"

Go around the room. Don't debate anything yet. Just listen. Write the nervous things down — they will come back later.

**Why this matters:** It surfaces the real landscape in the room before you impose a framework on it. The nervous things are usually where the important conversations live.

---

### Part 1 — The problem with how most people use AI — 15 minutes

Present this directly. Don't soften it.

**The standard approach:**
Most people use AI to produce more output faster. That is a reasonable goal. The problem is that optimizing for output, without thinking about what it does to the human producing it, quietly creates three things:

- Output that sounds like everyone else's — generic, voiceless, indistinguishable
- Decisions that belong to humans getting quietly outsourced to machines
- People who are producing more but growing less

Ask the room: **Has anyone experienced any of these? Even slightly?**

Let people respond. This is usually where the energy in the room shifts.

**The alternative framing:**
AI as a tool that amplifies what you can do — not a tool that does it for you. The difference is not about capability. It is about who stays in charge.

---

### Part 2 — Our operating model — 20 minutes

Walk through the seven principles from `PRINCIPLES.md`. Not as a lecture — as a conversation.

For each principle, ask one question:

| Principle | Question to ask the room |
|---|---|
| Amplify, don't replace | Where are we most at risk of replacing ourselves? |
| Access belongs to everyone | Who in our community might get left out as we use more AI? |
| Transparency as default | Are there places we're using AI without being clear about it? |
| The human defines what's good | Who defines what a good outcome looks like for our customers? |
| Name what's not working | What have we tried with AI that hasn't worked? |
| Stay adaptable | Are we building habits or dependencies? |
| Human agency is the load-bearing wall | What decisions must always stay with us? |

You don't need to cover all seven in depth. Let the conversation go where it needs to go. The principles are anchors, not a script.

---

### Part 3 — Our non-delegables — 20 minutes

This is the most important part of the session.

Share the non-delegables list from your `ORG-SETUP.md`. Read it out loud.

Then ask: **Does this feel right? Is anything missing? Is anything on here that shouldn't be?**

This conversation will surface disagreement. That is good. You want to know where people have different intuitions before those intuitions play out silently in their AI use.

Common tensions to watch for:
- Someone thinks a relationship is delegable that another person thinks is sacred
- Someone thinks a decision is routine that another person thinks requires judgment
- Someone is more comfortable with AI handling communications than others are

Don't resolve these tensions by majority vote. Resolve them by asking: what would we regret? What would our customers or community notice if we got this wrong?

Revise the non-delegables list based on the conversation. This is now a shared document, not a top-down policy.

---

### Part 4 — The three questions — 15 minutes

Introduce the three-question test from `USAGE.md`:

1. Am I amplifying myself or replacing myself?
2. Would my customers or community know the difference?
3. Is this building my capacity or creating dependency?

Run a short exercise. Ask each person to think of one AI task they do regularly — drafting, researching, summarizing, whatever. Then run it through all three questions silently.

Ask: did anyone's answer to any of those questions give them pause?

This is usually where the most honest conversations happen. Let them.

---

### Closing — 10 minutes

Return to the nervous things from the opening. Go back to the list.

Ask: after this conversation, has anything shifted? Are any of these less concerning? Are any more concerning now that we've talked?

Then close with one commitment per person:

> "One thing I will do differently in how I use AI this week."

These don't need to be big. They need to be real.

---

## After the session

**Within 24 hours:**
- Share the updated non-delegables list with everyone
- Make sure `ORG-CLAUDE.md` reflects anything that changed in the conversation
- Send people the link to install `CLAUDE.md` and `ORG-CLAUDE.md` with the instructions from `install.md`

**Within one week:**
- Check in with one or two people informally — how did it go? Did the three-question test come up?

**At 30 days:**
- Run a brief retrospective — 20 minutes, same group
- Three questions: What's working? What's not? What do we want to change?

---

## If your team shares a codebase

The session above is about how your team *relates* to AI. If your team also
*builds* in a shared repository with their own AI access, add the **Commons**
(`org/ORG-COMMONS.md`) — an opt-in `commons/` folder that becomes the team's
shared source of truth for settled facts and decisions. It stops every agent
re-deriving the same context (which maxes out tokens) and keeps teammates'
agents converged, with new entries gated behind human ratification.

This is optional and technical-leaning — skip it for non-engineering teams.

---

## Facilitation notes

**If the room is skeptical of AI entirely:**
Don't argue for AI adoption. Acknowledge the skepticism as legitimate and redirect: this session is not about whether to use AI. It is about how to use it in a way that doesn't cost us what matters. That framing usually opens the door.

**If the room is enthusiastic to the point of uncritical:**
Slow it down. The nervous things matter. Ask the people who haven't spoken. The most important risks in any room are usually held by the quietest people.

**If someone dominates the non-delegables conversation:**
Name it. "I want to make sure we're hearing from everyone on this one — these decisions affect all of us." This is especially important if the dominant voice is leadership.

**If people want to skip to tools and implementation:**
Acknowledge it. "We'll get there. This conversation first — because the tools only matter if we know what they're supposed to be doing for us."

---

## For Nysteria clients

If you are a Nysteria client using this guide as part of an engagement, your facilitator will customize this session for your organization's specific context. The structure above is the baseline. What gets emphasized, what gets extended, and what gets added depends on your industry, your team size, and what your `ORG-SETUP.md` revealed.

The assessment that follows this session is in `ORG-ASSESSMENT.md`.
