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
        PATH = "/opt/homebrew/bin:" +
                "/opt/homebrew/sbin:" +
                "/usr/local/bin:" +
                "/Users/samuelgray/.rbenv/shims:" +
                "$PATH"

        // Set the PATH to include the Fastlane bin directory
        // and the rbenv Ruby bin directory
        // PATH = 
        // PATH = '/Users/samuelgray/.rbenv/shims:
        // /Applications/vapor.app/Contents/MacOS:
        // /opt/homebrew/bin:
        // /opt/homebrew/sbin:
        // /usr/local/bin:
        // /System/Cryptexes/App/usr/bin:
        // /usr/bin:/bin:/usr/sbin:/sbin:
        // /var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin:
        // /var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin:
        // /var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin:
        // /Library/Apple/usr/bin:/usr/local/bin'
        // PATH =  "$HOME/.fastlane/bin:" +
        //         "$HOME/.rvm/gems/ruby-3.3.0/bin:" +
        //         "$HOME/.rvm/gems/ruby-3.3.0@global/bin:" +
        //         "$HOME/.rvm/rubies/ruby-3.3.0/bin:" +
        //         "/usr/local/bin:" +
        //         "$PATH"

        LC_ALL = 'en_US.UTF-8'
        LANG = 'en_US.UTF-8'

        APP_NAME = 'TuhDo'
        BUILD_NAME = 'TuhDo'
        APP_TARGET = 'TuhDo'
        APP_PROJECT = 'TuhDo.xcodeproj'
        // APP_WORKSPACE = 'TuhDo.xcworkspace'
        APP_TEST_SCHEME = 'TuhDoTests'
        // PUBLISH_TO_CHANNEL = 'teams'
    }

    stages {
        stage('Echo Path') {
            steps {
                script {
                    sh 'echo $PATH'
                }
            }
        }

        //<< Git SCM Checkout >>
        stage('Git Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Update Env with Build Variant') {
            steps {
                script {
                    env.BUILD_VARIANT = params.buildVariant
                    // Conditionally define a build variant 'impact'
                    if (BUILD_VARIANT == 'Debug_TestFlight') {
                        echo "Debug_TestFlight"
                    } else if (BUILD_VARIANT == 'Release_AppStore_TestFlight') {
                        echo "Release_AppStore_TestFlight"
                    } else if (BUILD_VARIANT == 'Debug_Scan_Only') {
                        echo "Debug_Scan_Only"
                    } else {
                        echo "Else block!!"
                    }
                }
            }
        }

        // stage('Source Zsh') {
        //     steps {
        //         script {
        //             sh 'source ~/.zshrc'
        //         }
        //     }
        // }

        stage('Bundle Install') {
            steps {
                script {
                    sh 'ruby -v'
                    sh 'bundle install'
                }
            }
        }

        stage('Dot Files Check') {
            steps {
                script {
                    sh "if [ -e .gitignore ]; then echo '.gitignore found'; else echo 'no .gitignore found' && exit 1; fi"
                }
            }
        }

        stage('Git - Fetch Version/Commits') {
            steps {
                script {
                    env.GIT_COMMIT_MSG = sh(returnStdout: true, script: '''
                    git log -1 --pretty=%B ${GIT_COMMIT}
                    ''').trim()

                    env.BUILD_NUMBER_XCODE = sh(returnStdout: true, script: '''
                    echo $(xcodebuild -target "${APP_TARGET}" -configuration "${APP_BUILD_CONFIG}" -showBuildSettings  | grep -i 'CURRENT_PROJECT_VERSION' | sed 's/[ ]*CURRENT_PROJECT_VERSION = //')
                    ''').trim()

                    env.BUNDLE_SHORT_VERSION = sh(returnStdout: true, script: '''
                    echo $(xcodebuild -target "${APP_TARGET}" -configuration "${APP_BUILD_CONFIG}" -showBuildSettings  | grep -i 'MARKETING_VERSION' | sed 's/[ ]*MARKETING_VERSION = //')
                    ''').trim()

                    env.APP_BUNDLE_IDENTIFIER = sh(returnStdout: true, script: '''
                    echo $(xcodebuild -target "${APP_TARGET}" -configuration "${APP_BUILD_CONFIG}" -showBuildSettings  | grep -i 'PRODUCT_BUNDLE_IDENTIFIER' | sed 's/[ ]*PRODUCT_BUNDLE_IDENTIFIER = //')
                    ''').trim()

                    def DATE_TIME = sh(returnStdout: true, script: '''
                    date +%Y.%m.%d-%H:%M:%S
                    ''').trim()

                    env.APP_BUILD_NAME = "${env.APP_NAME}-${env.BUILD_NUMBER}-Ver-${env.BUNDLE_SHORT_VERSION}-B-${env.BUILD_NUMBER_XCODE}-${DATE_TIME}"
                    echo "Build Name: ${env.APP_BUILD_NAME}"

                    env.GIT_BRANCH = sh(returnStdout: true, script: '''
                    git name-rev --name-only HEAD
                    ''').trim()
                    echo "Branch name: ${env.BRANCH_NAME}"
                    echo "Current Branch: ${env.GIT_BRANCH}"
                }
            }
        }

    }
}
