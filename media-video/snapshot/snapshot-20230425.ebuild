# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License-2

EAPI=8

inherit gnome2-utils meson toolchain-funcs xdg

COMMIT="de7dc2f4e41f433598531f08f33821ee58634684"
DESCRIPTION="Gnome Camera Application"
HOMEPAGE="https://gitlab.gnome.org/Incubator/snapshot"
SRC_URI="https://gitlab.gnome.org/Incubator/snapshot/-/archive/${COMMIT}/snapshot-${COMMIT}.tar.gz -> ${P}.tar.gz "

RESTRICT="network-sandbox"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

DEPEND="
	>=x11-libs/gtk+-3.0
	>=gui-libs/libadwaita-1.4.0
	>=media-libs/gstreamer-1.20.0
"
RDEPEND="${DEPEND}"
BDEPEND=""


S="${WORKDIR}/snapshot-${COMMIT}"


pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
