node {
  stage 'Building image'
  git '…'
  def newApp = docker.build "shred22/docker-regservice:1.0"
  newApp.push() // record this snapshot (optional)
  stage 'Test image'
  // run some tests on it (see below), then if everything looks good:
  stage 'Approve image'
  newApp.push 'latest'
}