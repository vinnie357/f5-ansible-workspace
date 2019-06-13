SE Ansible workspace for f5
---------------------------

Pre requisites:
===============


Environment any of:

- WSL https://docs.microsoft.com/en-us/windows/wsl/install-win10
- enable wsl bash terminal
    - file -> preferences -> settings
        search for terminal.integrated.shell
        replace the terminal with your path to wsl.exe
        example: C:\WINDOWS\System32\wsl.exe
    - Ubuntu
    - MacOSa

Software tools:
    - vsCode https://code.visualstudio.com/
    - githubdesktop https://desktop.github.com/
    - git
    - Ansible

Repo: 
    se-tmos-install https://github.com/vinnie357/se-tmos-install
software images:
    - current BIG-IP ova
nice to have:
    - BIG-IQ with Virtual Edition license pools
    - VMware vSphere

|

Clone and Install
------------------

create your python virtual enviroment then follow the install steps.
running bash install.sh will do this for you

.. code::
    
    chmod +x install.sh
    ./install.sh

|

script common failures:
    If your Ubuntu machine doesn't get PIP

    .. code::

        sudo apt-add-repository universe
        sudo apt-get update

    https://stackoverflow.com/questions/49836676/error-after-upgrading-pip-cannot-import-name-main


git ignore:
    create a .gitignore in the root directory
    make sure to ignore the ansible directory

    .. code::

        touch .gitignore
        echo "ansible" >> .gitignore
        echo ".gitignore" >> .gitignore
        echo "f5-appsvcs-extension" >> .gitignore
        echo "f5-declarative-onboarding" >> .gitignore
        echo "f5-telemetry-streaming" >> .gitignore
        echo "rpms/*" >> .gitignore
        echo "ova/*" >> .gitignore
        echo "group_vars/*" >> .gitignore
        echo "host_vars/*" >> .gitignore

    |

**modify ovas for custom IPs**
    https://devcentral.f5.com/articles/ve-on-vmware-part-1-custom-properties-29787
Common OVF Tool
    https://cot.readthedocs.io/en/latest/introduction.html

*example: cot edit-properties source-filename.ova -p net.mgmt.addr=""+string -p net.mgmt.gw=""+string -p user.root.pwd=""+string -p user.admin.pwd=""+string -u -o destination-filename.ova*

.. code::

    pip install cot
    cot edit-properties BIGIP-13.1.1.3-0.0.1.ALL-scsi.ova -p net.mgmt.addr=""+string -p net.mgmt.gw=""+string -p user.root.pwd=""+password -p user.admin.pwd=""+password -u -o vcenter-BIGIP-13.1.1.3-0.0.1.ALL-scsi.ova

|

expects: "vcenter-BIGIP-13.1.1.3-0.0.1.ALL-scsi.ova"
copy modified OVA to your project ova/f5 directory

## remove rpms and copy rpms to run for Automation tool chain

.. code::

    rm -r rpms/*
    cp f5-appsvcs-extension/dist/latest/*.rpm* rpms/
    cp f5-declarative-onboarding/dist/*.rpm* rpms/
    cp f5-telemetry-streaming/dist/*.rpm* rpms/

|

Setup
-----

.. note::

    hostname is **not** the FQDN in the folderstructure

|

populate your host_vars

.. code::

    host_vars
        hostname
            vars.yml
            vault.yml

populate your group_vars

.. code::

    group_vars
        groupname

populate your inventory

.. code::

    inventory
        [groupname]
            hostname

encrypt your vault passwords

.. code::

    ansible-vault encrypt vault.yml

.. note::

    more info here: 
        https://gist.github.com/vinnie357/de4068450f83cadf281db0cfa0b014db
|

create your context

.. code::

    context
        yourtask.yml

|

Deploy
------

create a context json with your target and role options

run deploy with your provided context

.. code::

    ansible-playbook deploy.yaml --extra-vars "@./context/bigip.yml" --ask-vault-pass

    ansible-playbook deploy.yaml --extra-vars "@./context/bigip.yml" --vault-password-file ~/.vault_pass.txt
|

Exit Virtual enviroment
-----------------------

.. code::

    deactivate

|



**To Do**
---------
- APM
    - expand apm policy
        - logon
        - ad auth
        - group check
        - sso
        - resource assign
        - network access profile
        - lease pool
    - attach new access items
        - connectivity profile
            - https
            - dtls
- Device
    - bigip HA with DO
    - trunks
- BIG-IQ
    - new device discovery and import
- Deprovisioning
    - create bigiq license clean up calls
    - device removal
- Management
    - Password rotation after deployment
- General
    - explain vmware OVA edits
        - device info for facts
        - /mgmt/shared/identified-devices/config/device-info