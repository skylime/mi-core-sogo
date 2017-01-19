#!/usr/bin/env bash
# Allow the user to control the groupware feature

if mdata-get sogo_groupware 1>/dev/null 2>&1; then
	# Require magic gsed to modify some defaults
	gsed -i \
		-e "s/isAddressBook = NO;/isAddressBook = YES;/" \
		-e "s/SOGoExternalAvatarsEnabled = NO;/SOGoExternalAvatarsEnabled = YES;/" \
		-e "s/SharedModification.js/GroupwareModification.js/" \
		/opt/local/etc/sogo/sogo.conf
fi
