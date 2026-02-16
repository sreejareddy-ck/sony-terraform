# Service Monitors

## Overview

`service-monitors` is a Bitbucket repository designed to centralize the creation and management of Datadog monitors using Terraform. It facilitates the automation of monitoring configurations ensuring a reliable and consistent setup across your services.

## How to create monitors for your Service

You need monitor configuration files in a specific format (explained later) to create/edit monitors. We have added a utility to create said files to ease with the boilerplate setup. You will need `python3` on your system to use it. You can use the following setup script to install python, or do it manually.

```bash
./scripts/install-python.sh
```

To create the boilerplate monitor configuration files for a component of your service, run this script.

```bash
scripts/monitor.py --service-name <service-name> --component-type <component-type> --component-name  <component-name>
```

The above script only creates new configuration files and existing monitor files will not be updated.

Example:

```bash
scripts/monitor.py --service-name godavari-v2 --component-type application --component-name gv2-priority
```

This will create the following files-

```text
service-monitors
└── monitors
    ├── godavari-v2
    │   ├── application
    │   │   ├── gv2-priority
    │   │   │   ├── avg-cpu-utilization.tfvars
    │   │   │   ├── avg-disk-utilization.tfvars
    │   │   │   ├── avg-disk-utilization.tfvars
    │   │   │   └── max-disk-utilization.tfvars
    │   │   └── ...
    │   └── ...
    └── ...
```

## Structure of a service monitor directory

- **`monitors/` directory**: The root folder where monitor configurations are stored. Each subdirectory represents a service that contains one or more components.

- **Service Name Directories**: Represent individual services. Each service directory contains component types relevant to that service.

- **Component Type Directories**: Within each service directory, components are grouped by their type (e.g., `rds`, `elasticache`, `application`). This layer helps in organizing monitors by the functionality of the components.

- **Component Name Directories**: For each component type, there can be one or more specific components (identified by name or role) that require monitoring. Each component has its own directory.

- **Terraform Variable Files (`*.tfvars`)**: Each component directory contains Terraform variable files named `monitor1.tfvars`, `monitor2.tfvars`, etc. These files define the configuration for each Datadog monitor associated with the component, such as thresholds, alert messages, and notification details.

This structure is designed to be scalable and easily understandable, allowing teams to quickly find and update monitor configurations for specific services or components.

Note: The `monitor1.tfvars` and `monitor2.tfvars` are placeholder names. The actual names of the file will be based in the component type defined here: [modules](modules/)


### Sample `avg-cpu-utilization.tfvars` file

```hcl
roster              = "test-roster"
datadog_service_tag = "component-1"
slack_channel       = "@slack-test-monitoring"
message             = "High CPU utilization for test-service:component-1"
resource_type       = "ec2"
critical_threshold  = 70
critical_recovery   = 65
runbook             = "runbook"
```

Add the necessary Terraform variable files (`*.tfvars`) for the monitors associated with the service. These files define the configuration for each Datadog monitor, such as thresholds, alert messages, and notification details.

Example can be found at [test-service](monitors/test-service/)
