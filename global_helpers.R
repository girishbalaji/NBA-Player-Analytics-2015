proj_dir <- dirname(parent.frame(2)$ofile)
set_wd_proj_home <- function(proj_dir) {
  setwd(proj_dir)
}
set_wd_proj_home(proj_dir)
