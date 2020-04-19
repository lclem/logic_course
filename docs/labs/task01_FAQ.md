FAQ for the SAT solver project

Q. Are the tests that are not visible for us more complicated than the examples provided in tests directory?
I mean, can we assume (with some accuracy) that if our solution does not exceed timeout for examples,
it will fit for tests that are not shown?

A. No, the extra tests are not going to be more complicated.
Two weeks before the deadline a test run of the SAT projects available then will be performed
and the results will be communicated so there will be time for fix-ups before the final deadline.

***

Q. Are we allowed to use multi-threading in our solution?

A. Yes, however it is neither necessary nor sufficient to solve the task.

***

Q. Should we worry about exponential blow up of formulas after CNF conversion? 
I guess optimizing CNF conversion (using e.g. Tseytin transformation) can be harder
and more time consuming than implementation of DPLL itself.

A. Yes, we should worry very much about the exponential blow-up.
The intention is that the translation to CNF must be of **polynomial** complexity.
One way to achieve this is to use the Tseytin transformation (which was covered in the lab).
Note: An exponential translation will most likely fail the tests,
no matter how much multi-threading and optimisations are thrown in the code,
which is the main point of worst-case complexity theory.

***

Q. Can we assume that solutions will be run on environment alike "students"?
I'd like to code my solution using Rust and if it won't exist in the testing environment by default,
I'd probably have to add a Rust installation to Makefile.

A. No, it cannot be assumed that solutions will be run on something like "students".
Please add the necessary commands in the Makefile in order to use Rust.
