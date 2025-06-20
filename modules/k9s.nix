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
        # remove-finalizers
        remove-finalizers = {
          shortCut = "Shift-D";
          confirm = true;
          dangerous = true;
          description = "Removes all finalizers from selected resource. Be careful when using it, it may leave dangling resources or delete them";
          scopes = [ "all" ];
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
