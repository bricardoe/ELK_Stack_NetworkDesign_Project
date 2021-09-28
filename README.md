## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

![ELK Stack Project Network Design Diagram](ELK_Stack_NetworkDesign_Project/Images/HW-13-Elk-Stack-AzureNetworkDesign.png)

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the ELK playbook file may be used to install only certain pieces of it, such as Filebeat or Metricbeat.


This list is Ansible's inventory and is stored in the hosts text file:
 # /etc/ansible/hosts
 [webservers]
 10.0.0.4 ansible_python_interpreter=/usr/bin/python3
 10.0.0.5 ansible_python_interpreter=/usr/bin/python3
 10.0.0.6 ansible_python_interpreter=/usr/bin/python3

 [elk]
 10.1.0.4 ansible_python_interpreter=/usr/bin/python3
 
  -  The below shows the output for ELK Install Playbook file:
  


This document contains the following details:
- Description of the Topology
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly available, in addition to restricting traffic to the network.

What aspect of security do load balancers protect? 
- The load balancer protects the Data/Web traffic, ensures the availability of the web servvers and provides security of the pool members.

What is the advantage of a jump box?_
- A jump server or jump host or jumpbox is a (special-purpose) computer on a network which is used as a gateway to access other Linux machines on a private network or security zone using the SSH protocol. 

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the data and system logs.
What does Filebeat watch for?
- Filebeat monitors the log files or locations that you specify, collects log events, and forwards them either to Elasticsearch or Logstash for indexing

What does Metricbeat record?
- Metricbeat takes the metrics and statistics that it collects and sends them to the output that you specify, such as Elasticsearch or Logstash.

The configuration details of each machine may be found below.

| Name             | Function                                                     | IP Address                          | Operating System |
|------------------|--------------------------------------------------------------|-------------------------------------|------------------|
| Jump Host/Box    | Gateway (with Ansible) to Web/ELK Server(s)                  | 10.0.0.4                            | Linux            |
| Web-1            | Web Server (DVWA Container) with Filebeat / Metricbeat       | 10.0.0.5                            | Linux            |
| Web-2            | Web Server (DVWA Container) with Filebeat / Metricbeat       | 10.0.0.6                            | Linux            |
| Web-3            | Web Server (Redundancy DVWA Container)                       | 10.0.0.7                            | Liinux           |
| ELK Server       | Elk Stack Container                                          | 10.1.0.4                            | Linux            |
| Load Balancer    | Distribute the traffic load among Web Servers / pool members | 20.85.247.149 (Static External IP)  | Linux            |
| Local PC/Machine | Access to Jump Host/Box                                      | 52.249.188.250 (External/Public IP) | Window/Mac/Linux |


### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the ELK Server machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses:
-  Local PC/Machine IP: 52.249.188.250 (via tcp port 1506)

Machines within the network can only be accessed by the Jump Host/Box.
Which machine did you allow to access your ELK VM? 
- Jump Host/Box

What was its IP address?
- Jump Host/Box IP: 10.0.0.4

A summary of the access policies in place can be found in the table below:

| Name          | Publicly Accessible | Allowed IP Addresses                  |
|---------------|---------------------|---------------------------------------|
| Jump Host/Box | No                  | Local PC/Machine IP (via SSH port 22) |
| Web-1         | No                  | 10.0.0.5                              |
| Web-2         | No                  | 10.0.0.6                              |
| Web-3         | No                  | 10.0.0.7                              |
| Load Balancer | No                  | Local PC/machine (via TCP p5601)      |
| ELK Server    | No                  | Local PC/Machine (via HTTP p80)       |


### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because...

What is the main advantage of automating configuration with Ansible?
 -  The main advantage of automating configuration with Ansible is it simplifies complex tasks such as reducing repetitive system administration which frees up time and increases efficiency. 
	
The playbook implements the following tasks:
In 3-5 bullets, explain the steps of the ELK installation play. E.g., install Docker; download image; etc._

~~~ 
These are the following steps of the ELK installation playbook:

- 1.) The elk config file specify the host IP that will have the ELK Stack installed on and the remote username that will have access

	name: Configure Elk VM with Docker
	hosts: elk
	remote_user: redsysadmin

   
- 2.) Install the Docker, pip/pip3 and Python modules required for the ELK Container
  
	- name: Install docker.io    
	- name: Install pip3 
	- name: Install Docker python module

   
- 3.) The VM virtual memory was increased

	- name: Increase virtual memory
    - command: sysctl -w vm.max_map_count=262144
	- name: Use more memory
      name: vm.max_map_count
      value: "262144"
     
  
- 4.) The section downloaded and launch the docker elk container module
  
  - name: download and launch a docker elk container
    docker_container:
      name: elk
      image: sebp/elk:761
      state: started


- 5.)The below published ports were oopened for Web traffic flow:

	- 5601:5601
    - 9200:9200
    - 5044:5044 

~~~

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

![Screenshot of docker ps output](Images/screenshot-docker-ps.png.png)


Last login: Sat Sep 18 16:17:50 2021 from 10.0.0.4
redsysadmin@Elk-Srv-1:~$ sudo docker ps
CONTAINER ID   IMAGE          COMMAND                  CREATED          STATUS          PORTS                                                                              NAMES
96ef91c286d1   sebp/elk:761   "/usr/local/bin/star…"   28 minutes ago   Up 28 minutes   0.0.0.0:5044->5044/tcp, 0.0.0.0:5601->5601/tcp, 0.0.0.0:9200->9200/tcp, 9300/tcp   elk


### Target Machines & Beats
This ELK server is configured to monitor the following machines:

- Web-1 : 10.0.0.5
- Web-2 : 10.0.0.6
- Web-3 : 10.0.0.7


We have installed the following Beats on these machines:

- FileBeat and MetricBeat

These Beats allow us to collect the following information from each machine:
In 1-2 sentences, explain what kind of data each beat collects, and provide 1 example of what you expect logs to see. E.g., `Winlogbeat` collects Windows logs, which we use to track user logon events, etc._

 - FileBeat collects data about the file system, such as various log files for any access and errors events (example Nginx logs)
 - MetricBeat collects machine metrics and service statistics, such as uptime, CPU, disk space and memory info
 
 
### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:

Answer the following questions to fill in the blanks:_

Which file is the playbook? Where do you copy it?_
 - Copy the filebeat-playbook.yml and metricbeat-playbook.yml files to /etc/ansible/roles.

Which file do you update to make Ansible run the playbook on a specific machine? How do I specify which machine to install the ELK server on versus which to install Filebeat on?_
- Update the /etc/ansible/hosts file to include the ip address of the machine under elk to install the ELK server or webservers to install Filebeat.

Which URL do you navigate to in order to check that the ELK server is running?
- Run the playbook, and navigate to the public IP via the published port to allow Web traffic http://104.21013.226:5601/ to check that the installation worked as expected.




As a **Bonus**, provide the specific commands the user will need to run to download the playbook, update the files, etc.


nano /etc/ansible/hosts command is used to edit the hosts file to ensure that the private IP of elk server is added to the ansible hosts file under the elk/elkservers group

Downloaded the below config files to ensure the remote user is added and provide connectivity to the ELK Stack.

root@2bbd6b84f9ec:/etc/ansible# curl https://gist.githubusercontent.com/slape/5cc350109583af6cbe577bbcc0710c93/raw/eca603b72586fbe148c11f9c87bf96a63cb25760/Filebeat > /etc/ansible/files/filebeat-config.yml
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 73112  100 73112    0     0   460k      0 --:--:-- --:--:-- --:--:--  460k



root@2bbd6b84f9ec:/etc/ansible# curl -L -O https://gist.githubusercontent.com/slape/58541585cc1886d2e26cd8be557ce04c/raw/0ce2c7e744c54513616966affb5e9d96f5e12f73/metricbeat > /etc/ansible/files/metricbeat-config.yml
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  6188  100  6188    0     0  52440      0 --:--:-- --:--:-- --:--:-- 52440




