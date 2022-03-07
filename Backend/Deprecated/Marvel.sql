USE [Marvel]
GO

DROP TABLE IF EXISTS Logs
DROP TABLE IF EXISTS Otp
DROP TABLE IF EXISTS UserAccounts
DROP TABLE IF EXISTS ROLES
DROP TABLE IF EXISTS PERMISSIONS
DROP TABLE IF EXISTS USER_ROLE
DROP TABLE IF EXISTS ROLE_PERMISSION

/****** Object:  Table [dbo].[Logs]    Script Date: 3/1/2022 11:38:11 AM ******/

GO

/****** Object:  Table [dbo].[Logs]    Script Date: 3/1/2022 11:38:11 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Logs](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[timestamp] [datetime] NOT NULL,
	[layer] [varchar](10) NOT NULL,
	[category] [varchar](10) NOT NULL,
	[userId] [int] NOT NULL,
	[description] [varchar](255) NOT NULL,
 CONSTRAINT [PK_Logs] PRIMARY KEY CLUSTERED
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[UserAccounts]    Script Date: 3/1/2022 11:38:21 AM ******/

GO

/****** Object:  Table [dbo].[UserAccounts]    Script Date: 3/1/2022 11:38:21 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[UserAccounts](
	[userId] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NOT NULL,
	[username] [varchar](50) NOT NULL,
	[email] [varchar](50) NOT NULL,
	[passcode] [varchar](50) NOT NULL,
	[role] [varchar](50) NOT NULL,
	[school] [varchar](50) NOT NULL,
	[active_status] [bit] NOT NULL
	CONSTRAINT [PK_UserAccounts] PRIMARY KEY ([UserId])
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[OTP]    Script Date: 3/1/2022 11:38:21 AM ******/

GO

/****** Object:  Table [dbo].[UserAccounts]    Script Date: 3/1/2022 11:38:21 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[OTP](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[timestamp] [datetime] NOT NULL,
	[userId] [int] NOT NULL,
	[otp] [varchar](10) NOT NULL,
 CONSTRAINT [PK_OTP] PRIMARY KEY CLUSTERED ([id] ASC)
 WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT FK_OTP FOREIGN KEY (userId)
 REFERENCES UserAccounts (userId)
	ON DELETE CASCADE
) ON [PRIMARY]


GO

--Create ROLES table...
CREATE TABLE [dbo].[ROLES](
	[RoleId] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar](50) NOT NULL,
	[RoleDetail] [nvarchar](250) NULL,
	[IsAdmin] [bit] NULL,
	[IsStudent] [bit] Null,
	[LastModified] [datetime] NOT NULL,
 CONSTRAINT [PK_tbl_Roles] PRIMARY KEY CLUSTERED
(
	[RoleId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[ROLES] ADD  CONSTRAINT [DF_ROLES_IsAdmin]  DEFAULT ((0)) FOR [IsAdmin]
GO

ALTER TABLE [dbo].[ROLES] ADD CONSTRAINT [DF_ROLES_IsStudent] DEFAULT ((0)) FOR [IsStudent]
GO

ALTER TABLE [dbo].[ROLES] ADD  CONSTRAINT [DF_ROLES_LastModified]  DEFAULT ((GETDATE())) FOR [LastModified]
GO

--Create PERMISSIONS table...
CREATE TABLE [dbo].[PERMISSIONS](
	[PermissionId] [int] IDENTITY(1,1) NOT NULL,
	[PermissionDetails] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_PERMISSIONS] PRIMARY KEY CLUSTERED
(
	[PermissionId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

--Create USER_ROLE table...
CREATE TABLE [dbo].[USER_ROLE](
	[UserId] [int] NOT NULL,
	[RoleId] [int] NOT NULL,
 CONSTRAINT [PK_USER_ROLE] PRIMARY KEY CLUSTERED
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[USER_ROLE]  WITH NOCHECK ADD  CONSTRAINT [FK_USER_ROLE_ROLES] FOREIGN KEY([RoleId])
REFERENCES [dbo].[ROLES] ([RoleId])
GO

ALTER TABLE [dbo].[USER_ROLE] CHECK CONSTRAINT [FK_USER_ROLE_ROLES]
GO

ALTER TABLE [dbo].[USER_ROLE]  WITH NOCHECK ADD  CONSTRAINT [FK_USER_ROLE_USERS] FOREIGN KEY([UserId])
REFERENCES [dbo].[UserAccounts] ([UserId])
GO

ALTER TABLE [dbo].[USER_ROLE] CHECK CONSTRAINT [FK_USER_ROLE_USERS]
GO

--Create ROLE_PERMISSION table...
CREATE TABLE [dbo].[ROLE_PERMISSION](
	[RoleId] [int] NOT NULL,
	[PermissionId] [int] NOT NULL,
 CONSTRAINT [PK_ROLE_PERMISSION] PRIMARY KEY CLUSTERED
(
	[Role_Id] ASC,
	[PermissionId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[ROLE_PERMISSION]  WITH NOCHECK ADD  CONSTRAINT [FK_ROLE_PERMISSION_PERMISSIONS] FOREIGN KEY([PermissionId])
REFERENCES [dbo].[PERMISSIONS] ([PermissionId])
GO

ALTER TABLE [dbo].[ROLE_PERMISSION] CHECK CONSTRAINT [FK_ROLE_PERMISSION_PERMISSIONS]
GO

ALTER TABLE [dbo].[ROLE_PERMISSION]  WITH NOCHECK ADD  CONSTRAINT [FK_ROLE_PERMISSION_ROLES] FOREIGN KEY([RoleId])
REFERENCES [dbo].[ROLES] ([RoleId])
GO

ALTER TABLE [dbo].[ROLE_PERMISSION] CHECK CONSTRAINT [FK_ROLE_PERMISSION_ROLES]
GO


--Create an 'Administrator' Role setting IsSystemRole=1
INSERT INTO ROLES(RoleName, RoleDetail, IsAdmin) VALUES('Administrator', 'Administrator can access all areas of the application by default.', 1)

--Create a 'StandardUser' Role setting IsSystemRole=0
INSERT INTO ROLES(RoleName, RoleDetail, IsStudent) VALUES('StudentUser', 'Students are restricted using Administrator options. ', 0)

--Create an Application Permission for the action method 'Create'
--defined in the 'Admin' controller (ie 'adminPermission')
INSERT INTO PERMISSIONS(PermissionDetailes) VALUES('adminPermission')

--Associate the Application Permission 'adminPermission' with the
--'Administrator' Role
INSERT INTO ROLE_PERMISSION VALUES(
	(SELECT RoleId FROM ROLES WHERE RoleName = 'Administrator'),
	(SELECT PermissionId FROM PERMISSIONS WHERE PermissionDetails = 'adminPermission'))

--Create the user 'exampleAdmin'
INSERT INTO USERS(Username, LastModified, EMail) VALUES('exampleAdmin', GETDATE(), 'exampleAdmin@student.csulb.edu')

--Associate the 'Administrator' Role with user
INSERT INTO USER_ROLE VALUES(
	(SELECT UserId FROM USERS WHERE Username = 'exampleAdmin'),
	(SELECT RoleId FROM ROLES WHERE RoleName = 'Administrator'))

INSERT INTO PERMISSIONS(PermissionDetailes) VALUES('studentPermission')

--Associate the Application Permission 'studentPermission' with the
--'StudentUser' Role
INSERT INTO ROLE_PERMISSION VALUES(
	(SELECT RoleId FROM ROLES WHERE RoleName = 'StudentUser'),
	(SELECT PermissionId FROM PERMISSIONS WHERE PermissionDetails = 'studentPermission'))

--Create the user 'exampleStudent'
INSERT INTO USERS(Username, LastModified, EMail) VALUES('exampleStudent', GETDATE(), 'exampleStudent@student.csulb.edu')

--Associate the 'StudentUser' Role with user
INSERT INTO USER_ROLE VALUES(
	(SELECT UserId FROM USERS WHERE Username = 'exampleStudent'),
	(SELECT RoleId FROM ROLES WHERE RoleName = 'StudentUser'))