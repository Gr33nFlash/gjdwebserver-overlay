# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson gnome2-utils xdg

COMMIT="37e96593d4accb1c637e992daa8466d444365db5"
LIBGD_COMMIT="c7c7ff4e05d3fe82854219091cf116cce6b19de0"

DESCRIPTION="XMPP and SMS messaging via libpurple and Modemmanager"
HOMEPAGE="https://source.puri.sm/Librem5/chatty"
SRC_URI="
	https://gitlab.gnome.org/GNOME/libgd/-/archive/${LIBGD_COMMIT}/libgd-${LIBGD_COMMIT}.tar.gz
	https://source.puri.sm/Librem5/chatty/-/archive/v${PV}/${PN}-v${PV}.tar.gz
	"

LICENSE="GPL-3"
SLOT="0"
IUSE=""
KEYWORDS="~arm64"

DEPEND="	gnome-extra/evolution-data-server[phonenumber]
		dev-libs/feedbackd
		gui-libs/libhandy
		x11-plugins/purple-mm-sms
		dev-libs/olm
		dev-libs/libphonenumber
		x11-libs/gtk+:3
		net-im/jabber-base
"
RDEPEND="${DEPEND}"
BDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-v${PV}"

src_prepare() {
	default
	eapply_user
	rm -r "${S}"/subprojects/libgd || die
	mv "${WORKDIR}"/libgd-"${LIBGD_COMMIT}" "${S}"/subprojects/libgd || die
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}