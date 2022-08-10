cluster:
        k3d cluster create sandman \
            -p 80:80@loadbalancer \
            -v /etc/machine-id:/etc/machine-id:ro \
            -v /var/log/journal:/var/log/journal:ro \
            -v /var/run/docker.sock:/var/run/docker.sock \
            --k3s-server-arg '--no-deploy=traefik' \
            --k3s-server-arg enable-admission-plugins=PodSecurityPolicy,NodeRestriction \
            --agents 0