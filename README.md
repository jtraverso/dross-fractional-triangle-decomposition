# Dross's theorem on fractional triangle decompositions in Lean 4

Author and maintainer: **Juan Pablo Traverso Gianini**. Licence: Apache-2.0 (see `LICENSE`).

**Theorem (Dross, 2016).** Every finite graph on `n` vertices with minimum degree at least
`9n/10` has a fractional triangle decomposition: nonnegative real weights on its triangles such
that every edge lies in triangles of total weight exactly one.

The audited statement is in [`Challenge.lean`](Challenge.lean), which imports only Mathlib and
contains the definition of a fractional triangle decomposition; the proof is in
[`Solution.lean`](Solution.lean). [`comparator.json`](comparator.json) names the compared theorem,
[`MATHLIB_DEFINITIONS.md`](MATHLIB_DEFINITIONS.md) reproduces verbatim the Mathlib definitions used
by the statement, and [`formalization.yaml`](formalization.yaml) records provenance, sources and
process.

## How the proof goes

The weights are obtained from a flow: a network whose capacities encode the triangles and the
edges, so that a flow saturating the edge arcs gives a fractional decomposition. A finite
max-flow/min-cut theorem (`LeanPool/MaxFlowMinCut.lean`) reduces the problem to bounding every cut
from below, which is done by double counting triangles and copies of `K₄` under the
minimum-degree hypothesis (`LeanPool/DrossFractionalTriangleDecomposition/Internal/`). Triangles
whose three vertices have high degree are handled by a peeling reduction: removing such a triangle
keeps the hypothesis on a smaller graph, and the decomposition lifts back.

The modules under `LeanPool/` are the author's contributions to
[Lean Pool](https://github.com/LeanPool/lean-pool) (PR #573 and the max-flow/min-cut project),
ported from the frozen Lean development of the author's Paper III, and copied from Lean Pool
commit `26ce45d3871e5560a8baffa4d49a8942b1d20a24` with header lines normalized.

## Source

* F. Dross, *Fractional triangle decompositions in graphs with large minimum degree*, SIAM J.
  Discrete Math. 30 (2016) 36–42, doi:10.1137/15M1014310.

## Authorship and use of AI

The result and the route were chosen by the author; the Lean proofs were produced with Harmonic's
Aristotle and other AI assistance, audited, and checked mechanically with Lean. See
`formalization.yaml` for details.

## Building

Lean `v4.35.0-rc3`, Mathlib `c55e6e786f49471c72fbddbec5415808896aec1e`:

```bash
lake exe cache get
lake build
```
