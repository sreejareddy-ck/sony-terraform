#!/usr/bin/python3

import argparse
from pathlib import Path
import sys

def copy_file(source_file, destination_file):
    try:
        with open(source_file, 'r') as source:
            with open(destination_file, 'w') as destination:
                content = source.read()
                destination.write(content)
    except FileNotFoundError:
        print("One of the files does not exist.")
    except Exception as e:
        print(f"An error occurred: {str(e)}")

def create_monitor_structure(service_name, component_type, component_name):
    # Step 1: Check if component folder exists in module directory
    module_path = Path.cwd() / "modules" / component_type
    if not module_path.exists():
        print(f"Error: Component {component_type} does not exist.")
        return False

    # Step 2: Create folder for service if not present
    monitors_path = Path.cwd() / "monitors"
    service_path = monitors_path / service_name
    if not service_path.exists():
        service_path.mkdir(parents=True)

    # Step 3: Create folder for component_type, if not present
    service_module_path = service_path / component_type
    if not service_module_path.exists():
        service_module_path.mkdir()

    # Step 4: Create folder for component if not present
    service_component_path = service_module_path / component_name
    if not service_component_path.exists():
        service_component_path.mkdir()

    # Step 5: Get all subfolder names inside module/<component-name>
    subfolders = [subfolder for subfolder in module_path.iterdir() if subfolder.is_dir()]

    # Step 6: Create .tfvars files for each subfolder if not present
    for subfolder in subfolders:
        subfolder_tfvars_path = service_component_path / f"{subfolder.name}.tfvars"
        if not subfolder_tfvars_path.exists():
            subfolder_tfvars_path.touch()

            # Step 7: Read variables.tf for each subfolder
            subfolder_variables_path = Path.cwd() / "scripts/templates/variables-template-tfvars"
            copy_file(subfolder_variables_path, subfolder_tfvars_path)

    return True

def main():
    parser = argparse.ArgumentParser(description="Create monitor structure")
    parser.add_argument("--service-name", type=str, help="Name of the service", required=True)
    parser.add_argument("--component-type", type=str, help="Type of the component", required=True)
    parser.add_argument("--component-name", type=str, help="Name of the component", required=True)
    args = parser.parse_args()

    success = create_monitor_structure(args.service_name, args.component_type, args.component_name)
    if success:
        print("Folder structure and files created successfully.")
    else:
        print("Usage: ./scripts/create_monitor <service-name> <component-type> <component-name>")
        print("Usage: For more reference: Run scripts/monitor.py -h")
        sys.exit(0)

if __name__ == "__main__":
    main()
