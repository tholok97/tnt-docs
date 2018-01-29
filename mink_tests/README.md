# Functional test of our deploymet of bookface using mink and phpunit

## Dependencies

* Uses composer to handle dependencies. If it is not installed, install that first. (Example install guide: <https://getcomposer.org/doc/00-intro.md>).
* After composer is installed (you can do `composer --version` from command line), run `composer update` in this folder. This should install the dependencies of the project (mink and phpunit).

## How to run

To run use this command: `./vendor/bin/phpunit functional_test.php`. (Useful alias: `alias t='./vendor/bin/phpunit functional_test.php'`).
