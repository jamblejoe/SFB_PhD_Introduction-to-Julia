### A Pluto.jl notebook ###
# v0.19.32

using Markdown
using InteractiveUtils

# ╔═╡ 87582bf0-7e4a-11ee-38c0-21687217649d
using LinearAlgebra

# ╔═╡ f19db849-dc6d-4306-88d5-ad51915d4c67
using KrylovKit

# ╔═╡ 92b6bf9b-191f-48a6-b1b3-610e5b1cc8e9
md""" # Strang matrices

In mathematics, a matrix is known to be a linear operator. In many cases, this can have huge performance advantages because, if you know a function which "acts like a matrix" but does not form the matrix itself, you can save the time that it takes to allocate the matrix (sometimes the matrix may not fit in memory!)

The Strang matrix is defined as

⎡⎣⎢⎢⎢⎢⎢⎢−211−2⋱1⋱⋱⋱⋱11−2⎤⎦⎥⎥⎥⎥⎥⎥

Define a type StrangMatrix and define a dispatch such that A*x acts like a Strang matrix on a vector.

some tips:

"""

# ╔═╡ a440bea5-a538-4821-b696-685f8531860a
function strang_matrix(N)
	
end

# ╔═╡ fcb5a80f-f81e-4e9b-bf13-bbf497fcd52d
md""" ## matrix free vector multiplication
"""

# ╔═╡ 44233a59-d495-4afb-bdc5-c557de73128a
md""" Define a new struct named StrangMatrix. What fields does the struct need to have? """

# ╔═╡ 04a09124-59d1-4bf7-b3ef-1e1cf547e067
struct StrangMatrix end

# ╔═╡ 6479e917-6c15-40a8-9a79-49e3945280b7
md""" 
We overload the Base function `*` by defining `Base.:*(A::StrangMatrix, x)` to define the action of the Strang matrix on a vector `x`. Implement the action of the Strang matrix on the vector `x` in the body of `Base.:*(A::StrangMatrix, x)`.
"""

# ╔═╡ 622afd73-1389-44ea-9d01-d268e8610aa1
function Base.:*(A::StrangMatrix, x)
	
	length(x) >= 2 || error("length of x must be larger or equal to 2")

	y = similar(x)
	
	y[1] = -2*x[1] + x[2]
	for i in 2:length(x)-1
		y[i] = x[i-1] - 2*x[i] + x[i+1]
	end
	y[end] = x[end-1] - 2*x[end]
	y
end

# ╔═╡ 27f58cdb-7554-4e55-9e97-7dccb6af525b
StrangMatrix() * ones(2)

# ╔═╡ 21bf821c-a50d-45fa-b21d-714243296057
StrangMatrix() * rand(10)

# ╔═╡ 82aaefc3-4597-4708-a34e-0439d1f55ea6
md""" ## matrix free eigenvalue calculation

The package KrylovKit (https://jutho.github.io/KrylovKit.jl/stable/) defines various Krylov subspace dependent methods. One of them is `eigsolve` to calculate eigenvalues and -vectors at the spectral edge of linear operators.

The `eigsolve` function can take in as first argument a linear function f(x). Calculate the largest and smallest eigenvalue of the StrangMatrix.
"""

# ╔═╡ f04dd3a3-3ce7-4d0d-848a-b6db36dcf23d
f(x) = StrangMatrix() * x

# ╔═╡ ca58b55d-3696-420e-a255-97ea25b657ba
eigsolve(f, rand(1000), 1, :LM; tol=1-3, issymmetric=true)

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
KrylovKit = "0b1a1467-8014-51b9-945f-bf0ae24f4b77"
LinearAlgebra = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[compat]
KrylovKit = "~0.6.0"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.9.3"
manifest_format = "2.0"
project_hash = "9a264b431c42bde3fa1d77e7bceb83bdbc19d3d8"

[[deps.Adapt]]
deps = ["LinearAlgebra", "Requires"]
git-tree-sha1 = "02f731463748db57cc2ebfbd9fbc9ce8280d3433"
uuid = "79e6a3ab-5dfb-504d-930d-738a2a938a0e"
version = "3.7.1"

    [deps.Adapt.extensions]
    AdaptStaticArraysExt = "StaticArrays"

    [deps.Adapt.weakdeps]
    StaticArrays = "90137ffa-7385-5640-81b9-e52037218182"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.ChainRulesCore]]
deps = ["Compat", "LinearAlgebra"]
git-tree-sha1 = "e0af648f0692ec1691b5d094b8724ba1346281cf"
uuid = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
version = "1.18.0"

    [deps.ChainRulesCore.extensions]
    ChainRulesCoreSparseArraysExt = "SparseArrays"

    [deps.ChainRulesCore.weakdeps]
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.Compat]]
deps = ["UUIDs"]
git-tree-sha1 = "8a62af3e248a8c4bad6b32cbbe663ae02275e32c"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "4.10.0"

    [deps.Compat.extensions]
    CompatLinearAlgebraExt = "LinearAlgebra"

    [deps.Compat.weakdeps]
    Dates = "ade2ca70-3891-5945-98fb-dc099432e06a"
    LinearAlgebra = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.0.5+0"

[[deps.GPUArraysCore]]
deps = ["Adapt"]
git-tree-sha1 = "2d6ca471a6c7b536127afccfa7564b5b39227fe0"
uuid = "46192b85-c4d5-4398-a991-12ede77f4527"
version = "0.1.5"

[[deps.KrylovKit]]
deps = ["ChainRulesCore", "GPUArraysCore", "LinearAlgebra", "Printf"]
git-tree-sha1 = "1a5e1d9941c783b0119897d29f2eb665d876ecf3"
uuid = "0b1a1467-8014-51b9-945f-bf0ae24f4b77"
version = "0.6.0"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.21+4"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

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

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.8.0+0"
"""

# ╔═╡ Cell order:
# ╠═87582bf0-7e4a-11ee-38c0-21687217649d
# ╠═92b6bf9b-191f-48a6-b1b3-610e5b1cc8e9
# ╠═a440bea5-a538-4821-b696-685f8531860a
# ╟─fcb5a80f-f81e-4e9b-bf13-bbf497fcd52d
# ╟─44233a59-d495-4afb-bdc5-c557de73128a
# ╠═04a09124-59d1-4bf7-b3ef-1e1cf547e067
# ╟─6479e917-6c15-40a8-9a79-49e3945280b7
# ╠═622afd73-1389-44ea-9d01-d268e8610aa1
# ╠═27f58cdb-7554-4e55-9e97-7dccb6af525b
# ╠═21bf821c-a50d-45fa-b21d-714243296057
# ╟─82aaefc3-4597-4708-a34e-0439d1f55ea6
# ╠═f19db849-dc6d-4306-88d5-ad51915d4c67
# ╠═f04dd3a3-3ce7-4d0d-848a-b6db36dcf23d
# ╠═ca58b55d-3696-420e-a255-97ea25b657ba
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
