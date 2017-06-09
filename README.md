## WebSiteBackupTools
WebStie Backup Tools Support Backup to Dropbox

## How to use

1. Clone project & init

   Ex: clone to root home

```=shell
git clone https://github.com/mouson/WebSiteBackupTools.git
cd /root/WebSiteBackupTools
git submodule update --init
```

2. Environment Setting

```=shell
cd /root/WebSiteBackupTools
cp Config/config.sh.sample Config/config.sh
vim Config/config.sh
```

3. Backup

```=shell
sh /root/WebSiteBackupTools/Scripts/Backup2Dropbox.sh config.sh
```

4. have fun

## Troubleshooting

1. shasum: command not found

* CentOS 6

```=shell
yum install  perl-Digest-SHA
```

ref: [shasum: command not found](http://pkgs.loginroot.com/errors/notFound/shasum)
