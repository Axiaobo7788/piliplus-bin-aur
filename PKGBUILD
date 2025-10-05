# Maintainer: Ethan <yeah_yaojiu@163.com>

pkgname=piliplus-bin
pkgver=1.1.4+4176
_version_=1.1.4.8
pkgrel=1
url="https://github.com/bggRGjQaUbCoE/PiliPlus"
pkgdesc="A Bilibili third-party client built with Flutter. | 使用Flutter开发的BiliBili第三方客户端"
arch=('x86_64')
license=('GPL3.0')
depends=('gtk3' 'mpv' 'libayatana-appindicator')
source=("${url}/releases/download/${_version_}/PiliPlus_linux_${pkgver}_amd64.tar.gz")
options=(!debug)

sha256sums=('b09bc8672f8d4cc84d7c0fb6c01fd4030a41a98b0c6783855e8d13ba7ef021f8')

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
