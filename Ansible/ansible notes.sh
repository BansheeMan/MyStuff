ansible all -m ping
ansible all -m setup
ansible all --list-host
ansible-inventory --list    # показывает все переменные у серверов
ansible-inventory --graph
ansible all --list-hosts -i hosts
ansible  --list-hosts -i hosts -vvv   # -v  -vv -vvv VERBOSE

ansible-playbook playbook.yml -i hosts
ansible-playbook playbook.yml --start-at-task Installing php fpm and php mysql
ansible-playbook -i inventory.ini playbook.yml -l server1
ansible-playbook playbook.yml --limit "192.168.1.100"
ansible-playbook playbook.yml --limit "имя_хоста"

ansible-doc -l                                                           # show list of module
ansible-galaxy collection install community.mysql

ansible lemp -m shell -a "uptime"                                       # show uptime throw SHELL
ansible lemp -m command -a "uptime"                                     # show uptime throw COMMAND
ansible kubeadm-worker-2 -a "kill 2712"
ansible kubeadm-master-2 --become -a "kill 14957"
ansible all -m command -a "kill 14957"
ansible kubespray_cluster --become -a 'sh -c "apt update && apt install -y python3 python3-pip"'
ansible kubeadm-master-2 --become -m shell -a "echo $USER > /tmp/user.txt && date"

ansible all -m copy -a "src=bla.txt dest=/home mode=777" -b                  # create file
ansible all -m file -a "path=/home/bla.txt state=absent" -b                  # remove file
ansible all -m get_url -a "url=https://www.google.com/bla.txt dest=/home"    # download file
ansible all -m yum -a "name=nginx state=latest" -b                           # apt install
ansible all -m uri -a "url=https://www.google.com"                           # check connect to url
ansible all -m uri -a "url=https://www.google.com return_content=yes"        # check connect to url and return content

##################   DEBUG    #########################

tasks:
  - name: Install packages
    yum:
      name: httpd
      state: present
    tags: install

  - name: Start service
    service:
      name: httpd
      state: started
    tags: start

     tasks:
    - name: Вывести секретную переменную
      debug:
        var: secret

    - name: Вывести секретное слово с сообщением
      debug:
        msg: "Секретное слово: {{ secret }}"

ansible-playbook site.yml --tags install                   # запускаешь только нужную задачу
ansible-playbook site.yml --tags "install,start"           # несколько
ansible-playbook site.yml --skip-tags start                # запустить всё кроме определённой задачи

ansible-playbook site.yml --start-at-task="Install packages"    # запускает плейбук начиная С указанной задачи, НО НЕ ТОЛЬКО ЕЁ.


    - name: "DOTNET_VERSION"
      ansible.builtin.debug:
        msg: "{{ dotnet_version }} >> {{ dotnet_version | type_debug }}"
      when: dotnet_version is defined

    - name: "DOTNET_VERSIONSSSSS"
      ansible.builtin.debug:
        msg: "{{ dotnet_versions }} >> {{ dotnet_versions | type_debug }}"
      when: dotnet_versions is defined

    - name: "__DOTNET_VERSIONS"
      ansible.builtin.debug:
        msg: |
          "{{ __dotnet_versions }} >> {{ __dotnet_versions | type_debug }}"
          "{{ __dotnet_versions[0] }} >> {{ __dotnet_versions[0] | type_debug }}"


################## DELETE ANSIBLE CORE #########################
sudo apt remove --purge ansible ansible-core -y
sudo apt autoremove --purge -y