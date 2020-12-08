node puppetagent.mylab.local {
  include git
}
node puppetmaster.mylab.local {
  include git
}
node jenkins.mylab.local {
  include jenkins
  include git
}
