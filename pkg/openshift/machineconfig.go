package openshift

import (
	mcfgv1 "github.com/openshift/machine-config-operator/pkg/apis/machineconfiguration.openshift.io/v1"
	mcfgclientset "github.com/openshift/machine-config-operator/pkg/generated/clientset/versioned"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	restclient "k8s.io/client-go/rest"
	"k8s.io/client-go/tools/clientcmd"
)

func GetAllMachineConfigPools(clientset *mcfgclientset.Clientset) (*mcfgv1.MachineConfigPoolList, error) {
	return clientset.Machineconfiguration().MachineConfigPools().List(metav1.ListOptions{})
}

func GetMachineConfig(clientset *mcfgclientset.Clientset, name string) (*mcfgv1.MachineConfig, error) {
	return clientset.Machineconfiguration().MachineConfigs().Get(name, metav1.GetOptions{})
}

func IsUnitEnabled(mcfg *mcfgv1.MachineConfig, unitName string) bool {
	systemdUnits := mcfg.Spec.Config.Systemd.Units

	for _, unit := range systemdUnits {
		if unit.Name == unitName && *unit.Enabled == true {
			return true
		}
	}
	return false
}

func SetupKubeConfig() (*restclient.Config, error) {
	loadingRules := clientcmd.NewDefaultClientConfigLoadingRules()
	configOverrides := &clientcmd.ConfigOverrides{}
	kubeConfig := clientcmd.NewNonInteractiveDeferredLoadingClientConfig(loadingRules, configOverrides)
	return kubeConfig.ClientConfig()
}
