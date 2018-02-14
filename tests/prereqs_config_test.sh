#! /bin/bash
# shellcheck disable=SC1091
# Keep shellcheck from complaining about being unable to follow includes
# (since those are either shunit2 or prereq, which get shellcheck on their
# own).
MOCK_CONFIG_ALL_OK='' # These are overridden in oneTimeSetUp()
MOCK_CONFIG_NOT_OK='' #

testConfigAllOK() {
    got=$(../prereqs -c "${MOCK_CONFIG_ALL_OK}")
    want="ls exists.
bash exists.
cp exists.
OK: all prereqs found"
    assertEquals "${want}" "${got}"
}

testConfigNotOK() {
    got=$(../prereqs -c "${MOCK_CONFIG_NOT_OK}")
    want="ls exists.
WARNING: BADTHING not found.
WARNING: ANOTHERBADTHING not found.
cp exists.
ERROR: some prereqs missing, please install them"
    assertEquals "${want}" "${got}"
}

oneTimeSetUp() {
    # Provide a mock config file for testing. This will be cleaned up
    # automatically by shunit2.
    MOCK_CONFIG_ALL_OK="${SHUNIT_TMPDIR}/allok.conf"
    cat <<EOF >"${MOCK_CONFIG_ALL_OK}"
has ls
has bash
has cp
EOF

    MOCK_CONFIG_NOT_OK="${SHUNIT_TMPDIR}/notok.conf"
    cat <<EOF >"${MOCK_CONFIG_NOT_OK}"
has ls
has BADTHING
has ANOTHERBADTHING
has cp
EOF
    # Load script under test
    . "../prereqs"
}

# Load shunit2
. "../lib/shunit2"
