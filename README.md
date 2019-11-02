# Basic Laravel/PHP Development Environment

A basic development environment to use with PHP, MySQL, Laravel and others.

## Getting Started

These instructions will get you a copy of the VirtualBox develop environment up and running on your local machine.

### Prerequisites

For Windows:

```
Oracle VM VirtualBox - the latest version can be found in https://www.oracle.com/virtualization/technologies/vm/;
Vagrant by Hashicorp - the latest version can be found in https://www.vagrantup.com/.
```

### Installing

Create a directory named "VM". At same level of VM directory, create a new named "code". Then, pull the project into the folder:

```
git clone https://github.com/marcoscouto10/virtualbox-machine.git
```

Now, you need to execute some Vagrant commands to up the virtual machine:

```
vagrant up
vagrant provision
```

After that, you only need to run another command to get root access on the machine:

```
vagrant ssh
```

## Authors

* **Marcos Couto**.

See also the list of [contributors](https://github.com/marcoscouto10/basic-laravel-php-dev-environment) who participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.

## Future Updates

* Add the Node.js packet
* Add the NPM packet
* ...
