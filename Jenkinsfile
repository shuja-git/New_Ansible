pipeline {
agent { label 'WORKSTATION' }
   options {
        ansiColor('xterm')
    }
stages {
stage("Ansible Playbook Run"){
steps{
   sh 'ansible-playbook 07-parallel.yml'
}
}
}
}