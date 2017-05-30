name 'AWS RDS Plugin Example'
type 'plugin'
rs_ca_ver 20161221
short_description "Amazon Web Services - Relational Database Service"

parameter "aws_region" do
  type "string"
  label "AWS Region"
  category "AWS Plugin"
  default "us-east-1"

plugin "aws_rds" do
  endpoint do
    default_host "rds.$region.amazonaws.com"
    default_scheme "https"
    path "/"
    query do {
      "Version" => "2014-10-31"
    } end
  end

  type "db_instances" do
    href_templates "/?Action=DescribeDBInstances&DBInstanceIdentifier={{//DBInstance/DBInstanceIdentifier}}"

    field "allocatedStorage" do
      alias_for "AllocatedStorage"
      type "number"
      location "query"
      # DESCRIPTION: The amount of storage (in gigabytes) to be initially allocated for the database instance.
      # NOTE: Valid values differ based on the specific DB engine specified.
        # Amazon Aurora - Not applicable. 
        # MySQL - Must be an integer from 5 to 6144.
        # MariaDB - Must be an integer from 5 to 6144.
        # PostgreSQL - Must be an integer from 5 to 6144.
        # Oracle - Must be an integer from 10 to 6144.
        # SQL Server - Must be an integer from 200 to 4096 (Standard Edition and Enterprise Edition) or from 20 to 4096 (Express Edition and Web Edition)
    end 

    field "autoMinorVersionUpgrade" do
      alias_for "AutoMinorVersionUpgrade"
      type "string" 
      location "query"
      # DESCRIPTION: Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window.
      # DEFAULT VALUE: true
      # NOTE: This parameter in AWS is actually boolean. The only valid values are "true" or "false".  
    end

    field "availabilityZone" do
      alias_for "AvailabilityZone"
      type "string"
      location "query"
      # DESCRIPTION: The EC2 Availability Zone that the database instance will be created in.
      # DEFAULT VALUE: A random, system-chosen Availability Zone in the endpoint's region.
      # NOTE: The AvailabilityZone parameter cannot be specified if the MultiAZ parameter is set to true. 
    end

    field "backupRetentionPeriod" do
      alias_for "BackupRetentionPeriod"
      type "number"
      location "query"
      # DESCRIPTION: The number of days for which automated backups are retained. Setting this parameter to a positive number enables backups. Setting this parameter to 0 disables automated backups.
      # DEFAULT VALUE: 1
      # NOTE: Must be a value from 0 to 35.  Cannot be set to 0 if the DB instance is a source to Read Replicas
    end

    field "characterSetName" do
      alias_for "CharacterSetName"
      type "string"
      location "query"
      # DESCRIPTION: For supported engines, indicates that the DB instance should be associated with the specified CharacterSet.
    end 

    field "copyTagsToSnapshot" do
      alias_for "CopyTagsToSnapshot"
      type "string"
      location "query"
      # DESCRIPTION: True to copy all tags from the DB instance to snapshots of the DB instance; otherwise false.
      # DEFAULT VALUE: false
      # NOTE: This parameter in AWS is actually boolean.  The only valid values are "true" or "false"
    end

    field "dbClusterIdentifier" do
      alias_for "DBClusterIdentifier"
      type "string"
      location "query"
      # DESCRIPTION: The identifier of the DB cluster that the instance will belong to.
    end

    field "dbInstanceClass" do
      alias_for "DBInstanceClass"
      type "string"
      location "query"
      required true
      # DESCRIPTION: The compute and memory capacity of the DB instance. Note that not all instance classes are available in all regions for all DB engines.
      # VALID VALUES: db.t1.micro | db.m1.small | db.m1.medium | db.m1.large | db.m1.xlarge | db.m2.xlarge |db.m2.2xlarge | db.m2.4xlarge | db.m3.medium | db.m3.large | db.m3.xlarge | db.m3.2xlarge | db.m4.large | db.m4.xlarge | db.m4.2xlarge | db.m4.4xlarge | db.m4.10xlarge | db.r3.large | db.r3.xlarge | db.r3.2xlarge | db.r3.4xlarge | db.r3.8xlarge | db.t2.micro | db.t2.small | db.t2.medium | db.t2.large
    end

    field "dbInstanceIdentifier" do
      alias_for "DBInstanceIdentifier"
      type "string"
      location "query"
      required true
      # DESCRIPTION: The DB instance identifier. This parameter is stored as a lowercase string.
      # NOTE: Must contain from 1 to 63 alphanumeric characters or hyphens (1 to 15 for SQL Server). First character must be a letter. Cannot end with a hyphen or contain two consecutive hyphens.
    end

    field "dbName" do
      alias_for "DBName"
      type "string"
      location "query"
      # NOTE: The meaning of this parameter differs according to the database engine you use.
        # MySQL - The name of the database to create when the DB instance is created. If this parameter is not specified, no database is created in the DB instance. Must contain 1 to 64 alphanumeric characters. Cannot be a word reserved by the specified database engine.
        # MariaDB - The name of the database to create when the DB instance is created. If this parameter is not specified, no database is created in the DB instance. Must contain 1 to 64 alphanumeric characters. Cannot be a word reserved by the specified database engine.
        # PostgreSQL - The name of the database to create when the DB instance is created. If this parameter is not specified, the default "postgres" database is created in the DB instance. Must contain 1 to 63 alphanumeric characters. Must begin with a letter or an underscore. Subsequent characters can be letters, underscores, or digits (0-9). Cannot be a word reserved by the specified database engine.
        # Oracle - The Oracle System ID (SID) of the created DB instance. If you specify null, the default value ORCL is used. You can't specify the string NULL, or any other reserved word, for DBName. Default = ORCL. Cannot be longer than 8 characters
        # SQL Server - Not applicable. Must be null.
        # Amazon Aurora - The name of the database to create when the primary instance of the DB cluster is created. If this parameter is not specified, no database is created in the DB instance. Must contain 1 to 64 alphanumeric characters. Cannot be a word reserved by the specified database engine.
    end 

    field "dbParameterGroupName" do
      alias_for "DBParameterGroupName"
      type "string"
      location "query"
      # DESCRIPTION: The name of the DB parameter group to associate with this DB instance. If this argument is omitted, the default DBParameterGroup for the specified engine will be used.
      # NOTE: Must be 1 to 255 alphanumeric characters. First character must be a letter. Cannot end with a hyphen or contain two consecutive hyphens
    end

    field "dbSecurityGroup" do
      alias_for "DBSecurityGroups.member.1"
      type "string"
      location "query"
      # DESCRIPTION: The DB security group to associate with this DB instance.
      # DEFAULT VALUE: The default DB security group for the database engine.
    end 

    field "dbSubnetGroupName" do
      alias_for "DBSubnetGroupName"
      type "string"
      location "query"
      # DESCRIPTION: A DB subnet group to associate with this DB instance.
      # NOTE: If there is no DB subnet group, then it is a non-VPC DB instance.
    end 

    field "domain" do
      alias_for "Domain"
      type "string"
      location "query"
      # DESCRIPTION: Specify the Active Directory Domain to create the instance in.
    end 

    field "domainIAMRoleName" do 
      alias_for "DomainIAMRoleName"
      type "string"
      location "query"
      # DESCRIPTION: Specify the name of the IAM role to be used when making API calls to the Directory Service.
    end 

    field "enableIAMDatabaseAuthentication" do 
      alias_for "EnableIAMDatabaseAuthentication"
      type "string"
      location "query"
      # DESCRIPTION: True to enable mapping of AWS Identity and Access Management (IAM) accounts to database accounts; otherwise false. You can enable IAM database authentication for the following database engines:
        # For MySQL 5.6, minor version 5.6.34 or higher
        # For MySQL 5.7, minor version 5.7.16 or higher
      # DEFAULT VALUE: false
      # NOTE: This parameter in AWS is actually boolean. The only valid values are "true" or "false".  
    end 

    field "engine" do
      alias_for "Engine"
      type "string"
      location "query"
      required true
      # DESCRIPTION: The name of the database engine to be used for this instance.
      # VALID VALUES: mysql | mariadb | oracle-se1 | oracle-se2 | oracle-se | oracle-ee | sqlserver-ee | sqlserver-se | sqlserver-ex | sqlserver-web | postgres | aurora
      # NOTE: Not every database engine is available for every AWS region.
    end 

    field "engineVersion" do
      alias_for "EngineVersion"
      type "string"
      location "query"
      # DESCRIPTION: The version number of the database engine to use.
      # NOTE: The following are the database engines and major and minor versions that are available with Amazon RDS. Not every database engine is available for every AWS region.
        # Amazon Aurora
          # Version 5.6 (available in these AWS regions: ap-northeast-1, ap-northeast-2, ap-south-1, ap-southeast-2, eu-west-1, us-east-1, us-east-2, us-west-2): 5.6.10a
        # MariaDB
          # Version 10.1 (available in these AWS regions: us-east-2): 10.1.16
          # Version 10.1 (available in these AWS regions: ap-northeast-1, ap-northeast-2, ap-south-1, ap-southeast-1, ap-southeast-2, eu-central-1, eu-west-1, sa-east-1, us-east-1, us-west-1, us-west-2): 10.1.14
          # Version 10.0 (available in all AWS regions): 10.0.24
          # Version 10.0 (available in these AWS regions: ap-northeast-1, ap-northeast-2, ap-south-1, ap-southeast-1, ap-southeast-2, eu-central-1, eu-west-1, sa-east-1, us-east-1, us-gov-west-1, us-west-1, us-west-2): 10.0.17
        # Microsoft SQL Server 2016
          # 13.00.2164.0.v1 (supported for all editions, and all AWS regions except sa-east-1)
        # Microsoft SQL Server 2014
          # 12.00.5000.0.v1 (supported for all editions, and all AWS regions)
          # 12.00.4422.0.v1 (supported for all editions except Enterprise Edition, and all AWS regions except us-east-2)
        # Microsoft SQL Server 2012
          # 11.00.6020.0.v1 (supported for all editions, and all AWS regions)
          # 11.00.5058.0.v1 (supported for all editions, and all AWS regions except us-east-2)
          # 11.00.2100.60.v1 (supported for all editions, and all AWS regions except us-east-2)
        # Microsoft SQL Server 2008 R2
          # 10.50.6529.0.v1 (supported for all editions, and all AWS regions except us-east-2)
          # 10.50.6000.34.v1 (supported for all editions, and all AWS regions except us-east-2)
          # 10.50.2789.0.v1 (supported for all editions, and all AWS regions except us-east-2)
        # MySQL
          # Version 5.7 (available in all AWS regions): 5.7.11
          # Version 5.7 (available in these AWS regions: ap-northeast-1, ap-northeast-2, ap-south-1, ap-southeast-1, ap-southeast-2, eu-central-1, eu-west-1, sa-east-1, us-east-1, us-gov-west-1, us-west-1, us-west-2): 5.7.10
          # Version 5.6 (available in all AWS regions): 5.6.29
          # Version 5.6 (available in these AWS regions: ap-northeast-1, ap-northeast-2, ap-south-1, ap-southeast-1, ap-southeast-2, eu-central-1, eu-west-1, sa-east-1, us-east-1, us-gov-west-1, us-west-1, us-west-2): 5.6.27
          # Version 5.6 (available in these AWS regions: ap-northeast-1, ap-northeast-2, ap-southeast-1, ap-southeast-2, eu-central-1, eu-west-1, sa-east-1, us-east-1, us-gov-west-1, us-west-1, us-west-2): 5.6.23
          # Version 5.6 (available in these AWS regions: ap-northeast-1, ap-southeast-1, ap-southeast-2, eu-central-1, eu-west-1, sa-east-1, us-east-1, us-gov-west-1, us-west-1, us-west-2): 5.6.19a | 5.6.19b | 5.6.21 | 5.6.21b | 5.6.22
          # Version 5.5 (available in all AWS regions): 5.5.46
          # Version 5.1 (only available in AWS regions ap-northeast-1, ap-southeast-1, ap-southeast-2, eu-west-1, sa-east-1, us-east-1, us-gov-west-1, us-west-1, us-west-2): 5.1.73a | 5.1.73b
        # Oracle 12c
          # 12.1.0.2.v8 (supported for EE in all AWS regions, and SE2 in all AWS regions except us-gov-west-1)
          # 12.1.0.2.v7 (supported for EE in all AWS regions, and SE2 in all AWS regions except us-gov-west-1)
          # 12.1.0.2.v6 (supported for EE in all AWS regions, and SE2 in all AWS regions except us-gov-west-1)
          # 12.1.0.2.v5 (supported for EE in all AWS regions, and SE2 in all AWS regions except us-gov-west-1)
          # 12.1.0.2.v4 (supported for EE in all AWS regions, and SE2 in all AWS regions except us-gov-west-1)
          # 12.1.0.2.v3 (supported for EE in all AWS regions, and SE2 in all AWS regions except us-gov-west-1)
          # 12.1.0.2.v2 (supported for EE in all AWS regions, and SE2 in all AWS regions except us-gov-west-1)
          # 12.1.0.2.v1 (supported for EE in all AWS regions, and SE2 in all AWS regions except us-gov-west-1)
        # Oracle 11g
          # 11.2.0.4.v12 (supported for EE, SE1, and SE, in all AWS regions)
          # 11.2.0.4.v11 (supported for EE, SE1, and SE, in all AWS regions)
          # 11.2.0.4.v10 (supported for EE, SE1, and SE, in all AWS regions)
          # 11.2.0.4.v9 (supported for EE, SE1, and SE, in all AWS regions)
          # 11.2.0.4.v8 (supported for EE, SE1, and SE, in all AWS regions)
          # 11.2.0.4.v7 (supported for EE, SE1, and SE, in all AWS regions)
          # 11.2.0.4.v6 (supported for EE, SE1, and SE, in all AWS regions)
          # 11.2.0.4.v5 (supported for EE, SE1, and SE, in all AWS regions)
          # 11.2.0.4.v4 (supported for EE, SE1, and SE, in all AWS regions)
          # 11.2.0.4.v3 (supported for EE, SE1, and SE, in all AWS regions)
          # 11.2.0.4.v1 (supported for EE, SE1, and SE, in all AWS regions)
        # PostgreSQL
          # Version 9.6.x: 9.6.1 | 9.6.2
          # Version 9.5.x: 9.5.6 | 9.5.4 | 9.5.2
          # Version 9.4.x: 9.4.11 | 9.4.9 | 9.4.7
          # Version 9.3.x: 9.3.16 | 9.3.14 | 9.3.12
    end

    field "iops" do
      alias_for "Iops"
      type "number"
      location "query"
      # DESCRIPTION: The amount of Provisioned IOPS (input/output operations per second) to be initially allocated for the DB instance.
      # NOTE: Must be a multiple between 3 and 10 of the storage amount for the DB instance. Must also be an integer multiple of 1000. For example, if the size of your DB instance is 500 GB, then your Iops value can be 2000, 3000, 4000, or 5000.
    end 

    field "kmsKeyId" do 
      alias_for "KmsKeyId"
      type "string"
      location "query"
      # DESCRIPTION: The KMS key identifier for an encrypted DB instance.
      # NOTE: The KMS key identifier is the Amazon Resource Name (ARN) for the KMS encryption key. If you are creating a DB instance with the same AWS account that owns the KMS encryption key used to encrypt the new DB instance, then you can use the KMS key alias instead of the ARN for the KM encryption key. If the StorageEncrypted parameter is true, and you do not specify a value for the KmsKeyId parameter, then Amazon RDS will use your default encryption key. AWS KMS creates the default encryption key for your AWS account. Your AWS account has a different default encryption key for each AWS region.
    end 

    field "licenseModel" do
      alias_for "LicenseModel"
      type "string"
      location "query"
      # DESCRIPTION: License model information for this DB instance.
      # VALID VALUES: license-included | bring-your-own-license | general-public-license
    end 

    field "masterUsername" do
      alias_for "MasterUsername"
      type "string"
      location "query"
      # DESCRIPTION: The name for the master database user.
      # NOTE: 
        # Amazon Aurora - Not applicable. You specify the name for the master database user when you create your DB cluster.
        # MariaDB - Must be 1 to 16 alphanumeric characters. Cannot be a reserved word for the chosen database engine.
        # Microsoft SQL Server - Must be 1 to 128 alphanumeric characters. First character must be a letter. Cannot be a reserved word for the chosen database engine.
        # MySQL - Must be 1 to 16 alphanumeric characters. First character must be a letter. Cannot be a reserved word for the chosen database engine.
        # Oracle - Must be 1 to 30 alphanumeric characters. First character must be a letter. Cannot be a reserved word for the chosen database engine.
        # PostgreSQL - Must be 1 to 63 alphanumeric characters. First character must be a letter. Cannot be a reserved word for the chosen database engine. 
    end 

    field "masterUserPassword" do
      alias_for "MasterUserPassword"
      type "string"
      location "query"
      # DESCRIPTION: The password for the master database user. Can be any printable ASCII character except "/", """, or "@".
      # NOTE: 
        # Amazon Aurora - Not applicable. You specify the password for the master database user when you create your DB cluster.
        # MariaDB - Must contain from 8 to 41 characters.
        # Microsoft SQL Server - Must contain from 8 to 128 characters.
        # MySQL - Must contain from 8 to 41 characters.
        # Oracle - Must contain from 8 to 30 characters.
        # PostgreSQL - Must contain from 8 to 128 characters.
    end 

    field "monitoringInterval" do
      alias_for "MonitoringInterval"
      type "number"
      location "query"
      # DESCRIPTION: The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance. To disable collecting Enhanced Monitoring metrics, specify 0. The default is 0.
      # VALID VALUES: 0, 1, 5, 10, 15, 30, 60
      # NOTE: If MonitoringRoleArn is specified, then you must also set MonitoringInterval to a value other than 0.
    end 

    field "monitoringRoleArn" do
      alias_for "MonitoringRoleArn"
      type "string"
      location "query"
      # DESCRIPTION: The ARN for the IAM role that permits RDS to send enhanced monitoring metrics to CloudWatch Logs. For example, arn:aws:iam:123456789012:role/emaccess.
      # NOTE: If MonitoringInterval is set to a value other than 0, then you must supply a MonitoringRoleArn value.
    end 

    field "multiAZ" do
      alias_for "MultiAZ"
      type "string"
      location "query"
      # DESCRIPTION: Specifies if the DB instance is a Multi-AZ deployment. You cannot set the AvailabilityZone parameter if the MultiAZ parameter is set to true.
      # NOTE: This parameter in AWS is actually boolean. The only valid values are "true" or "false". 
    end 

    field "optionGroupName" do
      alias_for "OptionGroupName"
      type "string"
      location "query"
      # DESCRIPTION: Indicates that the DB instance should be associated with the specified option group.
      # NOTE: Permanent options, such as the TDE option for Oracle Advanced Security TDE, cannot be removed from an option group, and that option group cannot be removed from a DB instance once it is associated with a DB instance.
    end 

    field "port" do
      alias_for "Port"
      type "number"
      location "query"
      # DESCRIPTION: The port number on which the database accepts connections.
      # NOTE: 
        # MySQL
          # Default: 3306
          # Valid Values: 1150-65535
        # MariaDB
          # Default: 3306
          # Valid Values: 1150-65535
        # PostgreSQL
          # Default: 5432
          # Valid Values: 1150-65535
        # Oracle
          # Default: 1521
          # Valid Values: 1150-65535
        # SQL Server
          # Default: 1433
          # Valid Values: 1150-65535 except for 1434, 3389, 47001, 49152, and 49152 through 49156.
        # Amazon Aurora
          # Default: 3306
          # Valid Values: 1150-65535
    end

    field "preferredBackupWindow" do
      alias_for "PreferredBackupWindow"
      type "string"
      location "query"
      # DESCRIPTION: The daily time range during which automated backups are created if automated backups are enabled, using the BackupRetentionPeriod parameter
      # DEFAULT VALUE: A 30-minute window selected at random from an 8-hour block of time per region.
      # NOTE: Must be in the format hh24:mi-hh24:mi. Times should be in Universal Coordinated Time (UTC). Must not conflict with the preferred maintenance window. Must be at least 30 minutes.
    end 

    field "preferredMaintenanceWindow" do
      alias_for "PreferredMaintenanceWindow"
      type "string"
      location "query"
      # DESCRIPTION: The weekly time range during which system maintenance can occur, in Universal Coordinated Time (UTC). 
      # DEFAULT VALUE: A 30-minute window selected at random from an 8-hour block of time per region, occurring on a random day of the week.
      # NOTE: 
        # Format: ddd:hh24:mi-ddd:hh24:mi
        # Valid Days: Mon, Tue, Wed, Thu, Fri, Sat, Sun
        # Minimum 30-minute window
    end 

    field "promotionTier" do
      alias_for "PromotionTier"
      type "number"
      location "query"
      # DESCRIPTION: A value that specifies the order in which an Aurora Replica is promoted to the primary instance after a failure of the existing primary instance.
      # DEFAULT VALUE: 1
      # VALID VALUES: 0-15
    end 

    field "publiclyAccessible" do
      alias_for "PubliclyAccessible"
      type "string"
      location "query"
      # DESCRIPTION: Specifies the accessibility options for the DB instance. A value of true specifies an Internet-facing instance with a publicly resolvable DNS name, which resolves to a public IP address. A value of false specifies an internal instance with a DNS name that resolves to a private IP address.
      # DEFAULT VALUE: The default behavior varies depending on whether a VPC has been requested or not. Default VPC: true. VPC: false.
      # NOTE: This parameter in AWS is actually boolean. The only valid values are "true" or "false". If no DB subnet group has been specified as part of the request and the PubliclyAccessible value has not been set, the DB instance will be publicly accessible. If a specific DB subnet group has been specified as part of the request and the PubliclyAccessible value has not been set, the DB instance will be private.
    end 

    field "storageEncrypted" do
      alias_for "StorageEncrypted"
      type "string"
      location "query"
      # DESCRIPTION: Specifies whether the DB instance is encrypted.
      # DEFAULT VALUE: false
      # NOTE: This parameter in AWS is actually boolean. The only valid values are "true" or "false". 
    end 

    field "storageType" do 
      alias_for "StorageType"
      type "string"
      location "query"
      # DESCRIPTION: Specifies the storage type to be associated with the DB instance.
      # DEFAULT VALUE: io1 if the Iops parameter is specified; otherwise standard
      # VALID VALUES: standard | gp2 | io1
    end 

    field "tdeCredentialArn" do
      alias_for "TdeCredentialArn"
      type "string"
      location "query"
      # DESCRIPTION: The ARN from the Key Store with which to associate the instance for TDE encryption.
    end 

    field "tdeCredentialPassword" do
      alias_for "TdeCredentialPassword"
      type "string"
      location "query"
      # DESCRIPTION: The password for the given ARN from the Key Store in order to access the device.
    end 

    field "timezone" do
      alias_for "Timezone"
      type "string"
      location "query"
      # DESCRIPTION: The time zone of the DB instance. The time zone parameter is currently supported only by Microsoft SQL Server.
    end 

    field "vpcSecurityGroup" do
      alias_for "VpcSecurityGroupIds.member.1"
      type "string"
      location "query"
      # DESCRIPTION: EC2 VPC security group to associate with this DB instance
      # DEFAULT: The default EC2 VPC security group for the DB subnet group's VPC.
    end 


    output_path "//DBInstance"

    output "BackupRetentionPeriod","MultiAZ","DBInstanceStatus","DBInstanceIdentifier","PreferredBackupWindow","PreferredMaintenanceWindow","AvailabilityZone","LatestRestorableTime","Engine","LicenseModel","PubliclyAccessible","DBName","AutoMinorVersionUpgrade","InstanceCreateTime","AllocatedStorage","MasterUsername","DBInstanceClass"

    output "endpoint_address" do
      body_path "Endpoint.Address"
    end

    output "endpoint_port" do 
      body_path "Endpoint.Port"
    end
    
    action "create" do
      verb "POST"
      path "/?Action=CreateDBInstance"
    end

    action "destroy" do
      verb "POST"
      path "$href?Action=DeleteDBInstance"
    end
 
    action "get" do
      verb "POST"
    end
 
    action "list" do
      verb "POST"
      path "/?Action=DescribeDBInstances"
    end

    provision 'provision_db_instance'
    
    delete    'delete_db_instance'
  end 
 
  type "security_groups" do
    href_templates "/?Action=DescribeDBSecurityGroups&DBSecurityGroupName={{//DBSecurityGroup/DBSecurityGroupName}}"

    field "name" do
      alias_for "DBSecurityGroupName"
      type      "string"
      location  "query"
    end

    field "description" do
      alias_for "DBSecurityGroupDescription"
      type      "string"
      location  "query"
    end
 
    output_path "//DBSecurityGroup"
 
    output 'DBSecurityGroupDescription' do
      body_path "DBSecurityGroupDescription"
      type "simple_element"
    end

    output 'OwnerId' do
      body_path "OwnerId"
      type "simple_element"
    end

    output 'DBSecurityGroupName' do
      body_path 'DBSecurityGroupName'
      type "simple_element"
    end 

    action "create" do
      verb "POST"
      path "/?Action=CreateDBSecurityGroup"
    end

    action "destroy" do
      verb "POST"
      path "$href?Action=DeleteDBSecurityGroup"
    end
 
    action "get" do
      verb "POST"
    end
 
    action "list" do
      verb "POST"
      path "/?Action=DescribeDBSecurityGroups"
    end

    provision "provision_sg"

    delete    "delete_sg"

  end
end

resource_pool "rds" do
  plugin $aws_rds

  parameter_values do
    region $aws_region
  end 

  auth "key", type: "aws" do
    version     4
    service    'rds'
    region     $aws_region
    access_key cred('AWS_ACCESS_KEY_ID')
    secret_key cred('AWS_SECRET_ACCESS_KEY')
  end

end

define provision_sg(@declaration) return @sec_group do
  sub on_error: handle_error() do
    initiate_debug_report()
    $object = to_object(@declaration)
    $fields = $object["fields"]
    @sec_group = aws_rds.security_groups.create($fields)
    @sec_group = @sec_group.get()
  end
end

define list_security_groups() return $object do
  @security_groups = aws_rds.security_groups.list()

  $object = to_object(@security_groups)

  $object = to_s($object)
end

define handle_error() do
  $error_info = complete_debug_report()
end

define delete_sg(@sec_group) do
  sub on_error: handle_error() do
    initiate_debug_report()
    @sec_group.destroy()
  end
end

define provision_db_instance(@declaration) return @db_instance do
  sub on_error: handle_error() do
    initiate_debug_report()
    $object = to_object(@declaration)
    $fields = $object["fields"]
    @db_instance = aws_rds.db_instances.create($fields)
    @db_instance = @db_instance.get()
  end
end

define list_db_instances() return $object do
  @db_instances = aws_rds.db_instances.list()

  $object = to_object(@db_instances)

  $object = to_s($object)
end

define handle_error() do
  $error_info = complete_debug_report()
end

define delete_db_instance(@db_instance) do
  sub on_error: handle_error() do
    initiate_debug_report()
    @db_instance.destroy()
  end
end