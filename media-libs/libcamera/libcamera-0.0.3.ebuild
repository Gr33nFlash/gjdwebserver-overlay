# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{7..10} )

inherit meson python-any-r1

DESCRIPTION="Camera support library for Linux"
HOMEPAGE="http://libcamera.org"
SRC_URI="https://github.com/libcamera-org/libcamera/archive/refs/tags/v${PV}.tar.gz"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="~arm64"
IUSE="debug doc test udev"

RDEPEND="
	>=net-libs/gnutls-3.3:=
	udev? ( virtual/libudev )
	dev-python/ply
"

DEPEND="
	${RDEPEND}
	dev-libs/openssl
	$(python_gen_any_dep 'dev-python/pyyaml[${PYTHON_USEDEP}]')
"

PATCHES=( 
	"${FILESDIR}"/libcamera-devel-v6-2-5-ipa-rkisp1-add-FrameDurationLimits-control.diff
	"${FILESDIR}"/libcamera-devel-v6-5-5-ipa-libcamera-add-support-for-ov8858-sensor.diff
	)
	
	
src_configure() {
	local emesonargs=(
		$(meson_feature doc documentation)
		$(meson_use test)
		--buildtype $(usex debug debug plain)
	)
	meson_src_configure
}

src_compile() {
	meson_src_compile
}

src_install() {
	meson_src_install
}
