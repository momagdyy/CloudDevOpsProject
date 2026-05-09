def call(String repoUrl, String imageTag) {
    sh """
        git config user.email "jenkins@jenkins.com"
        git config user.name "Jenkins"
        git checkout -B main
        git add kubernetes/deployment.yaml
        git commit -m "Update image tag to ${imageTag}"
        git push ${repoUrl} main
    """
}