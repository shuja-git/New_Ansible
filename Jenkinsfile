pipeline {
agent { label 'WORKSTATION' }
stages {
stage("Ansible Playbook Run"){
steps{
   sh 'ansible-playbook 07-parallel.yml'
}
}
}
}