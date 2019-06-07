#include <stdio.h>
#include "libopenshiftcompliance.h"

int main (int argc, char *argv[])
{
    int auditd_complies = machineconfig_systemd_unit_complies("auditd.service");
    printf("the check for auditd: %d\n", auditd_complies);
    return 0;
}
