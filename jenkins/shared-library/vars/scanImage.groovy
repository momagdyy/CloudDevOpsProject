def call(String imageName, String imageTag) {
    sh "trivy image --exit-code 0 --severity HIGH,CRITICAL ${imageName}:${imageTag}"
}
