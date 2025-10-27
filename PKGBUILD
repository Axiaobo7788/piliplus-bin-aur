# Maintainer: yeah <yeah_yaojiu@163.com>

pkgname=piliplus-bin
pkgver=1.1.4.15
pkgrel=2
url="https://github.com/bggRGjQaUbCoE/PiliPlus"
pkgdesc="A Bilibili third-party client built with Flutter. | 使用Flutter开发的BiliBili第三方客户端"
arch=('x86_64' 'aarch64')
license=('GPL-3.0')
depends=('gtk3' 'mpv' 'libayatana-appindicator')
source_x86_64=("https://github.com/bggRGjQaUbCoE/PiliPlus/releases/download/1.1.4.15/PiliPlus_linux_1.1.4%2B4285_amd64.tar.gz")
source_aarch64=("https://github.com/bggRGjQaUbCoE/PiliPlus/releases/download/1.1.4.15/PiliPlus_linux_1.1.4%2B4285_arm64.tar.gz")
options=(!debug)

sha256sums_x86_64=("21283ae37764bcd0e7a5c61abbb967692b604a9f87b7e6b35fa92ed754b1547f")
sha256sums_aarch64=("7f9c266ca7d0a0d41d113c229f21e5fa12c2ba38031bf4d714b5ae853befb961")

package() {

  install -d "$pkgdir/opt/$pkgname"
  
  cp "$srcdir/piliplus" "$pkgdir/opt/$pkgname/"
  cp -r "$srcdir/lib" "$pkgdir/opt/$pkgname/"
  cp -r "$srcdir/data" "$pkgdir/opt/$pkgname/"


 install -Dm644 "$srcdir/data/flutter_assets/assets/images/logo/logo.png" \
    "$pkgdir/usr/share/icons/hicolor/256x256/apps/$pkgname.png"

  install -Dm644 /dev/stdin "$pkgdir/usr/share/applications/$pkgname.desktop" <<EOF
[Desktop Entry]
Name=PiliPlus
Version=1.1.4.15
Comment=A Bilibili third-party client built with Flutter.
Exec=piliplus
Icon=$pkgname
Terminal=false
Type=Application
Categories=Utility;
EOF

  install -d "$pkgdir/usr/bin"
  ln -s "/opt/$pkgname/piliplus" "$pkgdir/usr/bin/piliplus"
}
