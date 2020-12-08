# java

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with the java module](#setup)
    * [Beginning with the java module](#beginning-with-the-java-module)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
6. [Limitations - OS compatibility, etc.](#limitations)
7. [Development - Guide for contributing to the module](#development)

## Overview

Installs the correct Java package on various platforms.

## Module Description

The java module can automatically install Java jdk or jre on a wide variety of systems. Java is a base component for many software platforms, but Java system packages don't always follow packaging conventions. The java module simplifies the Java installation process.

## Setup

### Beginning with the java module

To install the correct Java package on your system, include the `java` class: `include java`.

## Usage

The java module installs the correct jdk or jre package on a wide variety of systems. By default, the module installs the jdk package, but you can set different installation parameters as needed. For example, to install jre instead of jdk, you would set the distribution parameter:

```puppet
class { 'java':
  distribution => 'jre',
}
```

To install the latest patch version of Java 8 on CentOS

```puppet
class { 'java' :
  package => 'java-1.8.0-openjdk-devel',
}
```

The defined type `java::oracle` installs one or more versions of Oracle Java SE. `java::oracle` depends on [puppet/archive](https://github.com/voxpupuli/puppet-archive).  By using `java::oracle` you agree to Oracle's licensing terms for Java SE.

```puppet
java::oracle { 'jdk6' :
  ensure  => 'present',
  version => '6',
  java_se => 'jdk',
}

java::oracle { 'jdk8' :
  ensure  => 'present',
  version => '8',
  java_se => 'jdk',
}
```

To install a specific release of a Java version, e.g. 8u101-b13, provide both parameters `version_major` and `version_minor` as follows:

```puppet
java::oracle { 'jdk8' :
  ensure  => 'present',
  version_major => '8u101',
  version_minor => 'b13',
  java_se => 'jdk',
}
```

To install Oracle Java to a non-default basedir (defaults: /usr/lib/jvm for Debian; /usr/java for RedHat):
```puppet
java::oracle { 'jdk8' :
  ensure  => 'present',
  version_major => '8u101',
  version_minor => 'b13',
  java_se => 'jdk',
  basedir => '/custom/java',
}
```

To ensure that a custom basedir is a directory before Oracle Java is installed (note: manage separately for custom ownership or perms):
```puppet
java::oracle { 'jdk8' :
  ensure  => 'present',
  version_major => '8u101',
  version_minor => 'b13',
  java_se => 'jdk',
  manage_basedir => true,
  basedir => '/custom/java',
}
```

## Reference

For information on the classes and types, see the [REFERENCE.md](https://github.com/puppetlabs/puppetlabs-java/blob/master/REFERENCE.md). For information on the facts, see below.

### Facts

The java module includes a few facts to describe the version of Java installed on the system:

* `java_major_version`: The major version of Java.
* `java_patch_level`: The patch level of Java.
* `java_version`: The full Java version string.
* `java_default_home`: The absolute path to the java system home directory (only available on Linux). For instance, the `java` executable's path would be `${::java_default_home}/jre/bin/java`. This is slightly different from the "standard" JAVA_HOME environment variable.
* `java_libjvm_path`: The absolute path to the directory containing the shared library `libjvm.so` (only available on Linux). Useful for setting `LD_LIBRARY_PATH` or configuring the dynamic linker.

**Note:** The facts return `nil` if Java is not installed on the system.

## Limitations

For an extensive list of supported operating systems, see [metadata.json](https://github.com/puppetlabs/puppetlabs-java/blob/master/metadata.json)

This module cannot guarantee installation of Java versions that are not available on platform repositories.

This module only manages a singular installation of Java, meaning it is not possible to manage e.g. OpenJDK 7, Oracle Java 7 and Oracle Java 8 in parallel on the same system.

Oracle Java packages are not included in Debian 7 and Ubuntu 12.04/14.04 repositories. To install Java on those systems, you'll need to package Oracle JDK/JRE, and then the module can install the package. For more information on how to package Oracle JDK/JRE, see the [Debian wiki](http://wiki.debian.org/JavaPackage).

This module is officially [supported](https://forge.puppetlabs.com/supported) for the following Java versions and platforms:

OpenJDK is supported on:

* Red Hat Enterprise Linux (RHEL) 5, 6, 7
* CentOS 5, 6, 7
* Oracle Linux 6, 7
* Scientific Linux 6
* Debian 8, 9
* Ubuntu 14.04, 16.04, 18.04
* Solaris 11
* SLES 11, 12

Sun Java is supported on:

* Debian 6

Oracle Java is supported on:

* CentOS 6
* CentOS 7
* Red Hat Enterprise Linux (RHEL) 7

### Known issues

Where Oracle change the format of the URLs to different installer packages, the curl to fetch the package may fail with a HTTP/404 error. In this case, passing a full known good URL using the `url` parameter will allow the module to still be able to install specific versions of the JRE/JDK. Note the `version_major` and `version_minor` parameters must be passed and must match the version downloaded using the known URL in the `url` parameter. 

#### OpenBSD

OpenBSD packages install Java JRE/JDK in a unique directory structure, not linking
the binaries to a standard directory. Because of that, the path to this location
is hardcoded in the `java_version` fact. Whenever you upgrade Java to a newer
version, you have to update the path in this fact.

#### FreeBSD

By default on FreeBSD, Puppet versions prior to 4.0 throw an error saying `pkgng` is not the default provider. To fix this, install the [zleslie/pkgng module](https://forge.puppetlabs.com/zleslie/pkgng) and set it as the default package provider:

```puppet
Package {
  provider => 'pkgng',
}
```

On Puppet 4.0 and later, `pkgng` is included within Puppet and is the default package provider.

## Development

Puppet modules on the Puppet Forge are open projects, and community contributions are essential for keeping them great. To contribute to Puppet projects, see our [module contribution guide.](https://docs.puppetlabs.com/forge/contributing.html)

## Contributors

The list of contributors can be found at [https://github.com/puppetlabs/puppetlabs-java/graphs/contributors](https://github.com/puppetlabs/puppetlabs-java/graphs/contributors).
