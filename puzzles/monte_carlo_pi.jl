### A Pluto.jl notebook ###
# v0.19.32

using Markdown
using InteractiveUtils

# ╔═╡ d0c8f397-6980-4f30-8d5c-13f8ffa3fb5b
using Random, BenchmarkTools

# ╔═╡ 3058ac00-22c3-4185-9c0c-484729c0188a
md"""
# Monte Carlo Estimation of Pi
This exercise will guide you through the process of estimating the value of π using the Monte Carlo method.
You will fill in the missing parts of the code as described in the comments.
"""

# ╔═╡ b127a2ce-7e74-11ee-32a7-41d97c6fe2a6
function estimate_pi(total_points)
    # Initialize the count of points inside the quarter circle
    inside_circle = 0

    # Loop over the number of points
    for i = 1:total_points
        # Generate a random point (x, y) inside the unit square [0, 1] x [0, 1]
        
        if # ... condition to check if (x, y) is inside the circle
            inside_circle += 1
        end
    end

    # Estimate pi using the ratio of points inside the circle to the total points
    # and the area relation between the quarter circle and the unit square.
    pi_estimate = # ... calculate the estimate of pi

    return pi_estimate
end

# ╔═╡ 57e5b110-f91e-47a1-abb8-857cac867a4f
# Suggestion: start with a small number to test and with a larger for a more accurate estimate of π
total_points = 1000

# ╔═╡ c20e4c78-f64c-468f-81e4-735590d02404
estimated_pi = estimate_pi(total_points)

# ╔═╡ a056a0f8-aaf2-4d24-861f-543abe948b4e
"Estimated value of Pi: $estimated_pi"

# ╔═╡ 6f23322a-2152-49a1-8a87-a822ace2aae7
# calculate the difference from the tru value of π
# in Julia π (\pi + tab) is constant
difference_to_pi = ...

# ╔═╡ c6053300-84d4-4e79-aac1-8d9c5b7d5153
"Difference from π: $difference"

# ╔═╡ 3a77bc14-710b-4e87-82d8-7588fa66014a
md"""
## Parallel Estimation of Pi using Threads
Now, let's enhance the exercise to perform the Monte Carlo estimation in parallel using multiple threads.
You will modify the code to utilize Julia's multithreading environment to potentially speed up the computation.
"""

# ╔═╡ 10097670-7c6b-494e-b57b-9d517b387522
# Total number of available threads is given by
Threads.nthreads()

# ╔═╡ dde7ab0d-3a7d-408b-a173-a3f47f1cfd0c
md""" 
A simple for loop can be multithreaded with the `Threads.@threads` macro:
"""

# ╔═╡ 5c1419ea-316b-4603-95d6-bacde6d52359
let
	x = 0
	for i in 1:10_000
		x += 1
	end
	x
end

# ╔═╡ ce560a6d-ca8f-4197-9d61-a7de39542ac1
let
	x = 0
	Threads.@threads for i in 1:10_000
		x += 1
	end
	x
end

# ╔═╡ 6e6d8393-786a-49b1-875b-0f6c3468542f
md""" But wait! The threaded for loop gave the wrong result. This is because the access to the variable `x` is not threadsave. Multiple threads modify `x` at the same time. To avoid this we will make `x` atomic, which means threadsave"""

# ╔═╡ 1eca63ec-eee4-451b-b6de-7c218774a752
let
	x = Threads.Atomic{Int}(0)
	Threads.@threads for i in 1:10_000
		Threads.atomic_add!(x, 1)
	end
	x[]
end

# ╔═╡ d5ce1143-708e-4ce1-886d-84cc31a7a5e1
md""" If you paid attantion to the performance of the for loops you would have noticed that the atomic thread loop performs magnitudes worse than the serial for loop. This is because the threads are all trying to increase `x` at the same time, but only one thread at a time is allowed to modeify `x`. This results in a massive overhead and an effectively serial calculation. `Atomic` should only be used for variables, which are rarely modified."""

# ╔═╡ 1894774b-f49c-4529-81de-45c39c2dab24
md"""
A refined approach to leveraging multithreading in Julia involves the use of tasks. These tasks are adeptly managed by Julia's sophisticated task scheduler. To create tasks that are capable of running across multiple threads, one can utilize the Threads.@spawn macro. This powerful macro can be prefixed to a function, or encapsulated within `begin ... end` or `let ... end` blocks, thereby instantaneously creating and scheduling a task for execution.
"""

# ╔═╡ 55df009e-a2e4-45bb-b49c-4dd2c5b881f7
let
	x = Threads.Atomic{Int}(0)
	for i in 1:10
		Threads.@spawn begin
			local_x = 0
			for j in 1:1_000
				local_x += 1
			end
			Threads.atomic_add!(x, local_x)
		end
	end
	x
end

# ╔═╡ 83fe6453-d941-45c9-8f7e-a4d8a0833a54
md""" 
Note that the performance of the above threaded for loop is way better than the one before, because `x` is only modified 10 instead of 10_000 times. An even more flexible and Julian approach is sketched below. Try to understand the syntax of the code below:
"""

# ╔═╡ 9024bd66-2094-4c47-95e4-2c11d61d73bb
let
	tasks = []
	for i in 1:10
		task = Threads.@spawn begin
			local_x = 0
			for j in 1:1_000
				local_x += 1
			end
			local_x
		end
		push!(tasks, task)
	end
	results = fetch.(tasks)
	sum(results)
end

# ╔═╡ 281536b2-06e4-4940-abc6-b5cf9da59f13
md"""
Let us now turn to the parallelization of estimating π. Put in practice of what you have learned and try to define a multithreaded version of estimating π. You can benchmark your functions with `@btime estimate_pi(total_points)` and `@btime estimate_pi_threaded(total_points)`
"""

# ╔═╡ e9631233-9fa9-4298-9cc5-51949236bd77
function estimate_pi_threaded(total_points)

end

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
BenchmarkTools = "6e4b80f9-dd63-53aa-95a3-0cdb28fa8baf"
Random = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[compat]
BenchmarkTools = "~1.3.2"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.9.3"
manifest_format = "2.0"
project_hash = "800d5c92749d633f8efc6c822d6d410d109b9689"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.1"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.BenchmarkTools]]
deps = ["JSON", "Logging", "Printf", "Profile", "Statistics", "UUIDs"]
git-tree-sha1 = "d9a9701b899b30332bbcb3e1679c41cce81fb0e8"
uuid = "6e4b80f9-dd63-53aa-95a3-0cdb28fa8baf"
version = "1.3.2"

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

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

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

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.9.2"

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

[[deps.Profile]]
deps = ["Printf"]
uuid = "9abbd945-dff8-562f-b5e8-e1ebf5ef1b79"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

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

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.9.0"

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
# ╟─3058ac00-22c3-4185-9c0c-484729c0188a
# ╠═d0c8f397-6980-4f30-8d5c-13f8ffa3fb5b
# ╠═b127a2ce-7e74-11ee-32a7-41d97c6fe2a6
# ╠═57e5b110-f91e-47a1-abb8-857cac867a4f
# ╠═c20e4c78-f64c-468f-81e4-735590d02404
# ╠═a056a0f8-aaf2-4d24-861f-543abe948b4e
# ╠═6f23322a-2152-49a1-8a87-a822ace2aae7
# ╠═c6053300-84d4-4e79-aac1-8d9c5b7d5153
# ╟─3a77bc14-710b-4e87-82d8-7588fa66014a
# ╠═10097670-7c6b-494e-b57b-9d517b387522
# ╟─dde7ab0d-3a7d-408b-a173-a3f47f1cfd0c
# ╠═5c1419ea-316b-4603-95d6-bacde6d52359
# ╠═ce560a6d-ca8f-4197-9d61-a7de39542ac1
# ╟─6e6d8393-786a-49b1-875b-0f6c3468542f
# ╠═1eca63ec-eee4-451b-b6de-7c218774a752
# ╟─d5ce1143-708e-4ce1-886d-84cc31a7a5e1
# ╟─1894774b-f49c-4529-81de-45c39c2dab24
# ╠═55df009e-a2e4-45bb-b49c-4dd2c5b881f7
# ╟─83fe6453-d941-45c9-8f7e-a4d8a0833a54
# ╠═9024bd66-2094-4c47-95e4-2c11d61d73bb
# ╟─281536b2-06e4-4940-abc6-b5cf9da59f13
# ╠═e9631233-9fa9-4298-9cc5-51949236bd77
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
