# Lab01 - Intuitionistic propositional logic in Agda

**LICENCE:** This tutorial contains adaptations of material from [Programming Language Foundations in Agda](https://plfa.github.io/) by Phil Wadler and Wen Kokke. It is licensed under Creative Commons Attribution 4.0 International.

# Polymorphism and implicit arguments

The polymorphic identity function in Agda is written as follows:

```agda id=f2ae19e0-749c-4cd1-906f-e7a2fea9d3d7
module lab01 where
id : (A : Set) → A → A
id A x = x
```

Compare this with the equivalent Haskell definition:

```haskell no-exec id=f8dbc34e-3199-4e87-8486-4cf0277cafd6
id :: A -> A
id x = x
```

Therefore, in Agda `id A` is the identity on the type `A`, `id (A → A)` is the identity on functions `A → A`, and so on. It turns out that 1) specifying the argument `A` is boring and 2) in most cases Agda can infer it from the context. For these two reasons, Agda allows us to say that some argument is implicit `{A : Set}`, as we demonstrate below.

```agda no-exec id=aa4eaa36-51ec-42e4-b6d3-84944674f034
id : {A : Set} → A → A
id x = x
```

**SPACING:** Agda allows us to be very flexible in the variable names, which can be strings such as `x`, `idλ`, `a→b`, `&&true`, or even arbitrary unicode symbols `💔`, provided there is no space in-between. As a consequence, spaces in Agda have a syntactic meaning as separators, and we need to be very generous with them.

**AUTOCOMPLETION**: While in a code cell, you can enter `→` by writing `->` and pressing TAB, as demonstrated below.

![TAB.gif][nextjournal#file#51139b1d-225c-42e5-bc72-285e2d1ed173]

Similar useful combinations are:

* -> and →
* \\ and λ
* neg and ¬
* top and ⊤
* bot and ⊥
* /\\ and ∧
* \\/ and ∨
* forall and ∀
* exists and ∃
* Pi and Π
* Sigma and Σ

## Exercise

Write a polymorphic function `proj1` that takes two arguments of types `A` and `B`, respectively, and returns the first argument.

```agda id=dff28a84-01a6-473d-8ff8-a56f04ed4a09
proj1 : {A B : Set} → A → B → A
proj1 a b = {! a !}
```

**HOLES**: By placing the cursor around the question mark (**hole**) and pressing SHIFT+TAB, you will get typing information about the hole. This is demonstrated below.

![shift+tab.gif][nextjournal#file#b47ae1ab-084e-4dc8-8c3b-4cfa85594d9f]

# Intuitionistic propositional logic in Agda

## Implication

Intuitionistic implication is implemented as *function space* $A \to B$. This concept has no counterpart in classical logic. The function space operator `→` is an Agda primitive. The idea is that a proof of $A \to B$ is a (terminating) *program* $t : A \to B$ that, given a proof $a : A$ of $A$, always terminates and produces a proof $(t\; a) : B$ of $B$. The $\to$-elimination rule is implemented by *function application*.

```agda id=15df52a0-38cb-4b60-93c8-e3e79b79a40f
apply : {A B : Set} → (A → B) → A → B
apply a→b = λ a → a→b a
```

Equivalent spellings: `apply a→b a = a→b a`, ` apply a→b = a→b`, `apply = id` (why?). The last case shows why we do not need to explicitly use `apply`.

### **Exercise**

Prove in Agda following tautologies of intuitionistic propositional logic:

1. Argument commutativity: $(A \to B \to C) \to B \to A \to C$.
2. Distributivity: $(A \to B \to C) \to (A \to B) \to A \to C$.
3. Diamond $(A \to B) \to (A \to C) \to (B \to C \to D) \to A \to D$.
4. Projection: $A \to A \to A$. How many proof of this fact are there?

Note that the operator "$\to$" is right-associative: For example, the last expression above is parenthesised as $A \to (A \to A)$. We will only write parentheses when they are needed.

Also note that, since intuitionistic implication in general behaves differently from classical implication, the intuitionistic tautologies above hold for reasons which are different from why the same formulas are also classical tautologies (and thus must be reproved in the intuitionistic setting).

```agda id=516b02ec-b760-4d35-ae41-847f10c3810b
→-comm : {A B C : Set} → (A → B → C) → B → A → C
→-comm f b a = ?
```

```agda id=75c90116-9fe0-4cea-b805-c5a8ed33f690
→-distr : {A B C : Set} → (A → B → C) → (A → B) → A → C
→-distr f g x = ?
```

```agda id=b7519928-1787-4aed-8e22-27ec62473521
→-diamond : {A B C D : Set} → (A → B) → (A → C) → (B → C → D) → A → D
→-diamond f g h x = ?
```

```agda id=10504a5d-62ef-409c-8d28-4685d861c12b
→-proj : {A : Set} → A → A → A
→-proj a1 a2 = ?
```

```agda id=91a7ef55-4fae-44eb-8204-6268e6e91202
-- →-comm : {A B C : Set} → (A → B → C) → B → A → C
-- →-comm f b a = f a b

-- →-distr : {A B C : Set} → (A → B → C) → (A → B) → A → C
-- →-distr f g x = f x (g x)

-- →-diamond : {A B C D : Set} → (A → B) → (A → C) → (B → C → D) → A → D
-- →-diamond f g h x = h (f x) (g x)

-- there are two inhabitants of A → A → A
-- →-proj1 →-proj2 : {A : Set} → A → A → A
-- →-proj1 a _ = a
-- →-proj2 _ a = a
```

## Conjunction

In intuitionistic logic, a proof of $A \wedge B$ is a pair $\langle a, b \rangle$, where $a$ is a proof of $A$ and $b$ is a proof of $B$. (From this point of view, intuitionistic conjunction behaves similarly to classical conjunction, because also in classical logic both conjuncts must be provable for their conjunction to be provable.) This intuition translates immediately into the following *product* datatype:

```agda id=fba41ad9-72da-4298-bea8-6d296b8fa54a
data _∧_ (A : Set) (B : Set) : Set where
  _,_ : A → B → A ∧ B
  
-- alternative non-unicode typing
_/\_ = _∧_
```

The datatype `_∧_` is parametrised by two types, `A` and `B`, and it is written `A ∧ B` or, using prefix notation, `_∧_ A B`. It has only one constructor `⟨_,_⟩`, corresponding to the ∧-introduction rule: Given elements `a : A` and `b : B`,  `⟨ a , b ⟩` has type `A ∧ B` (notice the mandatory spaces!). The term above can also be written in prefix notation as `⟨_,_⟩ A B`. We can then define the two projection functions, which correspond to the two ∧-elimination rules:

```agda id=9c733646-89f7-4c9d-8c26-c2df2b808bce
fst : {A B : Set} → A ∧ B → A
fst (a , _) = a

snd : {A B : Set} → A ∧ B → B
snd (_ , b) = b
```

It is sometimes convenient to write longer conjunctions such as `A ∧ B ∧ C`, to which end we need to define that the operator `_∧_` is *right associative*.

```agda id=15101443-7498-4275-aa58-fecf7063ac2b
infixr 2 _∧_
infixr 10 _,_
```

We will also give it a numerical priority, `2` in this case, in order to avoid ambiguity later then introducing more operators.

Once again, `_∧_ ` is not an Agda primitive, but it can be defined with Agda's datatype creation facility.

### **Exercise**

Formalise and prove the following:

1. Curry/uncurry: $A → B → C$ is the same as $A \wedge B → C$.
2. Conjunction is commutative: $A \wedge B$ is the same as $B \wedge A$.
3. Conjunction is associative: $A \wedge B \wedge C$ is the same as $(A \wedge B) \wedge C$.
4. Implication distributes over conjunction: $A \to B \wedge C$ is the same as $(A \to B) \wedge (A \to C)$.

Do the last three properties follow from curry/uncurry?

```agda id=f3043aa2-465a-45aa-9b02-440702fbf506
uncurry : {A B C : Set} → (A → B → C) → A ∧ B → C
uncurry = ?
```

```agda id=a4ac100b-fdee-4477-a90d-b05e885142b6
curry : {A B C : Set} → (A ∧ B → C) → A → B → C
curry = ?
```

```agda id=49ee60ec-b8b2-4b69-9840-10c51be9451f
∧-comm : ?
∧-comm = ?
```

```agda id=e2c3f008-847f-428d-9a90-26e2f02a6bb7
∧-assoc-1 : ?
∧-assoc-1 = ?
```

```agda id=4c521ea7-81bb-4876-af2a-d00325001f5c
∧-assoc-2 : ?
∧-assoc-2 = ?
```

```agda id=0a69904b-8235-4765-b3b0-f5b59a12bd3c
→∧-distr-1 : ?
→∧-distr-1 = ?
```

```agda id=b6d34664-2ca1-424b-9b9e-0c22c3027d20
→∧-distr-2 : ?
→∧-distr-2 = ?
```

```agda id=8adecb3c-de54-412c-a197-e3f6f3c6f003
sol-uncurry : {A B C : Set} → (A → B → C) → A ∧ B → C
sol-uncurry f (a , b) = f a b

sol-curry : {A B C : Set} → (A ∧ B → C) → A → B → C
sol-curry f a b = f (a , b)

-- direct proof
sol-∧-comm : {A B : Set} → A ∧ B → B ∧ A
sol-∧-comm = λ{ (a , b) -> (b , a ) } -- (a , b) = b , a



-- using curry/uncurry
sol-∧-comm' : {A B : Set} → A ∧ B → B ∧ A
sol-∧-comm' = uncurry (λ a b → b , a)

-- direct proof
sol-∧-assoc-1 : {A B C : Set} → A ∧ B ∧ C → (A ∧ B) ∧ C
sol-∧-assoc-1 (a , b , c) = (a , b) , c

sol-∧-assoc-2 : {A B C : Set} → (A ∧ B) ∧ C → A ∧ B ∧ C
sol-∧-assoc-2 ((a , b) , c) = a , b , c

-- using curry/uncurry
-- ∧-assoc-1' : {A B C : Set} → A ∧ B ∧ C → (A ∧ B) ∧ C
-- ∧-assoc-1' {A} {B} {C} = uncurry {A} {B ∧ C} {(A ∧ B) ∧ C} (λ a → uncurry {B} {C} {(A ∧ B) ∧ C} (λ b c → ⟨ ⟨ a , b ⟩ , c ⟩))
-- ∧-assoc-2' : {A B C : Set} → (A ∧ B) ∧ C → A ∧ B ∧ C
-- ∧-assoc-2' {A} {B} {C} = uncurry {A ∧ B} {C} {A ∧ B ∧ C} (uncurry {A} {B} {C → A ∧ B ∧ C} (λ a b c → ⟨ a , ⟨ b , c ⟩ ⟩))

-- direct proofs
-- →∧-distr-1 : {A B C : Set} → (A → B ∧ C) → (A → B) ∧ (A → C)
-- →∧-distr-1 a→b∧c = ⟨ (λ a → fst (a→b∧c a)) , (λ a → snd (a→b∧c a)) ⟩ -- how to avoid the extra parentheses?
-- →∧-distr-2 : {A B C : Set} → (A → B) ∧ (A → C) → A → B ∧ C
-- →∧-distr-2 ⟨ a→b , a→c ⟩ a = ⟨ a→b a , a→c a ⟩

-- using curry/uncurry
-- →∧-distr-2' : {A B C : Set} → (A → B) ∧ (A → C) → A → B ∧ C
-- →∧-distr-2' = uncurry (λ a→b a→c a → ⟨ a→b a , a→c a ⟩)
```

## Disjunction

In intuitionistic logic a proof of a disjunction is a proof of either the first disjunct or of the second. More precisely, a proof of $A_1 \vee A_2$ is a pair $(k, t_k)$, where $k \in \{1, 2\}$ specifies that we are proving $A_k$ and $t_k : A_k$ is a proof thereof. The two options can be implemented with two different constructors, called right and left *injection*.

```agda id=d5ee3dfb-4c41-45b5-b98f-12f1fb464290
data _∨_ (A : Set) (B : Set) : Set where
    left : A → A ∨ B
    right : B → A ∨ B
```

```agda id=c239aac5-f81a-4d06-9809-4144ef52f5cc
case' : {A B C : Set} → (A → C) → (B → C) → A ∨ B → C
case' ff gg (left yy) = {! f !}
case' f g (right xx) = g xx
```

The two constructors `left` and `right` above correspond to the two ∨-introduction rules.

Notice that this is very different from classical logic (where it is "easier" to prove a disjunction), because a classical proof does not need to prove any single disjunct.

We give disjunction lower priority than conjunction so we can omit parenthesis from `(A ∧ B) ∨ C` and write `A ∧ B ∨ C` instead.

```agda id=a5d3accd-28ef-4ef0-8476-bdd227a2d9a6
infixr 1 _∨_ 
```

The ∨-elimination rule is provided by case analysis, which is implemented by performing pattern matching on the constructor.

```agda id=7a56766b-8a89-449c-ac5c-7e57247d56c7
case : {A B C : Set} → (A → C) → (B → C) → A ∨ B → C
case f g (left x) = f x
case f g (right x) = g x
```

### **Exercise**

Formalise and prove the following:

1. Disjunction is commutative: $A \vee B$ is the same as $B \vee A$.
2. Disjunction is associative: $A \vee B \vee C$ is the same as $(A \vee B) \vee C$.
3. $A \vee B \to C$ is the same as $(A \to C) \wedge (B \to C)$.

```agda id=2694f1a9-d612-4b03-bc1d-777ac2e9933e
∨-comm : {A B : Set} → ?
∨-comm = ?
```

```agda id=e4be6f16-8de1-476a-a07b-fb7e0a28f91a
∨-assoc : {A B C : Set} → ?
∨-assoc = ?
```

```agda id=91b27819-5cff-4727-a0f1-84a8db0b7b50
∨∧→-1 : {A B C : Set} → ?
∨∧→-1 = ?
```

```agda id=73f1a54f-f196-4972-900a-7db12da0e5fc
∨∧→-2 : {A B C : Set} → ?
∨∧→-2 = ?
```

```agda id=384ec384-e3ac-4887-b6e0-fd188c62d867
-- ∨-comm : {A B : Set} → A ∨ B → B ∨ A
-- ∨-comm (left a) = right a
-- ∨-comm (right a) = left a

-- ∨-assoc : {A B C : Set} → A ∨ B ∨ C → (A ∨ B) ∨ C
-- ∨-assoc (left a) = left (left a)
-- ∨-assoc (right (left b)) = left (right b)
-- ∨-assoc (right (right c)) = right c

-- ∨∧→-1 : {A B C : Set} → (A ∨ B → C) → (A → C) ∧ (B → C)
-- ∨∧→-1 a∨b→c = ⟨ (λ a → a∨b→c (left a)) , (λ b → a∨b→c (right b)) ⟩

-- ∨∧→-2 : {A B C : Set} → (A → C) ∧ (B → C) → A ∨ B → C
-- ∨∧→-2 ⟨ a→c , _ ⟩ (left a) = a→c a
-- ∨∧→-2 ⟨ _ , b→c ⟩ (right b) = b→c b
```

### **Exercise** (`∧` and `∨`)

Prove the following tautologies:

1. $A \wedge (B \vee C) \leftrightarrow A \wedge B \vee A \wedge C$.
2. $A \vee B \wedge C \leftrightarrow (A \vee B) \wedge (A \vee C)$.

```agda id=95d94ee6-2d18-4e92-ae14-36721f2c05bf
∧∨-distr-1 : {A B C : Set} → A ∧ (B ∨ C) → A ∧ B ∨ A ∧ C
∧∨-distr-1 = ?
```

```agda id=77c87a53-db82-4c61-87ea-8cda4b8e5d44
∧∨-distr-2 : {A B C : Set} → A ∧ B ∨ A ∧ C → A ∧ (B ∨ C)
∧∨-distr-2 = ?
```

```agda id=91306a94-695c-4aeb-8bed-b94bb47d22a5
∨∧-distr-1 : {A B C : Set} → A ∨ B ∧ C → (A ∨ B) ∧ (A ∨ C)
∨∧-distr-1 = ?
```

```agda id=62e3858d-664f-4f95-81dc-f5b418aa96ec
∨∧-distr-2 : {A B C : Set} → (A ∨ B) ∧ (A ∨ C) → A ∨ B ∧ C
∨∧-distr-2 = ?
```

```agda id=48abb887-f228-4b38-9890-91882017eb8f
-- ∧∨-distr-1 : {A B C : Set} → A ∧ (B ∨ C) → A ∧ B ∨ A ∧ C
-- ∧∨-distr-1 ⟨ a , left b ⟩ = left ⟨ a , b ⟩
-- ∧∨-distr-1 ⟨ a , right c ⟩ = right ⟨ a , c ⟩

-- ∧∨-distr-2 : {A B C : Set} → A ∧ B ∨ A ∧ C → A ∧ (B ∨ C)
-- ∧∨-distr-2 (left ⟨ a , b ⟩) = ⟨ a , left b ⟩
-- ∧∨-distr-2 (right ⟨ a , c ⟩) = ⟨ a , right c ⟩

-- ∨∧-distr-1 : {A B C : Set} → A ∨ B ∧ C → (A ∨ B) ∧ (A ∨ C)
-- ∨∧-distr-1 (left a) = ⟨ left a , left a ⟩
-- ∨∧-distr-1 (right ⟨ b , c ⟩) = ⟨ right b , right c ⟩

-- ∨∧-distr-2 : {A B C : Set} → (A ∨ B) ∧ (A ∨ C) → A ∨ B ∧ C
-- ∨∧-distr-2 ⟨ left a , _ ⟩ = left a
-- ∨∧-distr-2 ⟨ _ , left a ⟩ = left a
-- ∨∧-distr-2 ⟨ right b , right c ⟩ = right ⟨ b , c ⟩
```

## Truth values

The two truth values `⊤` and `⊥` are implemented via Agda's data type mechanism. Notice that neither `⊤` nor `⊥` are Agda primitives. However, Agda's datatype creation facilities allow us to define those datatypes in such a way that they behave as we expect.

### True: `⊤`

The type `⊤` has precisely one inhabitant, called `tt` (its only constructor).

```agda id=e1037592-39df-4db8-977d-635b8010200a
data ⊤ : Set where
  tt : ⊤
```

The ⊤-introduction rule says that we can prove that anything implies `⊤`.

```agda id=b2c08f5a-b717-4e83-b7ee-88269072a575
A→⊤ : {A : Set} → A → ⊤
A→⊤ _ = tt
```

There is no ⊤-elimination rule.

### False: `⊥`

The type `⊥` has dual property to `⊤`. The type `⊥` has no inhabitants at all, and thus we do not provide any constructor in its definition.

```agda id=6668be49-22f3-4ada-8db4-02912417067d
data ⊥ : Set where
```

The ⊥-elimination says that anything can be proved from `⊥`. The absurd pattern `()` below is how we tell Agda that there cannot be any argument to `⊥-elim`, and thus it says that no defining equation is needed.

```agda id=e780d7fe-43cb-40a8-87d8-9fc174a85b5d
⊥-elim : {A : Set} → ⊥ → A
⊥-elim ()
```

There is no ⊥-introduction rule. This makes the world a better place (why?).

## Negation

Negation is not a primitive in intuitionistic logic. In intuitionistic logic $\neg A$ means that, if we had a proof of $A$, then we could derive a contradiction $\bot$: $\neg A \;\equiv\; A \to \bot$. And this is how negation is defined in Agda.

```agda id=06986a37-d2c2-4fe4-a0d4-9ac4a60ed97c
¬_ : Set → Set
¬ A = A → ⊥
```

Thus, `¬ A` is a shorthand for (i.e., evaluates to) `A → ⊥`. Notice that for the first time we are defining a function that maps types to types, i.e., a so called *type-level function*. This is made possible by the fact that in a dependently typed language types are first-class citizens and can be manipulated as any other data.

We give negation higher priority than `∧` and `∨`, so we can just write `¬ A ∧ B` instead of \`(¬ A) ∧ B.

```agda id=aa034178-9832-407f-8272-471de928869c
infix 3 ¬_
```

### **Exercise** (`¬¬`)

The logic of Agda is intuitionistic. In particular, in Agda the following double negation law does *not* hold: $A \leftrightarrow \neg \neg A$. Which one of the two directions holds in intuitionistic logic?

* Formalise this and prove it in Agda.
* Does the proof (i.e., program) resemble something we have already seen?

*Hint:* The type $\neg \neg A$ expands to $(A \to \bot) \to \bot$.

```agda id=f8b05a91-59fd-46b1-aea3-885fe174f5ab
-- recall that ¬ ¬ A = (A → ⊥) → ⊥

¬¬-intro : {A : Set} → A → ¬ ¬ A
¬¬-intro x f = ?

-- the occurrence of "?" above is called a hole;
-- Agda will compile and remind us that there are open goals corresponding to holes to be solved
```

```agda id=f329d982-5e94-4644-bd3d-8f536f204fe2
-- Only the left-to-right direction holds

-- this is "apply" with the arguments swapped
-- ¬¬-intro : {A : Set} → A → ¬ ¬ A
-- ¬¬-intro x f = f x
```

### **Exercise** (`¬ B → ¬ A`)

The *contrapositive* of an implication $A \to B$ is $\neg B \to \neg A$. In classical logic an implication and its contrapositive are logically equivalent, i.e., the following is a tautology: $(A \to B) \leftrightarrow (\neg B \to \neg A)$. Use Agda to prove which, if any, of the two directions above holds in intuitionistic logic.

```agda id=e688b027-e8c8-4e47-be76-01426219f64e
contrapositive : ?
contrapositive = ?
```

```agda id=22a237db-9962-4251-9788-dc1d4437eb26
-- contrapositive : {A B : Set} → (A → B) → ¬ B → ¬ A
-- contrapositive a→b ¬b a = ¬b (a→b a)
```

### **Exercise**  (De Morgan laws)

Are the following laws valid in intuitionistic logic? If so, write a proof in Agda. \\begin{align} (1) \\qquad \\neg (A \\vee B) \\leftrightarrow \\neg A \\wedge \\neg B. \\ (2) \\qquad \\neg A \\vee \\neg B \\to \\neg (A \\wedge B). \\ (3) \\qquad \\neg (A \\wedge B) \\to \\neg A \\vee \\neg B. \\end{align}

```agda id=4c8ce260-2768-48eb-b18f-5e045e790ac3
de_morgan1-1 : {A B : Set} → ¬ (A ∨ B) → ¬ A ∧ ¬ B
de_morgan1-1 = ?
```

```agda id=9a0e3710-3194-421e-96ad-f70c046906ce
de_morgan1-2 : {A B : Set} → ¬ A ∧ ¬ B → ¬ (A ∨ B)
de_morgan1-2 = ?
```

```agda id=25d5e0bf-268d-46b8-a33f-7c1f6996f6f1
de_morgan2 : {A B : Set} → ¬ A ∨ ¬ B → ¬ (A ∧ B)
de_morgan2 = ?
```

```agda id=6f337a7e-fd3a-48f1-b6e2-f8550101a477
de_morgan3 : {A B : Set} → ¬ (A ∧ B) → ¬ A ∨ ¬ B
de_morgan3 = ?
```

```agda id=7947f79a-1d08-4fec-a968-17b45bdee974
sol-de_morgan1-1 : {A B : Set} → ¬ (A ∨ B) → ¬ A ∧ ¬ B
sol-de_morgan1-1 {A} {B} f = ⟨ ¬a , ¬b ⟩
    where
        ¬a : ¬ A
        ¬a a = f (left a)
        ¬b : ¬ B
        ¬b b = f (right b)

sol-de_morgan1-2 : {A B : Set} → ¬ A ∧ ¬ B → ¬ (A ∨ B)
sol-de_morgan1-2 ⟨ ¬a , _ ⟩ (left a) = ¬a a
sol-de_morgan1-2 ⟨ _ , ¬b ⟩ (right b) = ¬b b

sol-de_morgan2 sol-de_morgan2' : {A B : Set} → ¬ A ∨ ¬ B → ¬ (A ∧ B)
sol-de_morgan2 (left ¬a) ( a , _ ) = ¬a a
sol-de_morgan2 (right ¬b) ( _ , b ) = ¬b b

-- using case, we can write it more compactly (?)
sol-de_morgan2' ¬a∨¬b (a , b ) = case (\ ¬a → ¬a a) (\ ¬b → ¬b b) ¬a∨¬b

-- does not hold!
-- de_morgan3 : {A B : Set} → ¬ (A ∧ B) → ¬ A ∨ ¬ B
```

### **Exercise** (`¬ A ∨ B`)

In classical logic, $A \to B$ is defined to be $\neg A \vee B$. Which of the following two directions  $(A \to B) \leftrightarrow (\neg A \vee B)$ hold in intuitionistic logic? Prove it in Agda

```agda id=f589ae59-4842-44c9-9c58-d68bbd212b5f
-- state and prove the right direction here
```

```agda id=2c1ade1b-b2c9-4194-a9ba-a3691404ac36
classical→ : {A B : Set} → ¬ A ∨ B → A → B
classical→ (left ¬a) a = ⊥-elim (¬a a)
classical→ (right b) _ = b

-- the other direction does not hold,
-- since given f : A → B we do not know whether to produce a ¬ A or a B.
```

# Challenges

## **Exercise** (Triple negation)

While $\neg \neg A \to A$ does not hold in intuitionistic logic, prove that the following *triple negation* law holds

$$
\neg \neg \neg A \to \neg A.
$$
*Hint:* Expand the definition of "$\neg$". You should get a function of two arguments and output $\bot$.

```agda id=80a92cc1-5d77-4d29-8e65-afba8733eb2e
¬¬¬-rule : {A : Set} → ¬ ¬ ¬ A → ¬ A
¬¬¬-rule = ?
```

```agda id=b279aed0-c0aa-4490-92c9-fd706b1988bb
-- ¬ ¬ ¬ A = ((A → ⊥) → ⊥) → ⊥
-- ¬ A = A → ⊥

--¬¬¬-rule ¬¬¬-rule' : {A : Set} → ¬ ¬ ¬ A → ¬ A
--¬¬¬-rule f x = f (λ g → g x)

-- alternative writing with "where" clause
--¬¬¬-rule' {A} f x = f y
--    where
--        y : ¬ ¬ A
--        y g = g x
```

## **Exercise** (Irrefutability)

Show that the following classical tautologies $P$ are intuitionistically *irrefutable*, in the sense that $\neg \neg P$ is an intuitionistic tautology:

1. Law of excluded middle: $\neg \neg (A \vee \neg A)$. *Hint: Expand the definition of* $\neg$*. You will need: `left`, `right`, and* $\lambda$*-abstraction.*
2. Implication as disjunction: $\neg \neg ((A \to B) \to \neg A \vee B)$.
3. De Morgan: $\neg \neg (\neg (A \wedge B) \to \neg A \vee \neg B)$.

```agda id=3bd82f7c-5660-4a48-8089-db8c868408be
excluded-middle-irref : ?
excluded-middle-irref = ?
```

```agda id=c0998b98-d82e-4256-840a-751a795f8df3
impl-irref : ?
impl-irref = ?
```

```agda id=d0ae0f2a-12a5-436d-889f-1a7f28c93904
deMorgan-irref : ?
deMorgan-irref = ?
```

```agda id=06ef9b10-e08c-47f9-a60f-552ac3946dcf
-- ¬ ¬ (A ∨ ¬ A) = ((A ∨ (A → ⊥)) → ⊥) → ⊥ 
sol-excluded-middle-irref : {A : Set} → ¬ ¬ (A ∨ ¬ A)
sol-excluded-middle-irref {A} = λ (f : (A ∨ (A → ⊥)) → ⊥) → f (right (λ (a : A) → f (left a)))

-- ¬ ¬ (¬ ¬ A → A) = ((((A → ⊥) → ⊥) → A) → ⊥) → ⊥
sol-double-negation-irref : {A : Set} → ¬ ¬ (¬ ¬ A → A)
sol-double-negation-irref {A} = ?

-- peirce-irref : {A B : Set} → ¬ ¬ (((A → B) → A) → A)
-- peirce-irref = ?

-- ¬ ¬ ((A → B) → ¬ A ∨ B) = (((A → B) → ¬ A ∨ B) → ⊥) → ⊥
sol-impl-irref : {A B : Set} → ¬ ¬ ((A → B) → ¬ A ∨ B)
sol-impl-irref {A} {B} =  λ (f : ((A → B) → ¬ A ∨ B) → ⊥) → f (λ (g : A → B) → left (λ (a : A) → f (λ (g : A → B) → right (g a))))

-- ¬ ¬ (¬ (A ∧ B) → ¬ A ∨ ¬ B) = ((¬ (A ∧ B) → ¬ A ∨ ¬ B) → ⊥) → ⊥
sol-deMorgan-irref : {A B : Set} → ¬ ¬ (¬ (A ∧ B) → ¬ A ∨ ¬ B)
sol-deMorgan-irref {A} {B} = λ (f : (¬ (A ∧ B) → ¬ A ∨ ¬ B) → ⊥) → f (λ (g1 : ¬ (A ∧ B)) → left (λ (a : A) → f (λ (g2 : ¬ (A ∧ B)) → right (λ (b : B) → g1 ⟨ a , b ⟩)))) -- or g2
```

## **Exercise** (Weak Peirce's law)

Prove the following weakening of Peirce's law: $((((A \to B) \to A) \to A) \to B) \to B$.

```agda id=bf3158f0-548b-4b01-8e59-64cbf1c19a5f
wp : {A B : Set} → ((((A → B) → A) → A) → B) → B
wp = ?
```

```agda id=0a567b90-1c08-4d42-b86e-62551cbbe066
-- wp {A} {B} = λ f → f (λ (g : (A → B) → A) → g (λ (a : A) → f (\ _ → a )))
```

## **Exercise**

In the previous exercises we have seen that the following principles are not intuitionistic tautologies:

1. Law of excluded middle: $A \vee \neg A$.
2. Elimination of double negation: $\neg \neg A \to A$.
3. Implication as disjunction: $(A \to B) \to \neg A \vee B$.
4. The Negated De Morgan's law: $\neg (\neg A \wedge \neg B) \to A \vee B$.
5. Peirce's Law: $((A \to B) \to A) \to A$.

Show that all principles above are logically equivalent in intuitionistic logic. Each propositional variable $A, B$ is universally quantified in each principle.

*Hint:* Prove the following sequence of implications:

* $1 \to 2$.
* $2 \to 3$: Use irrefutability of $(A → B) \to \neg A \vee B$, proved earlier: $\neg \neg ((A \to B) \to \neg A \vee B)$.
* $3 \to 1$.
* $1 \to 4$: Use the excluded middle for $A$ and for $B$.
* $4 \to 1$: Use $\neg (\neg A \wedge \neg B) \to A \vee B$ with $B \equiv \neg A$.
* $1 \to 5$.
* $5 \to 1$: Use Peirce's law $((A' \to B') \to A') \to A'$ with $A' \equiv A \vee \neg A$ and $B' \equiv \bot.$

```agda id=80db43db-2792-4a0d-bc9d-5a694e5a7e7f
1→2 : ?
1→2 = ?
```

```agda id=af34c896-ebfd-4d3e-986c-c9d367822160
2→3 : ?
2→3 = ?
```

```agda id=3d6af4ca-81f4-4d7b-975b-045ef708406c
3→1 : ?
3→1 = ?
```

```agda id=da8b3100-33fb-4180-a128-e4d0e5f6f39a
1→4 : ?
1→4 = ?
```

```agda id=1c43de3c-2a2b-4033-91ed-79c551a60946
4→1 : ?
4→1 = ?
```

```agda id=8ac1a3eb-34f5-4414-a121-112625c793f4
1→5 : ?
1→5 = ?
```

```agda id=abd3e4ca-fc77-4269-a3ca-8901b7a4d636
5→1 : ?
5→1 = ?
```

```agda id=a9491576-f775-4ec0-a3d3-491108dceedf
_·_ : {A B C : Set} → (f : A → B) → (g : B → C) → A → C
f · g = λ a → g (f a)

-- 1
-- excluded-middle : {A : Set} → Set
-- excluded-middle {A} = A ∨ ¬ A

-- 2
-- double-negation : {A : Set} → Set
-- double-negation {A} = ¬ ¬ A → A

-- 3
-- impl : {A B : Set} → Set
-- impl {A} {B} = (A → B) → ¬ A ∨ B

-- 4
-- negatedDeMorgan : {A B : Set} → Set
-- negatedDeMorgan {A} {B} = ¬ (¬ A ∧ ¬ B) → A ∨ B

-- 4' (weaker principle)
-- deMorgan : {A B : Set} → Set
-- deMorgan {A} {B} = ¬ (A ∧ B) → ¬ A ∨ ¬ B

-- 5
-- peirce : {A B : Set} → Set
-- peirce {A} {B} = ((A → B) → A) → A

-- this direction holds even pointwise
-- 1→2 : {A : Set} → excluded-middle {A} → double-negation {A}
-- 1→2 (left a) _ = a
-- 1→2 (right a→⊥) a→⊥→⊥ = ⊥-elim (a→⊥→⊥ a→⊥)

-- 1→5 : {A B : Set} → excluded-middle {A} → peirce {A} {B}
-- 1→5 {A} {B} (left a) = λ _ → a
-- 1→5 {A} {B} (right ¬a) =  λ (f : (A → B) → A) → f (λ (a : A) → ⊥-elim (¬a a))

-- 1→3 : {A B : Set} → excluded-middle {A} → impl {A} {B}
-- 1→3 (left a) a→b = right (a→b a)
-- 1→3 (right ¬a) _ = left ¬a

-- 1→4' : {A B : Set} → excluded-middle {A} → excluded-middle {B} → deMorgan {A} {B}
-- 1→4' (left a) (left b) ¬[a∧b] = ⊥-elim (¬[a∧b] ⟨ a , b ⟩)
-- 1→4' (right ¬a) _ _ = left ¬a
-- 1→4' _ (right ¬b) _ = right ¬b

-- negatedDeMorgan: ¬ (¬ A ∧ ¬ B) → A ∨ B
-- 1→4 : {A B : Set} → excluded-middle {A} → excluded-middle {B} → negatedDeMorgan {A} {B}
-- 1→4 (left a) _ _ = left a
-- 1→4 _ (left b) _ = right b
-- 1→4 (right ¬a) (right ¬b) f = ⊥-elim (f ⟨ ¬a , ¬b ⟩)

-- we previously proved irrefutability of the law of exluded middle:
-- 2→1 : {A : Set} → double-negation {excluded-middle {A}} → excluded-middle {A}
-- 2→1 f = f excluded-middle-irref

-- we previously proved irrefutability of impl
-- 2→3 : {A B : Set} → double-negation {impl {A} {B}} → impl {A} {B}
-- 2→3 f = f impl-irref

-- 2→4' : {A B : Set} → double-negation {deMorgan {A} {B}} → deMorgan {A} {B}
-- 2→4' f = f deMorgan-irref

-- 2→5 : {A B : Set} → double-negation {A} → peirce {A} {B}
-- 2→5 = ?

-- ((A ∨ ¬ A → ⊥) → A ∨ ¬ A) → A ∨ ¬ A
-- 5→1 : {A : Set} → peirce {A ∨ ¬ A} {⊥} → excluded-middle {A}
-- 5→1 {A} = λ (f : ((A ∨ ¬ A → ⊥) → A ∨ ¬ A) → A ∨ ¬ A) → f (λ (g : A ∨ ¬ A → ⊥) → right (λ a → g (left a)))

-- 5→2 : {A : Set} → peirce {?} {?} → double-negation {A}
-- 5→2 = ?

-- ((A → B) → A) → A
-- (A → B) → ¬ A ∨ B
-- 5→3 : {A B : Set} → peirce {?} {?} → impl {A} {B}
-- 5→3 p a→b = ?

-- 5→4 : {A B : Set} → peirce {?} {?} → deMorgan {A} {B}
-- 5→4 = ?

-- impl = (A → B) → ¬ A ∨ B
-- 3→1 : {A : Set} → impl {A} {A} → excluded-middle {A}
-- 3→1 f = ∨-comm (f (λ a → a))

-- 3→2 : {A : Set} → impl {A} {A} → double-negation {A}
-- 3→2 = 3→1 · 1→2

-- 3→5 : {A B : Set} → impl {A} {B} → peirce {A} {B}
-- 3→5 = ?

-- impl: (A → ¬ B) → ¬ A ∨ ¬ B
-- deMorgan: ¬ (A ∧ B) → ¬ A ∨ ¬ B
-- 3→4' : {A B : Set} → impl {A} {¬ B} → deMorgan {A} {B}
-- 3→4' f ¬a∧b = f (curry ¬a∧b)

-- stronger proof than the above

-- impl: (A → A) → ¬ A ∨ B
-- negatedDeMorgan: ¬ (¬ A ∧ ¬ B) → A ∨ B
-- 3→4 : {A B : Set}→ impl {A} {A} → impl {B} {B} → negatedDeMorgan {A} {B}
-- 3→4 f g = 1→4 (3→1 f) (3→1 g)

-- p : {A : Set} → ¬ (A ∧ ¬ A)
-- p ⟨ a , ¬a ⟩ = ⊥-elim (¬a a)

-- negatedDeMorgan: ¬ (¬ A ∧ ¬ B) → A ∨ B
-- excluded-middle: A ∨ ¬ A
-- 4→1 : {A : Set} → negatedDeMorgan {A} {¬ A} → excluded-middle {A}
-- 4→1 f = f p

-- negatedDeMorgan: ¬ (¬ A ∧ ¬ B) → A ∨ B
-- 4→5 : {A B : Set} → negatedDeMorgan {A} {B} → peirce {A} {B}
-- 4→5 = ?
```

## **Exercise**

Show that the following two principles are intuitionistically equivalent:

1. De Morgan's Law: $\neg (A \wedge B) \to \neg A \vee \neg B$.
2. The *weak principle of excluded middle*: $\neg A \vee \neg \neg A$. This is interesting, because the weak principle of excluded middle is strictly weaker than the principle of excluded middle, but it is still not an intuitionistic tautology.

```agda id=4a7649e0-f404-4c2c-ad4b-9223c83995f8
deMorgan : {A B : Set} → Set
deMorgan {A} {B} = ¬ (A ∧ B) → ¬ A ∨ ¬ B

weak-excluded-middle : {A : Set} → Set
weak-excluded-middle {A} = ¬ A ∨ ¬ ¬ A

-- TODO state and prove the equivalence above
```

```agda id=c94a3ff4-140f-48cf-8a9e-de3bec688b31
-- solution
p : {A : Set} → ¬ (A ∧ ¬ A)
p ⟨ a , ¬a ⟩ = ⊥-elim (¬a a)

deMorgan→weak-excluded-middle : {A : Set} → deMorgan {A} {¬ A} → weak-excluded-middle {A}
deMorgan→weak-excluded-middle f = f p

¬¬∧ : {A B : Set} → ¬ ¬ A → ¬ ¬ B → ¬ ¬ (A ∧ B)
¬¬∧ ¬¬a ¬¬b ¬[a∧b] = ¬¬b (λ b → ¬¬a (λ a → ¬[a∧b] ⟨ a , b ⟩))

weak-excluded-middle→deMorgan : {A B : Set} → weak-excluded-middle {A} → weak-excluded-middle {B} → deMorgan {A} {B}
weak-excluded-middle→deMorgan (left ¬a) _ _ = left ¬a
weak-excluded-middle→deMorgan _ (left ¬b) _ = right ¬b
weak-excluded-middle→deMorgan (right ¬¬a) (right ¬¬b) ¬[a∧b] = ⊥-elim (¬¬∧ ¬¬a ¬¬b ¬[a∧b])
```

[nextjournal#file#51139b1d-225c-42e5-bc72-285e2d1ed173]:
<https://nextjournal.com/data/QmYVbesYVVMSjNfQREx7i7ETJKzyDdWFJBZizm6nSy2BhR?content-type=image/gif&node-id=51139b1d-225c-42e5-bc72-285e2d1ed173&filename=TAB.gif&node-kind=file>

[nextjournal#file#b47ae1ab-084e-4dc8-8c3b-4cfa85594d9f]:
<https://nextjournal.com/data/QmchSKxjAYdHiLA9q8JAXn8NNwx2JbLr5B8GwXTb5895NR?content-type=image/gif&node-id=b47ae1ab-084e-4dc8-8c3b-4cfa85594d9f&filename=shift%2Btab.gif&node-kind=file>

<details id="com.nextjournal.article">
<summary>This notebook was exported from <a href="https://nextjournal.com/a/MMHJBaDZzDjDVxxctWfxu?change-id=CnFHaaY6Ec3vbNga9MNc6V">https://nextjournal.com/a/MMHJBaDZzDjDVxxctWfxu?change-id=CnFHaaY6Ec3vbNga9MNc6V</a></summary>

```edn nextjournal-metadata
{:article
 {:settings {:numbered? true},
  :nodes
  {"06986a37-d2c2-4fe4-a0d4-9ac4a60ed97c"
   {:compute-ref #uuid "d055a6d4-3745-464b-92ca-ba4638f6d882",
    :exec-duration 542,
    :id "06986a37-d2c2-4fe4-a0d4-9ac4a60ed97c",
    :kind "code",
    :output-log-lines {:stdout 40},
    :runtime [:runtime "5c88ad99-bb88-42a3-90b6-5422664d8a7c"]},
   "06ef9b10-e08c-47f9-a60f-552ac3946dcf"
   {:compute-ref #uuid "75fcf553-b817-49f7-bffd-2373b2f10190",
    :exec-duration 743,
    :id "06ef9b10-e08c-47f9-a60f-552ac3946dcf",
    :kind "code",
    :output-log-lines {:stdout 58},
    :runtime [:runtime "5c88ad99-bb88-42a3-90b6-5422664d8a7c"]},
   "0a567b90-1c08-4d42-b86e-62551cbbe066"
   {:compute-ref #uuid "1b756cfd-5714-458b-91a8-309f8cbfaa59",
    :exec-duration 610,
    :id "0a567b90-1c08-4d42-b86e-62551cbbe066",
    :kind "code",
    :output-log-lines {:stdout 59},
    :runtime [:runtime "5c88ad99-bb88-42a3-90b6-5422664d8a7c"]},
   "0a69904b-8235-4765-b3b0-f5b59a12bd3c"
   {:compute-ref #uuid "c042b55f-fbba-4ce2-86fb-4a2061235e32",
    :exec-duration 522,
    :id "0a69904b-8235-4765-b3b0-f5b59a12bd3c",
    :kind "code",
    :output-log-lines {:stdout 20},
    :runtime [:runtime "5c88ad99-bb88-42a3-90b6-5422664d8a7c"]},
   "10504a5d-62ef-409c-8d28-4685d861c12b"
   {:compute-ref #uuid "a3cda394-ce4b-425d-9afc-8630c52ce54d",
    :exec-duration 391,
    :id "10504a5d-62ef-409c-8d28-4685d861c12b",
    :kind "code",
    :output-log-lines {:stdout 6},
    :runtime [:runtime "5c88ad99-bb88-42a3-90b6-5422664d8a7c"]},
   "15101443-7498-4275-aa58-fecf7063ac2b"
   {:compute-ref #uuid "239c2f3b-a537-43b4-8377-f87ebade0ab7",
    :exec-duration 606,
    :id "15101443-7498-4275-aa58-fecf7063ac2b",
    :kind "code",
    :output-log-lines {:stdout 6},
    :runtime [:runtime "5c88ad99-bb88-42a3-90b6-5422664d8a7c"]},
   "15df52a0-38cb-4b60-93c8-e3e79b79a40f"
   {:compute-ref #uuid "397b1e41-5438-4dc8-9d57-71fda0fe1791",
    :exec-duration 522,
    :id "15df52a0-38cb-4b60-93c8-e3e79b79a40f",
    :kind "code",
    :output-log-lines {:stdout 2},
    :runtime [:runtime "5c88ad99-bb88-42a3-90b6-5422664d8a7c"]},
   "1c43de3c-2a2b-4033-91ed-79c551a60946"
   {:compute-ref #uuid "44a867d8-20bc-42f5-be6b-34fa0aa1eb60",
    :exec-duration 649,
    :id "1c43de3c-2a2b-4033-91ed-79c551a60946",
    :kind "code",
    :output-log-lines {:stdout 74},
    :runtime [:runtime "5c88ad99-bb88-42a3-90b6-5422664d8a7c"]},
   "22a237db-9962-4251-9788-dc1d4437eb26"
   {:compute-ref #uuid "14733b1a-8919-4396-8ad4-a3b1c1af719c",
    :exec-duration 541,
    :id "22a237db-9962-4251-9788-dc1d4437eb26",
    :kind "code",
    :output-log-lines {:stdout 44},
    :runtime [:runtime "5c88ad99-bb88-42a3-90b6-5422664d8a7c"]},
   "25d5e0bf-268d-46b8-a33f-7c1f6996f6f1"
   {:compute-ref #uuid "613ab76f-b01b-4e1c-ab94-36bfa114931b",
    :exec-duration 576,
    :id "25d5e0bf-268d-46b8-a33f-7c1f6996f6f1",
    :kind "code",
    :output-log-lines {:stdout 47},
    :runtime [:runtime "5c88ad99-bb88-42a3-90b6-5422664d8a7c"]},
   "2694f1a9-d612-4b03-bc1d-777ac2e9933e"
   {:compute-ref #uuid "85a1c8b0-4402-48a0-b909-536522faf13e",
    :exec-duration 535,
    :id "2694f1a9-d612-4b03-bc1d-777ac2e9933e",
    :kind "code",
    :output-log-lines {:stdout 27},
    :runtime [:runtime "5c88ad99-bb88-42a3-90b6-5422664d8a7c"]},
   "2c1ade1b-b2c9-4194-a9ba-a3691404ac36"
   {:compute-ref #uuid "7b3a4711-74e1-4ec2-a7bc-9cc1973122cc",
    :exec-duration 686,
    :id "2c1ade1b-b2c9-4194-a9ba-a3691404ac36",
    :kind "code",
    :output-log-lines {:stdout 47},
    :runtime [:runtime "5c88ad99-bb88-42a3-90b6-5422664d8a7c"]},
   "384ec384-e3ac-4887-b6e0-fd188c62d867"
   {:compute-ref #uuid "29912202-dae9-4fb4-840d-66fd512e7e2c",
    :exec-duration 547,
    :id "384ec384-e3ac-4887-b6e0-fd188c62d867",
    :kind "code",
    :output-log-lines {:stdout 36},
    :runtime [:runtime "5c88ad99-bb88-42a3-90b6-5422664d8a7c"]},
   "3bd82f7c-5660-4a48-8089-db8c868408be"
   {:compute-ref #uuid "7a26ad21-f0ff-4725-bb72-b0375be90f11",
    :exec-duration 585,
    :id "3bd82f7c-5660-4a48-8089-db8c868408be",
    :kind "code",
    :output-log-lines {:stdout 51},
    :runtime [:runtime "5c88ad99-bb88-42a3-90b6-5422664d8a7c"]},
   "3d6af4ca-81f4-4d7b-975b-045ef708406c"
   {:compute-ref #uuid "83ff8573-a7b9-4c61-9a4f-a0277237013f",
    :exec-duration 624,
    :id "3d6af4ca-81f4-4d7b-975b-045ef708406c",
    :kind "code",
    :output-log-lines {:stdout 68},
    :runtime [:runtime "5c88ad99-bb88-42a3-90b6-5422664d8a7c"]},
   "48abb887-f228-4b38-9890-91882017eb8f"
   {:compute-ref #uuid "5de35348-127c-4b85-b40d-c54be8ef6095",
    :exec-duration 555,
    :id "48abb887-f228-4b38-9890-91882017eb8f",
    :kind "code",
    :output-log-lines {:stdout 40},
    :runtime [:runtime "5c88ad99-bb88-42a3-90b6-5422664d8a7c"]},
   "49ee60ec-b8b2-4b69-9840-10c51be9451f"
   {:compute-ref #uuid "3b16ceb4-61d6-4c25-82e5-333d0bf74579",
    :exec-duration 431,
    :id "49ee60ec-b8b2-4b69-9840-10c51be9451f",
    :kind "code",
    :output-log-lines {:stdout 11},
    :runtime [:runtime "5c88ad99-bb88-42a3-90b6-5422664d8a7c"]},
   "4a7649e0-f404-4c2c-ad4b-9223c83995f8"
   {:compute-ref #uuid "b89b25d3-ec5c-45f8-b888-860c8f990263",
    :exec-duration 670,
    :id "4a7649e0-f404-4c2c-ad4b-9223c83995f8",
    :kind "code",
    :output-log-lines {:stdout 80},
    :runtime [:runtime "5c88ad99-bb88-42a3-90b6-5422664d8a7c"]},
   "4c521ea7-81bb-4876-af2a-d00325001f5c"
   {:compute-ref #uuid "ef3fec49-f738-4248-9b14-5e9f4ad197e6",
    :exec-duration 428,
    :id "4c521ea7-81bb-4876-af2a-d00325001f5c",
    :kind "code",
    :output-log-lines {:stdout 17},
    :runtime [:runtime "5c88ad99-bb88-42a3-90b6-5422664d8a7c"]},
   "4c8ce260-2768-48eb-b18f-5e045e790ac3"
   {:compute-ref #uuid "3e096eb3-b05c-4b5b-bce2-14b587ada8d3",
    :exec-duration 719,
    :id "4c8ce260-2768-48eb-b18f-5e045e790ac3",
    :kind "code",
    :output-log-lines {:stdout 45},
    :runtime [:runtime "5c88ad99-bb88-42a3-90b6-5422664d8a7c"]},
   "51139b1d-225c-42e5-bc72-285e2d1ed173"
   {:id "51139b1d-225c-42e5-bc72-285e2d1ed173", :kind "file"},
   "516b02ec-b760-4d35-ae41-847f10c3810b"
   {:compute-ref #uuid "2708a72d-3013-4ac6-9530-b9eeb48a1b73",
    :exec-duration 455,
    :id "516b02ec-b760-4d35-ae41-847f10c3810b",
    :kind "code",
    :output-log-lines {:stdout 3},
    :runtime [:runtime "5c88ad99-bb88-42a3-90b6-5422664d8a7c"]},
   "5c88ad99-bb88-42a3-90b6-5422664d8a7c"
   {:environment
    [:environment
     {:article/nextjournal.id
      #uuid "02b5e9b4-9ab0-4adb-9164-9a36ba7b17a1",
      :change/nextjournal.id
      #uuid "5dea6ba0-ab98-4a7d-9d55-1b781c48c8d0",
      :node/id "3159bc83-58eb-4c79-8f37-f0429767a98a"}],
    :id "5c88ad99-bb88-42a3-90b6-5422664d8a7c",
    :kind "runtime",
    :language "agda",
    :type :jupyter},
   "62e3858d-664f-4f95-81dc-f5b418aa96ec"
   {:compute-ref #uuid "8e3978ba-d94d-4d00-8461-bc7df00c0f9e",
    :exec-duration 558,
    :id "62e3858d-664f-4f95-81dc-f5b418aa96ec",
    :kind "code",
    :output-log-lines {:stdout 40},
    :runtime [:runtime "5c88ad99-bb88-42a3-90b6-5422664d8a7c"]},
   "6668be49-22f3-4ada-8db4-02912417067d"
   {:compute-ref #uuid "765f81ac-a573-4a67-baa8-3f0b74f3b6c4",
    :exec-duration 579,
    :id "6668be49-22f3-4ada-8db4-02912417067d",
    :kind "code",
    :output-log-lines {:stdout 40},
    :runtime [:runtime "5c88ad99-bb88-42a3-90b6-5422664d8a7c"]},
   "6f337a7e-fd3a-48f1-b6e2-f8550101a477"
   {:compute-ref #uuid "1a088f05-c49e-4b51-a614-f532e8fd893c",
    :exec-duration 590,
    :id "6f337a7e-fd3a-48f1-b6e2-f8550101a477",
    :kind "code",
    :output-log-lines {:stdout 48},
    :runtime [:runtime "5c88ad99-bb88-42a3-90b6-5422664d8a7c"]},
   "73f1a54f-f196-4972-900a-7db12da0e5fc"
   {:compute-ref #uuid "119b303c-28ac-44e6-8929-b80dc0308512",
    :exec-duration 642,
    :id "73f1a54f-f196-4972-900a-7db12da0e5fc",
    :kind "code",
    :output-log-lines {:stdout 36},
    :runtime [:runtime "5c88ad99-bb88-42a3-90b6-5422664d8a7c"]},
   "75c90116-9fe0-4cea-b805-c5a8ed33f690"
   {:compute-ref #uuid "e06ee657-d0f8-408f-a604-a3a3e2ad2114",
    :exec-duration 457,
    :id "75c90116-9fe0-4cea-b805-c5a8ed33f690",
    :kind "code",
    :output-log-lines {:stdout 4},
    :runtime [:runtime "5c88ad99-bb88-42a3-90b6-5422664d8a7c"]},
   "77c87a53-db82-4c61-87ea-8cda4b8e5d44"
   {:compute-ref #uuid "039a1b9a-e10e-4bb0-b24c-8f90ddf2fb1d",
    :exec-duration 652,
    :id "77c87a53-db82-4c61-87ea-8cda4b8e5d44",
    :kind "code",
    :output-log-lines {:stdout 38},
    :runtime [:runtime "5c88ad99-bb88-42a3-90b6-5422664d8a7c"]},
   "7947f79a-1d08-4fec-a968-17b45bdee974"
   {:compute-ref #uuid "af3d66c6-d48f-49ef-b543-2232799cd8bd",
    :exec-duration 501,
    :id "7947f79a-1d08-4fec-a968-17b45bdee974",
    :kind "code",
    :output-log-lines {:stdout 4},
    :runtime [:runtime "5c88ad99-bb88-42a3-90b6-5422664d8a7c"]},
   "7a56766b-8a89-449c-ac5c-7e57247d56c7"
   {:compute-ref #uuid "7e02103d-514c-4d4f-ad5f-0a12d3252d11",
    :exec-duration 660,
    :id "7a56766b-8a89-449c-ac5c-7e57247d56c7",
    :kind "code",
    :output-log-lines {:stdout 24},
    :runtime [:runtime "5c88ad99-bb88-42a3-90b6-5422664d8a7c"]},
   "80a92cc1-5d77-4d29-8e65-afba8733eb2e"
   {:compute-ref #uuid "f0164d4a-d03b-4ab4-8731-3ecb6a5f9239",
    :exec-duration 637,
    :id "80a92cc1-5d77-4d29-8e65-afba8733eb2e",
    :kind "code",
    :output-log-lines {:stdout 48},
    :runtime [:runtime "5c88ad99-bb88-42a3-90b6-5422664d8a7c"]},
   "80db43db-2792-4a0d-bc9d-5a694e5a7e7f"
   {:compute-ref #uuid "6a0213c7-e86f-4c73-bd07-9fd43bd7af68",
    :exec-duration 672,
    :id "80db43db-2792-4a0d-bc9d-5a694e5a7e7f",
    :kind "code",
    :output-log-lines {:stdout 62},
    :runtime [:runtime "5c88ad99-bb88-42a3-90b6-5422664d8a7c"]},
   "8ac1a3eb-34f5-4414-a121-112625c793f4"
   {:compute-ref #uuid "d27ff2d6-b639-4463-998b-2a9695bad846",
    :exec-duration 578,
    :id "8ac1a3eb-34f5-4414-a121-112625c793f4",
    :kind "code",
    :output-log-lines {:stdout 77},
    :runtime [:runtime "5c88ad99-bb88-42a3-90b6-5422664d8a7c"]},
   "8adecb3c-de54-412c-a197-e3f6f3c6f003"
   {:compute-ref #uuid "ebc3abb3-44b6-4aa3-be76-1542b9fa4fd6",
    :exec-duration 615,
    :id "8adecb3c-de54-412c-a197-e3f6f3c6f003",
    :kind "code",
    :output-log-lines {:stdout 23},
    :runtime [:runtime "5c88ad99-bb88-42a3-90b6-5422664d8a7c"]},
   "91306a94-695c-4aeb-8bed-b94bb47d22a5"
   {:compute-ref #uuid "99df959e-8a15-45a9-91bb-7aac5219ebd4",
    :exec-duration 623,
    :id "91306a94-695c-4aeb-8bed-b94bb47d22a5",
    :kind "code",
    :output-log-lines {:stdout 39},
    :runtime [:runtime "5c88ad99-bb88-42a3-90b6-5422664d8a7c"]},
   "91a7ef55-4fae-44eb-8204-6268e6e91202"
   {:compute-ref #uuid "6b3bf00a-d019-464c-b0ac-f25238a7e55f",
    :exec-duration 436,
    :id "91a7ef55-4fae-44eb-8204-6268e6e91202",
    :kind "code",
    :name "solution",
    :output-log-lines {:stdout 6},
    :runtime [:runtime "5c88ad99-bb88-42a3-90b6-5422664d8a7c"]},
   "91b27819-5cff-4727-a0f1-84a8db0b7b50"
   {:compute-ref #uuid "76f59580-8509-4676-acd7-1d481c0e43f6",
    :exec-duration 613,
    :id "91b27819-5cff-4727-a0f1-84a8db0b7b50",
    :kind "code",
    :output-log-lines {:stdout 33},
    :runtime [:runtime "5c88ad99-bb88-42a3-90b6-5422664d8a7c"]},
   "95d94ee6-2d18-4e92-ae14-36721f2c05bf"
   {:compute-ref #uuid "e993cfdc-ea94-41b6-9359-eb2b1395ee59",
    :exec-duration 563,
    :id "95d94ee6-2d18-4e92-ae14-36721f2c05bf",
    :kind "code",
    :output-log-lines {:stdout 37},
    :runtime [:runtime "5c88ad99-bb88-42a3-90b6-5422664d8a7c"]},
   "9a0e3710-3194-421e-96ad-f70c046906ce"
   {:compute-ref #uuid "0e8e02dd-4bf6-403a-b3a5-5b5620e4a1d4",
    :exec-duration 799,
    :id "9a0e3710-3194-421e-96ad-f70c046906ce",
    :kind "code",
    :output-log-lines {:stdout 46},
    :runtime [:runtime "5c88ad99-bb88-42a3-90b6-5422664d8a7c"]},
   "9c733646-89f7-4c9d-8c26-c2df2b808bce"
   {:compute-ref #uuid "16ce3129-59ba-4fcb-b143-8a6487f7a818",
    :exec-duration 546,
    :id "9c733646-89f7-4c9d-8c26-c2df2b808bce",
    :kind "code",
    :output-log-lines {:stdout 6},
    :runtime [:runtime "5c88ad99-bb88-42a3-90b6-5422664d8a7c"]},
   "a4ac100b-fdee-4477-a90d-b05e885142b6"
   {:compute-ref #uuid "314e96c3-5aff-480e-8d90-da0dcd11980a",
    :exec-duration 459,
    :id "a4ac100b-fdee-4477-a90d-b05e885142b6",
    :kind "code",
    :output-log-lines {:stdout 8},
    :runtime [:runtime "5c88ad99-bb88-42a3-90b6-5422664d8a7c"]},
   "a5d3accd-28ef-4ef0-8476-bdd227a2d9a6"
   {:compute-ref #uuid "a12e993a-f2e1-42cf-98c6-afef32f05438",
    :exec-duration 660,
    :id "a5d3accd-28ef-4ef0-8476-bdd227a2d9a6",
    :kind "code",
    :output-log-lines {:stdout 24},
    :runtime [:runtime "5c88ad99-bb88-42a3-90b6-5422664d8a7c"]},
   "a9491576-f775-4ec0-a3d3-491108dceedf"
   {:compute-ref #uuid "4fd980db-338f-4614-aa70-5c322fbe3cba",
    :exec-duration 683,
    :id "a9491576-f775-4ec0-a3d3-491108dceedf",
    :kind "code",
    :output-log-lines {:stdout 80},
    :runtime [:runtime "5c88ad99-bb88-42a3-90b6-5422664d8a7c"]},
   "aa034178-9832-407f-8272-471de928869c"
   {:compute-ref #uuid "16990483-aa74-4d0b-a4cd-7cbd8e539eb3",
    :exec-duration 499,
    :id "aa034178-9832-407f-8272-471de928869c",
    :kind "code",
    :output-log-lines {:stdout 40},
    :runtime [:runtime "5c88ad99-bb88-42a3-90b6-5422664d8a7c"]},
   "aa4eaa36-51ec-42e4-b6d3-84944674f034"
   {:id "aa4eaa36-51ec-42e4-b6d3-84944674f034", :kind "code-listing"},
   "abd3e4ca-fc77-4269-a3ca-8901b7a4d636"
   {:compute-ref #uuid "eaa2ca0b-cb85-4b07-ade8-14fae9175f22",
    :exec-duration 616,
    :id "abd3e4ca-fc77-4269-a3ca-8901b7a4d636",
    :kind "code",
    :output-log-lines {:stdout 80},
    :runtime [:runtime "5c88ad99-bb88-42a3-90b6-5422664d8a7c"]},
   "af34c896-ebfd-4d3e-986c-c9d367822160"
   {:compute-ref #uuid "294372be-ad2e-4d51-9313-819d4f9e2adc",
    :exec-duration 714,
    :id "af34c896-ebfd-4d3e-986c-c9d367822160",
    :kind "code",
    :output-log-lines {:stdout 65},
    :runtime [:runtime "5c88ad99-bb88-42a3-90b6-5422664d8a7c"]},
   "b279aed0-c0aa-4490-92c9-fd706b1988bb"
   {:compute-ref #uuid "6b0c3b90-433b-4422-a57a-7259859c02cc",
    :exec-duration 613,
    :id "b279aed0-c0aa-4490-92c9-fd706b1988bb",
    :kind "code",
    :output-log-lines {:stdout 48},
    :runtime [:runtime "5c88ad99-bb88-42a3-90b6-5422664d8a7c"]},
   "b2c08f5a-b717-4e83-b7ee-88269072a575"
   {:compute-ref #uuid "5e7bb3c4-352a-4bc8-8129-18c06f037ba9",
    :exec-duration 579,
    :id "b2c08f5a-b717-4e83-b7ee-88269072a575",
    :kind "code",
    :output-log-lines {:stdout 40},
    :runtime [:runtime "5c88ad99-bb88-42a3-90b6-5422664d8a7c"]},
   "b47ae1ab-084e-4dc8-8c3b-4cfa85594d9f"
   {:id "b47ae1ab-084e-4dc8-8c3b-4cfa85594d9f", :kind "file"},
   "b6d34664-2ca1-424b-9b9e-0c22c3027d20"
   {:compute-ref #uuid "e06c6c5d-fe29-4546-8c28-91f77961ee2b",
    :exec-duration 485,
    :id "b6d34664-2ca1-424b-9b9e-0c22c3027d20",
    :kind "code",
    :output-log-lines {:stdout 23},
    :runtime [:runtime "5c88ad99-bb88-42a3-90b6-5422664d8a7c"]},
   "b7519928-1787-4aed-8e22-27ec62473521"
   {:compute-ref #uuid "8a025cbf-ee60-4be7-b4e6-7c4ec30cdabb",
    :exec-duration 490,
    :id "b7519928-1787-4aed-8e22-27ec62473521",
    :kind "code",
    :output-log-lines {:stdout 5},
    :runtime [:runtime "5c88ad99-bb88-42a3-90b6-5422664d8a7c"]},
   "bf3158f0-548b-4b01-8e59-64cbf1c19a5f"
   {:compute-ref #uuid "e9389a72-7b08-434e-9d70-3e8469c50960",
    :exec-duration 727,
    :id "bf3158f0-548b-4b01-8e59-64cbf1c19a5f",
    :kind "code",
    :output-log-lines {:stdout 59},
    :runtime [:runtime "5c88ad99-bb88-42a3-90b6-5422664d8a7c"]},
   "c0998b98-d82e-4256-840a-751a795f8df3"
   {:compute-ref #uuid "6afa3b69-547f-4891-8c3f-9d34b2bfa00f",
    :exec-duration 873,
    :id "c0998b98-d82e-4256-840a-751a795f8df3",
    :kind "code",
    :output-log-lines {:stdout 54},
    :runtime [:runtime "5c88ad99-bb88-42a3-90b6-5422664d8a7c"]},
   "c239aac5-f81a-4d06-9809-4144ef52f5cc"
   {:compute-ref #uuid "addb5f85-450d-402b-a2b5-271a62006c2a",
    :exec-duration 615,
    :id "c239aac5-f81a-4d06-9809-4144ef52f5cc",
    :kind "code",
    :output-log-lines {:stdout 24},
    :runtime [:runtime "5c88ad99-bb88-42a3-90b6-5422664d8a7c"]},
   "c94a3ff4-140f-48cf-8a9e-de3bec688b31"
   {:compute-ref #uuid "a21338be-e67d-4d6a-adbb-e992a0a4ea0c",
    :exec-duration 1002,
    :id "c94a3ff4-140f-48cf-8a9e-de3bec688b31",
    :kind "code",
    :output-log-lines {:stdout 80},
    :runtime [:runtime "5c88ad99-bb88-42a3-90b6-5422664d8a7c"]},
   "d0ae0f2a-12a5-436d-889f-1a7f28c93904"
   {:compute-ref #uuid "781ec954-2a17-4fd3-ac1c-933f886a2325",
    :exec-duration 665,
    :id "d0ae0f2a-12a5-436d-889f-1a7f28c93904",
    :kind "code",
    :output-log-lines {:stdout 57},
    :runtime [:runtime "5c88ad99-bb88-42a3-90b6-5422664d8a7c"]},
   "d5ee3dfb-4c41-45b5-b98f-12f1fb464290"
   {:compute-ref #uuid "a9688713-35dd-43a1-96c6-f6ee980fb067",
    :exec-duration 587,
    :id "d5ee3dfb-4c41-45b5-b98f-12f1fb464290",
    :kind "code",
    :output-log-lines {:stdout 23},
    :runtime [:runtime "5c88ad99-bb88-42a3-90b6-5422664d8a7c"]},
   "da8b3100-33fb-4180-a128-e4d0e5f6f39a"
   {:compute-ref #uuid "854dd34d-c668-47ac-903e-e04dc1c17041",
    :exec-duration 605,
    :id "da8b3100-33fb-4180-a128-e4d0e5f6f39a",
    :kind "code",
    :output-log-lines {:stdout 71},
    :runtime [:runtime "5c88ad99-bb88-42a3-90b6-5422664d8a7c"]},
   "dff28a84-01a6-473d-8ff8-a56f04ed4a09"
   {:compute-ref #uuid "e74656c6-1408-49a5-a77a-1ebc4ef8312b",
    :exec-duration 422,
    :id "dff28a84-01a6-473d-8ff8-a56f04ed4a09",
    :kind "code",
    :output-log-lines {:stdout 1},
    :runtime [:runtime "5c88ad99-bb88-42a3-90b6-5422664d8a7c"]},
   "e1037592-39df-4db8-977d-635b8010200a"
   {:compute-ref #uuid "67417f0c-003c-4849-9cd4-89a83f8ae83a",
    :exec-duration 454,
    :id "e1037592-39df-4db8-977d-635b8010200a",
    :kind "code",
    :output-log-lines {:stdout 40},
    :runtime [:runtime "5c88ad99-bb88-42a3-90b6-5422664d8a7c"]},
   "e2c3f008-847f-428d-9a90-26e2f02a6bb7"
   {:compute-ref #uuid "1da89b6e-c37e-43ec-99c9-2aae1ad3e84e",
    :exec-duration 543,
    :id "e2c3f008-847f-428d-9a90-26e2f02a6bb7",
    :kind "code",
    :output-log-lines {:stdout 14},
    :runtime [:runtime "5c88ad99-bb88-42a3-90b6-5422664d8a7c"]},
   "e4be6f16-8de1-476a-a07b-fb7e0a28f91a"
   {:compute-ref #uuid "f1022d9a-f4f6-476a-8a2d-0f93cfe02d04",
    :exec-duration 659,
    :id "e4be6f16-8de1-476a-a07b-fb7e0a28f91a",
    :kind "code",
    :output-log-lines {:stdout 30},
    :runtime [:runtime "5c88ad99-bb88-42a3-90b6-5422664d8a7c"]},
   "e688b027-e8c8-4e47-be76-01426219f64e"
   {:compute-ref #uuid "da7f04ca-0c34-4329-b144-1c8d1890ef88",
    :exec-duration 540,
    :id "e688b027-e8c8-4e47-be76-01426219f64e",
    :kind "code",
    :output-log-lines {:stdout 44},
    :runtime [:runtime "5c88ad99-bb88-42a3-90b6-5422664d8a7c"]},
   "e780d7fe-43cb-40a8-87d8-9fc174a85b5d"
   {:compute-ref #uuid "9a3acced-4166-41ae-94ef-e52eaff68a45",
    :exec-duration 492,
    :id "e780d7fe-43cb-40a8-87d8-9fc174a85b5d",
    :kind "code",
    :output-log-lines {:stdout 40},
    :runtime [:runtime "5c88ad99-bb88-42a3-90b6-5422664d8a7c"]},
   "f2ae19e0-749c-4cd1-906f-e7a2fea9d3d7"
   {:compute-ref #uuid "ba1ac586-43c4-474a-8533-5a210fe004e0",
    :exec-duration 1160,
    :id "f2ae19e0-749c-4cd1-906f-e7a2fea9d3d7",
    :kind "code",
    :output-log-lines {:stdout 1},
    :runtime [:runtime "5c88ad99-bb88-42a3-90b6-5422664d8a7c"]},
   "f3043aa2-465a-45aa-9b02-440702fbf506"
   {:compute-ref #uuid "9a55b0be-2701-4f17-be84-d6780d31f2f0",
    :exec-duration 508,
    :id "f3043aa2-465a-45aa-9b02-440702fbf506",
    :kind "code",
    :output-log-lines {:stdout 7},
    :runtime [:runtime "5c88ad99-bb88-42a3-90b6-5422664d8a7c"]},
   "f329d982-5e94-4644-bd3d-8f536f204fe2"
   {:compute-ref #uuid "15d188f6-68a9-42e0-992a-da253fa5dcf3",
    :exec-duration 574,
    :id "f329d982-5e94-4644-bd3d-8f536f204fe2",
    :kind "code",
    :output-log-lines {:stdout 41},
    :runtime [:runtime "5c88ad99-bb88-42a3-90b6-5422664d8a7c"]},
   "f589ae59-4842-44c9-9c58-d68bbd212b5f"
   {:compute-ref #uuid "00f25bfa-a97c-4914-a5ee-578d8a4e0cba",
    :exec-duration 647,
    :id "f589ae59-4842-44c9-9c58-d68bbd212b5f",
    :kind "code",
    :output-log-lines {:stdout 47},
    :runtime [:runtime "5c88ad99-bb88-42a3-90b6-5422664d8a7c"]},
   "f8b05a91-59fd-46b1-aea3-885fe174f5ab"
   {:compute-ref #uuid "9ddc420d-2fd1-4f8e-9f8a-7e4125d38b14",
    :exec-duration 535,
    :id "f8b05a91-59fd-46b1-aea3-885fe174f5ab",
    :kind "code",
    :output-log-lines {:stdout 41},
    :runtime [:runtime "5c88ad99-bb88-42a3-90b6-5422664d8a7c"]},
   "f8dbc34e-3199-4e87-8486-4cf0277cafd6"
   {:id "f8dbc34e-3199-4e87-8486-4cf0277cafd6", :kind "code-listing"},
   "fba41ad9-72da-4298-bea8-6d296b8fa54a"
   {:compute-ref #uuid "6639f519-a107-4e60-ad1b-3fbfc1b5f51d",
    :exec-duration 532,
    :id "fba41ad9-72da-4298-bea8-6d296b8fa54a",
    :kind "code",
    :output-log-lines {:stdout 6},
    :runtime [:runtime "5c88ad99-bb88-42a3-90b6-5422664d8a7c"]}},
  :nextjournal/id #uuid "02d75fbd-eb7b-46a9-b268-212402502ada",
  :article/change
  {:nextjournal/id #uuid "5f65cc82-ff5f-4ca9-b27b-bbb5bbeb2972"}}}

```
</details>
