# Save data as an R object
facts <- read.csv("data-raw/facts.csv", stringsAsFactors = FALSE)
save(facts, file = "data/facts.RData")
