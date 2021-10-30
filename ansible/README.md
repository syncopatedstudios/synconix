# instructions for a soundbot

Hey Baby. Looking good. Wanna install me? I'm a real good time.

## > This is what I'll do for Five dollars

### More than one Linux!
Choose what packages you want to install in one or all of these places:
- [Fedora](vars/RedHat/Fedora.yml)
- [Debian](vars/Debian/Debian.yml)
- [Arch](vars/Archlinux/Archlinux.yml)
- [Ruby, Python and Atom packages](vars/common.yml)

#### Packages

######Resources

Software that needs compilin' can be found in

[audio](roles/audio/defaults/main.yml)

- [repology](https://repology.org/) | database of distro package names

- [pkgs.org](https://pkgs.org/) | same

- [command-not-found](https://command-not-found.com/) | find out what packages contains a command

- [whohas](https://github.com/whohas/whohas) | cli tool to query package databases

- [fpm](https://github.com/jordansissel/fpm) | making all the packages

To add a distro...
* create a task file in the distro role.
* add packages to install in vars/distro/distro.yml
* edit distro/tasks/main.yml to include the task file for the newly added distro

To add an application...
* add the applications git repo or download location in audio/defaults/main.yml
* create a task file in audio/tasks/<appname>.yml
* add the task to the main task list in audio/tasks/main.yml

# Wiki stuff

Now...take your pants off then open [group_vars/all.yml](group_vars/all.yml)

Change these values to reflect your Linux lifestyle.

```yaml
user:
  name: b08x
  home: /home/b08x
  gnupg: /home/b08x/.gnupg
  uid: 1000
  gid: 1000
  group: b08x
  shell: zsh
  zsh: /usr/share/oh-my-zsh
  terminal: xterm
  secondary_groups: "input,video,audio"
  email: rwpannick@gmail.com
  password: <sha8092>

path:
  - "{{ user.home }}/.local/bin"
  - "{{ user.home }}/.cargo/bin"
  - "{{ user.home }}/.gem/ruby/3.0.0/bin"
  - "/var/lib/gems/2.7.0/bin"
  - "/usr/lib/jvm/default/bin"
  - "/opt/sonic-pi/bin"
```

If you have multiple hosts with a need for different aliases, put those in hosts_vars and they will be appended to ~/.aliases

```yaml
aliases:
  - h="history 1"
```

After you're finished with that, you might want to add some environment variables for ansible to work with. Open [soundbot.yml](soundbot.yml) Add anything you would export in your shell enviornment.

```yaml
- hosts: all
  gather_facts: yes
  vars:
    env_vars:
      ZSH: "{{ user.zsh }}"
      PATH: "{{ ansible_env.PATH }}:{{ path|join(':') }}"
```

## Desktop Environment

set which window manager and subsequent packages to install

```yaml
install_x11: True
install_i3: True
```
set i3 as the window manager by adding a boolean variable
you can set this per host in host_vars, in the distro defaults and in a few
other places if the need calls for it. You can find the default settings in
[ui defaults](roles/ui/defaults/main.yml)

Right now there are package lists for x11 and i3 only. If you'd like to add packages for any other desktop enviornment, add the packages you want in distro defaults, create a task for it, then add a boolean to this list.


## theme

set the variables for theme elements in [ui defaults](roles/ui/defaults/main.yml)

```yaml
gtk_theme: oomox-soundbotv2
gtk_icon_theme: oomox-soundbotv2
gtk_font:
  name: Hack Nerd Font
  size: 11
gtk_cursor_theme: Adwaita

qt5_icon_theme: oomox-soundbotv2
qt5ct_style: gtk2

kvantum_theme: MateriaDark
hintstyle: hintmedium
```

To enable these settings, run the shell function `runtag theme`

## dots
use git to manage your home directory. set these in [group_vars](group_vars/all.yml)

###### group_vars/all:
```yaml
dots:
  repo: git@github.com:b08x/dots
  home: "{{ user.home }}/.dots"
  backup: "{{ user.home }}/.dotsbackup"
  untracked: False
```

If you would like to use git to keep track the files in your home directory then fill in the variables here. If you leave this section blank you will be prompted to initialize a git repo at some point. See [dots](roles/soundbot/README.md) for more detail.


## tasks

```bash
ansible-playbook -v --connection=local -i $HOSTNAME, soundbot.yml --list-tasks
```

# ansible stuff

## variable precdence
In ansible there are 22 areas where you can set variables. Here we use 8 of them. Here is where you can find them; ranging from highest to lowest in precdence.

1. role (and include_role) params
2. set_facts / registered vars
3. include_vars
4. play vars_files
5. play vars
6. playbook host_vars/*
7. playbook group_vars/all
8. role defaults (defined in role/defaults/main.yml)
