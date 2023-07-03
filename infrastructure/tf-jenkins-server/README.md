1. Create Key Pair using

```sh
ssh-keygen -t rsa -b 4096 -m pem -f app_kp && mv app_kp.pub infrastructure/tf-jenkins-server/modules/compute/app_kp.pub && mv app_kp app_kp.pem && chmod 400 app_kp.pem
```