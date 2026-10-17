using Plots
using Plots.Measures 
gr()

fuel_types = ["LNG/LOX", "LH/LOX", "RP1/LOX"]
y = [245.98561, 650.51951, 1862.6407]


emissions_cols = ["BC", "CO","Al2O3", "Cly", "NOx"]
pollutant_labels = [raw"Black Carbon" raw"$\mathrm{CO}$" raw"$\mathrm{Al}_{\mathrm{2}}\mathrm{O}_{\mathrm{3}}$" raw"$\mathrm{Cl}_\mathrm{y}$" raw"$\mathrm{NO}_{\mathrm{x}}$"]

lng = [78.088365, 951.112656, 125.9520, 83.327961, 245.98561]
lh = [486.44, 1338.93562, 2.0610e+04, 13635.1114, 650.51951]
rp1 = [2627.3798, 13829.4444, 2.0835e+03, 1378.39358, 1862.6407]

p1 = pie(
    emissions_cols,
    lng,
    title = "Emissions with a LNG/LOX Mixture Fuel",
    titlefontsize=20,
    palette = :darktest,
)

p2 = pie(
    emissions_cols,
    lh,
    title = "Emissions with a LH/LOX Mixture Fuel",
    titlefontsize=20,
    palette = :darktest,
    legend = false
)

p3 = pie(
    emissions_cols,
    rp1,
    title = "Emissions with a RP1/LOX Mixture Fuel",
    titlefontsize=20,
    palette = :darktest,
    legend = false
)


# p1 = pie(
#     fuel_types, 
#     y, 
#     title = raw"NO$_\mathrm{x}$ Emissions",
#     titlefontsize=20,
#     legend=false,
#     titlegap=10mm # Forces the row below to step down
# )

# p2 = pie(
#     fuel_types, 
#     [83.327961, 13635.1114, 1378.39358], 
#     title = raw"Cl$_\mathrm{y}$ Emissions",
#     titlefontsize=20, 
#     legend=false,
#     bottom_margin=10mm
# )

# p3 = pie(
#     fuel_types, 
#     [78.088365, 486.44, 2627.3798], 
#     title = "Black Carbon Emissions",
#     titlefontsize=20, 
#     legend=false 
# )

# p4 = pie(
#     fuel_types, 
#     [25173.57631, 44010.68611, 347290.9713], 
#     title = raw"CO₂ Emissions",
#     titlefontsize=20, 
#     legend=true 
# )
plot(
    p1, 
    p2,
    p3,
    layout = (2, 2),
    size = (1500, 900),
    legendfontsize=12,
    dpi = 1000,
)
