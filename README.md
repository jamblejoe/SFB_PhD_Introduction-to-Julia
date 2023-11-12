# Introduction to Julia for the SFB PhD seminar

This repository contains Pluto notebooks and helpful resources for an introduction to the Julia programming language.

A cheat sheet with the most common Julia idioms is available [here](https://cheatsheet.juliadocs.org/). Another cheat sheet is available as pdf file in this repository.

- **very_basics.jl** Demonstrates the very basics of Julia, including variable assignment, basic arithmetic, and control flow.
- **structs_strang_matrix_krylov.jl** Demonstrates the use of structs in Julia, and how to use them to define a matrix type that can be used to do matrix free vector multiplication and eigenvalue calculations with the Krylov.jl package.
- **threading_monte_carlo.jl** Demonstrates the use of multithreading in Julia, and how to use it to speed up Monte Carlo simulations.
- **julia_meets_python.jl** Demonstrates the integration of Python into Julia using the PyCall package, showcasing examples like defining Python functions and importing Python modules such as numpy for use in Julia.