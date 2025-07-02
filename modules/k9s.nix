{ config, pkgs, ... }:
{
  programs.k9s = {
    enable = true;
    aliases = {
      aliases = {
        dp = "deployments";
        sec = "v1/secrets";
        jo = "jobs";
        cr = "clusterroles";
        crb = "clusterrolebindings";
        ro = "roles";
        rb = "rolebindings";
        np = "networkpolicies";
        rmqu = "users.rabbitmq.com";
        rmqv = "vhosts.rabbitmq.com";
        rmqq = "queues.rabbitmq.com";
        rmqpo = "policies.rabbitmq.com";
        rmqpe = "permissions.rabbit.com";
      };
    };
    plugin = {
      plugins = {
        # debug-container
        debug = {
          shortCut = "Shift-D";
          description = "Add debug container";
          dangerous = true;
          scopes = [ "containers" ];
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
          scopes = [ "persistentvolumeclaimes" "namespaces" ];
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
        # flux-trace
        flux-trace = {
          shortCut = "Shift-T";
          confirm = false;
          description = "Flux trace";
          scopes = [ "all" ];
          command = "sh";
          background = true;
          args = [
            "-c"
            "flux --context $CONTEXT trace $NAME --kind `echo $RESOURCE_NAME | sed -E 's/(s)$//g'` --api-version $RESOURCE_GROUP/$RESOURCE_VERSION --namespace $NAMESPACE $NAME | less"
          ];
        };
      };
    };
    settings = {
      skipLatestRevCheck = true;
      k9s = {
        logger = {
          tail = 1000;
          buffer = 100000;
          sinceSeconds = -1;
        };
      };
    };
    skins = {};
    views = {};
  };
}
