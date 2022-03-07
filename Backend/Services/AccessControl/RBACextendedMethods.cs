using System;
using UserAcc;
using System.Collections.Generic;
using System.Web;
using Microsoft.AspNetCore.Mvc;

//Get requesting user's roles/permissions from database tables...      
public static class RBACextendedMethods
{
    public static bool CheckRole(this ControllerBase controller, string role)
    {
        bool result = false;
        try
        {
            //Check if the requesting user has the specified role...
            result = new RBACUser(controller.ControllerContext.HttpContext.User.Identity.Name).CheckRole(role);
        }
        catch { }
        return result;
    }

    public static bool CheckRoles(this ControllerBase controller, string roles)
    {
        bool result = false;
        try
        {
            //Check if the requesting user has any of the specified roles...
            //Make sure you separate the roles using initialing different roleName
            result = new RBACUser(controller.ControllerContext.HttpContext.User.Identity.Name).CheckRoles(roles);
        }
        catch { }
        return result;
    }

    public static bool CheckPermission(this ControllerBase controller, string permission)
    {
        bool result = false;
        try
        {
            //Check if the requesting user has the specified application permission...
            result = new RBACUser(controller.ControllerContext.HttpContext.User.Identity.Name).CheckPermission(permission);
        }
        catch { }
        return result;
    }

    public static bool IsAdmin(this ControllerBase controller)
    {
        bool isAdmin = false;
        try
        {
            //Check if the requesting user has the System Administrator privilege...
            isAdmin = new RBACUser(controller.ControllerContext.HttpContext.User.Identity.Name).IsAdmin;
        }
        catch { }
        return isAdmin;
    }

    public static bool IsStudent(this ControllerBase controller)
    {
        bool isStudent = false;
        try
        {
            //Check if the requesting user has the System Administrator privilege...
            isStudent = new RBACUser(controller.ControllerContext.HttpContext.User.Identity.Name).IsStudent;
        }
        catch { }
        return isStudent;
    }
}
