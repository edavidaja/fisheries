_default:
  just --list

# download ss executable for linux
setup:
  wget https://github.com/nmfs-stock-synthesis/stock-synthesis/releases/download/v3.30.20/ss_linux -O ss
  chmod +x ss
  npx degit nmfs-stock-synthesis/user-examples/model_files/empirical_wtatage_and_age_selex --force

# restore environment
bootstrap:
  R -q -e "renv::restore()"
  
# write manifest
manifest:
  R -q -e 'rsconnect::writeManifest(appFiles = c("ss", "plumber.R", "control.ss", "data.ss", "forecast.ss", "ss_summary.sso", "starter.ss", "wtatage.ss"))'

# deploy to named connect server
deploy connect:
  rsconnect deploy manifest manifest.json -n {{connect}}
  
# run ss model
run:
  ./ss

clean:
  git clean -f
