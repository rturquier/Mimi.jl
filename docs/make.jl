using Documenter, Mimi

makedocs(
	doctest = false,
    modules = [Mimi],
	sitename = "Mimi.jl",
	pages = [
		"Home" => "index.md",
		"Tutorials" => Any[
			"Tutorials Intro" => "tutorials/tutorial_main.md",
			"1 Install Mimi" => "tutorials/tutorial_1.md"
			"2 Run an Existing Model" => "tutorials/tutorial_2.md",
			"3 Modify an Existing Model" => "tutorials/tutorial_3.md",
			"4 Create a Model" => "tutorials/tutorial_4.md",
			"5 Create a Composite Model" => "tutorials/tutorial_5.md",
			"6 Sensitivity Analysis" => "tutorials/tutorial_6.md"
		],
		"How-to Guides" => Any[
			"How-to Guides Intro" => "howto/howto_main.md",
			"1 Flat Models" => "howto/howto_1.md",
			"2 Composite Models" => "howto/howto_2.md",
			"3 Explore Results" => "howto/howto_3.md",
			"4 Sensitvity Analysis" => "howto/howto_4.md",
			"5 Advanced Topics" => "howto/howto_5.md",
			"6 Port to v0.5.0" => "howto/howto_6.md",
			"7 Port to v1.0.0" => "howto/howto_7.md"
		],
		"Reference Guides" => Any[
			"API Reference" => "ref/reference.md"
		],
		"FAQ" => "faq.md",
	]
	format = Documenter.HTML(prettyurls = get(ENV, "JULIA_NO_LOCAL_PRETTY_URLS", nothing) === nothing)
)

deploydocs(
    repo = "github.com/mimiframework/Mimi.jl.git",
)
