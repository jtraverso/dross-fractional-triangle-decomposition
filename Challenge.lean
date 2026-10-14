/-
Copyright (c) 2026 Juan Pablo Traverso Gianini. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Juan Pablo Traverso Gianini
-/
module

public import Mathlib

/-!
# Dross's theorem on fractional triangle decompositions

**Theorem (Dross, 2016).** Every finite graph `G` on `n` vertices with minimum degree at least
`9n/10` has a fractional triangle decomposition: nonnegative real weights on its triangles such
that every edge of `G` lies in triangles of total weight exactly one.

A triangle is a 3-element vertex set inducing a clique (`G.cliqueFinset 3`), and its edges are
the non-diagonal unordered pairs of its vertices (`triEdges`).

The Mathlib definitions used in this statement are reproduced verbatim, with file and line at the
pinned Mathlib revision, in `MATHLIB_DEFINITIONS.md` at the root of this repository.
-/

@[expose] public section

open SimpleGraph Finset

namespace DrossTriangle

/-- The non-loop edges spanned by a finite set of vertices. -/
def triEdges {V : Type*} [DecidableEq V] (t : Finset V) : Finset (Sym2 V) :=
  t.sym2.filter (fun e => ¬ e.IsDiag)

/-- A fractional triangle decomposition of `G`: nonnegative weights on vertex sets such that,
for every edge `e` of `G`, the triangles of `G` containing `e` have total weight one. -/
def FractionalTriangleDecomp {V : Type*} [DecidableEq V] [Fintype V] (G : SimpleGraph V)
    [DecidableRel G.Adj] : Prop :=
  ∃ w : Finset V → ℝ, (∀ t, 0 ≤ w t) ∧
    ∀ e ∈ G.edgeFinset,
      (∑ t ∈ G.cliqueFinset 3, if e ∈ triEdges t then w t else 0) = 1

/-- **Dross (2016).** A finite graph on `n` vertices with minimum degree at least `9n/10` has a
fractional triangle decomposition. -/
theorem dross_fractional_triangle_decomposition {V : Type*} [Fintype V] [DecidableEq V]
    (G : SimpleGraph V) [DecidableRel G.Adj] (h : 9 * Fintype.card V ≤ 10 * G.minDegree) :
    FractionalTriangleDecomp G := by
  sorry

end DrossTriangle
