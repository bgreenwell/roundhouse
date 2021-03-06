roundhouse: An R wrapper to the ICNDb API <img src="tools/roundhouse-logo.png" align="right" width="130" height="150" />
========================================================================================================================

<!-- badges: start -->
[![CRAN
status](https://www.r-pkg.org/badges/version/roundhouse)](https://CRAN.R-project.org/package=roundhouse)
[![Travis-CI Build
Status](https://travis-ci.org/bgreenwell/roundhouse.svg?branch=master)](https://travis-ci.org/bgreenwell/roundhouse)
[![AppVeyor Build
Status](https://ci.appveyor.com/api/projects/status/github/bgreenwell/roundhouse?branch=master&svg=true)](https://ci.appveyor.com/project/bgreenwell/roundhouse)
[![Coverage
Status](https://img.shields.io/codecov/c/github/bgreenwell/roundhouse/master.svg)](https://codecov.io/github/bgreenwell/roundhouse?branch=master)
[![lifecycle](https://img.shields.io/badge/lifecycle-maturing-brightgreen.svg)](https://www.tidyverse.org/lifecycle/#stable)
<!-- badges: end -->

Overview
--------

Generate random Chuck Norris facts from the excellent internet Chuck
Norris database 😎.

Sample fact
-----------

Chuck Norris solved the [traveling salesman
problem](https://en.wikipedia.org/wiki/Travelling_salesman_problem) in
*O*(1) time. Here’s the pseudo-code:

    Break salesman into N pieces.
    Kick each piece to a different city.

Installation
------------

You can install the development version of `roundhouse` from GitHub
using

``` r
if (!requireNamespace("devtools")) {
  install.packages("devtools")
}
devtools::install_github("bgreenwell/roundhouse")
```

Example usage
-------------

⚠️ **WARNING:** Some facts may contain explicit material!

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

# Generate a random fact with a roundhouse kick!
roundhouse::kick(width = 40, size = 15)
```

![](tools/roundhouse.gif)

``` r
# Or simply supply your own text!
roundhouse::kick("Chuck Norris can’t test for equality because he has no equal.",
                 type = 2, width = 40, size = 25, fps = 5)
```

<img src="tools/README-example-02-1.gif" style="display: block; margin: auto auto auto 0;" />

Inspirations
------------

-   [Lone Wolf McQuade](https://www.youtube.com/watch?v=pfLTbzU0FXo)
