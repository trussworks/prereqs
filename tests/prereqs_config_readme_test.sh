#! /bin/bash
# shellcheck disable=SC1091
# Keep shellcheck from complaining about being unable to follow includes
# (since those are either shunit2 or prereq, which get shellcheck on their
# own).

MOCK_README_ALL_OK='' # These are overridden in oneTimeSetup()
MOCK_README_NOT_OK='' #

testReadmeAllOK() {
    got=$(../prereqs -r "${MOCK_README_ALL_OK}")
    want="awk exists.
sed exists.
ls exists.
bash exists.
cp exists.
OK: all prereqs found"
    assertEquals "${want}" "${got}"
}

testReadmeNotOK() {
    got=$(../prereqs -r "${MOCK_README_NOT_OK}")
    want="awk exists.
sed exists.
ls exists.
WARNING: BADTHING not found.
WARNING: ANOTHERBADTHING not found.
cp exists.
ERROR: some prereqs missing, please install them"
    assertEquals "${want}" "${got}"
}

oneTimeSetUp() {
    # Provide a mock README.md for testing.
    MOCK_README_ALL_OK="${SHUNIT_TMPDIR}/allok.md"
    cat <<EOF >"${MOCK_README_ALL_OK}"
# MyApp

My app is neat.

## prereqs
   - ls
   - bash
   - cp

## Other stuff
Here! More stuff!
EOF
    MOCK_README_NOT_OK="${SHUNIT_TMPDIR}/notok.md"
    cat <<EOF >"${MOCK_README_NOT_OK}"
# MyApp

My app is less neat.

## prereqs
   - ls
   - BADTHING
   - ANOTHERBADTHING
   - cp

## Other stuff
Here! More stuff!
EOF
    # Load script under test
    . "../prereqs"
}

. "../lib/shunit2"
