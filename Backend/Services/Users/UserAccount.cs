using System;

namespace UserAcc
{
    public class UserAccount
    {
        public string name;
        public string username;
        public string password;
        public string email;
        public string passcode; 
        public string role;
        public bool active;
 

        public UserAccount(string n, string u, string p, string e, string pass, string r, bool a)
        {
            this.name = n;
            this.username = u;
            this.password = p;
            this.email = e;
            this.passcode = pass;
            this.role = r;
            this.active = a;


        }

        public string Name { get => name; set => name = value; }
        public string Username { get => username; set => username = value; }
        public string Role { get => role; set => role = value; }
        public bool Active { get => active; set => active = value; }
        public string Email { get => email; set => email = value; }
        public string Password { get => password; set => password = value; }
        public string Passcode { get => passcode; set => passcode = value; }
    }

    public class ROLE
    {
        private string roleName;
        private string roleDetail;
        private bool isAdmin;
        private bool isStudent;

        public ROLE(string rn, string rd, bool a, bool s)
        {
            this.RoleName = rn;
            this.RoleDetail = rd;
            this.isAdmin = a;
            this.isStudent = s;

            PERMISSION = new HashSet<PERMISSION>();
            UserAccount = new HashSet<UserAccount>();
        }
        public string RoleName { get => roleName; set => roleName = value; }
        public string RoleDetail { get => roleDetail; set => roleDetail = value; }
        public bool IsAdmin { get => isAdmin; set => isAdmin = value; }
        public bool IsStudent { get => isStudent; set => isStudent = value; }
        public virtual ICollection<PERMISSION> PERMISSION { get; set; }
        public virtual ICollection<UserAccount> UserAccount { get; set; }
    }
    public class PERMISSION
    {
        private string permissionDetails;

        public PERMISSION(string pd)
        {
            this.PermissionDetails = pd;
            ROLE = new HashSet<ROLE>();
        }

        public string PermissionDetails { get => permissionDetails; set => permissionDetails = value; }

        public virtual ICollection<ROLE> ROLE { get; set; }
    }
}
