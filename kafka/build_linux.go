// +build linux

package kafka

// #cgo CFLAGS: -I${SRCDIR}/3rdparty/include
// #cgo LDFLAGS: ${SRCDIR}/3rdparty/lib/linux_amd64/librdkafka.a ${SRCDIR}/3rdparty/lib/linux_amd64/liblz4.a ${SRCDIR}/3rdparty/lib/linux_amd64/libsasl2.a ${SRCDIR}/3rdparty/lib/linux_amd64/libssl.a ${SRCDIR}/3rdparty/lib/linux_amd64/libcrypto.a -lz -lm -ldl -lrt
//
import "C"
