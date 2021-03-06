## Teaching material

- ["Mathematical Logic"](https://www.springer.com/gp/book/9780387942582) by Ebbinghaus, Flum, and Thomas.
  - A classical book covering pure logic.
- ["Handbook of Practical Logic and Automated Reasoning"](https://www.cl.cam.ac.uk/~jrh13/atp/) by John Harrison [[vid1]](https://www.youtube.com/watch?v=Nydg-N83VYc)[[vid2]](https://www.youtube.com/watch?v=iPFJY0aW4E4)[[vid3]](https://www.youtube.com/watch?v=ZdJ0-V77f_0)[[vid4]](https://www.youtube.com/watch?v=g3EQKBMq5h0).
  - Great source of inspiration for a more applied approach to logic.
  - Expecially Sec. 2.9 on **DPLL SAT**.
- Problem book (**latest version**: [2020-05-24](book/logic_book_2020-05-24.pdf); previous versions: [2020-02-24](book/logic_book_2020-02-24.pdf), [2020-03-15](book/logic_book_2020-03-15.pdf)). 
  - It will be the main source of problems for the tutorials.
  - Feedback can be submitted in the form of [issues](https://github.com/lclem/logic_course/issues/).
    
- [Agda FAQ](labs/agda/agda_FAQ.md).
  - More questions on Agda will be collected there if they pop up.
- [skrypt](skrypt/calosc.pdf) (po polsku).
- [Past exams](https://moodle.mimuw.edu.pl/mod/url/view.php?id=13772) [[mirror]](archive/exam-pack.zip).
- [Past test questions](https://docs.google.com/forms/d/e/1FAIpQLSelSJszgoUIlPPx1U3AcY2gFmeBBp2p4y3y2Rmt-8Aoq27psQ/viewform?usp=sf_link).

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
  - [FAQ](labs/task01_FAQ.md) for the SAT project.
- Agda project: **10 points** (10 exercises, 1 point each).
  - Deadline for submission: 18th May 2020, 8pm.
  - Assignment invitation link sent via USOS mail.
- Mid-term exam: **30 points** (3 problems).
  - Coverage: lecture and related tutorial material weeks 0-5 included, except intuitionistic propositional/FO logic (e.g., no compactness/Skolem-Löwenheim for first-order logic).
- Final exam: **40 points** (3 problems).
  - This year there will be no test for the final exam, just problems.
- **NEW** 2nd take exam: Subscribe in [this form](https://docs.google.com/forms/d/e/1FAIpQLSdak3wSZNfrhACgb9qRqdHOEse1J5zWuC1PXp0_jujitEykXw/viewform?usp=sf_link) if you are interested.
- Book feedback: **+1 point** for every legitimate factual mistake found (excluding spelling mistakes), awarded to the first student that finds the mistake. Submit an issue [here](https://github.com/lclem/logic_course/issues/).
- Final score (up to 100 points without BOOK): SAT + Agda + MIDTERM + FINAL + BOOK.
- Guaranteed conversion thresholds: [50,59] gives 3, [60,69] gives 3.5, [70,79] gives 4, [80,89] gives 4.5, [90,99] gives 5, [100,∞) gives 5.5.

## Labs
* Lab01 (weeks 0,1) [Haskell]: Normal forms (NNF, DNF, CNF), DNF SAT, Ramsey numbers. [[lab01.zip]](labs/lab01.zip)
* Lab02 (weeks 2,3) [Haskell]: Equisatisfiable CNF, DP SAT. [[lab02.zip]](labs/lab02.zip)
* **SAT project presentation** at the end of week 3.
* Lab03 (weeks 4,5) [Agda Lab 01] [[notebook]](labs/agda/Lab01.ipynb) [[YT tutorial]](https://www.youtube.com/playlist?list=PL36j6ft5UmIr5x-NhLtKjmGdqoFpqR9Ol): Intuitionistic propositional logic. There are at least three options to work on this material:
  1. Work on the notebook online with [mybinder](https://mybinder.org/v2/gh/lclem/logic_course/master?filepath=docs/labs/agda/Lab01.ipynb). This option is fully online, does not require any installation. In order to retain the work done, it is necessary to locally download the notebook once one is done with it. To start working again, launch mybinder as above and upload your local copy.
  2. Work on the notebook locally by installing [Jupyter notebook](https://github.com/jupyter/notebook), Agda (see below), and the [Agda kernel](https://github.com/lclem/agda-kernel) for Jupyter.
  3. Do not work on the notebook at all and use local Agda files. Can still use the notebook to follow the description of the exercies and the comments. Installation instructions can be found on [Agda's github page](https://github.com/agda/agda). Popular local editors for working with Agda include [emacs](https://agda.readthedocs.io/en/v2.6.1/tools/emacs-mode.html) and [Atom](https://atom.io/packages/agda-mode). Note that it may take long time to install Agda, especially if building from sources (>1 hr).
* Lab04 (weeks 6,7) [Agda Lab 02] [[notebook]](labs/agda/Lab02.lagda.ipynb) [[mybinder]](https://mybinder.org/v2/gh/lclem/logic_course/master?filepath=docs/labs/agda/Lab02.lagda.ipynb) [[nextjournal]](https://nextjournal.com/a/MTG16bsjspisCTxKMrBHc?token=GntCzS9wsPvtKnojg74Dir): Intuitionistic first-order logic.
  - Nextjournal instructions: Register on nextjournal, access the read-only link above, and *remix* the notebook. You can then add collaborators for collaborative editing.
* **Agda project presentation** after all groups have officially seen [Agda Lab 02], which means at the end of week 8.

* Lab05 (weeks 9,10) [Z3 lab] [[notebook]](labs/LabZ3.ipynb) [[colab]](https://colab.research.google.com/github/lclem/logic_course/blob/master/docs/labs/LabZ3.ipynb) [[nextjournal]](https://nextjournal.com/a/MTMzzvE9CWkVWUK8ncHnj?token=HSPYLRYt8L2yijQtvTMdZ8): SAT as a blackbox.
  - Note: In order to use the Z3 library, we need more configurable systems like Nextjournal and Google Colab where Z3 can be installed.
  - Nextjournal instructions: Remix the read-only notebook and add your tutor as a collaborator for real-time feedback.
  - Google colab instructions: Open the link and save a local copy in Drive.
  
* Lab06 (weeks 11,12) [Haskell] [[nextjournal]](https://nextjournal.com/a/MXfaeLFbJoDxtZJcgoKYS?token=LJUyJXBFS9931sYXePTAiJ): Classical first-order logic: Syntax, semantics, normal forms (NNF, PNF).
* Lab07 (weeks 13,14) [Haskell] [[nextjournal]](https://nextjournal.com/a/MadgWAgVngRAgsQNyT2ff?token=JuTL4RzYRwBGph5Eg3rENE): Classical first-order logic: Skolemisation, deciding ∀∃-formulas, syllogisms.

## Outline

| week  | lecture date | lecture topics  |  tutorials | 
|---:|---:|:---|:--|
| 0  | 24.02 | organisation; historical context; introduction to propositional logic, tautology is coNP-complete, P1.2.3 (functionally complete set of connectives); multi-valued logics [[slides]](slides/01-intro.pdf) | sec. 1.1 (warm-up), P1.2.2 (normal forms: NNF, CNF, DNF), <del>P1.2.3 (functionally complete set of connectives),</del> P1.2.4 (equisatisfiable CNF); P1.3.1-1.3.4 (complexity of SAT)  | 
| 1 | 02.03 | Hilbert's proof system for propositional logic, soundness, deduction theorem, completeness (weak and strong); compactness; interpolation, <del>Beth definability</del> [[slides]](slides/02-completeness.pdf) | proof examples, P1.5.2 (compactness => König's lemma), P1.5.3 (De Bruijn-Erdős' theorem), P1.5.4, P2.9.2 (compactness w.r.t. finite satisfiability/logical consequence), weak completeness implies strong completeness |
| 2 | 09.03 | resolution (soundness, refutation completeness, <del>hardness of pigeon-hole formulas,</del> polynomial interpolants P1.7.6); SAT solving (DP, DPLL, phase transition); success of SAT solvers [[slides]](slides/03-resolution.pdf) | P1.3.5 (self-reducibility of SAT), P1.4.3 (exponential lower bound on equivalent CNF), P1.7.2 (interpolation), P1.7.3 (Beth definability), P1.7.4 (infinite extension of interpolation) |
| 3 | 16.03 | intuitionistic propositional logic: law of excluded middle, natural deduction, Curry-Howard correspondence (simply-typed lambda-calculus), models, tautology is PSPACE-complete [[live stream]](https://youtu.be/4MtVtuULxxQ) [[video]](https://youtu.be/FwPfMFfRD-8) [[slides]](slides/04-intuitionism.pdf) | P1.9.1 (examples), P1.9.2 (monotonicity of natural deduction), P1.9.3 (Kripke models with one world), P1.9.4 (monotonicity of Kripke semantics), P1.9.5 (soundness), P1.9.7 (examples of intuitionistic non-tautologies), P1.9.8 (linear models), P1.9.9 (disjunction property) |
| 4 | 23.03 | first-order logic: syntax, semantics, examples, Codd's theorem, evaluation in AC0 for fixed formula, normal forms (NNF, PNF, SNF), Herbrand's theorem [[live stream]](https://youtu.be/R_aFVUzb7d8) [[slides]](slides/05-first_order_logic.pdf) | P2.1.2, P2.1.6-9 (definability examples), P2.2.1-2 (NNF, PNF), P2.3.1-3 (satisfaction relation), P2.6.1-2 (logical consequence), P2.14.1 (relational algebra) |
| 5 | 30.03 | Hilbert's proof system for first-order logic, soundness, completeness [[live stream]](https://youtu.be/i1Nl1XOGxZ0) [[slides]](slides/06-completeness_FO.pdf) | expressing properties in first-order logic: spectrum (P2.8.2-2.8.9) and its closure properties (P2.8.10-13); infiniteness (P2.3.4-7) |
| 6 | 06.04 | intuitionistic first-order logic: tautology examples, natural deduction, dependent types, lambdaP1 calculus, Kripke models, negative translation [[live stream]](https://youtu.be/epzULiW39p8) [[slides]](slides/07-intuitionistic_FO.pdf) | more on spectrum: P2.8.15 (semilinear sets), P2.8.21-22 (spectra of existential and universal sentences), P2.8.29 (spectra are in NEXPTIME), P2.8.25-26 (counting spectrum); no exercises for IFOL (covered by the labs) |
| 7 | 13.04 | (EASTER MONDAY) | 
| 8 | 20.04 | compactness, Skolem-Löwenheim theorem, nonaxiomatisability [[live stream]](https://youtu.be/E4JnHcKoTvo) [[slides]](slides/08-compactness_and_SL.pdf) | non-axiomatisability via compactness: P2.9.6, P2.9.7, P2.9.9, P2.9.10, P2.9.14, P2.9.15, P2.9.16 (done in the lecture); applications of Skolem-Löwenheim: P2.10.2 (done in the lecture), P2.10.7 |
| 9 | 27.04 | **MIDTERM EXAM** | more compactness (P2.9.4, P2.9.5, P2.9.18, P2.9.22) and Skolem-Löwenheim (P2.10.4, P2.10.9, P2.10.10, P2.10.11) |
| 10 | 04.05 | (NO LECTURE, Friday schedule on this Monday) | |
| 11 | 11.05 | relational homomorphisms, isomorphisms, Ehrenfeucht-Fraïssé games, application to non-definability and non-axiomatisability [[live stream]](https://youtu.be/mtmksRJ3zmM) [[slides]](slides/09-EF_games.pdf) | P2.11.7 (isomorphism); P2.11.12, P2.12.4, P2.12.5, P2.12.6 (elementary equivalence), P2.12.10 (distinguishing sentences), P2.12.13 (infinite EF game) |
| 12 | 18.05 | the decision problem: semidecidability of validity and finite satifiability; decidable theories: finite model property (restriction on quantifier prefix, signature), quantifier elimination (equality, dense order, linear arithmetic, Presburger arithmetic, Tarski's algebra) [[live stream]](https://youtu.be/PpFjRg2_NpM) [[slides]](slides/10-quantifier_elimination.pdf) | P2.12.22-23 (inexpressibility via EF-games); P4.1.3-4 (small model property); P4.2.4, P4.2.6 (quantifier elimination) |
| 13 | 25.05 | undecidability of validity (Church-Turing) and finite satisfiability (Trakhtenbrot) [[live stream]](https://youtu.be/3NRi9S-F2Vk) [[slides]](slides/11-undecidability.pdf) | P2.12.11 (the hypercube), P2.12.27 (non-axiomatisability of the Church-Rosser property), P4.2.8-11 (quantifier elimination), P4.3.3 (decidability via interpretation) |
| 14 | 01.06 | second-order logic: expressiveness, failures (compactness, Skolem-Löwenheim theorems), nonaxiomatisability, Fagin's theorem (finite model theory), monadic second-order logic (word models, Büchi-Elgot-Trakhtenbrot's theorem) [[live tream]](https://youtu.be/qzMv-BpticE) [[slides]](slides/12-second_order_logic.pdf) | P3.1.2 (countability), P3.1.5-8 (reachability, connectivity, Eulerian and Hamiltonian cycles of infinite and finite graphs), P3.1.9 (colourability), P3.2.1 (compactness and SO), P3.2.2 (Skolem-Löwenheim and SO), P3.3.5 (star-free regular languages in FO)|
| 15 | 08.06 | arithmetic and Gödel's incompleteness theorem [[live stream]](https://youtu.be/S9uauo3oAqY) [[slides]](slides/13-incompleteness.pdf) | P5.1.3-4 (expressing numeric functions in arithmetic), P5.1.5 (Collatz), P5.2.1-4 (recognising languages in arithmetic), P5.2.7 (undecidability of the integers), P5.3.2 (elimination of weak second-order quantifiers in arithmetic) |
| 16 | 19.06 | **EXAM** 10am-1pm (3 hrs) | |
| < ∞  | 05.09 | **2nd TAKE EXAM** [[subscription form]](https://docs.google.com/forms/d/e/1FAIpQLSdak3wSZNfrhACgb9qRqdHOEse1J5zWuC1PXp0_jujitEykXw/viewform?usp=sf_link) | |

[[sources](https://github.com/lclem/logic_course)]
