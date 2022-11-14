library(plumber)
library(coro)
library(fastmap)
library(promises)
future::plan("multicore")

#* run SS
#* @get /ss
function() {
  future_promise(
   system(command = "./ss")
  )
}

#* get SS results
#* @get /results
function() {
  readLines("forecast.ss_new")
}
