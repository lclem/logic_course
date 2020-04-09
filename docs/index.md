## Teaching material

- ["Mathematical Logic"](https://www.springer.com/gp/book/9780387942582) by Ebbinghaus, Flum, and Thomas.
  - A classical book covering pure logic.
- ["Handbook of Practical Logic and Automated Reasoning"](https://www.cl.cam.ac.uk/~jrh13/atp/) by John Harrison [[vid1]](https://www.youtube.com/watch?v=Nydg-N83VYc)[[vid2]](https://www.youtube.com/watch?v=iPFJY0aW4E4)[[vid3]](https://www.youtube.com/watch?v=ZdJ0-V77f_0)[[vid4]](https://www.youtube.com/watch?v=g3EQKBMq5h0).
  - Great source of inspiration for a more applied approach to logic.
  - Expecially Sec. 2.9 on **DPLL SAT**.
- **NEW!** [Problem book (**new version 2020-03-15**)](book/logic_book_2020-03-15.pdf).
  - It will be the main source of problems for the tutorials.
  - Feedback can be submitted in the form of [issues](https://github.com/lclem/logic_course/issues/).
- [skrypt](skrypt/calosc.pdf) (po polsku).
- [Past exams](https://moodle.mimuw.edu.pl/mod/url/view.php?id=13772).

## Remote learning

Rocket.Chat:
- [lecture](https://chat.mimuw.edu.pl/channel/LDI2020_lecture).
- Lab groups: [1](https://chat.mimuw.edu.pl/channel/loglab1-jc), [2](https://chat.mimuw.edu.pl/channel/loglab2-lc).
- Tutorial groups: [3](https://chat.mimuw.edu.pl/channel/ldi2020_tutorial3) [[google meet]](https://meet.google.com/twe-bedm-uwu).

## (L)earning points
- SAT project: **20 points** = 10 public tests + 10 private tests.
  - For each test: Timeout (1 min): 0 points. Correct: 1 point. Incorrect: -1 point.
  - Must show their code to their lab tutor before (and including) their respective last lab.
  - Any programming language is allowed.
  - Announcement of the project: 20th March 2020.
  - Deadline for submission: 12th June 2020, 20:00.
  - [Detailed description](labs/task01_description.pdf). The submission is done in GitHub Classroom, as specified in the detailed description.
- Agda project: **10 points**.
  - Deadline for submission: two weeks after the task is given.
- Mid-term exam: **30 points** (3 problems).
- Final exam: **40 points** = 10 (10 test questions) + 30 (3 problems).
- Book feedback: **+1 point** for every legitimate factual mistake found (excluding spelling mistakes), awarded to the first student that finds the mistake. Submit an issue [here](https://github.com/lclem/logic_course/issues/).
- Final score: min(SAT + Agda + MIDTERM + FINAL + BOOK, 100).

## Labs
* Lab01 (weeks 0,1) [Haskell]: Normal forms (NNF, DNF, CNF), DNF SAT, Ramsey numbers. [[lab01.zip]](labs/lab01.zip)
* Lab02 (weeks 2,3) [Haskell]: Equisatisfiable CNF, DP SAT. [[lab02.zip]](labs/lab02.zip)
* **SAT project presentation** at the end of week 3.
* Lab03 (weeks 4,5) [Agda Lab 01] [[notebook]](labs/agda/Lab01.ipynb) [[YT tutorial]](https://www.youtube.com/playlist?list=PL36j6ft5UmIr5x-NhLtKjmGdqoFpqR9Ol): Intuitionistic propositional logic. There are at least three options to work on this material:
  1. Work on the notebook online with [mybinder](https://mybinder.org/v2/gh/lclem/logic_course/master?filepath=docs/labs/agda/Lab01.ipynb). This option is fully online, does not require any installation. In order to retain the work done, it is necessary to locally download the notebook once one is done with it. To start working again, launch mybinder as above and upload your local copy.
  2. Work on the notebook locally by installing [Jupyter notebook](https://github.com/jupyter/notebook), Agda (see below), and the [Agda kernel](https://github.com/lclem/agda-kernel) for Jupyter.
  3. Do not work on the notebook at all and use local Agda files. Can still use the notebook to follow the description of the exercies and the comments. Installation instructions can be found on [Agda's github page](https://github.com/agda/agda). Popular local editors for working with Agda include [emacs](https://agda.readthedocs.io/en/v2.6.1/tools/emacs-mode.html) and [Atom](https://atom.io/packages/agda-mode). Note that it may take long time to install Agda, especially if building from sources (>1 hr).
* Lab04 (weeks 6,7) [Agda Lab 02] [[notebook]](labs/agda/Lab02.lagda.ipynb) [[mybinder]](https://mybinder.org/v2/gh/lclem/logic_course/master?filepath=docs/labs/agda/Lab02.lagda.ipynb): Intuitionistic first-order logic.
* **Agda project presentation** after all groups have officially seen [Agda Lab 02], which means at the end of week 8.

**The information on labs below is currently outdated**

* Lab05 (weeks 9,10) [Z3]: SAT as a blackbox.
* Lab06 (weeks 11,12) [Prolog?]: Classical first-order logic.
* Lab07 (weeks 13,14) [Prolog?]: Classical first-order logic.
* Labs for week 15 are officially **cancelled** (so each group has 7 labs).

## Outline

| week  | lecture date | lecture topics  |  tutorials | 
|---:|---:|:---|:--|
| 0  | 24.02 | organisation; historical context; introduction to propositional logic, tautology is coNP-complete, P1.2.3 (functionally complete set of connectives); multi-valued logics [[slides]](slides/01-intro.pdf) | sec. 1.1 (warm-up), P1.2.2 (normal forms: NNF, CNF, DNF), <del>P1.2.3 (functionally complete set of connectives),</del> P1.2.4 (equisatisfiable CNF); P1.3.1-1.3.4 (complexity of SAT)  | 
| 1 | 02.03 | Hilbert's proof system for propositional logic, soundness, deduction theorem, completeness (weak and strong); compactness; interpolation, <del>Beth definability</del> [[slides]](slides/02-completeness.pdf) | proof examples, P1.5.2 (compactness => König's lemma), P1.5.3 (De Bruijn-Erdős' theorem), P1.5.4, P2.9.2 (compactness w.r.t. finite satisfiability/logical consequence), weak completeness implies strong completeness |
| 2 | 09.03 | resolution (soundness, refutation completeness, <del>hardness of pigeon-hole formulas,</del> polynomial interpolants P1.7.6); SAT solving (DP, DPLL, phase transition); success of SAT solvers [[slides]](slides/03-resolution.pdf) | P1.3.5 (self-reducibility of SAT), P1.4.3 (exponential lower bound on equivalent CNF), P1.7.2 (interpolation), P1.7.3 (Beth definability), P1.7.4 (infinite extension of interpolation) |
| 3 | 16.03 | intuitionistic propositional logic: law of excluded middle, natural deduction, Curry-Howard correspondence (simply-typed lambda-calculus), models, tautology is PSPACE-complete [[live stream]](https://youtu.be/4MtVtuULxxQ) [[video]](https://youtu.be/FwPfMFfRD-8) [[slides]](slides/04-intuitionism.pdf) | P1.9.1 (examples), P1.9.2 (monotonicity of natural deduction), P1.9.3 (Kripke models with one world), P1.9.4 (monotonicity of Kripke semantics), P1.9.5 (soundness), P1.9.7 (examples of intuitionistic non-tautologies), P1.9.8 (linear models), P1.9.9 (disjunction property) |
| 4 | 23.03 | first-order logic: syntax, semantics, examples, Codd's theorem, evaluation in AC0 for fixed formula, normal forms (NNF, PNF, SNF), Herbrand's theorem [[live stream]](https://youtu.be/R_aFVUzb7d8) [[slides]](slides/05-first_order_logic.pdf) | P2.1.2, P2.1.6-9 (definability examples), P2.2.1-2 (NNF, PNF), P2.3.1-3 (satisfaction relation), P2.6.1-2 (logical consequence), P2.14.1 (relational algebra) |
| 5 | 30.03 | Hilbert's proof system for first-order logic, soundness, completeness [[live stream]](https://youtu.be/i1Nl1XOGxZ0) [[slides]](slides/06-completeness_FO.pdf) | expressing properties in first-order logic: spectrum (P2.8.2-2.8.9) and its closure properties (P2.8.10-13); infiniteness (P2.3.4-7) |
| 6 | 06.04 | intuitionistic first-order logic: tautology examples, natural deduction, dependent types, lambdaP1 calculus, Kripke models, negative translation [[live stream]](https://youtu.be/epzULiW39p8) [[slides]](slides/07-intuitionistic_FO.pdf) | more on spectrum: P2.8.15 (semilinear sets), P2.8.21-22 (spectra of existential and universal sentences), P2.8.29 (spectra are in NEXPTIME); no exercises for IFOL (studied in labs) |
| 7 | 13.04 | (EASTER MONDAY) | 
| 8 | 20.04 | compactness, Skolem-Löwenheim theorems, nonaxiomatisability | |
| 9 | 27.04 | **MIDTERM EXAM** | |
| 10 | 04.05 | (NO LECTURE, Friday schedule on this Monday) | |
| 11 | 11.05 | isomorphism, logical relations, Ehrenfeucht-Fraïssé games, inexpressibility | |
| 12 | 18.05 | the decision problem: semidecidability of validity and finite satifiability; undecidability of validity (Church-Turing) and finite satisfiability (Trakhtenbrot) | |
| 13 | 25.05 | decidable theories: finite model property (restriction on quantifier prefix, signature), quantifier elimination (equality, dense order, linear arithmetic, Presburger arithmetic, Tarski's algebra) | |
| 14 | 01.06 | arithmetic and Gödel's incompleteness theorem | |
| 15 | 08.06 | second-order logic: expressiveness, failures (compactness, Skolem-Löwenheim theorems), nonaxiomatisability, Fagin's theorem (finite model theory), monadic second-order logic (word models, Büchi-Elgot-Trakhtenbrot's theorem) | |
| 16 | xx.06 | **EXAM** | |
| ∞ | xx.09 | **2nd TAKE EXAM** | |

[[sources](https://github.com/lclem/logic_course)]
