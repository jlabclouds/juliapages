import PlutoUI
import PlutoPages

# Navigation structure for mathematical tracks
const MATH_TRACKS = Dict(
    "algebra" => (
        title = "Linear Algebra",
        emoji = "🔢",
        description = "Matrix theory, linear transformations, eigenvalues",
        courses = ["MATH 676", "MATH 677"],
        chapters = [
            "01_vectors_matrices",
            "02_linear_transformations",
            "03_eigenvalues_eigenvectors",
            "04_matrix_decompositions",
            "05_applications",
        ]
    ),
    "analysis" => (
        title = "Real Analysis",
        emoji = "📈",
        description = "Limits, continuity, differentiability, integration",
        courses = ["MATH 653", "MATH 656"],
        chapters = [
            "01_real_numbers_topology",
            "02_sequences_series",
            "03_continuity",
            "04_differentiation",
            "05_integration",
        ]
    ),
    "geometry-topology" => (
        title = "Geometry & Topology",
        emoji = "🔷",
        description = "Manifolds, topological spaces, differential geometry",
        courses = ["MATH 681", "MATH 680"],
        chapters = [
            "01_topological_spaces",
            "02_manifolds",
            "03_differential_forms",
            "04_homology_cohomology",
            "05_geometric_structures",
        ]
    ),
    "scientific-computation" => (
        title = "Scientific Computation",
        emoji = "🖥️",
        description = "Numerical methods, differential equations, optimization",
        courses = ["MATH 661", "MATH 662"],
        chapters = [
            "01_floating_point_arithmetic",
            "02_linear_systems",
            "03_nonlinear_equations",
            "04_odes_pdes",
            "05_optimization",
        ]
    ),
    "applied-mathematics" => (
        title = "Applied Mathematics",
        emoji = "🌍",
        description = "Modeling, asymptotic methods, variational principles",
        courses = ["MATH 668", "MATH 669"],
        chapters = [
            "01_mathematical_modeling",
            "02_asymptotic_analysis",
            "03_perturbation_methods",
            "04_variational_principles",
            "05_case_studies",
        ]
    ),
)

"""
    get_sidebar_html()
Generate sidebar HTML for track navigation
"""
function get_sidebar_html()
    html_content = """
    <div class="track-selector">
        <h2>📚 Choose Your Track</h2>
        <nav class="track-nav">
    """
    
    for (key, track) in MATH_TRACKS
        html_content *= """
            <div class="track-item">
                <a href="/$(key)/" class="track-link">
                    <span class="emoji">$(track.emoji)</span>
                    <span class="title">$(track.title)</span>
                </a>
                <p class="description">$(track.description)</p>
                <div class="courses">
                    $(join(["<span class=\"course\">$c</span>" for c in track.courses], " "))
                </div>
            </div>
        """
    end
    
    html_content *= """
        </nav>
    </div>
    <style>
        .track-selector {
            padding: 1rem;
            border-radius: 8px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        
        .track-selector h2 {
            margin: 0 0 1.5rem 0;
            font-size: 1.2rem;
            font-weight: 600;
        }
        
        .track-nav {
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }
        
        .track-item {
            padding: 0.75rem;
            border-radius: 6px;
            background: rgba(255, 255, 255, 0.1);
            transition: all 0.3s ease;
        }
        
        .track-item:hover {
            background: rgba(255, 255, 255, 0.2);
            transform: translateX(4px);
        }
        
        .track-link {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            text-decoration: none;
            color: white;
            font-weight: 500;
        }
        
        .emoji {
            font-size: 1.5rem;
        }
        
        .description {
            margin: 0.5rem 0;
            font-size: 0.85rem;
            opacity: 0.9;
            margin-left: 2rem;
        }
        
        .courses {
            margin-left: 2rem;
            display: flex;
            gap: 0.4rem;
            flex-wrap: wrap;
        }
        
        .course {
            font-size: 0.75rem;
            background: rgba(255, 255, 255, 0.2);
            padding: 0.2rem 0.5rem;
            border-radius: 3px;
        }
    </style>
    """
    
    return PlutoUI.HTML(html_content)
end

export MATH_TRACKS, get_sidebar_html
