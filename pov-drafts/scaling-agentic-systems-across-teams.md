# Point of View: Scaling Agentic Systems Across Teams

*(Source: ["Scaling Agentic Systems Across Teams"](https://equalexperts.blogin.co/posts/scaling-agentic-systems-across-teams-326867) by Cláudio Diniz, 2026-09-25.)*

Most organisations that get one agentic system working — a chatbot, a copilot — are now rushing to scale it, and almost all of them hit the same wall at the same moment: the system outgrows what one team can hold in its head.

What we see instead is a familiar pattern:

Teams keep everything on a single team for too long, until the agent is carrying business logic the underlying APIs were never designed for. Or they split ownership — domain teams taking their own MCP servers, or their own agents — on the assumption that splitting ownership removes the coupling between teams.

It doesn't. Splitting ownership doesn't fail because teams lack an architecture pattern to copy. It fails because the dependency between teams was never in the architecture diagram to begin with — it's in the prompt itself, and nothing in a typical MCP-server-vs-multi-agent decision addresses that.

Our point of view is simple:

You get scaling right when you stop treating ownership boundaries as an architecture decision and start treating them as a dependency-mapping decision — then make the resulting cross-team dependency visible and governable through shared evals, rather than hoping a clean org chart will make it disappear.

Done well, scaling an agentic system across teams keeps each team's cognitive load manageable while keeping behaviour predictable for the customer. Done poorly, it trades one team's overload for an invisible web of cross-team regressions that only a customer ever discovers.

## What Scaling Agentic Systems Really Isn't

Scaling an agentic system across teams is not primarily about:

Choosing between domain teams owning MCP servers or owning full agents. Drawing a RACI chart for who's responsible for the chatbot. Hiring more engineers to split the backlog.

Those are implementation choices, not the work itself.

The real work is identifying where the dependency between teams actually lives — the system prompt, tool descriptions, schemas, tool results, other agents' descriptions and responses — and deciding, deliberately, which boundary is worth its coordination cost.

## Our Point of View

Scaling succeeds when organisations accept that the dependency between teams doesn't go away when ownership splits — it moves into the prompt, where no schema or interface protects it — and build the shared evals that make that moved dependency visible again.

The teams that succeed start lean with one team and one agent, map who changes, understands, and relies on each component of the prompt before dividing ownership, choose MCP-server boundaries based on how many consumers actually exist rather than org structure, and treat their eval suite — not a design document — as the real agreement between teams.

## Principles

1. **Start Lean, Earn the Split** — begin with a single team, a single agent, and APIs designed for agents. Postpone the ownership conversation until the pain is real, and check first whether it's "the red flag" (the agent is compensating for bad APIs — fix the APIs) or genuinely "the inevitable" (the business has many real domains).
2. **Map the Prompt Before You Divide the Team** — the context a model sees is assembled from pieces (system prompt, tool descriptions, schemas, tool results, other agents' responses). For each piece, ask who can change it, who understands it, and who relies on it, before assigning ownership across teams.
3. **Choose the Boundary by Consumer Count, Not by Org Chart** — an MCP server earns its coordination cost when it has more than one real consumer (the chatbot, a back-office copilot, another team's agent). With a single consumer, splitting it across two teams pays the coordination cost without getting any reuse in return.
4. **Evals Are the Contract, Not the Document** — a tool description or schema change isn't breaking by itself; it becomes breaking when it breaks a behaviour someone relies on, and that reliance usually lives only in a consuming team's head. The eval suite is the agreement a document can't enforce.
5. **Co-Own the Integration Layer** — single-agent evals can stay with each team, like unit tests. Multi-agent, cross-team evals must be jointly owned — if only the chatbot team owns them, they become a gatekeeper; if only the domain team owns them, routing failures go unnoticed.

## Techniques That Make This Work

**Ownership & interface design:** mapping who changes, understands, and relies on each component of the assembled prompt; choosing tool granularity deliberately (a narrow `get_unshipped_orders(customer_id)` keeps domain knowledge with the API owner; a generic `query_orders(filter)` pushes that knowledge back onto the consuming agent); using structured outputs wherever a downstream consumer depends on the result.

**Evals as the cross-team agreement:** a two-layer suite — Layer A single-agent evals owned per-team, Layer B multi-agent/integration evals co-owned and run on every merge to main; testing behaviours with varied phrasing and more/less context, not fixed examples; running each variation multiple times to get a pass rate rather than a single pass/fail; asserting hard facts with code and using a model-based grader only for what can't be checked mechanically; tracking the pass-rate trend over time so a drop from 98% to 85% is treated as a signal even while it still clears the bar.

## What This Enables

Agentic systems that can scale past a single team's cognitive limit without quietly turning into one unowned, tangled prompt. Cross-team changes that surface as a specific failing eval scenario instead of a customer-facing incident. Ownership boundaries that are drawn because they earn their coordination cost, not because they match the org chart.

## What Success Looks Like

A tool or schema change in one team's service shows up as a named failing scenario in CI, not a support ticket three weeks later. Pass-rate trends are watched and investigated even when the suite is still green. Nobody can argue in the abstract about whose responsibility a regression is — the shared eval suite, not a document, is the artifact both teams point to.

## The Opportunity Ahead

Splitting ownership of an agentic system was never going to make the coupling between teams disappear — only visible or invisible. The organisations that scale agentic systems well aren't the ones with the cleanest architecture diagram; they're the ones whose evals make a cross-team regression impossible to miss.
