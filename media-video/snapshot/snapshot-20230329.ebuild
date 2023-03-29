# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License-2

EAPI=8

CRATES="
  blocking-1.3.0
  block-buffer-0.10.4
  proc-macro-crate-1.3.1
  rand_chacha-0.3.1
  quick-xml-0.23.1
  proc-macro-error-attr-1.0.4
  rustc_version-0.4.0
  rustix-0.37.3
  proc-macro2-1.0.53
  regex-1.7.3
  slab-0.4.8
  temp-dir-0.1.11
  system-deps-6.0.4
  thiserror-1.0.40
  thiserror-impl-1.0.40
  socket2-0.4.9
  thread_local-1.1.7
  toml_datetime-0.6.1
  tracing-attributes-0.1.23
  toml-0.7.3
  tracing-core-0.1.30
  tracing-0.1.37
  tracing-log-0.1.3
  unicode-bidi-0.3.13
  version-compare-0.1.1
  value-bag-1.0.0-alpha.9
  waker-fn-1.1.0
  version_check-0.9.4
  wayland-sys-0.30.1
  indexmap-1.9.3
  gst-plugin-version-helper-0.7.5
  wayland-protocols-0.30.0
  winnow-0.4.1
  zbus_names-2.5.0
  zvariant_utils-1.0.0
  log-0.4.17
  zvariant-3.12.0
  wayland-scanner-0.30.0
  option-operations-0.5.0
  gstreamer-video-0.20.3
  libadwaita-0.3.1
  overload-0.1.1
  ordered-stream-0.2.0
  pkg-config-0.3.26
  parking-2.0.0
  pango-sys-0.17.0
  pango-0.17.4
  pin-utils-0.1.0
  pin-project-lite-0.2.9
  sharded-slab-0.1.4
  async-trait-0.1.68
  gtk4-0.6.4
  libc-0.2.140
  gstreamer-gl-x11-sys-0.20.0
  gstreamer-gl-wayland-sys-0.20.0
  gstreamer-gl-wayland-0.20.0
  gstreamer-gl-x11-0.20.0
  linux-raw-sys-0.3.0
  gstreamer-gl-sys-0.20.0
  gstreamer-gl-egl-sys-0.20.0
  gstreamer-gl-0.20.0
  gstreamer-gl-egl-0.20.0
  paste-1.0.12
  percent-encoding-2.2.0
  async-std-1.12.0
  ashpd-0.4.0
  num-traits-0.2.15
  num-rational-0.4.1
  async-fs-1.6.0
  nu-ansi-term-0.46.0
  async-recursion-1.0.4
  once_cell-1.17.1
  gettext-sys-0.21.3
  num-integer-0.1.45
  gdk4-wayland-sys-0.6.3
  gtk4-sys-0.6.3
  gsk4-0.6.3
  async-lock-2.7.0
  async-executor-1.5.0
  gstreamer-0.20.3
  async-global-executor-2.3.1
  atomic-waker-1.1.0
  async-task-4.4.0
  async-io-1.13.0
  async-broadcast-0.5.1
  anyhow-1.0.70
  aho-corasick-0.7.20
  zbus_macros-3.11.1
  zvariant_derive-3.12.0
  zbus-3.11.1
  muldiv-1.0.1
  memoffset-0.7.1
  wayland-client-0.30.1
  memoffset-0.8.0
  locale_config-0.3.0
  memchr-2.5.0
  libloading-0.7.4
  libadwaita-sys-0.3.0
  lazy_static-1.4.0
  gst-plugin-gtk4-0.10.5
  wayland-backend-0.1.1
  unicode-normalization-0.1.22
  io-lifetimes-1.0.9
  idna-0.3.0
  iana-time-zone-0.1.54
  hex-0.4.3
  gsk4-sys-0.6.3
  kv-log-macro-1.0.7
  gtk4-macros-0.6.5
  url-2.3.1
  heck-0.4.1
  hashbrown-0.12.3
  gstreamer-video-sys-0.20.0
  gstreamer-sys-0.20.0
  gstreamer-base-0.20.0
  gdk4-sys-0.6.3
  gdk4-0.6.3
  unicode-ident-1.0.8
  tracing-subscriber-0.3.16
  gstreamer-base-sys-0.20.0
  gdk4-x11-sys-0.6.3
  gdk4-x11-0.6.3
  typenum-1.16.0
  semver-1.0.17
  glib-sys-0.17.4
  gdk4-wayland-0.6.3
  tinyvec_macros-0.1.1
  serde-1.0.158
  graphene-sys-0.17.0
  glib-macros-0.17.6
  toml_edit-0.19.8
  graphene-rs-0.17.1
  tinyvec-1.6.0
  gobject-sys-0.17.4
  glib-0.17.5
  gettext-rs-0.7.0
  syn-2.0.10
  gio-sys-0.17.4
  gio-0.17.4
  syn-1.0.109
  generic-array-0.14.6
  getrandom-0.2.8
  gdk-pixbuf-sys-0.17.0
  gdk-pixbuf-0.17.0
  futures-util-0.3.27
  futures-task-0.3.27
  futures-sink-0.3.27
  field-offset-0.3.5
  smallvec-1.10.0
  futures-macro-0.3.27
  futures-lite-1.12.0
  futures-io-0.3.27
  event-listener-2.5.3
  enumflags2_derive-0.7.4
  static_assertions-1.1.0
  futures-channel-0.3.27
  form_urlencoded-1.1.0
  enumflags2-0.7.5
  futures-executor-0.3.27
  futures-core-0.3.27
  fastrand-1.9.0
  dlib-0.5.0
  sha1-0.10.5
  serde_repr-0.1.12
  serde_derive-1.0.158
  downcast-rs-1.2.0
  dirs-4.0.0
  serde_spanned-0.6.1
  scoped-tls-1.0.1
  regex-syntax-0.6.29
  nix-0.26.2
  dirs-sys-0.3.7
  derivative-2.2.0
  concurrent-queue-2.1.0
  polling-2.6.0
  crossbeam-utils-0.8.15
  rand_core-0.6.4
  ctor-0.1.26
  quote-1.0.26
  proc-macro-error-1.0.4
  ppv-lite86-0.2.17
  digest-0.10.6
  cpufeatures-0.2.6
  crypto-common-0.1.6
  chrono-0.4.24
  cfg-expr-0.14.0
  byteorder-1.4.3
  pretty-hex-0.3.0
  cairo-sys-rs-0.17.0
  cairo-rs-0.17.0
  rand-0.8.5
  cfg-if-1.0.0
  cc-1.0.79
  bitflags-1.3.2
  async-channel-1.8.0
  autocfg-1.1.0
  atomic_refcell-0.1.9
"

VALA_USE_DEPEND="vapigen"

inherit cargo vala meson gnome2-utils toolchain-funcs xdg

COMMIT="7aa6b9f7e48665739f718d615a4ee7cfa6fd282b"
DESCRIPTION="Gnome Camera Application"
HOMEPAGE="https://gitlab.gnome.org/msandova/snapshot"
SRC_URI="https://gitlab.gnome.org/msandova/snapshot/-/archive/${COMMIT}/snapshot-${COMMIT}.tar.gz -> ${P}.tar.gz "
SRC_URI+=" $(cargo_crate_uris ${CRATES})"

RESTRICT="network-sandbox"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
IUSE="+introspection +vala"
REQUIRED_USE="vala? ( introspection )"

DEPEND="
	>=x11-libs/gtk+-3.0
	>=gui-libs/libadwaita-1.2.0
	media-libs/aperture
"
RDEPEND="${DEPEND}"
BDEPEND=""


S="${WORKDIR}/snapshot-${COMMIT}"

src_prepare() {
	default
	eapply_user
	use vala

}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
}
