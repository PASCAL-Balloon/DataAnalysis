using Plots
using CSV
using DataFrames
using StatsPlots
using Dates
using Plots.PlotMeasures

gr()
# plotly()

df = CSV.read("Presentations\\launches_19570101-20251231_v2_6_0.csv", DataFrame)

df[!, :datetime] = [DateTime(replace(d, "Z" => "")) for d in df[!, "date"]]

df[!, :year] = [year(d) for d in df[!, :datetime]]
emissions_cols = ["BC", "CO", "CO2", "H2O", "Al2O3", "Cly", "NOx"]


df_annual = combine(groupby(df, :year), emissions_cols .=> sum .=> emissions_cols)

df_annual_kt = df_annual[!,2:8] ./ 1000


labels = [raw"Black Carbon" raw"$\mathrm{CO}$" raw"$\mathrm{CO}_{\mathrm{2}}$" raw"$\mathrm{H}_{\mathrm{2}}\mathrm{O}$" raw"$\mathrm{Al}_{\mathrm{2}}\mathrm{O}_{\mathrm{3}}$" raw"$\mathrm{Cl}_\mathrm{y}$" raw"$\mathrm{NO}_{\mathrm{x}}$"]
p2_labels = [raw"Black Carbon" raw"$\mathrm{CO}$" raw"$\mathrm{Al}_{\mathrm{2}}\mathrm{O}_{\mathrm{3}}$" raw"$\mathrm{Cl}_\mathrm{y}$" raw"$\mathrm{NO}_{\mathrm{x}}$"]


p1 = groupedbar(
    # data and bar settings
    df_annual[!, :year],
    [df_annual_kt[!, "BC"] df_annual_kt[!, "CO"] df_annual_kt[!, "CO2"] df_annual_kt[!, "H2O"] df_annual_kt[!, "Al2O3"] df_annual_kt[!, "Cly"] df_annual_kt[!, "NOx"]],
    bar_position = :stack, 
    bar_width = 0.8,
    palette = :darktest,
    lw = 0,   
    # labels           
    title="Total Annual Emissions by Year",
    titlefontsize=20,
    xlims=(1955,2026),
    ylabel= "Mass [kT]",
    yguidefontsize=16,
    ylims=(0,180),
    tickfontsize=12,
    # legend
    label = labels,
    legendfontsize=14,
    extra_kwargs = Dict(:subplot => Dict(:legend_hfactor => 1.5)),
    # size and margins
    left_margin=8mm,
    top_margin=5mm,
    bottom_margin=10mm,
)

total_emissions = sum(eachcol(df_annual_kt[!, emissions_cols]))
nox_percentage = (df_annual_kt[!, "NOx"] ./ total_emissions) .* 100

p2 = groupedbar(
    # data and bar settings
    df_annual[!, :year],
    [df_annual_kt[!, "BC"] df_annual_kt[!, "CO"] df_annual_kt[!, "Al2O3"] df_annual_kt[!, "Cly"] df_annual_kt[!, "NOx"]],
    bar_position = :stack, 
    bar_width = 0.8,
    palette = :darktest,
    lw = 0,   
    # labels           
    title="Total Annual Emissions by Year",
    titlefontsize=20,
    xlims=(1955,2026),
    ylabel= "Mass [kT]",
    yguidefontsize=16,
    ylims=(0,12),
    tickfontsize=12,
    # legend
    label = p2_labels,
    legendfontsize=14,
    extra_kwargs = Dict(:subplot => Dict(:legend_hfactor => 1.5)),
    # size and margins
    left_margin=8mm,
    top_margin=5mm,
    bottom_margin=10mm,
)


p3 = bar(
    df_annual[!, :year],
    nox_percentage,
    bar_width = 0.8,
    color = :yellow3,
    lw = 0,   
    # labels           
    title= raw"$\mathrm{NO}_{\mathrm{x}}$ Share of Total Volume",
    titlefontsize=20,
    xlims=(1955,2026),
    ylabel= raw"$\mathrm{NO}_{\mathrm{x}}$ Share [%]",
    yguidefontsize=16,
    ylims = (0, maximum(nox_percentage) * 1.1),
    tickfontsize=12,
    # legend
    legend = false,
    # size and margins
    left_margin=8mm,
    top_margin=5mm,
)


plot(
    # p1, 
    p2,
    p3, 
    layout = (2, 1),
    size = (1500, 900),
    dpi = 1000;
)