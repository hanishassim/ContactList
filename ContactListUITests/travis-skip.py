#!/usr/bin/python2.7

#
# travis-skip.py
# ContactListUITests
#
# Skip the UI tests in Travis builds because they aren't supported.
#
# We can't run the tests on Travis because Xcode needs permission to use the Accessibility API
# to control ContactList.
#
# See https://github.com/travis-ci/travis-ci/issues/5819
#
#

import xml.etree.ElementTree as ET

SCHEME_FILE = "ContactList/ContactList.xcodeproj/xcshareddata/xcschemes/ContactList.xcscheme"
UI_REF_XPATH = ".//BuildableReference[@BlueprintName='ContactListUITests']/.."

# Parse the Xcode scheme.
tree = ET.parse(SCHEME_FILE)

# Set the TestableReference for the UI tests to skipped.
tree.getroot().findall(UI_REF_XPATH)[0].set("skipped", "YES")

# Save the scheme.
tree.write(SCHEME_FILE)


