roundhouse: An R wrapper to the ICNDb API <img src="tools/roundhouse-logo.png" align="right" />
===============================================================================================

Generate random Chuck Norris facts from the excellent internet Chuck Norris database 😎

⚠️ **WARNING:** Some facts may contain explicit material!

Installation
------------

You can install the development version of `roundhouse` from GitHub using

``` r
if (!requireNamespace("devtools")) install.packages("devtools")
devtools::install_github("bgreenwell/roundhouse")
```

Basic usage
-----------

``` r
# Generate a random fact
roundhouse::random_fact()
#> [1] "Chuck Norris has never been accused of murder because his roundhouse kicks are recognized as 'acts of God.'"

# Generate multiple random facts
roundhouse::random_fact(3)
#> [1] "Chuck Norris doesn't need garbage collection because he doesn't call .Dispose(), he calls .DropKick()."
#> [2] "There are no steroids in baseball. Just players Chuck Norris has breathed on."                         
#> [3] "All browsers support the hex definitions #chuck and #norris for the colors black and blue."

# Print fact categories
roundhouse::fetch_categories()
#> [1] "explicit" "nerdy"
```

Inspirations
------------

-   [Lone Wolf McQuade](https://www.youtube.com/watch?v=pfLTbzU0FXo)
