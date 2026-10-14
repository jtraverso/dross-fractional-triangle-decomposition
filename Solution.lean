/-
Copyright (c) 2026 Juan Pablo Traverso Gianini. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Juan Pablo Traverso Gianini
-/
module

public import Mathlib
public import LeanPool.DrossFractionalTriangleDecomposition

/-!
# Proof of the statement in `Challenge.lean`

The definitions below are verbatim copies of those in `Challenge.lean`; they coincide with the
library's `LeanPool.DrossFractionalTriangleDecomposition.triEdges` and
`LeanPool.DrossFractionalTriangleDecomposition.FractionalTriangleDecomp`. The theorem is
`LeanPool.DrossFractionalTriangleDecomposition.dross_fractional_flow_exact`, proved by
max-flow/min-cut (`LeanPool/DrossFractionalTriangleDecomposition/Internal/`).
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
  obtain ⟨w, hw, he⟩ :=
    LeanPool.DrossFractionalTriangleDecomposition.dross_fractional_flow_exact G h
  exact ⟨w, hw, he⟩

end DrossTriangle
