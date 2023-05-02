# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gnome2-utils meson vala xdg

COMMIT="d664384370bb55f0e46a78da094c567a5a7e97c6"
DESCRIPTION="Track your fitness goals"
HOMEPAGE="https://gitlab.gnome.org/World/Health/"
SRC_URI="https://gitlab.gnome.org/World/${PN}/-/archive/0.94.0/${PN}-${PV}.tar.gz"

LICENSE="CC-BY-3.0 GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

S="${WORKDIR}/${PN}-${PV}-${COMMIT}"

RDEPEND="
	>=dev-libs/glib-2.30
	>=dev-libs/json-glib-1.4.4
	>=dev-libs/libxml2-2.9.10
	>=dev-libs/libgee-0.8.5
	>=net-libs/libsoup-2.64
	>=gui-libs/gtk-4.3.0
	>=gui-libs/libadwaita-1.0
	>=app-crypt/libsecret-0.20
"

DEPEND="${RDEPEND}"

BDEPEND="
	$(vala_depend)
	virtual/pkgconfig
"
src_prepare() {
	default
	vala_setup
}

pkg_postinst() {
	gnome2_schemas_update
	xdg_pkg_postinst
}

pkg_postrm() {
	gnome2_schemas_update
	xdg_pkg_postrm
}
