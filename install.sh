# install
sudo apt update

# folders
mkdir ova
mkdir rpms
mkdir host_vars
mkdir group_vars

## git
sudo apt install git -y

## If your Ubuntu machine doesn't get PIP
# sudo apt-add-repository universe
# sudo apt-get update

## python 
sudo apt-get install python -y
sudo apt install python-pip -y
python -V
# pip install --upgrade pip

# virtual envrionment
sudo apt-get install virtualenv
virtualenv ansible
. ansible/bin/activate
#upgrade
pip install --upgrade pip

# ansible
pip install ansible
ansible --version

## f5-sdk
pip install f5-sdk
## vmware tools
pip install pyvmomi
pip install cot

#https://clouddocs.f5.com/products/orchestration/ansible/devel/usage/virtualenv.html
### install your version
pip install --upgrade ansible

# inventory/group_vars/all.yaml
#ansible_python_interpreter: /usr/local/bin/python3

# get repos from git
## f5 ansible sandbox as root DIR
#git clone https://github.com/f5devcentral/f5-ansible-sandbox.git
#cd f5-ansible-sandbox
## do
git clone https://github.com/F5Networks/f5-declarative-onboarding.git
## as3
git clone https://github.com/F5Networks/f5-appsvcs-extension.git
## ts
git clone https://github.com/F5Networks/f5-telemetry-streaming.git

# get the f5ansible modules
ansible-galaxy install f5devcentral.f5ansible

# dev install optional
# ```
# mkdir f5-ansible-devel
# cd f5-ansible-devel
# virtualenv ansibledev
# . ansibledev/bin/activate
# pip install git+git://github.com/ansible/ansible.git@devel
# ansible-galaxy install f5devcentral.f5ansible
# ```
