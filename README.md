


### my rx 5700 xt VDDC_CURVE
```
OD_SCLK:
0: 800Mhz
1: 1900Mhz

OD_MCLK:
1: 875MHz

OD_VDDC_CURVE:
0: 800MHz 710mV
1: 1417MHz 806mV
2: 1900MHz 1001mV
```


### good OD_VDDC_CURVE example:
```
1700MHz 875mV
1900MHz 1001mV
2000MHz 1085mV
```

### auto sclk & mclk clock
```
echo "auto" > /sys/class/drm/card1/device/power_dpm_force_performance_level 
```

### max sclk & mclk clock
```
echo "profile_peak" > /sys/class/drm/card1/device/power_dpm_force_performance_level 
```
