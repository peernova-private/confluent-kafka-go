// +build linux

package kafka

// #cgo LDFLAGS: -lrdkafka -llz4 -lsasl2 -lssl -lcrypto -lz -lm -ldl -lrt
//
import "C"
