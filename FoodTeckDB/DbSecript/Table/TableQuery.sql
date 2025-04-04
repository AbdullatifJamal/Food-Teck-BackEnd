CREATE DATABASE Food_System_App_DB;

CREATE TABLE Super_Admin(
Super_Admin_Id int identity(1,1) primary key,
Username VARCHAR(50) UNIQUE NOT NULL CHECK (Username LIKE '%[A-Za-z]%' AND Username NOT LIKE '%[^A-Za-z]%'),
[Password] VARCHAR(100) NOT NULL CHECK (
        LEN(Password) >= 8 
        AND Password LIKE '%[a-z]%' 
        AND Password LIKE '%[A-Z]%' 
        AND Password LIKE '%[0-9]%' 
        AND Password LIKE '%[^A-Za-z0-9]%'
		),
Email VARCHAR(255) UNIQUE NOT NULL CHECK (
        Email LIKE '%@gmail.com' 
        OR Email LIKE '%@hotmail.com' 
        OR Email LIKE '%@outlook.com' 
        OR Email LIKE '%@zoho.com'
		),

CreatedBy varchar(max),
UpdatedBy varchar(max),
CreationDate datetime default GetDate(),
UpdationDate datetime,
isActive bit default 1,
isverified bit default 1
)


CREATE TABLE Users (
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName VARCHAR(255) NOT NULL,
    LastName VARCHAR(255) NOT NULL,
    Username VARCHAR(50) UNIQUE NOT NULL CHECK (Username LIKE '%[A-Za-z]%' AND Username NOT LIKE '%[^A-Za-z]%'),
    [Password] VARCHAR(100) NOT NULL CHECK (
        LEN(Password) >= 8 
        AND Password LIKE '%[a-z]%'
        AND Password LIKE '%[A-Z]%'
        AND Password LIKE '%[0-9]%'
        AND Password LIKE '%[^A-Za-z0-9]%'
    ),
    Email VARCHAR(255) UNIQUE NOT NULL CHECK (
        Email LIKE '%@gmail.com' 
        OR Email LIKE '%@hotmail.com' 
        OR Email LIKE '%@outlook.com' 
        OR Email LIKE '%@zoho.com'
    ),
    PhoneNumber VARCHAR(10) UNIQUE CHECK (
        PhoneNumber LIKE '07[7-9]%%%%%%%' AND LEN(PhoneNumber) = 10
    ),
    Profile_Image VARCHAR(255) NULL,
    UserType VARCHAR(50) CHECK (UserType IN ('SuperAdmin', 'Admin', 'Client', 'Employee', 'Driver')) NOT NULL,
    CreatedBy VARCHAR(MAX),
    UpdatedBy VARCHAR(MAX),
    CreationDate DATETIME DEFAULT GETDATE(),
    UpdationDate DATETIME,
    isActive BIT DEFAULT 1,
    isVerified BIT DEFAULT 1
);

CREATE TABLE Roles (
    RolesId INT IDENTITY(1,1) PRIMARY KEY,
    Name_EN VARCHAR(100) UNIQUE NOT NULL, -- English name
    Name_AR NVARCHAR(100) UNIQUE NOT NULL, -- Arabic name
    CreatedBy VARCHAR(MAX),
    UpdatedBy VARCHAR(MAX),
    CreationDate DATETIME DEFAULT GETDATE(),
    UpdationDate DATETIME,
    isActive BIT DEFAULT 1,
    UserID INT NOT NULL,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

CREATE TABLE Categorys (
CategoryId int identity(1,1) primary key,
name_en VARCHAR(255) UNIQUE NOT NULL, 
name_ar NVARCHAR(255) UNIQUE NOT NULL, 
[Image] varchar(255) null, 
CreatedBy varchar(max),
UpdatedBy varchar(max),
CreationDate datetime default GetDate(),
UpdationDate datetime,
isActive bit default 1,

);

CREATE TABLE Items (
    ItemID INT IDENTITY(1,1) PRIMARY KEY,
    NameAR NVARCHAR(255) UNIQUE NOT NULL,
    NameEN VARCHAR(255) UNIQUE NOT NULL,
    ItemImage VARCHAR(255) NULL,
    DescriptionAR NVARCHAR(MAX),
    DescriptionEN VARCHAR(MAX),
    Price DECIMAL(10, 2) NOT NULL CHECK (Price > 0),
    CreatedBy VARCHAR(MAX),
    UpdatedBy VARCHAR(MAX),
    CreationDate DATETIME DEFAULT GETDATE(),
    UpdationDate DATETIME,
    isActive BIT DEFAULT 1,
    CategoryID INT NOT NULL,
    FOREIGN KEY (CategoryID) REFERENCES Categorys(CategoryID)
);

CREATE TABLE Orders (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    OrderCreationDate DATETIME NOT NULL,
    TotalPrice DECIMAL(10, 2) NOT NULL,
    AssignedDriver VARCHAR(255) CHECK (AssignedDriver IN ('Shipment', 'Completed', 'Cancelled','Pending')) DEFAULT 'Pending',
    Rate DECIMAL(3, 2) CHECK (Rate BETWEEN 0 AND 5),
    [Status] VARCHAR(255) CHECK (Status IN ('Active', 'On Shipment', 'Completed', 'Cancelled', 'Pending')) DEFAULT 'Pending',
    CreatedBy VARCHAR(MAX),
    UpdatedBy VARCHAR(MAX),
    CreationDate DATETIME DEFAULT GETDATE(),
    UpdationDate DATETIME,
    isActive BIT DEFAULT 1,
    ItemID INT NOT NULL,
    ClientID INT NOT NULL,
    DriverID INT NOT NULL,
    FOREIGN KEY (ItemID) REFERENCES Items(ItemID),
    FOREIGN KEY (ClientID) REFERENCES Users(UserID),
    FOREIGN KEY (DriverID) REFERENCES Users(UserID)
);

CREATE TABLE Addresses (
    AddressID INT IDENTITY(1,1) PRIMARY KEY,
    Province VARCHAR(255) NOT NULL DEFAULT 'Jordanian',
    Region VARCHAR(255) NOT NULL,
    AddressHint VARCHAR(255) NULL,
    CreatedBy VARCHAR(MAX),
    UpdatedBy VARCHAR(MAX),
    CreationDate DATETIME DEFAULT GETDATE(),
    UpdationDate DATETIME,
    isActive BIT DEFAULT 1,
    UserID INT NOT NULL,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

CREATE TABLE Payments (
    PaymentID INT IDENTITY(1,1) PRIMARY KEY,
    PaymentDate DATETIME DEFAULT GETDATE(),
    PaymentMethod VARCHAR(50) CHECK (PaymentMethod IN ('Cash', 'Credit Card', 'Debit Card', 'Online Payment')),
    Status VARCHAR(20) CHECK (Status IN ('Pending', 'Completed', 'Failed', 'Refunded')),
    Notes NVARCHAR(255) NULL,
    OrderID INT NOT NULL,
    UserID INT NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) ON DELETE CASCADE,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

CREATE TABLE Reviews (
    ReviewID INT IDENTITY(1,1) PRIMARY KEY,
    [Message] NVARCHAR(MAX) NOT NULL,
    ItemRate DECIMAL(3, 2) CHECK (ItemRate BETWEEN 0 AND 5),
    UserID INT NOT NULL,
    ItemID INT NOT NULL,
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (ItemID) REFERENCES Items(ItemID)
);

CREATE TABLE Notifications (
    NotificationID INT IDENTITY(1,1) PRIMARY KEY,
    Title NVARCHAR(255) NOT NULL,
    NotificationType VARCHAR(255) CHECK (NotificationType IN ('Issue', 'Support', 'New Order', 'New System Action')),
    isRead BIT DEFAULT 0,
    CreatedBy VARCHAR(MAX),
    UpdatedBy VARCHAR(MAX),
    CreationDate DATETIME DEFAULT GETDATE(),
    UpdationDate DATETIME,
    isActive BIT DEFAULT 1,
    UserID INT NOT NULL,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

CREATE TABLE OTPs (
    OTPID INT IDENTITY(1,1) PRIMARY KEY,
    OTPCode INT NOT NULL CHECK (OTPCode BETWEEN 10000 AND 99999),
    ExpirationTime DATETIME NOT NULL,
    IsUsed BIT DEFAULT 0,
    CreatedAt DATETIME DEFAULT GETDATE(),
    UserID INT NOT NULL,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

CREATE TABLE CardPayment (

CardPaymentID int identity(1,1) primary key,

CardNumber VARCHAR(16) NOT NULL,
CardHolderName NVARCHAR(100) NOT NULL,
ExpiryDate CHAR(5) NOT NULL, -- Format: MM/YY
CVV CHAR(3) NOT NULL,
CardType VARCHAR(20) CHECK (CardType IN ('Visa', 'MasterCard', 'Amex', 'Discover')),

PaymentID INT NOT NULL,
FOREIGN KEY (PaymentID) REFERENCES Payments(PaymentID) ON DELETE CASCADE,
UserID INT NOT NULL,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)

);

CREATE TABLE Sggestion(
Sggestion_id int identity(1,1) primary key,
Title NVARCHAR(255) NOT NULL,
Email VARCHAR(255) UNIQUE NOT NULL CHECK (
        Email LIKE '%@gmail.com' 
        OR Email LIKE '%@hotmail.com' 
        OR Email LIKE '%@outlook.com' 
        OR Email LIKE '%@zoho.com'
		 ),

rate DECIMAL(3, 2) CHECK (rate BETWEEN 0 AND 5),
[status] varchar (255) CHECK (Status IN 
('Open', 'Pending','waiting customer response ', 'Closed','Received ', 'Approved' , 'Rejected' )) DEFAULT 'Pending', 

CreatedBy varchar(max),
UpdatedBy varchar(max),
CreationDate datetime default GetDate(),
UpdationDate datetime,
isActive bit default 1,

UserID INT NOT NULL,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

CREATE TABLE ItemOptions (
OptionID  int identity(1,1) primary key,
NameAR NVARCHAR(255) UNIQUE NOT NULL, -- Arabic name
NameEN VARCHAR(255) UNIQUE NOT NULL, -- English name
IsRequired bit DEFAULT 0,

 ItemID INT NOT NULL,
    FOREIGN KEY (ItemID) REFERENCES Items(ItemID)
);

CREATE TABLE Offers (
OffersId int identity(1,1) primary key,
Title_EN NVARCHAR(255) CHECK (Title_EN LIKE '%[A-Za-z %$?]%'),
Description_EN NVARCHAR(500) CHECK (Description_EN LIKE '%[A-Za-z %$?]%'),
Title_AR NVARCHAR(255) CHECK (Title_AR LIKE '%[ء-ي %$?]%'),
Description_AR NVARCHAR(500) CHECK (Description_AR LIKE '%[ء-ي %$?]%'),
[Start_Date] DATE CHECK (Start_Date >= CAST(GETDATE() AS DATE)),
[End_Date] DATE,
Limit_Amount FLOAT CHECK (Limit_Amount > 0),
Limit_Persons INT CHECK (Limit_Persons > 0),
Code NVARCHAR(50) CHECK (Code LIKE '%[A-Za-z0-9]%'),
[Image] NVARCHAR(255) NULL,
[Percentage] INT CHECK (Percentage > 0 AND Percentage <= 50),

CreatedBy varchar(max),
UpdatedBy varchar(max),
CreationDate datetime default GetDate(),
UpdationDate datetime,
isActive bit default 1,

 ItemID INT NOT NULL,
    FOREIGN KEY (ItemID) REFERENCES Items(ItemID),

CONSTRAINT CHK_EndDate CHECK (End_Date > Start_Date)
);