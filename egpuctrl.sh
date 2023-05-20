#!/bin/sh

# simple script for my eGPU

# GPU Path
path="/sys/class/drm/card1/device"


#	you have to change the variables if you have a different gpu


# my rx 5700 xt VDDC_CURVE

#		OD_SCLK:
#		0: 800Mhz
#		1: 1900Mhz

#		OD_MCLK:
#		1: 875MHz

#		OD_VDDC_CURVE:
#		0: 800MHz 710mV
#		1: 1417MHz 806mV
#		2: 1900MHz 1001mV


# OD_VDDC_CURVE:
vc_1="1 1417 806"
vc_2="2 1900 1001"



# set the power of the GPU performance target
performance_target(){
	echo "vc $vc_1" > /sys/class/drm/card1/device/pp_od_clk_voltage
	echo "vc $vc_2" > /sys/class/drm/card1/device/pp_od_clk_voltage
	echo "s 1 $(echo $vc_2 | awk '{print $2}')" > /sys/class/drm/card1/device/pp_od_clk_voltage
	echo "c" > /sys/class/drm/card1/device/pp_od_clk_voltage
}

# restart amdgpu driver
restart_amdgpu(){
	modprobe -r amdgpu
	sleep 5
	modprobe amdgpu
}

# usage
print_usage(){
	echo "usage: $0 [option]"
	echo -e "\t--info\t\tprint SCLK,MCLK,VDDC_CURVE"
	echo -e "\t--set-target\tset max 1900MHz max 1001mV"
	echo -e "\t--reset\t\treset SCLK,MCLK,VDDC_CURVE"
	echo -e "\t--restart-amdgpu\trestart amdgpu driver for eGPU"
}

case $1 in

	"--info") cat $path/pp_od_clk_voltage;;

	"--set-target") performance_target;;

	"--reset") echo "r" > /sys/class/drm/card1/device/pp_od_clk_voltage;;

	"--restart-amdgpu") restart_amdgpu;;

	*) print_usage;;

esac
