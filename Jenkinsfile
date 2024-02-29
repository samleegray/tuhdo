pipeline {
    agent { 
        label 'mac-mini-server' 
    }

    parameters {
        // the default choice for commit-triggered builds is the first item in the choices list
        choice(name: 'buildVariant', 
        choices: ['Debug_Scan_Only', 'Debug_TestFlight', 'Release_AppStore_TestFlight'], 
        description: 'The variants to build')
    }

    environment {
        LC_ALL = 'en_US.UTF-8'
        APP_NAME = 'TuhDo'
        BUILD_NAME = 'TuhDo'
        APP_TARGET = 'TuhDo'
        APP_PROJECT = 'TuhDo.xcodeproj'
        // APP_WORKSPACE = 'TuhDo.xcworkspace'
        APP_TEST_SCHEME = 'TuhDoTests'
        // PUBLISH_TO_CHANNEL = 'teams'
    }

    stages {
        //<< Git SCM Checkout >>
        stage('Git Checkout') {
            steps {
                checkout scm
            }
    }
}