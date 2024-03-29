package main

import (
	"C"
	"fmt"

	"github.com/JAORMX/compliance-lib/pkg/openshift"
	mcfgclientset "github.com/openshift/machine-config-operator/pkg/generated/clientset/versioned"
)

//export machineconfig_systemd_unit_complies
func machineconfig_systemd_unit_complies(input *C.char) C.int {
	targetUnit := C.GoString(input)
	pass := true
	config, err := openshift.SetupKubeConfig()
	if err != nil {
		panic(err.Error())
	}

	// create the clientset
	clientset, err := mcfgclientset.NewForConfig(config)
	if err != nil {
		panic(err.Error())
	}

	mcfgpools, err := openshift.GetAllMachineConfigPools(clientset)
	if err != nil {
		panic(err.Error())
	}

	for _, machineconfigpool := range mcfgpools.Items {
		mcfgpoolName := machineconfigpool.ObjectMeta.Name
		effectiveMcfg := machineconfigpool.Status.Configuration.Name
		mcfg, err := openshift.GetMachineConfig(clientset, effectiveMcfg)
		if err != nil {
			panic(err.Error())
		}

		if openshift.IsUnitEnabled(mcfg, targetUnit) {
			fmt.Printf("'%s' is enabled for the node role '%s'\n", targetUnit, mcfgpoolName)
		} else {
			fmt.Printf("'%s' is NOT enabled for the node role '%s'\n", targetUnit, mcfgpoolName)
			pass = false
		}

	}

	if pass {
		return 1
	} else {
		return 0
	}
}

// We need an entry point; it's ok for this to be empty
func main() {}
