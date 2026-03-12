using Test
using MyTemplate

@testset "MyTemplate Tests" begin
    @testset "Configuration" begin
        config = MyTemplate.get_site_config()
        @test haskey(config, "title")
        @test haskey(config, "version")
        @test config["title"] == "MyTemplate"
    end

    @testset "Navigation Structure" begin
        nav = MyTemplate.get_navigation_structure()
        @test !isempty(nav)
        @test first(nav).title == "Home"
    end

    @testset "HTML Generation" begin
        navbar = MyTemplate.get_navbar_html()
        @test contains(navbar, "navbar")
        
        footer = MyTemplate.get_footer_html()
        @test contains(footer, "footer")
    end

    @testset "Module Export" begin
        @test :serve in names(MyTemplate)
        @test :build_docs in names(MyTemplate)
        @test :run_dev_server in names(MyTemplate)
    end
end
