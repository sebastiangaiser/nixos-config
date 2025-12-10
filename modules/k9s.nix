{ config, pkgs, ... }:
{
  programs.k9s = {
    enable = true;
      aliases = {
        dp = "deployments";
        sec = "v1/secrets";
        jo = "jobs";
        cr = "clusterroles";
        crb = "clusterrolebindings";
        ro = "roles";
        rb = "rolebindings";
        np = "networkpolicies";
        # https://cloudnative-pg.io/documentation/current/kubectl-plugin/
        cnpg = "clusters.postgresql.cnpg.io";
        # https://www.rabbitmq.com/kubernetes/operator/operator-overview
        rmqu = "users.rabbitmq.com";
        rmqv = "vhosts.rabbitmq.com";
        rmqq = "queues.rabbitmq.com";
        rmqpo = "policies.rabbitmq.com";
        rmqpe = "permissions.rabbit.com";
    };
    plugins = {
      # debug-container
      debug = {
        shortCut = "Shift-D";
        description = "Add debug container";
        dangerous = true;
        scopes = [ "pods" ];
        command = "bash";
        background = false;
        confirm = true;
        args = [
          "-c"
          "kubectl --kubeconfig=$KUBECONFIG debug -it --context $CONTEXT -n=$NAMESPACE $POD --target=$NAME --image=ghcr.io/nicolaka/netshoot:v0.14 --share-processes -- bash"
        ];
      };
      # remove-finalizers
      remove-finalizers = {
        shortCut = "Shift-D";
        confirm = true;
        dangerous = true;
        description = "Removes all finalizers from selected resource. Be careful when using it, it may leave dangling resources or delete them";
        scopes = [
          "persistentvolumeclaimes"
          "namespaces"
        ];
        command = "kubectl";
        background = true;
        args = [
          "patch"
          "--context"
          "$CONTEXT"
          "--namespace"
          "$NAMESPACE"
          "$RESOURCE_NAME.$RESOURCE_GROUP"
          "$NAME"
          "-p {'metadata':{'finalizers':null}}"
          "--type"
          "merge"
        ];
      };
      # stern
      stern = {
        shortCut = "Ctrl-Y";
        confirm = false;
        description = "Logs <Stern>";
        scopes = [ "pods" ];
        command = "stern";
        background = false;
        args = [
          "--tail"
          "50"
          "$FILTER"
          "-n"
          "$NAMESPACE"
          "--context"
          "$CONTEXT"
        ];
      };
      # helm-diff
      helm-diff-previous = {
        shortCut = "Shift-D";
        confirm = false;
        description = "Diff with Previous Revision";
        scopes = [ "helm" ];
        command = "bash";
        background = false;
        args = [
          "-c"
          "LAST_REVISION=$(($COL-REVISION-1));"
          "helm diff revision $COL-NAME $COL-REVISION $LAST_REVISION --kube-context $CONTEXT --namespace $NAMESPACE --color | less -RK"
        ];
      };
      helm-diff-current = {
        shortCut = "Shift-Q";
        confirm = false;
        description = "Diff with Current Revision";
        scopes = [ "history" ];
        command = "bash";
        background = false;
        args = [
          "-c"
          "RELEASE_NAME=$(echo $NAME | cut -d':' -f1);"
          "LATEST_REVISION=$(helm history -n $NAMESPACE --kube-context $CONTEXT $RELEASE_NAME | grep deployed | cut -d$'\t' -f1 | tr -d ' \t');"
          "helm diff revision $RELEASE_NAME $LATEST_REVISION $COL-REVISION --kube-context $CONTEXT --namespace $NAMESPACE --color | less -RK"
        ];
      };
      # cert-manager
      cert-status = {
        shortCut = "Shift-S";
        confirm = false;
        description = "Certificate status";
        scopes = [ "certificates" ];
        command = "bash";
        background = false;
        args = [
          "-c"
          "cmctl status certificate --context $CONTEXT -n $NAMESPACE $NAME |& less"
        ];
      };
      cert-renew = {
        shortCut = "Shift-R";
        confirm = false;
        description = "Certificate renew";
        scopes = [ "certificates" ];
        command = "bash";
        background = false;
        args = [
          "-c"
          "cmctl renew --context $CONTEXT -n $NAMESPACE $NAME |& less"
        ];
      };
      secret-inspect = {
        shortCut = "Shift-I";
        confirm = false;
        description = "Inspect secret";
        scopes = [ "secrets" ];
        command = "bash";
        background = false;
        args = [
          "-c"
          "cmctl inspect secret --context $CONTEXT -n $NAMESPACE $NAME |& less"
        ];
      };
      # terraform-controller
      reconcile-terraform = {
        shortCut = "Shift-C";
        confirm = false;
        description = "Re_c_oncile a Terraform";
        scopes = [ "terraforms" ];
        command = "tfctl";
        background = true;
        args = [
          "reconcile"
          "--request-timeout"
          "1s"
          "--context"
          "$CONTEXT"
          "--namespace"
          "$NAMESPACE"
          "$NAME"
        ];
      };
      resume-terraform = {
        shortCut = "Shift-R";
        confirm = false;
        description = "Resume a Terraform";
        scopes = [ "terraforms" ];
        command = "tfctl";
        background = true;
        args = [
          "resume"
          "--request-timeout"
          "1s"
          "--context"
          "$CONTEXT"
          "--namespace"
          "$NAMESPACE"
          "$NAME"
        ];
      };
      suspend-terraform = {
        shortCut = "Shift-S";
        confirm = false;
        description = "Suspend a Terraform";
        scopes = [ "terraforms" ];
        command = "tfctl";
        background = true;
        args = [
          "suspend"
          "--request-timeout"
          "1s"
          "--context"
          "$CONTEXT"
          "--namespace"
          "$NAMESPACE"
          "$NAME"
        ];
      };
      break-glass-terraform = {
        shortCut = "Shift-B";
        confirm = true;
        description = "BREAK GLASS Terraform";
        scopes = [ "terraforms" ];
        command = "bash";
        background = false;
        args = [
          "-c"
          "tfctl break-glass --context $CONTEXT --namespace $NAMESPACE $NAME ; sleep infinity"
        ];
      };
      # gitrepository
      reconcile-gitrepository = {
        shortCut = "Shift-C";
        confirm = false;
        description = "Re_c_oncile a GitRepository";
        scopes = [ "gitrepositories" ];
        command = "flux";
        background = true;
        args = [
          "reconcile"
          "--timeout"
          "1s"
          "source"
          "git"
          "--context"
          "$CONTEXT"
          "--namespace"
          "$NAMESPACE"
          "$NAME"
        ];
      };
      resume-gitrepository = {
        shortCut = "Shift-R";
        confirm = false;
        description = "Resume a GitRepository";
        scopes = [ "gitrepositories" ];
        command = "flux";
        background = true;
        args = [
          "resume"
          "--timeout"
          "1s"
          "source"
          "git"
          "--context"
          "$CONTEXT"
          "--namespace"
          "$NAMESPACE"
          "$NAME"
        ];
      };
      suspend-gitrepository = {
        shortCut = "Shift-S";
        confirm = false;
        description = "Suspend a GitRepository";
        scopes = [ "gitrepositories" ];
        command = "flux";
        background = true;
        args = [
          "suspend"
          "--timeout"
          "1s"
          "source"
          "git"
          "--context"
          "$CONTEXT"
          "--namespace"
          "$NAMESPACE"
          "$NAME"
        ];
      };
      # helmrelease
      reconcile-helmrelease = {
        shortCut = "Shift-C";
        confirm = false;
        description = "Re_c_oncile a HelmRelease";
        scopes = [ "helmreleases" ];
        command = "flux";
        background = true;
        args = [
          "reconcile"
          "--timeout"
          "1s"
          "--with-source"
          "helmrelease"
          "--context"
          "$CONTEXT"
          "--namespace"
          "$NAMESPACE"
          "$NAME"
        ];
      };
      resume-helmrelease = {
        shortCut = "Shift-R";
        confirm = false;
        description = "Resume a HelmRelease";
        scopes = [ "helmreleases" ];
        command = "flux";
        background = true;
        args = [
          "resume"
          "--timeout"
          "1s"
          "helmrelease"
          "--context"
          "$CONTEXT"
          "--namespace"
          "$NAMESPACE"
          "$NAME"
        ];
      };
      suspend-helmrelease = {
        shortCut = "Shift-S";
        confirm = false;
        description = "Suspend a HelmRelease";
        scopes = [ "helmreleases" ];
        command = "flux";
        background = true;
        args = [
          "suspend"
          "helmrelease"
          "--context"
          "$CONTEXT"
          "--namespace"
          "$NAMESPACE"
          "$NAME"
        ];
      };
      # kustomization
      reconcile-kustomization = {
        shortCut = "Shift-C";
        confirm = false;
        description = "Re_c_oncile a Kustomization";
        scopes = [ "kustomizations" ];
        command = "flux";
        background = true;
        args = [
          "reconcile"
          "--timeout"
          "1s"
          "--with-source"
          "Kustomization"
          "--context"
          "$CONTEXT"
          "--namespace"
          "$NAMESPACE"
          "$NAME"
        ];
      };
      resume-kustomization = {
        shortCut = "Shift-R";
        confirm = false;
        description = "Resume a Kustomization";
        scopes = [ "kustomizations" ];
        command = "flux";
        background = true;
        args = [
          "resume"
          "--timeout"
          "1s"
          "kustomization"
          "--context"
          "$CONTEXT"
          "--namespace"
          "$NAMESPACE"
          "$NAME"
        ];
      };
      suspend-kustomization = {
        shortCut = "Shift-S";
        confirm = false;
        description = "Suspend a Kustomization";
        scopes = [ "kustomizations" ];
        command = "flux";
        background = true;
        args = [
          "suspend"
          "kustomization"
          "--context"
          "$CONTEXT"
          "--namespace"
          "$NAMESPACE"
          "$NAME"
        ];
      };
      # TODO duplicate plugin key found for \"Shift-T\" in \"flux-trace\"
      # flux-trace
      # flux-trace = {
      #   shortCut = "Shift-T";
      #   confirm = false;
      #   description = "Flux trace";
      #   scopes = [ "all" ];
      #   command = "sh";
      #   background = true;
      #   args = [
      #     "-c"
      #     "flux --context $CONTEXT trace $NAME --kind `echo $RESOURCE_NAME | sed -E 's/(s)$//g'` --api-version $RESOURCE_GROUP/$RESOURCE_VERSION --namespace $NAMESPACE $NAME | less"
      #   ];
      # };
      cnpg-backup = {
        shortCut = "b";
        description = "Backup";
        scopes = [ "cluster" ];
        command = "bash";
        confirm = true;
        background = false;
        args = [
          "-c"
          "kubectl cnpg backup $NAME -n $NAMESPACE --context $CONTEXT |& less -R"
        ];
      };
      cnpg-hibernate-status = {
        shortCut = "h";
        description = "Hibernate status";
        scopes = [ "cluster" ];
        command = "bash";
        background = false;
        args = [
          "-c"
          "kubectl cnpg hibernate status $NAME -n $NAMESPACE --context $CONTEXT |& less -R"
        ];
      };
      cnpg-hibernate = {
        shortCut = "Shift-H";
        description = "Hibernate";
        confirm = true;
        scopes = [ "cluster" ];
        command = "bash";
        background = false;
        args = [
          "-c"
          "kubectl cnpg hibernate on $NAME -n $NAMESPACE --context $CONTEXT |& less -R"
        ];
      };
      cnpg-hibernate-off = {
        shortCut = "Shift-H";
        description = "Wake up hibernated cluster in this namespace";
        confirm = true;
        scopes = [ "namespace" ];
        command = "bash";
        background = false;
        args = [
          "-c"
          "kubectl cnpg hibernate off $NAME -n $NAME --context $CONTEXT |& less -R"
        ];
      };
      cnpg-logs = {
        shortCut = "l";
        description = "Logs";
        scopes = [ "cluster" ];
        command = "bash";
        background = false;
        args = [
          "-c"
          "kubectl cnpg logs cluster $NAME -f -n $NAMESPACE --context $CONTEXT"
        ];
      };
      cnpg-psql = {
        shortCut = "p";
        description = "PSQL shell";
        scopes = [ "cluster" ];
        command = "bash";
        background = false;
        args = [
          "-c"
          "kubectl cnpg psql $NAME -n $NAMESPACE --context $CONTEXT"
        ];
      };
      cnpg-reload = {
        shortCut = "r";
        description = "Reload";
        confirm = true;
        scopes = [ "cluster" ];
        command = "bash";
        background = false;
        args = [
          "-c"
          "kubectl cnpg reload $NAME -n $NAMESPACE --context $CONTEXT |& less -R"
        ];
      };
      cnpg-restart = {
        shortCut = "Shift-R";
        description = "Restart";
        confirm = true;
        scopes = [ "cluster" ];
        command = "bash";
        background = false;
        args = [
          "-c"
          "kubectl cnpg restart $NAME -n $NAMESPACE --context $CONTEXT |& less -R"
        ];
      };
      # TODO duplicate plugin key found for \"s\" in \"cnpg-status\"
      # cnpg-status = {
      #   shortCut = "s";
      #   description = "Status";
      #   scopes = [ "cluster" ];
      #   command = "bash";
      #   background = false;
      #   args = [
      #     "-c"
      #     "kubectl cnpg status $NAME -n $NAMESPACE --context $CONTEXT |& less -R"
      #   ];
      # };
      cnpg-status-verbose = {
        shortCut = "Shift-S";
        description = "Status (verbose)";
        scopes = [ "cluster" ];
        command = "bash";
        background = false;
        args = [
          "-c"
          "kubectl cnpg status $NAME -n $NAMESPACE --context $CONTEXT --verbose |& less -R"
        ];
      };
    };
    settings = {
      k9s = {
        skipLatestRevCheck = true;
        logger = {
          tail = 1000;
          buffer = 100000;
          sinceSeconds = -1;
        };
        # TODO not supported by home-manager, yet...
        # namespace = {
        #   active = "all";
        #   lockFavorites = true;
        #   favorites = [
        #     "all"
        #     "monitoring"
        #     "observability"
        #     "kafka"
        #     "cert-manager"
        #     "kube-system"
        #     "kyverno"
        #     "logging"
        #     "default"
        #   ];
        # };
      };
    };
    # Set via catppuccin.nix
    skins = {};
    views = {};
  };
}
