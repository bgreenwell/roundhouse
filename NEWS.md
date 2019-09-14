# roundhouse 0.0.1.9000


## New functions

* You can suggest new Chuck Norris facts be added in the next release via the new `suggest_new_fact()` function!

* New function `punch()` which works just like `kick()` (but without the `type` argument).

## Minor changes

* Generating Chuck Norris facts no longer requires a network connection.

* Fix URL typo in `DESCRIPTION`.

* New `sound` and `sound_repeat` arguments to `random_fact()` for determining whether or not the phrase "Chuck Norris" should be shouted, and how many times, before generating a random fact. You can also delay the sound a certain number of seconds using the `sound_delay` argument.

* The full database of existing facts is now available as a data frame via `roundhouse::facts`.


# roundhouse 0.0.1

* Initial release.
