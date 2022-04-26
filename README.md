# instructions for a soundbot

Hey Baby. Looking good. Wanna install me? I'm a real good time.

## > This is what I'll do for Five dollars

Let's say all the things necessary to make this work are in place*, and yer itchin'. Ask yourself: "Where have I been putting my hands lately?"

For convience, this has been intentially designed in a convoluted fashion to exercise configuration concepts for an audio production environment.

# Wiki stuff

Now...take your pants off then open [group_vars/all.yml](group_vars/all.yml)

Change these values to reflect how you see yourself.

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
  password: <sha5billion>

path:
  - "{{ user.home }}/.local/bin"
  - "{{ user.home }}/.cargo/bin"
  - "{{ user.home }}/.gem/ruby/3.0.0/bin"
  - "/var/lib/gems/2.7.0/bin"
  - "/usr/lib/jvm/default/bin"
  - "/opt/sonic-pi/bin"
```

If you want, if you have multiple hosts with a need for different aliases on each one, put those in hosts_vars and set a task to append them to ~/.aliases

```yaml
aliases:
  - h="history 1"
```

After you're finished with that, ask yourself "Did I turn off the oven?" Then think about what environment variables you might want to set for ansible to work with. Open [soundbot.yml](soundbot.yml) to set the environment path Ansible will use. For this you will need to know how [playbook filters](https://docs.ansible.com/ansible/latest/user_guide/playbooks_filters.html) work.

```yaml
- hosts: all
  gather_facts: yes
  vars:
    env_vars:
      ZSH: "{{ user.zsh }}"
      PATH: "{{ ansible_env.PATH }}:{{ path|join(':') }}"
```

## Desktop Environment

you set which window manager and other ui related thigns...

```yaml
install_x11: True
install_i3: True
```
Set whether or not to install i3 window manager by adding a boolean variable in a group or host_vars file. You can find the default settings in the [ui section](roles/base/defaults/main.yml)

i3 is currently the default. If you'd like to add packages for any other desktop enviornment, add the packages you want in the primary vars file, create a task for it, then add a boolean to this list.


## theme

set the variables for theme elements in the [ui section](roles/base/defaults/main.yml)

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

If you would like to use git to keep track the files in your home directory then fill in the variables here. If you leave this section blank you will be prompted to initialize a git repo at some point. {--See [dots](roles/soundbot/README.md) for more detail.--}


## tasks

```bash
ansible-playbook -v --connection=local -i $HOSTNAME, soundbot.yml --list-tasks
```

# compiling applications from source
To add an application you want to compile from source...
* add the applications git repo or download location in [builds](roles/builds/defaults/main.yml)
* create a task file in builds/tasks/<appname>.yml
* add the task to the main task list in builds/tasks/main.yml

# ansible stuff

## variable precdence
{--In ansible there are 22 areas where you can set variables. Here we use 8 of them. Here is where you can find them; ranging from highest to lowest in precdence.

1. role (and include_role) params
2. set_facts / registered vars
3. include_vars
4. play vars_files
5. play vars
6. playbook host_vars/*
7. playbook group_vars/all
8. role defaults (defined in role/defaults/main.yml)--}



###### Some Resources


- [repology](https://repology.org/) | database of distro package names

- [pkgs.org](https://pkgs.org/) | same

- [command-not-found](https://command-not-found.com/) | find out what packages contains a command

- [whohas](https://github.com/whohas/whohas) | cli tool to query package databases

## lsyncd

running lsync from crambot --> bender

on bender:

git init .
git fetch
git checkout development -f
