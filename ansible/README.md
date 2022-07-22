# instructions for a soundbot v1.0.0-alpha

Hey Baby. Looking good. Wanna quick install? I'm a real good time.

(An exercise configuration concepts for an audio production environment.)

# Wiki stuff

Now...take your pants off then open [group_vars/all.yml](group_vars/all.yml)

`group_vars`
if you have different classes of hosts (say one a network, headless node another a full DAW), then you can assign those hosts to different groups within the inventory (hosts) file and set variables to apply to those groups here

`host_vars`
if group_vars made sense, then this just applies to individual hosts


Change these values to reflect _your_ values

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

## UI Variables

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
{--
###### group_vars/all:
```yaml
dots:
  repo: git@github.com:b08x/dots
  home: "{{ user.home }}/.dots"
  backup: "{{ user.home }}/.dotsbackup"
  untracked: False
```

If you would like to use git to keep track the files in your home directory then fill in the variables here. If you leave this section blank you will be prompted to initialize a git repo at some point.--} {--See [dots](roles/soundbot/README.md) for more detail.--}


## tasks

```bash
ansible-playbook -v --connection=local -i $HOSTNAME, soundbot.yml --list-tasks
```

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

- [polybar wiki](https://github.com/polybar/polybar/wiki/Configuration)
