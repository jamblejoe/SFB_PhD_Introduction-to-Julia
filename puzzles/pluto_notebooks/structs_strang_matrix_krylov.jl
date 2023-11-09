### A Pluto.jl notebook ###
# v0.19.32

using Markdown
using InteractiveUtils

# ╔═╡ 87582bf0-7e4a-11ee-38c0-21687217649d
using LinearAlgebra, SparseArrays

# ╔═╡ f19db849-dc6d-4306-88d5-ad51915d4c67
using KrylovKit

# ╔═╡ 92b6bf9b-191f-48a6-b1b3-610e5b1cc8e9
md""" # Strang matrices

Gil Strang's favourite matrix, in the remainer of this notebook called the Strang matrix, is the second order difference matrix defined as

$\begin{bmatrix}
-2 & 1 & 0 & \cdots & 0 \\
1 & -2 & 1 & \ddots & \vdots \\
0 & 1 & -2 & \ddots & 0 \\
\vdots & \ddots & \ddots & \ddots & 1 \\
0 & \cdots & 0 & 1 & -2
\end{bmatrix}$

Your first task is to implement a function `strang_matrix(N)` which will create an $N \times N$ Strang matrix using dense matrix operations.

**Tips:**
- Remember that Julia arrays are 1-indexed.
- You can initialize a matrix full of zeros with `zeros(N, N)`.
- To set the values on the diagonal and off-diagonals, you might find the functions `fill!`, `diagm`, or array indexing useful.

**Your function should:**
- Take an integer `N` as input.
- Return a dense `N x N` Strang matrix.
"""

# ╔═╡ a440bea5-a538-4821-b696-685f8531860a
function strang_matrix(N)
    # Initialize a matrix of zeros
    A = zeros(N, N)
    
    # Your code here: Fill in the diagonal and off-diagonal entries as defined by the Strang matrix
    # Hint: You may use for loops or vectorized operations
    
    return A
end

# ╔═╡ fd69aca4-869a-4c1c-841c-46af76b7ea27
md"""
Implement a function sparse_strang_matrix(N) which returns sparse Strang matrix. For that considere the following example code.

This code snippet demonstrates the creation of a sparse matrix with predefined non-zero entries using Julia's sparse matrix capabilities. The matrix created by this code is a 3x3 matrix with specific values assigned to certain positions as indicated by the `rows`, `cols`, and `vals` arrays:

- `rows` = [1,1,2,3]: This array specifies the row indices of the non-zero entries.
- `cols` = [2,1,2,3]: This array corresponds to the column indices for each non-zero entry.
- `vals` = 1:4: This is a range object that expands to [1, 2, 3, 4], which provides the actual values to be inserted into the matrix.

The `sparse` function takes these three arrays to construct the sparse matrix. The resulting matrix looks like this:

$\begin{bmatrix}
2 & 1 & 0 \\
0 & 3 & 0 \\
0 & 0 & 4
\end{bmatrix}$

This matrix contains values only at the specified positions, with all other entries being implicitly zero. The approach used here is efficient for large sparse matrices, where direct assignment of non-zero values avoids the storage and computation overhead of handling zeros.
"""

# ╔═╡ 4b8b4945-290b-4586-9ab8-15922e8d959b
let
	rows = [1,1,2,3]
	cols = [2,1,2,3]
	vals = 1:4
	sparse(rows, cols, vals, 3, 3)
end

# ╔═╡ d28634b7-db71-4fd2-9745-c0201e49d833
function sparse_strang_matrix(N)

	rows = []
	cols = []
	vals = []
	
    # Your code here: Set the values of the rows and cols according to the Strang matrix definition

    
    return sparse(rows, cols, vals, N, N)
end

# ╔═╡ 791de0e7-213b-404c-a93b-68ef1db8165e
md"""
Explore how to define the sparse matrix with `spdiagm`.
"""

# ╔═╡ fcb5a80f-f81e-4e9b-bf13-bbf497fcd52d
md""" ## matrix free vector multiplication
"""

# ╔═╡ c6e7f12b-09b1-4e90-8b87-d7616feca1f2
md"""
In mathematics, a matrix is known to be a linear operator. In many cases, this can have huge performance advantages because, if you know a function which "acts like a matrix" but does not form the matrix itself, you can save the time that it takes to allocate the matrix (sometimes the matrix may not fit in memory!)
"""

# ╔═╡ 44233a59-d495-4afb-bdc5-c557de73128a
md""" Define a new struct named StrangMatrix. What fields does the struct need to have? """

# ╔═╡ 04a09124-59d1-4bf7-b3ef-1e1cf547e067
struct StrangMatrix 

end

# ╔═╡ 6479e917-6c15-40a8-9a79-49e3945280b7
md""" 
We overload the Base function `*` by defining `Base.:*(A::StrangMatrix, x)` to define the action of the Strang matrix on a vector `x`. Implement the action of the Strang matrix on the vector `x` in the body of `Base.:*(A::StrangMatrix, x)`.
"""

# ╔═╡ 622afd73-1389-44ea-9d01-d268e8610aa1
function Base.:*(A::StrangMatrix, x)
	
	y = zeros(length(x))

	## implement action of Strang matrix on x here
	# the result should be stored in y
	
	
	return y
end

# ╔═╡ 27f58cdb-7554-4e55-9e97-7dccb6af525b
StrangMatrix() * ones(2)

# ╔═╡ 21bf821c-a50d-45fa-b21d-714243296057
StrangMatrix() * rand(10)

# ╔═╡ 8c8a8763-89c3-463d-ab62-958e5ff11ed7
md"""
What happens for the edge case of a $1\times 1$ matrix?
"""

# ╔═╡ 14982dca-1f5c-4461-b07e-8106dbfb5b35
StrangMatrix() * ones(1)

# ╔═╡ 42cb2e86-0fe9-429c-b81f-1779b13c44ae
md"""
### Utilizing KrylovKit for Eigenvalue Calculations

The `KrylovKit` package (https://jutho.github.io/KrylovKit.jl/stable/) in Julia provides a suite of Krylov subspace algorithms that are designed for efficient eigenvalue and singular value computations, particularly for large, sparse or structured matrices. Utilizing Krylov subspace methods is advantageous as they can compute spectral properties without explicitly forming the full matrix, which is especially beneficial for matrices that are too large to store in memory. 

In our context, `eigsolve` from KrylovKit allows us to find the eigenvalues of a matrix by only using the matrix-vector multiplication operation. This means we can work with our matrix-free representation of the StrangMatrix to compute its largest and smallest eigenvalues, which are of particular interest in many physical and engineering applications where these values often carry significant meaning regarding the stability and behavior of a system.

"""

# ╔═╡ 82aaefc3-4597-4708-a34e-0439d1f55ea6
md"""
The `eigsolve` function can take in as first argument a linear function f(x). Calculate the largest and smallest eigenvalue of the StrangMatrix.
"""

# ╔═╡ f04dd3a3-3ce7-4d0d-848a-b6db36dcf23d
f(x) = StrangMatrix() * x

# ╔═╡ ca58b55d-3696-420e-a255-97ea25b657ba
eigsolve(f, rand(1000), 1, :LM; tol=1-3, issymmetric=true)

# ╔═╡ d7822404-dae3-449f-9945-f3c82c672ab7
md"""
**BONUS:** The linear function `f(x)` and the `*` function both store the `StrangMatrix() * x` in a new vector. Redefine your struct `StrangMatrix` to be a subtype of the abstract type `AbstractMatrix`. Implement the necessary methods for the `StrangMatrix` to be an `AbstractMatrix` type.

Especially, overload the `LinearAlgebra` method `LinearAlgebra.mul!(y,A,x)` which stores `A*x` in `y`.
"""

# ╔═╡ b43348f4-1f1a-44d6-8e21-6caf45db4e6a
function LinearAlgebra.mul!(y,A::StrangMatrix,x)
	## implement here
end

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
KrylovKit = "0b1a1467-8014-51b9-945f-bf0ae24f4b77"
LinearAlgebra = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[compat]
KrylovKit = "~0.6.0"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.9.3"
manifest_format = "2.0"
project_hash = "ce7b48b29d675136fd9f15948af1d91cd8312e01"

[[deps.Adapt]]
deps = ["LinearAlgebra", "Requires"]
git-tree-sha1 = "02f731463748db57cc2ebfbd9fbc9ce8280d3433"
uuid = "79e6a3ab-5dfb-504d-930d-738a2a938a0e"
version = "3.7.1"

    [deps.Adapt.extensions]
    AdaptStaticArraysExt = "StaticArrays"

    [deps.Adapt.weakdeps]
    StaticArrays = "90137ffa-7385-5640-81b9-e52037218182"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.1"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.ChainRulesCore]]
deps = ["Compat", "LinearAlgebra"]
git-tree-sha1 = "e0af648f0692ec1691b5d094b8724ba1346281cf"
uuid = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
version = "1.18.0"
weakdeps = ["SparseArrays"]

    [deps.ChainRulesCore.extensions]
    ChainRulesCoreSparseArraysExt = "SparseArrays"

[[deps.Compat]]
deps = ["UUIDs"]
git-tree-sha1 = "8a62af3e248a8c4bad6b32cbbe663ae02275e32c"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "4.10.0"
weakdeps = ["Dates", "LinearAlgebra"]

    [deps.Compat.extensions]
    CompatLinearAlgebraExt = "LinearAlgebra"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.0.5+0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[deps.GPUArraysCore]]
deps = ["Adapt"]
git-tree-sha1 = "2d6ca471a6c7b536127afccfa7564b5b39227fe0"
uuid = "46192b85-c4d5-4398-a991-12ede77f4527"
version = "0.1.5"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.KrylovKit]]
deps = ["ChainRulesCore", "GPUArraysCore", "LinearAlgebra", "Printf"]
git-tree-sha1 = "1a5e1d9941c783b0119897d29f2eb665d876ecf3"
uuid = "0b1a1467-8014-51b9-945f-bf0ae24f4b77"
version = "0.6.0"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.3"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "7.84.0+0"

[[deps.LibGit2]]
deps = ["Base64", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.10.2+0"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.2+0"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2022.10.11"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.21+4"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.9.2"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "838a3a4188e2ded87a4f9f184b4b0d78a1e91cb7"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.0"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SparseArrays]]
deps = ["Libdl", "LinearAlgebra", "Random", "Serialization", "SuiteSparse_jll"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.SuiteSparse_jll]]
deps = ["Artifacts", "Libdl", "Pkg", "libblastrampoline_jll"]
uuid = "bea87d4a-7f5b-5778-9afe-8cc45184846c"
version = "5.10.1+6"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.0"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.13+0"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.8.0+0"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.48.0+0"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+0"
"""

# ╔═╡ Cell order:
# ╠═87582bf0-7e4a-11ee-38c0-21687217649d
# ╟─92b6bf9b-191f-48a6-b1b3-610e5b1cc8e9
# ╠═a440bea5-a538-4821-b696-685f8531860a
# ╟─fd69aca4-869a-4c1c-841c-46af76b7ea27
# ╠═4b8b4945-290b-4586-9ab8-15922e8d959b
# ╠═d28634b7-db71-4fd2-9745-c0201e49d833
# ╟─791de0e7-213b-404c-a93b-68ef1db8165e
# ╟─fcb5a80f-f81e-4e9b-bf13-bbf497fcd52d
# ╟─c6e7f12b-09b1-4e90-8b87-d7616feca1f2
# ╟─44233a59-d495-4afb-bdc5-c557de73128a
# ╠═04a09124-59d1-4bf7-b3ef-1e1cf547e067
# ╟─6479e917-6c15-40a8-9a79-49e3945280b7
# ╠═622afd73-1389-44ea-9d01-d268e8610aa1
# ╠═27f58cdb-7554-4e55-9e97-7dccb6af525b
# ╠═21bf821c-a50d-45fa-b21d-714243296057
# ╟─8c8a8763-89c3-463d-ab62-958e5ff11ed7
# ╠═14982dca-1f5c-4461-b07e-8106dbfb5b35
# ╟─42cb2e86-0fe9-429c-b81f-1779b13c44ae
# ╠═f19db849-dc6d-4306-88d5-ad51915d4c67
# ╟─82aaefc3-4597-4708-a34e-0439d1f55ea6
# ╠═f04dd3a3-3ce7-4d0d-848a-b6db36dcf23d
# ╠═ca58b55d-3696-420e-a255-97ea25b657ba
# ╟─d7822404-dae3-449f-9945-f3c82c672ab7
# ╠═b43348f4-1f1a-44d6-8e21-6caf45db4e6a
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
