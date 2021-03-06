Require Export Coq.Lists.List.
Require Export Coq.Arith.Arith.
Require Import Program.Wf.

Program Fixpoint merge (x : list nat) (y : list nat) {measure (length x + length y)} : list nat :=
  match x with
  | x1 :: xs =>
    match y with
      | y1 :: ys => if x1 <? y1
        then x1::(merge xs y)
        else y1::(merge x ys)
      | _ => x
    end
  | _ => y
  end.
Next Obligation.
  apply Nat.add_le_lt_mono.
  reflexivity.
  auto.
Qed.

Program Fixpoint mergesort (x : list nat) {measure (length x)}: list nat :=
  match x with
  | nil => nil
  | x :: nil => x :: nil
  | x :: y :: nil => if x <? y
    then (x :: y :: nil)
    else (y :: x :: nil)
  | x :: y :: z :: rest => 
    let a := (x :: y :: z :: rest) in 
    let p := (Nat.div2 (length a)) in
    merge (mergesort (firstn p a)) (mergesort (skipn p a))
  end.
Next Obligation.
Admitted.
Next Obligation.
Admitted.

Eval compute in mergesort (5::9::1::3::4::6::6::3::2::nil).
