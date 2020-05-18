Q: What is the meaning of `→` in the second line of the code below?

```agda
Π : (A : Set) → (B : A → Set) → Set
Π A B = (a : A) → B a
```

A: `→` is a type constructor in the second line. Thus, `Π` is a function that returns a type (`Set` in Agda),
which happens to be a functional type. This is called *type-level programming*.

***

Q: But then what is `λ (a : A) → B a`?

A: The meaning of `→` is different now.
That is a function that takes an `a` (of type `A`) and returns `B a`. In other word, it is just `B`!
(It could have been written `λ (a : A) . B a` like in logic/lambda calculus to avoid overloading `→`,
but there is never ambiguity thanks to the `λ` part.)
