#! /bin/bash
# shellcheck disable=SC1091
# Keep shellcheck from complaining about being unable to follow includes
# (since those are either shunit2 or prereq, which get shellcheck on their
# own).

testHas() {
    assertTrue "has ls"
    assertFalse "has NONEXISTANT"
}

oneTimeSetUp() {
    # Load script under test
    . "../prereqs"
}

# Load shunit2
. "../lib/shunit2"
