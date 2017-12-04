def giturl = 'https://github.com/v1v/poc-jobdsl-pipelines'

job('seed') {
    scm {
        git(giturl)
    }
    steps {
        shell '''
            find ./* -maxdepth 0 ! -path . -type d | sort | while read folder
            do
                normalise=$(basename ${folder})
                echo "pipelineJob('${normalise}') {" >> pipeline.jobs
                echo "    definition {" >> pipeline.jobs
                echo "        cps {" >> pipeline.jobs
                echo "            script(readFileFromWorkspace('${normalise}/Jenkinsfile'))" >> pipeline.jobs
                echo "            sandbox()" >> pipeline.jobs
                echo "        }" >> pipeline.jobs
                echo "    }" >> pipeline.jobs
                echo "}" >> pipeline.jobs
            done
        '''
        dsl {
            text(readFileFromWorkspace('pipeline.jobs'))
            removeAction('DELETE')
        }
    }
}