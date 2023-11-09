### A Pluto.jl notebook ###
# v0.19.32

using Markdown
using InteractiveUtils

# ╔═╡ c1c471ca-7f0f-11ee-379f-ed99d76158f2
using PyCall

# ╔═╡ 105c8808-da60-4a63-9704-c974968853db
using Conda

# ╔═╡ d5ba6443-5b74-4f5e-b3cc-87b08306b3ed
md"""
# Introduction to PyCall in Julia
First, lets import the `PyCall` package, which allows Julia to interact with Python. This package provides a powerful interface to Python libraries, enabling the use of Python functions and objects within the Julia environment.
"""

# ╔═╡ d0554f47-9590-4a57-8de6-70b8dfc64531
md"""
After defining the `python_sqrt` function in Python, we can make it accessible in Julia by assigning it to a Julia variable `python_sqrt`. This is done via the `py"python_sqrt"` syntax which fetches the `python_sqrt` function from the Python global namespace.
"""

# ╔═╡ 90c33592-e2b1-4033-b2a1-b9c87500d214
py"""
import math

def python_sqrt(x):
    return math.sqrt(x)
"""

# ╔═╡ 36bf1fec-8c64-4813-acae-726c90060e11
python_sqrt = py"python_sqrt"

# ╔═╡ beed5354-b6b0-4767-a38b-1c801d188098
md"""
Here we demonstrate how to call the `python_sqrt` function with a Julia argument. The function is executed within Python's runtime, and the result is returned back to Julia. We pass the number `16` to our `python_sqrt` function and get the result.
"""

# ╔═╡ d6c13fc2-64ae-4ac8-b984-be417d1313b4
python_sqrt(16)

# ╔═╡ 258c10e5-b8be-4348-8fe3-a3b6b3969f82
md"""
## Importing Python Modules
We can directly import Python modules into the Julia environment using the `@pyimport` macro. In this cell, we import the `numpy` module, which is a fundamental package for scientific computing in Python. This allows us to use `numpy` functions as if they were Julia functions.

"""

# ╔═╡ ac9fdc4f-5077-4474-b045-91fd5fc07d41
@pyimport numpy as np

# ╔═╡ 5cc92531-782f-4f6e-b746-b829ec287dab
begin
	x = np.linspace(0, 2*np.pi, 100)
	y = np.sin(x)
end

# ╔═╡ ab298e6f-4c6c-4318-b8f6-d3ee17341929
md"""
To visualize data, we can use Python's `matplotlib` library. Here, we import the `matplotlib.pyplot` module using the `pyimport` function. This module is typically used for creating static, interactive, and animated visualizations in Python.
"""

# ╔═╡ 80caf7bb-cde4-43ed-aea9-10f6a0774e59
plt = pyimport("matplotlib.pyplot")

# ╔═╡ 2fcde805-6d14-424d-84cb-d65aff1fc641
let
	plt.plot(x, y)
	plt.title("Sine Wave")
	plt.xlabel("x")
	plt.ylabel("sin(x)")
	plt.show()
end

# ╔═╡ ec6eb370-7a01-4815-b9eb-d04837583bb3
md"""
## Machine Learning with Scikit-learn in Julia

In this section, we will explore how to leverage Python's `scikit-learn`, a robust machine learning library, within the Julia environment. We will demonstrate how to train a simple model on a dataset, make predictions, and evaluate the model's performance. This will provide an example of how Julia's capabilities can be extended with Python's machine learning libraries.

## Installing scikit-learn for Use in Julia
Before we can leverage `scikit-learn`, we need to make sure it is installed in our Python environment. If `scikit-learn` is not already installed, we can use PyCall's `Conda` package, which is a Julia wrapper for Conda, to install Python packages directly from Julia.

"""

# ╔═╡ 934b41d6-1cf3-4452-a5f0-79947d74ab8e
Conda.add("scikit-learn")

# ╔═╡ a8c7dce9-08ae-4215-a87e-1f6fc0d808cf
@pyimport sklearn.datasets as skdatasets

# ╔═╡ d6bca7ee-c371-4524-9149-2bc597b74987
md"""
Scikit-learn comes with a set of standard datasets for practicing machine learning. Here, we will load the famous Iris dataset, which is a simple yet rich dataset for classification tasks.

"""

# ╔═╡ 999586ac-7dbb-406a-a18e-4cd771eca81c
iris = skdatasets.load_iris()

# ╔═╡ efb12ec4-95ed-4fae-8e3d-bb4a0c562d93


# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
Conda = "8f4d0f93-b110-5947-807f-2305c1781a2d"
PyCall = "438e738f-606a-5dbb-bf0a-cddfbfd45ab0"

[compat]
Conda = "~1.9.1"
PyCall = "~1.96.2"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.9.3"
manifest_format = "2.0"
project_hash = "d42e5e1b3f471c914a68ef6a2a8c9bb9994dcef9"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.1"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.0.5+0"

[[deps.Conda]]
deps = ["Downloads", "JSON", "VersionParsing"]
git-tree-sha1 = "8c86e48c0db1564a1d49548d3515ced5d604c408"
uuid = "8f4d0f93-b110-5947-807f-2305c1781a2d"
version = "1.9.1"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "31e996f0a15c7b280ba9f76636b3ff9e2ae58c9a"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.4"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.3"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "7.84.0+0"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.10.2+0"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "9ee1618cbf5240e6d4e0371d6f24065083f60c48"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.11"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.2+0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

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

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "716e24b21538abc91f6205fd1d8363f39b442851"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.7.2"

[[deps.PrecompileTools]]
deps = ["Preferences"]
git-tree-sha1 = "03b4c25b43cb84cee5c90aa9b5ea0a78fd848d2f"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.2.0"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "00805cd429dcb4870060ff49ef443486c262e38e"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.4.1"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.PyCall]]
deps = ["Conda", "Dates", "Libdl", "LinearAlgebra", "MacroTools", "Serialization", "VersionParsing"]
git-tree-sha1 = "1cb97fa63a3629c6d892af4f76fcc4ad8191837c"
uuid = "438e738f-606a-5dbb-bf0a-cddfbfd45ab0"
version = "1.96.2"

[[deps.Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.VersionParsing]]
git-tree-sha1 = "58d6e80b4ee071f5efd07fda82cb9fbe17200868"
uuid = "81def892-9a0e-5fdd-b105-ffc91e053289"
version = "1.3.0"

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
"""

# ╔═╡ Cell order:
# ╟─d5ba6443-5b74-4f5e-b3cc-87b08306b3ed
# ╠═c1c471ca-7f0f-11ee-379f-ed99d76158f2
# ╟─d0554f47-9590-4a57-8de6-70b8dfc64531
# ╠═90c33592-e2b1-4033-b2a1-b9c87500d214
# ╠═36bf1fec-8c64-4813-acae-726c90060e11
# ╟─beed5354-b6b0-4767-a38b-1c801d188098
# ╠═d6c13fc2-64ae-4ac8-b984-be417d1313b4
# ╟─258c10e5-b8be-4348-8fe3-a3b6b3969f82
# ╠═ac9fdc4f-5077-4474-b045-91fd5fc07d41
# ╠═5cc92531-782f-4f6e-b746-b829ec287dab
# ╟─ab298e6f-4c6c-4318-b8f6-d3ee17341929
# ╠═80caf7bb-cde4-43ed-aea9-10f6a0774e59
# ╠═2fcde805-6d14-424d-84cb-d65aff1fc641
# ╟─ec6eb370-7a01-4815-b9eb-d04837583bb3
# ╠═105c8808-da60-4a63-9704-c974968853db
# ╠═934b41d6-1cf3-4452-a5f0-79947d74ab8e
# ╠═a8c7dce9-08ae-4215-a87e-1f6fc0d808cf
# ╟─d6bca7ee-c371-4524-9149-2bc597b74987
# ╠═999586ac-7dbb-406a-a18e-4cd771eca81c
# ╠═efb12ec4-95ed-4fae-8e3d-bb4a0c562d93
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
