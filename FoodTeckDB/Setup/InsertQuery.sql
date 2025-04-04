INSERT INTO Super_Admin (Username, Password, Email, CreatedBy, UpdatedBy)
VALUES 
('JohnDoe', 'SecurePass1!', 'john.doe@gmail.com', 'System', 'System'),
('JaneSmith', 'SecurePass2@', 'jane.smith@hotmail.com', 'System', 'System'),
('MichaelJohnson', 'SecurePass3#', 'michael.johnson@outlook.com', 'System', 'System'),
('EmilyDavis', 'SecurePass4$', 'emily.davis@zoho.com', 'System', 'System'),
('WilliamWilson', 'SecurePass5%', 'william.wilson@gmail.com', 'System', 'System'),
('SarahTaylor', 'SecurePass6^', 'sarah.taylor@hotmail.com', 'System', 'System')

INSERT INTO Users (FirstName, LastName, Username, [Password], Email, PhoneNumber, Profile_Image, UserType, CreatedBy, UpdatedBy)
VALUES 
('John', 'Doe', 'johndoe', 'UserPass1!', 'john.doe@gmail.com', '0771234567', NULL, 'Client', 'Admin', NULL),
('Jane', 'Smith', 'janesmith', 'UserPass2@', 'jane.smith@hotmail.com', '0782345678', NULL, 'Driver', 'Admin', NULL),
('Alice', 'Johnson', 'alicej', 'UserPass3#', 'alice.johnson@outlook.com', '0793456789', NULL, 'Admin', 'SuperAdmin', NULL),
('Bob', 'Brown', 'bobbrown', 'UserPass4$', 'bob.brown@zoho.com', '0774567890', NULL, 'Employee', 'Admin', NULL),
('Eve', 'Davis', 'evedavis', 'UserPass5%', 'eve.davis@gmail.com', '0785678901', NULL, 'Client', 'Admin', NULL);

INSERT INTO Roles (Name_EN, Name_AR, CreatedBy, UserID)
VALUES 
('Administrator', N'مسؤول النظام', 'SuperAdmin', 1),
('Client', N'عميل', 'SuperAdmin', 2),
('Driver', N'سائق', 'SuperAdmin', 3),
('Employee', N'موظف', 'SuperAdmin', 4),
('Support', N'دعم فني', 'SuperAdmin', 5);

INSERT INTO Categorys (name_en, name_ar, [Image], CreatedBy)
VALUES 
('Pizza', N'بيتزا', 'pizza.jpg', 'Admin'),
('Burger', N'برغر', 'burger.jpg', 'Admin'),
('Sushi', N'سوشي', 'sushi.jpg', 'Admin'),
('Pasta', N'معكرونة', 'pasta.jpg', 'Admin'),
('Salad', N'سلطة', 'salad.jpg', 'Admin');

INSERT INTO Items (NameAR, NameEN, ItemImage, DescriptionAR, DescriptionEN, Price, CreatedBy, CategoryID)
VALUES 
(N'بيتزا مارغريتا', 'Margherita Pizza', 'margherita.jpg', N'بيتزا كلاسيكية مع صلصة الطماطم والجبن.', 'Classic pizza with tomato sauce and cheese.', 10.99, 'Admin', 1),
(N'برغر لحم بقري', 'Beef Burger', 'beef_burger.jpg', N'برغر لحم بقري مع خبز وطماطم.', 'Beef burger with bread and tomatoes.', 8.99, 'Admin', 2),
(N'سوشي سلمون', 'Salmon Sushi', 'salmon_sushi.jpg', N'سوشي مع سمك السلمون الطازج.', 'Sushi with fresh salmon.', 15.99, 'Admin', 3),
(N'معكرونة ألفريدو', 'Fettuccine Alfredo', 'alfredo.jpg', N'معكرونة مع صلصة الفريدو.', 'Pasta with alfredo sauce.', 12.99, 'Admin', 4),
(N'سلطة سيزر', 'Caesar Salad', 'caesar_salad.jpg', N'سلطة سيزر مع الدجاج المشوي.', 'Caesar salad with grilled chicken.', 9.99, 'Admin', 5);

INSERT INTO Orders (OrderCreationDate, TotalPrice, AssignedDriver, Rate, [Status], CreatedBy, ItemID, ClientID, DriverID)
VALUES 
(GETDATE(), 10.99, 'Shipment', 4.5, 'Active', 'Client', 1, 1, 3),
(GETDATE(), 8.99, 'Completed', 5.0, 'On Shipment', 'Client', 2, 2, 3),
(GETDATE(), 15.99, 'Pending', NULL, 'Pending', 'Client', 3, 1, 3),
(GETDATE(), 12.99, 'Cancelled', NULL, 'Cancelled', 'Client', 4, 2, 3),
(GETDATE(), 9.99, 'Shipment', 4.0, 'Active', 'Client', 5, 1, 3);

INSERT INTO Addresses (Province, Region, AddressHint, CreatedBy, UserID)
VALUES 
('Amman', 'Jabal Al Weibdeh', 'Near the mosque', 'User', 1),
('Irbid', 'University Street', 'Opposite the university', 'User', 2),
('Zarqa', 'Al Hashemi', 'Next to the supermarket', 'User', 3),
('Aqaba', 'South Beach', 'Close to the port', 'User', 4),
('Madaba', 'King Talal Street', 'Beside the park', 'User', 5);

INSERT INTO Payments (PaymentDate, PaymentMethod, Status, Notes, OrderID, UserID)
VALUES 
(GETDATE(), 'Cash', 'Completed', 'Paid in cash', 1, 1),
(GETDATE(), 'Credit Card', 'Pending', 'Card payment pending', 2, 2),
(GETDATE(), 'Online Payment', 'Failed', 'Transaction failed', 3, 3),
(GETDATE(), 'Debit Card', 'Completed', 'Paid via debit card', 4, 4),
(GETDATE(), 'Cash', 'Refunded', 'Refund initiated', 5, 5);

INSERT INTO Reviews ([Message], ItemRate, UserID, ItemID)
VALUES 
('Great pizza!', 5.0, 1, 1),
('Burger was okay.', 3.5, 2, 2),
('Fresh sushi, loved it!', 4.5, 3, 3),
('Pasta was a bit salty.', 2.5, 4, 4),
('Salad was refreshing.', 4.0, 5, 5);

INSERT INTO Notifications (Title, NotificationType, isRead, CreatedBy, UserID)
VALUES 
('New Order Received', 'New Order', 0, 'System', 1),
('Payment Pending', 'Issue', 0, 'System', 2),
('Order Completed', 'New System Action', 1, 'System', 3),
('Support Request', 'Support', 0, 'System', 4),
('Order Cancelled', 'New System Action', 0, 'System', 5);

INSERT INTO OTPs (OTPCode, ExpirationTime, IsUsed, UserID)
VALUES 
(12345, DATEADD(MINUTE, 10, GETDATE()), 0, 1),
(23456, DATEADD(MINUTE, 10, GETDATE()), 0, 2),
(34567, DATEADD(MINUTE, 10, GETDATE()), 1, 3),
(45678, DATEADD(MINUTE, 10, GETDATE()), 0, 4),
(56789, DATEADD(MINUTE, 10, GETDATE()), 0, 5);

INSERT INTO CardPayment (CardNumber, CardHolderName, ExpiryDate, CVV, CardType, PaymentID, UserID)
VALUES 
('4111111111111111', 'John Doe', '12/25', '123', 'Visa', 1, 1),
('5500000000000004', 'Jane Smith', '06/26', '456', 'MasterCard', 2, 2),
('378282246310005', 'Alice Johnson', '09/24', '789', 'Amex', 3, 3),
('6011111111111117', 'Bob Brown', '03/27', '321', 'Discover', 4, 4),
('4242424242424242', 'Eve Davis', '11/28', '654', 'Visa', 5, 5);

INSERT INTO Sggestion (Title, Email, rate, [status], CreatedBy, UserID)
VALUES 
('Improve Delivery Time', 'feedback1@gmail.com', 4.0, 'Open', 'User', 1),
('Add More Payment Options', 'feedback2@hotmail.com', 3.5, 'Pending', 'User', 2),
('Better Customer Support', 'feedback3@outlook.com', 5.0, 'Closed', 'User', 3),
('Update App UI', 'feedback4@zoho.com', 4.5, 'Received', 'User', 4),
('Include Vegan Options', 'feedback5@gmail.com', 4.0, 'Approved', 'User', 5);

INSERT INTO ItemOptions (NameAR, NameEN, IsRequired, ItemID)
VALUES 
(N'إضافة جبن إضافي', 'Extra Cheese', 0, 1),
(N'اختيار الحجم', 'Size Selection', 1, 2),
(N'اختيار التوابل', 'Spice Level', 0, 3),
(N'إضافة صلصة', 'Add Sauce', 0, 4),
(N'إضافة خبز إضافي', 'Extra Bread', 0, 5);

INSERT INTO Offers (Title_EN, Description_EN, Title_AR, Description_AR, Start_Date, End_Date, Limit_Amount, Limit_Persons, Code, [Image], Percentage, CreatedBy, ItemID)
VALUES 
(
    'Summer Discount', 
    'Enjoy 20% off on all items', 
    N'خصم الصيف', 
    N'استمتع بخصم 20% على جميع العناصر', 
    CAST(GETDATE() AS DATE), -- Today's date as Start_Date
    DATEADD(DAY, 30, CAST(GETDATE() AS DATE)), -- 30 days from today
    1000, 
    50, 
    'SUMMER20', 
    'summer_offer.jpg', 
    20, 
    'Admin', 
    1
),
(
    'Weekend Special', 
    'Get 15% off on weekends', 
    N'عرض نهاية الأسبوع', 
    N'احصل على خصم 15% في عطلة نهاية الأسبوع', 
    CAST(GETDATE() AS DATE), -- Today's date as Start_Date
    DATEADD(DAY, 7, CAST(GETDATE() AS DATE)), -- 7 days from today
    500, 
    30, 
    'WEEKEND15', 
    'weekend_offer.jpg', 
    15, 
    'Admin', 
    2
),
(
    'First Order Bonus', 
    '50% off for new users', 
    N'عرض الطلب الأول', 
    N'خصم 50% للمستخدمين الجدد', 
    CAST(GETDATE() AS DATE), -- Today's date as Start_Date
    DATEADD(DAY, 15, CAST(GETDATE() AS DATE)), -- 15 days from today
    200, 
    20, 
    'FIRST50', 
    'first_order.jpg', 
    50, 
    'Admin', 
    3
),
(
    'VIP Discount', 
    'Exclusive 30% off', 
    N'خصم VIP', 
    N'خصم حصري 30%', 
    CAST(GETDATE() AS DATE), -- Today's date as Start_Date
    DATEADD(DAY, 10, CAST(GETDATE() AS DATE)), -- 10 days from today
    300, 
    10, 
    'VIP30', 
    'vip_offer.jpg', 
    30, 
    'Admin', 
    4
),
(
    'Flash Sale', 
    'Limited time offer 40% off', 
    N'عرض فلاش', 
    N'عرض محدود الوقت 40% خصم', 
    CAST(GETDATE() AS DATE), -- Today's date as Start_Date
    DATEADD(DAY, 5, CAST(GETDATE() AS DATE)), -- 5 days from today
    150, 
    15, 
    'FLASH40', 
    'flash_sale.jpg', 
    40, 
    'Admin', 
    5
);








