# s(CASP) encoding of Rule 34

This is an encoding in s(CASP) of rule 34 of Singapore's Legal Profession (Professional Conduct) Rules 2015.
The source material is available [here](https://sso.agc.gov.sg/SL/LPA1966-S706-2015#pr34-).


# Installation

In order to run this software you need to install the ciao programming langauge, and then install s(CASP).

Instructions are available [here](https://gitlab.software.imdea.org/ciao-lang/sCASP).

Note that the original published version of the code was designed for an earlier version of s(CASP).
You may need to edit `run_tests.sh` to use the `--prev_forall` flag to make older encodings run properly.

# Testing

Once installed, you can run two different sets of tests against the original and amended law.

* r34.pl: Our "faithful" encoding of what the legislation says.
* r34_amended.pl: Our  proposed amendment to the section.

|File|Passed|Failed|
|---|---|---|
| r34.pl |22|25|
|r34_amended.pl|25|25|

Because the amendment changed some of the section numberings, it was necessary to rewrite some of the tests
to reflect the new numberings. There are therefore two packages of tests.

```
./run_tests.sh tests
./run_tests.sh tests_amended
```

## Using s(CASP)

To run a test directly, using the following command:

`scasp --human --tree tests/test1.pl`

replacing the filename for the specific test as appropriate.