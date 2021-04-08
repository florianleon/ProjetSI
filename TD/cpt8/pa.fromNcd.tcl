
# PlanAhead Launch Script for Post PAR Floorplanning, created by Project Navigator

create_project -name cpt8 -dir "/home/fleon/Bureau/ProjetSI/TD/cpt8/planAhead_run_2" -part xc6slx16csg324-3
set srcset [get_property srcset [current_run -impl]]
set_property design_mode GateLvl $srcset
set_property edif_top_file "/home/fleon/Bureau/ProjetSI/TD/cpt8/moduleCPT8.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {/home/fleon/Bureau/ProjetSI/TD/cpt8} }
set_property target_constrs_file "moduleCPT8.ucf" [current_fileset -constrset]
add_files [list {moduleCPT8.ucf}] -fileset [get_property constrset [current_run]]
open_netlist_design
read_xdl -file "/home/fleon/Bureau/ProjetSI/TD/cpt8/moduleCPT8.ncd"
if {[catch {read_twx -name results_1 -file "/home/fleon/Bureau/ProjetSI/TD/cpt8/moduleCPT8.twx"} eInfo]} {
   puts "WARNING: there was a problem importing \"/home/fleon/Bureau/ProjetSI/TD/cpt8/moduleCPT8.twx\": $eInfo"
}
