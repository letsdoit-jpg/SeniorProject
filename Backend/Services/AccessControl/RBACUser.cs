using UserAcc;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using Microsoft.AspNetCore.Mvc;


// An ‘Action Filter’ is an ideal candidate for checking a user’s authorization for the invoked functionality

public class RBACUser // actions class for RBAC user to check for permission
{
    public int UserId { get; set; }
    public string UserName { get; set; }
    public bool IsAdmin { get; set; }
    private List<UserRole> Roles = new List<UserRole>();

    // NEED TO CREATE 
    // public bool IsStudent for students access where student will not be able to see administration option on UI. 
    public bool IsStudent { get; set; } 

    
    public RBACUser(string userName)
    {
        this.UserName = userName;
        this.IsAdmin = false;
        this.IsStudent = false;
        GetDBuserRolesPermissions();
    }

    private void GetDBuserRolesPermissions()
    {         
        // need to get user data from database table

        /*using ( )
        {
            UserAccount user = data.UserAccount.Where(x => x.UserName == this.UserName).FirstOrDefault();
            if (user != null)
            {
                this.UserName = user.Username;
                foreach (ROLE role in user.Role)
                {
                    UserRole userRole = new UserRole { RoleName = role.RoleName };
                    foreach (PERMISSION permission in role.PERMISSION)
                    {
                        userRole.Permissions.Add(new RolePermission
                        {
                            PermissionDetails = permission.PermissionDetails
                        });
                    }
                    this.Roles.Add(userRole);
                    if (!this.IsAdmin)
                    { 
                        this.IsAdmin = role.IsAdmin; 
                    }
                    else if (!this.IsStudent)
                    {
                        this.IsStudent = role.IsStudent; 
                    }
                }
            }
        }*/
    }

    public bool CheckPermission(string rPermission)
    {
        bool result = false;
        foreach (UserRole role in this.Roles)
        {
            result = (role.Permissions.Where (x => x.PermissionDetails.ToLower() == rPermission.ToLower()).ToList().Count > 0);
            if (result)
            {
                break;
            }
        }
        return result;
    }

    public bool CheckRole(string role)
    {
        return (Roles.Where(x => x.RoleName == role).ToList().Count > 0);
    }

    public bool CheckRoles(string roles)
    {
        bool result = false;
        _ = roles.ToLower().Split(';');
        foreach (UserRole role in this.Roles)
        {
            try
            {
                result = roles.Contains(role.RoleName.ToLower());
                if (result)
                    return result;
            }
            catch (Exception e)
            {
                Console.WriteLine("Roles does not found. ", e);
            }
        }
        return result;
    }

}

public class UserRole
{
   
    public string RoleName { get; set; }
    public List<RolePermission> Permissions = new List<RolePermission>();
}

public class RolePermission
{
    public string PermissionDetails{ get; set; }
}