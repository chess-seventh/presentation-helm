%title: Helm and Helmfile
%author: Chess Seventh
%date: 2020-04-10

# Helm and Helmfile

\```
\ ___________________________
\< what are these moo' ? >
\ ---------------------------
\        ^__^
\        (oo)-_______
\        (__)        )_/
\            ||----w |
\            ||     ||
\```

--------------------

\```
\ ........................
\ | something that you'll |
\ | love and hate, donkey |
\ -------------------------
\            /
\           /
\         .--.
\        |o_o |
\        |:_/ |
\       //   \\ \\
\      (|     | )
\     /'\\_   \_/`\\
\     \\___)=(___/
\```

--------------------

# Helm

Release manager for Kubernetes

## Charts

A chart is a set of dependencies to deploy an application

e.g: [Nginx-ingress chart](https://github.com/helm/charts/tree/master/stable/nginx-ingress)

* Roles
* RolesBindings
* Service
* Deployment or DaemonSet
* etc...


--------------------

# Basic commands

First you need to import some repos

## Repos

\```
\ $ helm repo add stable https://kubernetes-charts.storage.googleapis.com
\ $ helm repo update
\ "stable" has been added to your repositories
\```

## Install a chart

\```
\ $ helm install home-nginx stable/nginx-ingress
\```


## Adapt a chart to your needs

\```
\ $ helm install my-new-nginx stable/nginx-ingress --namespace kube-system --set controller.image.repository=quay.io/kubernetes-ingress-controller/nginx-ingress-controller-arm --set controller.image.tag=0.25.1 --set controller.image.runAsUser=33 --set defaultBackend.enabled=false
\```

--------------------


\```
\ __________________________________________________________
\< This is moo'! I'll never remember all of these commands ! >
\ ----------------------------------------------------------
\        ^__^
\        (oo)-_______
\        (__)        )_/
\            ||----w |
\            ||     ||
\```

--------------------


\```
\ ....................................
\ | Hold tight to your horse, donkey, |
\ | I'm just getting started !        |
\ ------------------------------------
\            /
\           /
\         .--.
\        |o_o |
\        |:_/ |
\       //   \\ \\
\      (|     | )
\     /'\\_   \_/`\\
\     \\___)=(___/
\```

--------------------

# Values

## Get values from official chart

\```
\ $ helm inspect values stable/nginx-ingress
\ ## nginx configuration
\ ## Ref: https://github.com/kubernetes/ingress/blob/master/controllers/nginx/configuration.md
\ ##
\ controller:
\   name: controller
\   image:
\     repository: quay.io/kubernetes-ingress-controller/nginx-ingress-controller
\     tag: "0.30.0"
\     pullPolicy: IfNotPresent
\     # www-data -> uid 101
\     runAsUser: 101
\     allowPrivilegeEscalation: true
\   # This will fix the issue of HPA not being able to read the metrics.
\   # Note that if you enable it for existing deployments, it won't work as the labels are immutable.
\   # We recommend setting this to true for new deployments.
\   useComponentLabel: false
\   # Configures the ports the nginx-controller listens on
\   containerPort:
\     http: 80
\     https: 443
\   # Will add custom configuration options to Nginx https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/configmap/
\   config: {}
\ [TRUNCATED]
\```

--------------------

# Values.yaml !

## Save the values in a file

\```
\ $ helm inspect values stable/nginx-ingress > values-nginx.yaml
\```

## Edit your values to your needs

You can now re-run the chart.

\```
\ $ helm install my-new-nginx stable/nginx-ingress -f values-nginx.yaml
\```

--------------------


\```
\ _____________________________
\< Well that was pretty easy' ! >
\ -----------------------------
\        ^__^
\        (oo)-_______
\        (__)        )_/
\            ||----w |
\            ||     ||
\```

--------------------

\```
\ ................................
\ | I SAID HOLD ON TO YOUR HORSE! |
\ | You stubborn donkey !         |
\ --------------------------------
\            /
\           /
\         .--.
\        |o_o |
\        |:_/ |
\       //   \\ \\
\      (|     | )
\     /'\\_   \_/`\\
\     \\___)=(___/
\```

--------------------

# Create your own chart

\```
\ $ helm create chess-chart
\ Creating chess-chart
\ $ tree
\ .
\ └── chess-chart
\     ├── charts
\     ├── Chart.yaml
\     ├── templates
\     │   ├── deployment.yaml
\     │   ├── \_helpers.tpl
\     │   ├── ingress.yaml
\     │   ├── NOTES.txt
\     │   ├── serviceaccount.yaml
\     │   ├── service.yaml
\     │   └── tests
\     │       └── test-connection.yaml
\     └── values.yaml
\ 4 directories, 9 files
\```


--------------------


# Adapt and deploy your own chart


\```
\ $ helm install my-chart charts/chess-chart
\```

--------------------

# Helmfile

Puts all the charts you want to deploy in one single file !


\```
\ $ cat helmfile.yaml
\bases:
\  - "environments.yaml"
\---
\helmfiles:
\  - "releases/namespaces.yaml"
\  - "releases/secrets.yaml"
\  - "releases/metrics-server.yaml"
\  - "releases/nginx-ingress.yaml"
\  - "releases/external-dns.yaml"
\  - "releases/cert-manager.yaml"
\```

Environments to ease up where you wanna deploy!

\```
\ $ cat environments.yaml
\environments:
\  demo:
\    values:
\      - kubeContext: demo.rootbytes.net
\```


--------------------

# Demo time !


--------------------


# Links and sources


\```
\ .............................................
\ | github.com/chess-seventh/presentation-helm |
\ ---------------------------------------------
\            /
\           /
\         .--.
\        |o_o |
\        |:_/ |
\       //   \\ \\
\      (|     | )
\     /'\\_   \_/`\\
\     \\___)=(___/
\```

Questions?


