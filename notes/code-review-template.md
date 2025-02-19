# Code Review Template

```
Based on [Code Review Guidelines, What to look for in a code review](https://w.amazon.com/index.php/SoftwareStandards/CodeReviewGuidelines#What_to_look_for_in_a_code_review) and [CR Ninja Greasemonkey script](https://w.amazon.com/index.php/Greasemonkey/CR_Ninja).

Clarity

1. `[ ]` **Easy to read.** You should understand what each line and function does at a glance.
1. `[ ]` **Consistent style.** If a team style guide is available, follow it.
1. `[ ]` **Concise.** Functions and methods are concise, in intent and limited to a "page".
1. `[ ]` **Documented.** Code is appropriately documented for other developers to understand.
  1. `[ ]` Comments are concise, easily understandable, and add value to the surrounding code.
  1. `[ ]` Functions have clear intent and/or have minimal comments describing expectations.
  1. `[ ]` Public APIs are documented with Javadoc (Java) or Doxygen (C/C++).
  1. `[ ]` The Whys (intent) are explained as well as The Whats (implementation)?
1. `[ ]` **Appropriate abstractions.** Functions bridge one level of abstraction, calling lower-level functions.
1. `[ ]` **Appropriately scoped.** No "run-on" functions that span dozens of lines, that could easily be split into sub-functions.
1. `[ ]` **Nothing obscure.** No unnecessary and/or obscure language tricks.
1. `[ ]` **No spurious comments.** Commented out code makes it more difficult to read and can be difficult to catch -- do not assume everyone is using syntax highlighting.

Correctness

1. `[ ]` **No obvious bugs.**
1. `[ ]` **Unit tests.** Remember to run the tests.
1. `[ ]` **Test coverage.** The unit tests adequately test the code and/or changes to the code. A code coverage tool should be automatically run with builds.
1. `[ ]` **Thread safe.** Thread safety and concurrency is documented at the class or API level for callers to understand expected semantics.

Design Implications

1. `[ ]` **Makes sense.**
1. `[ ]` **Integrates well.** Changes fit the existing design. New responsibilities from code changes are appropriately scoped.
1. `[ ]` **Addresses design deficiencies.** If simple behavior change requires complex code changes, reconsider the existing design.
1. `[ ]` **Addresses ambiguity.** Change fully address all of the feature and/or issue requirements. Address ambiguity in the requirements that could cause issues in production.

Reuse and Duplicated Code

1. `[ ]` **No duplication.** If even a few lines of code are duplicated more than once within a module, it is a sign that refactoring is needed.
1. `[ ]` **No need to refactor.** Consider whether any local functionality should be in a shared library.
1. `[ ]` **Not redundant.** Code is essential and cannot be completely removed or replaced with existing libraries.

Configuration and Constants

1. `[ ]` **Configuration actually needed.** Code should use configuration instead of constant values where appropriate.
1. `[ ]` **Explicit defaults.** Assign default values for all configuration values.
1. `[ ]` **Documented.** Document all configuration behavior.
1. `[ ]` **No magic numbers.**

Backwards Compatibility and Versioning

1. `[ ]` **Backwards compatible API.**
1. `[ ]` **Backwards compatible configuration.**
1. `[ ]` **Changes are necessary.** Avoid unnecessary backwards-incompatible changes.
1. `[ ]` **No deployment issues.** For backwards-incompatible changes, document how they will be deployed.

Dependencies

1. `[ ]` **No risky new dependencies.** Consider the risk implications on availability and operations.
1. `[ ]` **No unused dependencies.** Dependency should be necessary with rationale.
1. `[ ]` **Alternatives considered.** No simpler solution exists.

Failure Handling

1. `[ ]` **Edge cases covered.**
  1. `[ ]` **Resilient to garbage return values.**
  1. `[ ]` **Resilient to garbage input values.**
  1. `[ ]` **Resilient to null values.** Functions either never accept null values or clearly document when null values are acceptable.
1. `[ ]` **Edge cases covered.**
1. `[ ]` **Clear exception strategy.** Consider and handle all error conditions. For Spring activities, use exception translators. For Java, use idomatic try-catch clauses.

Performance

1. `[ ]` **No premature optimization.**
1. `[ ]` **No obvious performance problems**
1. `[ ]` **Profiled code is documented.** If code was profiled and changed, provide a 1-2 line comment summarizing the profiler results.

Instrumentation

1. `[ ]` **Appropriate logging.** Logging should support operational activities, e.g. debugging and deployment. Log messages alone should be sufficient to explain the behavior of the system.
1. `[ ]` **Appropriate log levels.** Log levels and conditional branches are used appropriately to limit performance impact to the happy case.
1. `[ ]` **Appropriate metrics.** When appropriate, include both error and performance metrics, e.g. exceptions, timing, and latency.
1. `[ ]` **Handles regressions to existing metrics.** If existing metrics are changed, metric regressions are handled during deployment.

SQL

1. `[ ]` **No SQL injection vulnerability.** Use SQL libraries that escape user input when generating SQL queries.
1. `[ ]` **Use prepared SQL queries.** Use prepared SQL queries correctly. Avoid creating multiple equivalent prepared statements when a single prepared statement can be reused.
1. `[ ]` **Explain plan analyzed.** Complex SQL queries have been analyzed using the `EXPLAIN` statement. Address performance any potential issues. Summarize the plan results in a comment.
1. `[ ]` **Backfill provided.** If backfills are required, a design, strategy, and relevant scripts are provided.
```


