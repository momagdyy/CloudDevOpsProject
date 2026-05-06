def call(String imageName, String imageTag) {
    sh "sed -i 's|image:.*|image: ${imageName}:${imageTag}|' kubernetes/deployment.yaml"
}
