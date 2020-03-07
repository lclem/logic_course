## Teaching material

- ["Mathematical Logic"](https://www.springer.com/gp/book/9780387942582) by Ebbinghaus, Flum, and Thomas.
  - A classical book covering pure logic.
- ["Handbook of Practical Logic and Automated Reasoning"](https://www.cl.cam.ac.uk/~jrh13/atp/) by John Harrison [[vid1]](https://www.youtube.com/watch?v=Nydg-N83VYc)[[vid2]](https://www.youtube.com/watch?v=iPFJY0aW4E4)[[vid3]](https://www.youtube.com/watch?v=ZdJ0-V77f_0)[[vid4]](https://www.youtube.com/watch?v=g3EQKBMq5h0).
  - Great source of inspiration for a more applied approach to logic.
- **NEW!** [Problem book](book/logic_book_2020-02-24.pdf).
  - It will be the main source of problems for the tutorials.
  - Feedback can be submitted in the form of [issues](https://github.com/lclem/logic_course/issues/).
- [skrypt](https://www.mimuw.edu.pl/~urzy/calosc.pdf) (po polsku).
- [Past exams](https://moodle.mimuw.edu.pl/mod/url/view.php?id=13772).

## (L)earning points
- SAT project: **20 points** = 10 public tests + 10 private tests.
  - For each test: Timeout (1 min): 0 points. Correct: 1 point. Incorrect: -1 point.
  - Must show their code to their lab tutor before (and including) their respective last lab.
  - Any programming language is allowed.
  - Deadline for submission: 12th June 2020, 20:00.
- COQ project: **10 points**.
  - Deadline for submission: two weeks after the task is given.
- Mid-term exam: **30 points** (3 problems).
- Final exam: **40 points** = 10 (10 test questions) + 30 (3 problems).
- Book feedback: **+1 point** for every legitimate factual mistake found (excluding spelling mistakes), awarded to the first student that finds the mistake. Submit an issue [here](https://github.com/lclem/logic_course/issues/).
- Final score: min(SAT +  COQ + MIDTERM + FINAL + BOOK, 100).

## Labs
* Lab01 (weeks 0,1) [Haskell]: Normal forms (NNF, DNF, CNF), DNF SAT, Ramsey numbers. [[lab01.zip]](labs/lab01.zip)
* Lab02 (weeks 2,3) [Haskell]: Equisatisfiable CNF, DP SAT. **SAT project presentation**.
* Lab03 (weeks 4,5) [Z3]: SAT as a blackbox.
* Labs for week 6 are **cancelled** due to the subsequent Easter.
* Lab04 (weeks 7,8) [coq]: Intuitionistic propositional logic.
* Lab05 (weeks 9,10) [coq]: Intuitionistic First-order logic. **COQ project presentation**.
* Lab06 (weeks 11,12) [Prolog?]: Classical first-order logic.
* Lab07 (weeks 13,14) [Prolog?]: Classical first-order logic.
* Labs for week 15 are officially **cancelled** (so each group has 7 labs).

## Outline

| week  | lecture date | lecture topics  |  tutorials | 
|---:|---:|:---|:--|
| 0  | 24.02 | organisation; historical context; introduction to propositional logic, tautology is coNP-complete, P1.2.3 (functionally complete set of connectives); multi-valued logics [[slides]](slides/01-intro.pdf) | sec. 1.1 (warm-up), P1.2.2 (normal forms: NNF, CNF, DNF), <del>P1.2.3 (functionally complete set of connectives),</del> P1.2.4 (equisatisfiable CNF); P1.3.1-1.3.4 (complexity of SAT)  | 
| 1 | 02.03 | Hilbert's proof system for propositional logic, soundness, deduction theorem, completeness (weak and strong); compactness; interpolation, <del>Beth definability</del> [[slides]](slides/02-completeness.pdf) | proof examples, P1.5.2 (compactness => König's lemma), P1.5.3 (De Bruijn-Erdős' theorem), P1.5.4, P2.9.2 (compactness w.r.t. finite satisfiability/logical consequence), weak completeness implies strong completeness |
| 2 | 09.03 | resolution (soundness, refutation completeness, hardness of pigeon-hole formulas); sat solving | P1.3.5 (self-reducibility of SAT), P1.4.3 (exponential lower bound on equivalent CNF), P1.7.2 (interpolation), P1.7.3 (Beth definability), P1.7.4 (infinite extension of interpolation), P1.7.6 (resolution yields polynomial interpolation) |
| 3 | 16.03 | first-order logic: syntax, semantics, examples, Codd's theorem | |
| 4 | 23.03 | proof systems for first-order logic, soundness, completeness | |
| 5 | 30.03 | compactness, Skolem-Löwenheim theorems, nonaxiomatisability | |
| 6 | 06.04 | intuitionistic logic: propositional, first-order, role of law of excluded middle, Curry-Howard correspondence (lambda-calculus and dependent types) | |
| 7 | 13.04 | (EASTER) | 
| 8 | 20.04 | isomorphism, logical relations, Ehrenfeucht-Fraïssé games, inexpressibility | |
| 9 | 27.04 | **MIDTERM EXAM** (rooms 5440 and 5050) | |
| 10 | 04.05 | the decision problem: semidecidability of validity and finite satifiability; undecidability of validity (Church-Turing) and finite satisfiability (Trakhtenbrot) | |
| 11 | 11.05 | decidable theories: finite model property (restriction on quantifier prefix, signature), quantifier elimination (equality, dense order, linear arithmetic, Presburger arithmetic, Tarski's algebra) | |
| 12 | 18.05 | arithmetic and Gödel's incompleteness theorem | |
| 13 | 25.05 | second-order logic: expressiveness, failures (compactness, Skolem-Löwenheim theorems), nonaxiomatisability, Fagin's theorem (finite model theory) | |
| 14 | 01.06 | monadic second-order logic (word models, Büchi-Elgot-Trakhtenbrot's theorem) | |
| 15 | 08.06 | miscellanea | |
| 16 | xx.06 | **EXAM** | |
| ∞ | xx.09 | **REPAIR EXAM** | |

[[sources](https://github.com/lclem/logic_course)]
