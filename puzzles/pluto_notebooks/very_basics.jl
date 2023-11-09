### A Pluto.jl notebook ###
# v0.19.32

using Markdown
using InteractiveUtils

# ╔═╡ d75d310e-7f08-11ee-10c3-47dfdf272c8a
md"""
## Welcome to Julia Programming

Welcome to your first step into the world of programming with Julia! This interactive notebook is designed to guide you through the fundamental concepts of programming and the unique features of the Julia language. As you progress, remember that learning to code is like learning a new language; it takes practice and patience. Let's get started!
"""

# ╔═╡ d609939b-a7d7-4108-a1ca-0e46f51f45fd
md"""
**NOTE!!** If you do not want to declare variables or functions for the whole Pluto notebook then encapsulate everything in a cell in a `let-end` block, i.e.
```julia
let
    # your code here
end
```
"""

# ╔═╡ fc5c732a-5fb2-4a92-9dbe-32497f83a13d
md"""
### Variables in Julia

**Creating a Variable:**
To create a variable in Julia, you simply need to assign a value to a name using the `=` operator. For example, `x = 10` creates a variable `x` that holds the value `10`.

**Naming Conventions:**
Julia's variable names are case-sensitive and can include underscores (`_`), letters, digits (not as the first character), and Unicode characters. For instance, `my_variable`, `var123`, and `δ` are all valid variable names.

📝 **Exercise 1:** Define a variable `my_var` and assign it the value `100`.

**Multiple Assignments:**
Julia allows you to assign values to several variables simultaneously. For example, `a, b = 1, 2` assigns `1` to `a` and `2` to `b`.

📝 **Exercise 2:** Assign the values `5` and `10` to variables `first_var` and `second_var` respectively, in a single line of code.

**Swapping Values:**
You can swap the values of two variables in a single, expressive line of code: `a, b = b, a`.

📝 **Exercise 3:** Swap the values of `first_var` and `second_var` from the previous exercise.

**Dynamic Typing:**
Julia is a dynamically typed language, meaning that variables do not have a fixed type and can be reassigned to values of different types. For example, `my_var` can start as an integer and then be assigned a string.

📝 **Exercise 4:** Change the value of `my_var` to the string `"Julia"`.

**Constants:**
If you want a variable's value to remain constant throughout your program, you can declare it with the `const` keyword. This can help prevent bugs and improve performance.

📝 **Exercise 5:** Declare a constant named `MY_CONSTANT` with the value `3.14`.


"""

# ╔═╡ 18fc2629-3bb7-4dec-b3c4-122709091954


# ╔═╡ faff712c-be4d-4cff-86b2-2127132c796a


# ╔═╡ 09357dfe-9baf-4da3-a486-7d4c3a1fa59a


# ╔═╡ 88da6f27-4fbc-42fc-ad6b-17640aab63f8


# ╔═╡ 3f4974c8-5f32-48a4-a87b-bdc404643e9b
md"""
### Exploring Data Types

Every value in Julia has a type that defines its nature and the operations that can be performed on it. Understanding data types is crucial because it influences how data is stored, how operations are performed on them, and how they interact with each other.

Julia has several basic data types:

- **Integers** (`Int`): These are whole numbers that can be positive, negative, or zero.
- **Floating-point numbers** (`Float64`/`Float32`): These represent real numbers and can include decimals. `Float64` is a double-precision floating-point number, and `Float32` is a single-precision floating-point number.
- **Complex numbers** (`Complex{T}`): These represent numbers with both real and imaginary parts, where `T` can be any numeric type like `Float64` or `Int64`.
- **Strings** (`String`): Used for text, a sequence of characters.
- **Booleans** (`Bool`): Logical type that can be either `true` or `false`.
- **Symbols** (`Symbol`): These are used as identifiers and are similar to strings but are interned and immutable.

📝 **Exercise 1:** Create an `Int64` named `my_int` with the value `42`.

📝 **Exercise 2:** Create a `Float64` named `my_float` with the value `3.14`.

📝 **Exercise 3:** Create a `Complex{Float64}` number named `my_complex` with real part `3.0` and imaginary part `4.0`.

📝 **Exercise 4:** Create a `String` named `my_string` with the value `"Hello, Julia!"`.

📝 **Exercise 5:** Create a `Boolean` named `my_bool` with the value `true`.

📝 **Exercise 6:** Create a `Symbol` named `my_symbol` with the value `:julia`.

You can check the type of any value `x` with the function `typeof(x)`. Check the types of your variables.
"""

# ╔═╡ deb99da9-c06d-4851-974c-e90dfd0b5a31


# ╔═╡ 10b229ba-3341-47f5-b532-d04d1f1c39d3


# ╔═╡ be404a22-4388-477a-9f35-1a16267ac71e


# ╔═╡ 7cbcd6f2-88b5-4936-a057-0fe86a0ece81
md"""
**BONUS:** Explore the typehierarchy of Julia. To check whether TypeA is a subtype of TypeB use `TypeA <: TypeB`.
"""

# ╔═╡ 08d643ff-dc83-44b9-ba1f-2ad9005cbcc2
md"""
### Working with Arrays

An **array** is a collection of items stored at contiguous memory locations. Think of it as a row of storage boxes, where each box can hold an item, and we can retrieve them using their position in the row.

📝 **Exercise 1:** Create an array named `my_array` that contains the integers from `1` to `5`.

📝 **Exercise 2:** Access the third element in `my_numbers` and assign it to a variable named `third_element`.

📝 **Exercise 3:** Change the second element of `my_numbers` to `10`.

Arrays can also be multidimensional, like a grid. We often use 2D arrays to represent matrices or tables.

📝 **Exercise 4:** Create a 2x3 array named `my_matrix` with numbers of your choice.

Apart from creating and modifying arrays, Julia provides several functions to analyze and manipulate them.

📝 **Exercise 5:** Use the `push!` function to add the number `6` to the end of `my_numbers`.

📝 **Exercise 6:** Use the `pop!` function to remove the last element from `my_numbers`.

📝 **Exercise 7:** Use the `splice!` function to remove the second element from `my_numbers`.

📝 **Exercise 8:** Find the length of `my_numbers` using the `length` function.

📝 **Exercise 9:** Sort `my_numbers` in ascending order using the `sort!` function.

Remember, functions that end with an exclamation mark (`!`) modify the array in place. Those without the exclamation mark return a new array with the modification, leaving the original array unchanged.
"""

# ╔═╡ 9af0d2aa-b66c-4692-b942-6e6a2256b4a2


# ╔═╡ bf70ebfe-b78f-4b37-a2fb-d447aad27df5


# ╔═╡ e0dda0f8-96ce-4015-b95c-e43a26314185


# ╔═╡ 259ff519-ba35-40bb-b0ac-47744dd60774


# ╔═╡ ce869b9f-a10f-46b4-99d2-a6c0c0c598aa
md"""
### Functions: The Building Blocks of Programming

Functions are one of the most powerful tools in programming, allowing you to encapsulate code that performs a specific task into a reusable and manageable block. In Julia, functions are first-class objects, meaning they can be assigned to variables, passed as arguments to other functions, and returned as values.

**Defining a Simple Function:**
To define a function in Julia, you use the `function` keyword, followed by the function name, arguments, and the `end` keyword to close the definition.

📝 **Exercise 1:** Define a function `greet` that takes a name as an argument and prints `"Hello, [name]!"`.

**Return Values:**
Functions often return values. The last expression evaluated in the function is automatically returned, or you can use the `return` keyword explicitly to return a value.

📝 **Exercise 2:** Define a function `square` that takes a number as an argument and returns its square.

**Higher-Order Functions:**
A higher-order function is a function that takes one or more functions as arguments or returns a function. This is a powerful concept that can lead to very expressive code.

📝 **Exercise 3:** Use the `map` function to apply your `square` function to an array of numbers `[1, 2, 3, 4, 5]`.

**Varargs Functions:**
Functions in Julia can accept a variable number of arguments using the varargs (`...`) syntax.

📝 **Exercise 4:** Define a function `sum_numbers` that takes a variable number of arguments and returns their sum.

**Keyword Arguments:**
Julia functions can also take keyword arguments, which are named arguments with default values. The syntax is `f(x,y;keyword_arguement=1)`. Note the `;` after the normal function arguments.

📝 **Exercise 5:** Define a function `rectangle_area` with keyword arguments for `width` and `height` that calculates the area of a rectangle.

**Best Practices:**
- Functions should do one thing and do it well.
- Use clear and descriptive names for functions and their arguments.
- Keep functions short and readable.

By mastering functions, you unlock the full potential of Julia’s flexibility and performance.
"""

# ╔═╡ 47b5bf98-424a-4655-8966-e43ad64fae5e


# ╔═╡ 04c9eefd-17e8-48b7-82af-9e11760a0087


# ╔═╡ e12df4e8-735a-4982-9d93-45403f29e1ed


# ╔═╡ 34e0f555-1f2d-4587-9310-e1eb190f6822
md"""
### Control Structures and Flow in Julia

Control structures are fundamental in programming, allowing you to dictate how and when certain blocks of code are executed. In this section, we'll explore the various control flow structures that Julia provides, such as conditional statements, loops, and more.

**Conditional Execution (`if` statement):**
Use `if` statements to execute code conditionally. If the condition is true, the code block is executed; otherwise, it's skipped.

📝 **Exercise 1:** Write an `if` statement that checks if a variable `num` is positive, negative, or zero and prints out an appropriate message.

**Loops:**
Loops are used to repeat a block of code multiple times. Julia provides several loop constructs:

- `for` loops are used to iterate over ranges, arrays, or any iterable object.
- `while` loops keep running as long as a condition is true.

📝 **Exercise 2:** Write a `for` loop that prints the numbers from 1 to 10.

📝 **Exercise 3:** Write a `while` loop that doubles a variable `x` until it is greater than 100.

**Nested Loops:**
You can place loops inside of other loops to work with multi-dimensional data or to perform complex tasks.

📝 **Exercise 4:** Use nested `for` loops to iterate over a 2D array and print each element.

**Early Exit (`break` and `continue`):**
The `break` statement immediately exits a loop, while `continue` skips the current iteration and proceeds to the next one.

📝 **Exercise 5:** Write a loop that searches for the first occurrence of a number in an array and exits when it finds it.

📝 **Exercise 6:** Modify the loop from Exercise 5 to skip even numbers using `continue`.

**Conditional Operator (`? :`):**
Julia provides the conditional operator `? :`, which is a concise way to express simple if-else statements.

📝 **Exercise 7:** Use the conditional operator to assign a value to a variable `result` based on whether another variable `age` is greater than 18.

**Exception Handling (`try`/`catch`):**
Use `try`/`catch` to handle exceptions, which are errors that occur during execution.

📝 **Exercise 8:** Write a `try`/`catch` block that attempts to divide two numbers and catches a division by zero error.

By mastering control structures, you will be able to write more dynamic and robust Julia programs.
"""

# ╔═╡ fc9e89e4-15b2-4cbf-9079-0731253a47a1


# ╔═╡ 035ca0e7-754d-4bb0-82e0-2c59033a3f55


# ╔═╡ 27818e91-5314-4b75-964f-431b26cc8c2d


# ╔═╡ Cell order:
# ╟─d75d310e-7f08-11ee-10c3-47dfdf272c8a
# ╠═d609939b-a7d7-4108-a1ca-0e46f51f45fd
# ╟─fc5c732a-5fb2-4a92-9dbe-32497f83a13d
# ╠═18fc2629-3bb7-4dec-b3c4-122709091954
# ╠═faff712c-be4d-4cff-86b2-2127132c796a
# ╠═09357dfe-9baf-4da3-a486-7d4c3a1fa59a
# ╠═88da6f27-4fbc-42fc-ad6b-17640aab63f8
# ╟─3f4974c8-5f32-48a4-a87b-bdc404643e9b
# ╠═deb99da9-c06d-4851-974c-e90dfd0b5a31
# ╠═10b229ba-3341-47f5-b532-d04d1f1c39d3
# ╠═be404a22-4388-477a-9f35-1a16267ac71e
# ╟─7cbcd6f2-88b5-4936-a057-0fe86a0ece81
# ╟─08d643ff-dc83-44b9-ba1f-2ad9005cbcc2
# ╠═9af0d2aa-b66c-4692-b942-6e6a2256b4a2
# ╠═bf70ebfe-b78f-4b37-a2fb-d447aad27df5
# ╠═e0dda0f8-96ce-4015-b95c-e43a26314185
# ╠═259ff519-ba35-40bb-b0ac-47744dd60774
# ╟─ce869b9f-a10f-46b4-99d2-a6c0c0c598aa
# ╠═47b5bf98-424a-4655-8966-e43ad64fae5e
# ╠═04c9eefd-17e8-48b7-82af-9e11760a0087
# ╠═e12df4e8-735a-4982-9d93-45403f29e1ed
# ╟─34e0f555-1f2d-4587-9310-e1eb190f6822
# ╠═fc9e89e4-15b2-4cbf-9079-0731253a47a1
# ╠═035ca0e7-754d-4bb0-82e0-2c59033a3f55
# ╠═27818e91-5314-4b75-964f-431b26cc8c2d
