using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Routing;


public class RBACAuth 
{/*
    public override void OnAuthorization(authorize auth)
    {
        //Create permission string based on the requested controller name and action name in the format 'controllername-action'
        string requiredPermission = String.Format("{0}-{1}", auth.ActionDescriptor.ControllerDescriptor.ControllerName, auth.ActionDescriptor.ActionName);

        //Create an instance of our custom user authorization object passing requesting user's 'Windows Username' into constructor
        RBACUser result = new RBACUser(auth.RequestContext.HttpContext.User.Identity.Name);
        //Check if the requesting user has the permission to run the controller's action
        if (!result.CheckPermission(requiredPermission) & !result.IsAdmin)
        {
            //User doesn't have the required permission and is not an Admin, return our custom “401 Unauthorized” access error
            //Since we are setting filterContext.Result to contain an ActionResult page, the controller's action will not be run.
            //The custom “401 Unauthorized” access error will be returned to the browser in response to the initial request.
            auth.result = new RedirectToRouteResult(new RouteValueDictionary { { "action", "Index" }, { "controller", "Denied" } });
        }
        //If the user has the permission to run the controller's action, then filterContext.Result will be uninitialized and
        //executing the controller's action is dependant on whether filterContext.Result is uninitialized.
    }*/
}
