// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import groovy.json.JsonSlurper

this_stage = "None"
gitCommit = ""
cml_token = "12345"
thisSecret = "verysecret"
agentName = ""

pipeline {
    agent none

    parameters {
        string(name: 'environment', defaultValue: 'default', description: 'Workspace/environment file to use for deployment')
        string(name: 'version', defaultValue: '', description: 'Version variable to pass to Terraform')
        booleanParam(name: 'autoApprove', defaultValue: false, description: 'Automatically run apply after generating plan?')
    }

    environment {
        JENKINS_CRED = credentials('jenkins-jenkins')
        NEXUS_CRED = credentials('jenkins-nexus')
        GIT_REPO_NAME = "AppCICD" 
    }

    stages {
        stage('Ontwikkel') {
            agent { 
                node { 
                    label 'Dev' 
                } 
            }
            stages {
                stage ('Gegevens verzamelen') {
                    steps {
                        collect_vars("Ontwikkel")
                    }
                }
                stage ('Overschakelen op build node') {
                    steps {
                        prepare("Ontwikkel", "${gitCommit}")
                    }
                }
                stage ('Deploy infra') {
                    stages {
                        stage('Plan') {
                            steps {
                                script {
                                    currentBuild.displayName = params.version
                                }
                                sh 'terraform init -input=false'
                                sh 'terraform workspace select ${environment}'
                                sh "terraform plan -input=false -out tfplan -var 'version=${params.version}' --var-file=environments/${params.environment}.tfvars"
                                sh 'terraform show -no-color tfplan > tfplan.txt'
                            }
                        }

                        stage('Approval') {
                            when {
                                not {
                                    equals expected: true, actual: params.autoApprove
                                }
                            }

                            steps {
                                script {
                                    def plan = readFile 'tfplan.txt'
                                    input message: "Do you want to apply the plan?",
                                        parameters: [text(name: 'Plan', description: 'Please review the plan', defaultValue: plan)]
                                }
                            }
                        }

                        // stage('Apply') {
                        //     steps {
                        //         sh "terraform apply -input=false tfplan"
                        //     }
                        // }
                    }
                }
                stage ('Installeren Presentatielaag servers') {
                    steps {
                        echo "Start applicatieinstallatie Ontwikkelomgeving Presentatielaag"
                        collect_vars("Ontwikkel", "Presentatie")
                        ansiblePlaybook installation: 'ansible', inventory: "vars/ontwikkel", playbook: 'ontwikkel.yml', extraVars: ["omgeving": "Ontwikkel", "compartiment": "Presentatie"], extras: '-vvvv'
                    }
                }
                stage ('Installeren Applicatielaag servers') {
                    steps {
                        echo "Start applicatieinstallatie Ontwikkelomgeving Applicatielaag"
                        collect_vars("Ontwikkel", "Applicatie")
                        ansiblePlaybook installation: 'ansible', inventory: "vars/ontwikkel", playbook: 'ontwikkel.yml', extraVars: ["omgeving": "Ontwikkel", "compartiment": "Applicatie"], extras: '-vvvv'
                    }
                }
                stage ('Installeren Datalaag servers') {
                    steps {
                        echo "Start applicatieinstallatie Ontwikkelomgeving Datalaag"
                        collect_vars("Ontwikkel", "Presentatie")
                        ansiblePlaybook installation: 'ansible', inventory: "vars/ontwikkel", playbook: 'ontwikkel.yml', extraVars: ["omgeving": "Ontwikkel", "compartiment": "Presentatie"], extras: '-vvvv'
                    }
                }
                stage('Smoke test') {
                    steps {
                        script {
                            sh "robot --variable VALID_PASSWORD:${thisSecret} -d  test_results -i Smoke smoketest.robot"
                            currentBuild.result = 'SUCCESS'
                        }
                    }
                }
                stage ('Opruimen') {
                    steps {
                        cleanup("Ontwikkel", "${gitCommit}", "${cml_token}")
                    }
                }
            }
        }
    }
    post {
        always {
            echo "Archiveren artifacts"
            //archiveArtifacts artifacts: '**/*', fingerprint: true
            //junit 'build/reports/**/*.xml'
        }
        success {
            echo "Build ${env.BUILD_tag}, commit: ${gitCommit} was successvol."
            //mail to: 'architect@infraautomator.example.com',
            //subject: "Build ${env.BUILD_tag}, commit: ${gitCommit} was successful.",
            //body: "Build is on branch ${env.JOB_NAME}"
        }
        unsuccessful {
            echo "Build ${env.BUILD_tag}, commit: ${gitCommit} mislukt."
            //mail to: 'architect@infraautomator.example.com',
            //subject: "Build ${env.BUILD_tag}, commit: ${gitCommit} was successful.",
            //body: "Build is on branch ${env.JOB_NAME}"
        }
        changed {
            echo "${env.JOB_NAME} deed de vorige keer wat anders..."
        }
    }
}

def collect_vars(my_env) {
    script {
        // Set global variables
        gitCommit = "${env.GIT_COMMIT[0..7]}"
    }                       
    echo "De commit is op branch ${env.JOB_NAME}, met short ID: ${gitCommit}"
    echo 'Aanmaken Jenkins Agent'
    script {
        thisSecret = startagent("${env.BRANCH_NAME}","${env.BUILD_tag}","${gitCommit}")
    }

    script {
        agentName = "${GIT_REPO_NAME}-${env.BRANCH_NAME}-${gitCommit}"
    }
    echo "De agent voor de volgende fase is: ${agentName}"

    return null
}

def prepare(stage, commit) {
    echo "Overgeschakeld naar jenkins agent: ${GIT_REPO_NAME}-${env.BRANCH_NAME}-${stage}-${commit}"
    checkout scm
    return null
}

def startagent(branch, build, commit) {
    echo "Aanmaken Jenkins build node placeholder voor repository: ${GIT_REPO_NAME}, branch: ${branch}, build: ${build} (commit:  ${commit})"
    sh 'curl -L -s -o /dev/null -u ' + "${JENKINS_CRED}" + ' -H Content-Type:application/x-www-form-urlencoded -X POST -d \'json={"name":+"' + "${GIT_REPO_NAME}" + "-" + "${branch}" + "-" + "${commit}" + '",+"nodeDescription":+"AppCICD+host:+' + "${GIT_REPO_NAME}" + "-" + "${branch}" + "-" + "${commit}" + '",+"numExecutors":+"1",+"remoteFS":+"/home/jenkins",+"labelString":+"' + "${GIT_REPO_NAME}" + "-" + "${branch}" + "-"+ "${commit}" + '",+"mode":+"EXCLUSIVE",+"":+["hudson.slaves.JNLPLauncher",+"hudson.slaves.RetentionStrategy$Always"],+"launcher":+{"stapler-class":+"hudson.slaves.JNLPLauncher",+"$class":+"hudson.slaves.JNLPLauncher",+"workDirSettings":+{"disabled":+false,+"workDirPath":+"",+"internalDir":+"remoting",+"failIfWorkDirIsMissing":+false},+"tunnel":+"",+"vmargs":+""},+"retentionStrategy":+{"stapler-class":+"hudson.slaves.RetentionStrategy$Always",+"$class":+"hudson.slaves.RetentionStrategy$Always"},+"nodeProperties":+{"stapler-class-bag":+"true"},+"type":+"hudson.slaves.DumbSlave"}\' "' + "${env.JENKINS_URL}" + 'computer/doCreateItem?name="' + "${GIT_REPO_NAME}" + "-" + "${branch}" + "-" + "${commit}" + '"&type=hudson.slaves.DumbSlave"'

    echo 'Ophalen Agent Secret'
    script {
        agentSecret = jenkins.model.Jenkins.getInstance().getComputer("${GIT_REPO_NAME}" + "-" + "${branch}" + "-" + "$commit").getJnlpMac()
    }

    return "${agentSecret}"
}

def stopagent(branch, build, commit) {
    echo "Verwijderen Jenkins build node placeholder voor repository: ${GIT_REPO_NAME}, branch: ${branch}, build: ${build} (commit:  ${commit})"
    sh 'curl -L -s -o /dev/null -u ' + "${JENKINS_CRED}" + ' -H "Content-Type:application/x-www-form-urlencoded" -X POST "' + "${env.JENKINS_URL}" + 'computer/' + "${GIT_REPO_NAME}" + "-" + "${branch}" + "-" + "${commit}" + '/doDelete"'
    
    return null
}

def cleanup(env, commit, token) {
    echo "Overschakelen naar jenkins agent: ${env}"

    echo 'Verwijderen Jenkins Agent'
    stopagent("${env.BRANCH_NAME}","${env.BUILD_tag}","${commit}")
    /* clean up our workspace */
    deleteDir() 
    return null
}