# gr_adi_lib_iio

For automated testing using hardware such as an Analog Devices ADALM-PLUTO:

```
docker \
  run \
    --device \
      "/dev/bus/usb" \
    --device-cgroup-rule \
      "a 189:* rwm" \
    --interactive \
    --name \
      "he_ad_lib_iio" \
    --rm \
    --tty \
    "gr_adi_lib_iio:v0.21"
```
