# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop gnome2-utils meson pam readme.gentoo-r1 systemd xdg

MY_P="${PN}-v${PV}"
LVC_COMMIT="a1ae68ff11dc6156f9c80069194ea39679700f3f"
LCU_COMMIT="6798b38d4d66d069751151b3e9a202c6de8d7f3c"
GMO_COMMIT="f1b50f0f90604e0f125412932dae9b1e08d57ddc"

DESCRIPTION="A pure Wayland shell prototype for GNOME on mobile devices"
HOMEPAGE="https://gitlab.gnome.org/World/Phosh/phosh/"
SRC_URI="
	https://gitlab.gnome.org/World/Phosh/phosh/-/archive/v${PV}/${MY_P}.tar.gz
	https://gitlab.gnome.org/GNOME/libgnome-volume-control/-/archive/${LVC_COMMIT}/libgnome-volume-control-${LVC_COMMIT}.tar.gz
	https://gitlab.gnome.org/World/Phosh/libcall-ui/-/archive/${LCU_COMMIT}/libcall-ui-${LCU_COMMIT}.tar.gz
	https://gitlab.gnome.org/guidog/gmobile/-/archive/${GMO_COMMIT}/gmobile-${GMO_COMMIT}.tar.gz
"
S="${WORKDIR}/${MY_P}"

KEYWORDS="~amd64 ~arm64"

LICENSE="GPL-3"
SLOT="0"
IUSE="+systemd"

DEPEND="
	app-crypt/gcr
	dev-libs/feedbackd
	media-sound/pulseaudio
	>=gui-libs/libhandy-1.1.90
	net-misc/networkmanager
	gnome-base/gnome-control-center
	gnome-base/gnome-desktop
	gnome-base/gnome-session
	x11-themes/gnome-backgrounds
	gnome-base/gnome-keyring
	gnome-base/gnome-shell
	x11-wm/phoc
	sys-apps/systemd
	sys-power/upower
	app-misc/geoclue
        net-libs/libnma
        media-sound/callaudiod
"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-util/ctags
	dev-build/meson
"

src_prepare() {
	default
	rm -r "${S}"/subprojects/gvc || die
	mv "${WORKDIR}"/libgnome-volume-control-"${LVC_COMMIT}" "${S}"/subprojects/gvc || die
	rm -r "${S}"/subprojects/libcall-ui || die
	mv "${WORKDIR}"/libcall-ui-"${LCU_COMMIT}" "${S}"/subprojects/libcall-ui || die
	rm -r "${S}"/subprojects/gmobile || die
	mv "${WORKDIR}"/gmobile-"${GMO_COMMIT}" "${S}"/subprojects/gmobile || die
	
	#Phosh patches
#	eapply "${FILESDIR}"/0001-system-prompt-allow-blank-passwords.patch
#	eapply "${FILESDIR}"/0003-fix-locale-issue-in-service-file.patch
#	eapply "${FILESDIR}"/977.patch
#	eapply "${FILESDIR}"/1008.patch

}

src_configure() {
	local emesonargs=(	
	-Dsystemd=true
	-Dtests=false
	-Dphoc_tests=disabled
	)

	meson_src_configure
}

src_install() {
	default
	meson_src_install
	newpamd "${FILESDIR}"/pam_phosh 'phosh'
	systemd_newunit "${FILESDIR}"/phosh.service 'phosh.service'
	domenu "${FILESDIR}"/sm.puri.OSK0.desktop
	dobin "${FILESDIR}"/osk-wayland

	DOC_CONTENTS="To amend the existing password policy please see the man 5 passwdqc.conf
				page and then edit the /etc/security/passwdqc.conf file to change enforce=none
				to allow use digit only password as phosh only support passcode for now"
	readme.gentoo_create_doc
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
	readme.gentoo_print_elog
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
