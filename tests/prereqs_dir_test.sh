#! /bin/bash
# shellcheck disable=SC1091
# Keep shellcheck from complaining about being unable to follow includes
# (since those are either shunit2 or prereq, which get shellcheck on their
# own).

testPrereqsDir() {
    local prereqs_dir_retval
    prereqs_dir
    # We need to do this because prereqs_dir_ returns the physical path,
    # and on macOS SHUNIT_TMPDIR is a logical path (/var is a symlink to
    # /private/var).
    local physical_tmpdir
    physical_tmpdir=$(cd -- "${SHUNIT_TMPDIR}" && pwd -P 2>/dev/null)
    assertEquals "${prereqs_dir_retval}" "${physical_tmpdir}"
}

oneTimeSetUp() {
    # Copy prereqs into the tmpdir so we can safely verify that we get
    # the right script dir.
    cp ../prereqs "${SHUNIT_TMPDIR}"
    # Load script under test
    # shellcheck source=/dev/null
    . "${SHUNIT_TMPDIR}/prereqs"
}

# Load shunit2
. "../lib/shunit2"
