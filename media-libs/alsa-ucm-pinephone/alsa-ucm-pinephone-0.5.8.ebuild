# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

COMMIT="355d788a6b53bb6b723779c5f791b735f589479d"

DESCRIPTION="ALSA ucm configuration files for the PinePhone (Pro)"
HOMEPAGE="https://gitlab.manjaro.org/manjaro-arm/packages/community/pinephone/alsa-ucm-pinephone"
SRC_URI="https://gitlab.manjaro.org/manjaro-arm/packages/community/pinephone/alsa-ucm-pinephone/-/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/alsa-ucm-pinephone-${COMMIT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~arm64"

RDEPEND="
	>=media-libs/alsa-topology-conf-1.2.5
	>=media-libs/alsa-lib-1.2.6
	>=media-plugins/alsa-plugins-1.2.6
	>=media-libs/alsa-ucm-conf-1.2.6
	>=media-video/pipewire-0.3.42
"
DEPEND="${RDEPEND}"

src_install() {
	# PinePhone Configs
	insinto /usr/share/alsa/ucm2/PinePhone/
	insopts -m644
	doins "${S}"/PinePhone-HiFi.conf HiFi.conf
	doins "${S}"/PinePhone-VoiceCall.conf VoiceCall.conf
	doins "${S}"/PinePhone.conf

	# PinePhone Pro Configs
	insinto /usr/share/alsa/ucm2/PinePhonePro/
	insopts -m644
	doins "${S}"/PinePhonePro-HiFi.conf HiFi.conf
	doins "${S}"/PinePhonePro-VoiceCall.conf VoiceCall.conf
	doins "${S}"/PinePhonePro.conf

	# Create Symlinks
	dosym ../../../PinePhone/PinePhone.conf /usr/share/alsa/ucm2/conf.d/simple-card/PinePhone.conf
	dosym ../../../PinePhonePro/PinePhonePro.conf /usr/share/alsa/ucm2/conf.d/simple-card/PinePhonePro.conf
}
