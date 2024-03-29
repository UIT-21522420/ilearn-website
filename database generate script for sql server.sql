USE [master]
GO
/****** Object:  Database [ILearnDB]    Script Date: 04-Jan-24 3:19:18 PM ******/
CREATE DATABASE [ILearnDB]
GO
ALTER DATABASE [ILearnDB] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ILearnDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ILearnDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ILearnDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ILearnDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ILearnDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ILearnDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [ILearnDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ILearnDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ILearnDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ILearnDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ILearnDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ILearnDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ILearnDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ILearnDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ILearnDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ILearnDB] SET  ENABLE_BROKER 
GO
ALTER DATABASE [ILearnDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ILearnDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ILearnDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ILearnDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ILearnDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ILearnDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ILearnDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ILearnDB] SET RECOVERY FULL 
GO
ALTER DATABASE [ILearnDB] SET  MULTI_USER 
GO
ALTER DATABASE [ILearnDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ILearnDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ILearnDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ILearnDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ILearnDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [ILearnDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'ILearnDB', N'ON'
GO
ALTER DATABASE [ILearnDB] SET QUERY_STORE = OFF
GO
USE [ILearnDB]
GO
/****** Object:  Table [dbo].[Account]    Script Date: 04-Jan-24 3:19:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[username] [nvarchar](50) NOT NULL,
	[password] [nvarchar](50) NOT NULL,
	[role] [int] NOT NULL,
	[userStatus] [int] NOT NULL,
 CONSTRAINT [PK_Account] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cart]    Script Date: 04-Jan-24 3:19:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cart](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[sessionID] [int] NOT NULL,
	[courseID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 04-Jan-24 3:19:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[categoryName] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Course]    Script Date: 04-Jan-24 3:19:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Course](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[courseName] [nvarchar](50) NOT NULL,
	[coursePrice] [decimal](18, 0) NOT NULL,
	[introduction] [nvarchar](4000) NULL,
	[description] [nvarchar](4000) NULL,
	[numberOfLectures] [int] NULL,
	[discountPrice] [decimal](18, 0) NULL,
	[img] [nvarchar](100) NULL,
	[lecturerID] [int] NOT NULL,
	[categoryID] [int] NOT NULL,
	[discount] [int] NULL,
 CONSTRAINT [PK__Course__3214EC271B8898BB] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Decentralization]    Script Date: 04-Jan-24 3:19:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Decentralization](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[accountID] [int] NOT NULL,
	[functionID] [int] NOT NULL,
 CONSTRAINT [PK_Decentralization] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FunctionT]    Script Date: 04-Jan-24 3:19:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FunctionT](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[functionName] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Lecturer]    Script Date: 04-Jan-24 3:19:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Lecturer](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[lecturerName] [nvarchar](100) NOT NULL,
	[description] [nvarchar](4000) NULL,
	[email] [nvarchar](50) NOT NULL,
	[phone] [nvarchar](20) NOT NULL,
	[img] [nvarchar](100) NULL,
	[accountID] [int] NOT NULL,
 CONSTRAINT [PK__Lecturer__3214EC270D53F97A] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ShoppingSession]    Script Date: 04-Jan-24 3:19:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ShoppingSession](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[accountID] [int] NOT NULL,
	[total] [decimal](18, 0) NULL,
	[createdAt] [datetime] NOT NULL,
 CONSTRAINT [PK_ShoppingSession] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Student]    Script Date: 04-Jan-24 3:19:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Student](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[email] [nvarchar](50) NOT NULL,
	[phone] [nvarchar](20) NULL,
	[img] [nvarchar](50) NULL,
	[accountID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Video]    Script Date: 04-Jan-24 3:19:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Video](
	[ID] [int] NOT NULL,
	[title] [nvarchar](50) NOT NULL,
	[link] [nvarchar](50) NOT NULL,
	[createdAt] [datetime] NOT NULL,
	[modifiedAt] [datetime] NULL,
	[courseID] [int] NOT NULL,
	[subtitle] [nvarchar](4000) NULL,
 CONSTRAINT [PK_Video] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Account] ON 

INSERT [dbo].[Account] ([ID], [username], [password], [role], [userStatus]) VALUES (1, N'admin', N'123456', 0, 1)
INSERT [dbo].[Account] ([ID], [username], [password], [role], [userStatus]) VALUES (8, N'nhat@gmail.com', N'1', 1, 1)
INSERT [dbo].[Account] ([ID], [username], [password], [role], [userStatus]) VALUES (9, N'thaidui@gmail.com', N'1', 1, 1)
INSERT [dbo].[Account] ([ID], [username], [password], [role], [userStatus]) VALUES (10, N'ltt@gmail.com', N'1', 2, 1)
INSERT [dbo].[Account] ([ID], [username], [password], [role], [userStatus]) VALUES (17, N'nhv@gmail.com', N'1', 2, 1)
INSERT [dbo].[Account] ([ID], [username], [password], [role], [userStatus]) VALUES (18, N'tnd@gmail.com', N'1', 2, 1)
SET IDENTITY_INSERT [dbo].[Account] OFF
GO
SET IDENTITY_INSERT [dbo].[Cart] ON 

INSERT [dbo].[Cart] ([ID], [sessionID], [courseID]) VALUES (8, 5, 1)
INSERT [dbo].[Cart] ([ID], [sessionID], [courseID]) VALUES (9, 6, 2)
SET IDENTITY_INSERT [dbo].[Cart] OFF
GO
SET IDENTITY_INSERT [dbo].[Category] ON 

INSERT [dbo].[Category] ([ID], [categoryName]) VALUES (1, N'Khoá học nền tảng')
INSERT [dbo].[Category] ([ID], [categoryName]) VALUES (2, N'Cẩm nang luyện thi cấp tốc')
INSERT [dbo].[Category] ([ID], [categoryName]) VALUES (3, N'Khóa vip - học trực tiếp')
INSERT [dbo].[Category] ([ID], [categoryName]) VALUES (4, N'Ebook')
SET IDENTITY_INSERT [dbo].[Category] OFF
GO
SET IDENTITY_INSERT [dbo].[Course] ON 

INSERT [dbo].[Course] ([ID], [courseName], [coursePrice], [introduction], [description], [numberOfLectures], [discountPrice], [img], [lecturerID], [categoryID], [discount]) VALUES (1, N'Cẩm Nang Toeic Part 5', CAST(500000 AS Decimal(18, 0)), N'Khoá học giúp bạn đạt 30/30 câu trong phần thi TOEIC part 5 chỉ trong 30ph học tập.', N'Khoá học giúp bạn đạt 30/30 câu trong phần thi TOEIC part 5 chỉ trong 30ph học tập.', 23, CAST(199000 AS Decimal(18, 0)), N'toeic-part-5.jpg', 1, 1, 61)
INSERT [dbo].[Course] ([ID], [courseName], [coursePrice], [introduction], [description], [numberOfLectures], [discountPrice], [img], [lecturerID], [categoryID], [discount]) VALUES (2, N'30 ngày giỏi ngữ pháp tiếng anh', CAST(1868000 AS Decimal(18, 0)), N'✔️ Có cái nhìn tổng thể, logic và hệ thống về ngữ pháp tiếng Anh.
✔️ Thành thạo 8 loại từ trong tiếng Anh
✔️ Thành thạo 9 thì tiếng anh cơ bản mà ai cũng phải biết
✔️ Nắm vững ngữ pháp giúp tự tin giao tiếp, sử dụng tiếng Anh
✔️ Tự tin làm mọi bài tập ngữ pháp của các học phần tiếng Anh trên trường ĐH
✔️ Nắm vững ngữ pháp giúp tạo nền tảng để tham gia các kỳ thi quốc tế như TOEIC, IELTS..', N'TẦM QUAN TRỌNG CỦA NGỮ PHÁP TIẾNG ANH
✔️ Nếu ví tiếng Anh là một ngôi nhà, thì ngữ pháp tiếng Anh được xem là cái móng của ngôi nhà đó. Ngôi nhà muốn vững chắc, thì cái móng phải tốt, phải đủ dày, đủ sâu. Ngữ pháp là nền tảng để người nói thể hiện tư tưởng, là mảnh ghép giúp con người diễn đạt một thông điệp chính xác, rõ ràng và dễ hiểu. Bạn muốn học giỏi tiếng Anh, trước hết bạn nên biết về ngữ pháp, có nền tảng ngữ pháp vững sẽ giúp bạn chinh phục được tiếng Anh dễ dàng hơn. 

TUY NHIÊN

❌ Bạn Học tiếng Anh rất lâu rồi nhưng chưa thành công ?
❌ Hay bạn mất gốc tiếng Anh và đang mong muốn học lại từ đầu ?
❌ Bạn muốn tìm một khóa học chất lượng với đội ngũ giảng viên uy tín ?
❌ Bạn muốn hằng ngày học ít mà mang lại hiệu quả cao ?
❌ Đặc biệt bạn muốn được giáo viên đồng hành, kèm cặp sửa bài cho bạn hằng ngày ?

ĐỪNG LO LẮNG

>> Khóa học 30 ngày giỏi ngữ pháp tiếng Anh cơ bản, của giảng viên Lê Thị Thanh là dành cho bạn.

Khóa học được thiết kế dưới dạng thử thách 30 ngày. Mỗi ngày sẽ là một chủ điểm ngữ pháp được hướng dẫn 1 cách tỉ mỉ và ngắn gọn, kèm theo mỗi chủ điểm ngữ pháp là bài tập thực hành được thiết kế theo mức độ từ dễ đến khó để người học có thể dần làm quen với công thức từ đó có thể vận dụng tốt trong các bài tập chuyên sâu. Đặc biệt sẽ có cả đáp án và giải thích đáp án kèm theo giúp bạn có thể check bài và sửa lại những câu sai của mình.

Đăng kí ngay nếu muốn chinh phục ngữ pháp nền tảng ngay trong hôm nay!', 31, CAST(999000 AS Decimal(18, 0)), N'30-ngay-gioi-ngu-phap-tieng-anh.jpg', 1, 1, 47)
INSERT [dbo].[Course] ([ID], [courseName], [coursePrice], [introduction], [description], [numberOfLectures], [discountPrice], [img], [lecturerID], [categoryID], [discount]) VALUES (3, N'Cẩm Nang Toeic Part 7', CAST(500000 AS Decimal(18, 0)), N'Khoá học giúp bạn đạt 54/54 câu trong phần thi TOEIC part 7 chỉ trong 30ph học tập', N'Khoá học giúp bạn đạt 54/54 câu trong phần thi TOEIC part 7 chỉ trong 30ph học tập', 23, CAST(199000 AS Decimal(18, 0)), N'toeic-part-7.jpg', 1, 2, 61)
INSERT [dbo].[Course] ([ID], [courseName], [coursePrice], [introduction], [description], [numberOfLectures], [discountPrice], [img], [lecturerID], [categoryID], [discount]) VALUES (4, N'Cẩm Nang Toeic Part 4', CAST(500000 AS Decimal(18, 0)), N'Khoá học giúp bạn đạt 30/30 câu trong phần thi TOEIC part 4 chỉ trong 30ph học tập', N'Khoá học giúp bạn đạt 30/30 câu trong phần thi TOEIC part 4 chỉ trong 30ph học tập', 23, CAST(199000 AS Decimal(18, 0)), N'toeic-part-4.jpg', 1, 2, 61)
INSERT [dbo].[Course] ([ID], [courseName], [coursePrice], [introduction], [description], [numberOfLectures], [discountPrice], [img], [lecturerID], [categoryID], [discount]) VALUES (5, N'Cẩm Nang Toeic Part 3', CAST(500000 AS Decimal(18, 0)), N'Khoá học giúp bạn đạt 39/39 câu trong phần thi TOEIC part 3 chỉ trong 30ph học tập', N'Khoá học giúp bạn đạt 39/39 câu trong phần thi TOEIC part 3 chỉ trong 30ph học tập', 23, CAST(199000 AS Decimal(18, 0)), N'toeic-part-3.jpg', 1, 2, 61)
INSERT [dbo].[Course] ([ID], [courseName], [coursePrice], [introduction], [description], [numberOfLectures], [discountPrice], [img], [lecturerID], [categoryID], [discount]) VALUES (6, N'Cẩm Nang Toeic Part 2', CAST(500000 AS Decimal(18, 0)), N'Khoá học giúp bạn đạt 25/25 câu trong phần thi TOEIC part 2 chỉ trong 30ph học tập', N'Khoá học giúp bạn đạt 25/25 câu trong phần thi TOEIC part 2 chỉ trong 30ph học tập', 23, CAST(199000 AS Decimal(18, 0)), N'toeic-part-2.jpg', 1, 2, 61)
INSERT [dbo].[Course] ([ID], [courseName], [coursePrice], [introduction], [description], [numberOfLectures], [discountPrice], [img], [lecturerID], [categoryID], [discount]) VALUES (7, N'Cẩm Nang Toeic Part 1', CAST(500000 AS Decimal(18, 0)), N'Khoá học giúp bạn đạt 6/6 câu trong phần thi TOEIC part 1 chỉ trong 30ph học tập', N'Khoá học giúp bạn đạt 6/6 câu trong phần thi TOEIC part 1 chỉ trong 30ph học tập', 18, CAST(199000 AS Decimal(18, 0)), N'toeic-part-1.jpg', 1, 2, 61)
INSERT [dbo].[Course] ([ID], [courseName], [coursePrice], [introduction], [description], [numberOfLectures], [discountPrice], [img], [lecturerID], [categoryID], [discount]) VALUES (8, N'Ebook 2000 từ vựng TOEIC giúp bạn đạt điểm cao', CAST(200000 AS Decimal(18, 0)), N'Ebook 2000 từ vựng, cụm từ vựng TOEIC cốt lõi giúp bạn đạt điểm cao một cách nhanh nhất', N'Chào bạn,

Bạn muốn cải thiện kỹ năng tiếng Anh của mình và đạt được điểm số cao trong kỳ thi TOEIC? Chúng tôi rất vui khi giới thiệu đến bạn cuốn Ebook từ vựng TOEIC của chúng tôi, với hơn 1500 từ vựng phổ biến trong kỳ thi TOEIC được tổng hợp từ các bộ đề thi và giải thích một cách dễ hiểu.

Cuốn Ebook từ vựng TOEIC sẽ giúp bạn nâng cao kỹ năng nghe và đọc hiểu, tăng khả năng sử dụng từ vựng chính xác và đa dạng, từ đó cải thiện điểm số TOEIC của bạn. Bạn có thể sử dụng Ebook từ vựng TOEIC để học tập và ôn tập ở bất kỳ đâu, bất kỳ lúc nào với thiết bị di động của bạn.

Hãy đăng ký tải ngay cuốn Ebook từ vựng TOEIC của chúng tôi để bắt đầu hành trình nâng cao kỹ năng tiếng Anh của mình. Đừng quên chia sẻ cuốn Ebook này với bạn bè của bạn để họ cũng có cơ hội nâng cao kỹ năng tiếng Anh của mình.

Cảm ơn bạn đã quan tâm đến sản phẩm của chúng tôi!', 1, CAST(100000 AS Decimal(18, 0)), N'ebook-2000-tu.jpg', 1, 4, 50)
INSERT [dbo].[Course] ([ID], [courseName], [coursePrice], [introduction], [description], [numberOfLectures], [discountPrice], [img], [lecturerID], [categoryID], [discount]) VALUES (9, N'CẤY NỀN TOEIC', CAST(3000000 AS Decimal(18, 0)), N'- Đạt 350 - 450 điểm sau khóa học.

- Nắm chắc các chủ điểm ngữ pháp cơ bản.

- Tự tin nghe hiểu cách chủ đề thông dụng.

- Biết cách phát âm chuẩn giọng Mỹ.

- Tích lũy 600 từ vựng nền trong tiếng Anh.', N'Bạn muốn có TOEIC nhưng...

😢 Mất gốc nền, học mãi không tiến bộ?

😣 Không thể nghe được những videos tiếng Anh cơ bản?

😟 Ngữ pháp mơ hồ, từ vựng kém ?

😭 Không có lộ trình, phương pháp học rõ ràng?

Đừng lo lắng, giảng viên Lê Thanh đã thiết kế khóa học “CẤY NỀN TOEIC” nhằm giúp bạn ôn luyện các dạng bài tập trong đề thi TOEIC một cách hiệu quả

🔷 KHÓA HỌC SẼ GIÚP BẠN: 

Nắm chắc các chủ điểm ngữ pháp cơ bản.
Tự tin nghe hiểu cách chủ đề thông dụng.
Biết cách phát âm chuẩn giọng Mỹ.
Tích lũy 600 từ vựng nền trong tiếng Anh.
🔷 CAM KẾT CỦA TRUNG TÂM: 

Đạt 350 - 450 điểm sau khóa học.
Tạo cảm hứng học tập mỗi khi đến lớp.
Học lại MIỄN PHÍ nếu học viên không đạt điểm đầu ra.
🔷 ĐỘI NGŨ ĐÀO TẠO: 

Giảng viên: Cô Lê Thị Thanh, TOEIC 980/990, giám đốc trung tâm.
Trợ giảng: Bạn Hoàng Thị Thu Hương, TOEIC 955/990
🔷 LỘ TRÌNH KHÓA HỌC: 24 buổi, mỗi buổi 2 tiếng ( 2 tháng )

Học chuyên đề 16 buổi: 4 buổi ngữ âm, 4 buổi học nghe, 8 buổi học ngữ pháp, 1 buổi thi cuối khoa.
Học phụ đạo 8 buổi: được hướng dẫn chữa bài và giải thích chi tiết, tỉ mỉ
Luyện nghe sáng | 45 ngày: được kèm cặp luyện nghe mỗi ngày theo lộ trình từ đơn giản đến nâng cao.
🔷 HÌNH THỨC HỌC: 

Online và Offline: Ngoài hình thức học ngay tại trung tâm thì bạn còn được học trực tuyến các bài giảng có sẵn trên hệ thống website.
🔷 LỊCH HỌC:

Lớp B34 | Thứ 3 & 6 : 20h00 - 22h00 | Khai giảng ngày 30/6/2022
Lớp B35 | Thứ 2 & 5 : 20h00 - 22h00 | Khai giảng ngày 10/7/2022
Lớp B36 | Thứ 2 & 5 : 17h30 - 19h30 | Khai giảng ngày 17/8/2022
🔷 HOẠT ĐỘNG NGOẠI KHÓA: 

Được tham gia 01 buổi teambuilding về kỹ năng làm việc nhóm; hoạt động đạp xe khám phá vẻ đẹp Hà Nội về đêm.
🔷 QUÀ TẶNG ĐẶC BIỆT

Tặng khoá học CẤY NỀN TOEIC ONLINE trọn đời khi đăng ký và hoàn thành học phí trước ngày khai giảng 1 tuần.
Tặng balo đựng Laptop cho nhóm đăng ký 3 người trở lên.', 0, CAST(2686000 AS Decimal(18, 0)), N'toeic-caynen.jpg', 1, 3, 11)
INSERT [dbo].[Course] ([ID], [courseName], [coursePrice], [introduction], [description], [numberOfLectures], [discountPrice], [img], [lecturerID], [categoryID], [discount]) VALUES (10, N'TOEIC CĂN BẢN', CAST(3500000 AS Decimal(18, 0)), N'Bạn sẽ mắm được phương pháp và kĩ năng nghe cũng như đọc hiểu, phương pháp làm bài thi
Bạn sẽ nắm chắc và vận dụng tốt các chủ điểm ngữ pháp thường gặp trong đề thi TOEIC
Bạn sẽ tích lũy 1000 từ vựng tiếng Anh thông dụng qua các chủ đề
Bạn sẽ bất ngờ về kỹ năng nghe tiếng của mình.
Đặc biệt bạn sẽ đạt 500-650 điểm sau khi kết thúc khóa học.', N'Gửi các bạn học viên thân mến,

Cảm ơn bạn đã đồng hành cùng IMAX chinh phục mục tiêu TOEIC trong thời gian sắp tới.

Chương trình TOEIC CĂN BẢN là khóa học TOEIC được thiết kế dành cho người đã có kiến thức cơ bản về Tiếng Anh đạt trên 350 điểm test trình độ đầu vào tuy nhiên chưa được hệ thống bài bản theo form bài thi TOEIC. Khóa học cung cấp các kiến thức nâng cao, kỹ thuật làm bài và tránh bẫy đề thi giúp học viên có thể tăng nhanh chóng điểm thi chỉ sau 2,5 tháng. 

Thông tin chi tiết về khóa học:

🔷 CAM KẾT CỦA KHÓA HỌC:

- Đạt 500 – 650 điểm sau 2.5 tháng ( Note: Trên 20% các bạn học viên đạt trên 700 điểm sau khóa học này )

- Đạt ít nhất Điểm C tất cả các học phần tiếng Anh trên trường.

- Học lại MIỄN PHÍ nếu học viên không đạt điểm đầu ra ( dưới 500 điểm )

🔷 ĐỘI NGŨ ĐÀO TẠO SIÊU CHẤT.

- Giảng viên: Cô Lê Thị Thanh, TOEIC 980/990, giám đốc trung tâm

- Giảng viên: Thầy Nguyễn Văn Dương, TOEIC 965/990, quản lý đào tạo  

🔷 LỘ TRÌNH KHÓA HỌC.

- Học chuyên đề | 22 buổi: 10 listening, 10 reading, 2 buổi thi và giải đề

- Học phụ đạo | 10 buổi: hướng dẫn chữa bài và giải thích chi tiết, tỷ mỉ

- Luyện nghe sáng | 45 ngày: Được hướng dẫn và check bài kỹ lưỡng

🔷 LỊCH HỌC:

- Lớp I26 | Thứ 3 & 6 : 20h00 - 22h00 | Khai giảng ngày 30/11/2021

- Lớp I27 | Thứ 2 & 5 : 20h00 - 22h00 | Khai giảng ngày 10/1/2022

- Lớp I28 | Thứ 2 & 5 : 17h30 - 19h30 | Khai giảng ngày 17/1/2022

🔷 ĐẶC BIỆT

- Tặng khoá học TOEIC CĂN BẢN ONLINE trọn đời khi đăng ký và hoàn thành học phí trước ngày khai giảng 1 tuần.

- Tặng balo đựng Laptop cho nhóm đăng ký 3 người trở lên.', 57, CAST(3268000 AS Decimal(18, 0)), N'toeic-canban.jpg', 1, 3, 7)
INSERT [dbo].[Course] ([ID], [courseName], [coursePrice], [introduction], [description], [numberOfLectures], [discountPrice], [img], [lecturerID], [categoryID], [discount]) VALUES (11, N'TOEIC CHUYÊN SÂU', CAST(15000000 AS Decimal(18, 0)), N'- Đạt 700 - 850 điểm sau khóa học.

- Tự tin vượt qua tất cả các học phần tiếng Anh trên trường với điểm số cao.

- Sử dụng tiếng Anh để chinh phục nhà tuyển dụng với mức lương khởi điểm 500$ - 1000$

- Học lại MIỄN PHÍ nếu học viên không đạt điểm đầu ra 750+.', N'Bạn khao khát chinh mục TOEIC 750+ để nâng cao chất lượng học tập, tự tin ứng tuyển vào các công ty nước ngoài với mức lương 500-1000$ và đặc biệt là thăng tiến trong sự nghiệp nhưng ....

Bạn học mãi mà vẫn lẹt đẹt ở mức 500 - 600 điểm mà không bức lên được.
Phần bài đọc của bạn còn kém, đặc biệt là part 6 & 7.
Bạn chưa biết cách phân bố thời gian và giải đề hiệu quả.
Đặc biệt bạn thiếu một người mentor đồng hành và giải đáp cho bạn mọi thắc mắc.
Chính vì vậy chương trình TOEIC CHUYÊN SÂU là khóa học TOEIC được thiết kế dành là dành cho bạn.

🔷 KHÓA HỌC SẼ GIÚP BẠN: 

Thành thạo kỹ năng làm bài phần reading: part 5, 6, 7
Luyện đề chuyên sâu phần nghe
Tích luỹ 1500 từ vựng
Giải đề thành thạo & hoàn thiện toàn bộ kỹ năng.
🔷 CAM KẾT CỦA TRUNG TÂM: 

Đạt 700 - 850 điểm sau khóa học.
Sử dụng tiếng Anh để chinh phục nhà tuyển dụng với mức lương khởi điểm 500$ - 1000$
Học lại MIỄN PHÍ nếu học viên không đạt điểm đầu ra 750+
🔷 ĐỘI NGŨ ĐÀO TẠO: 

Giảng viên: Cô Lê Thị Thanh, TOEIC 980/990, giám đốc trung tâm
Giảng viên: Thầy Nguyễn Văn Dương, TOEIC 965/990, quản lý đào tạo
🔷 LỘ TRÌNH KHÓA HỌC: 52 buổi, mỗi buổi 2 tiếng ( 2,5 tháng )

Học chuyên đề 22 buổi: 5 buổi listening, 12 buổi reading, 5 luyệnđề )
Học phụ đạo: 10 buổi học (1 buổi / tuần)
Giải đề chi tiết: 21 buổi sáng (bắt đầu từ buổi 17)
Luyện nghe sáng 40 ngày: được luyện bám sát đề thi thật.
🔷 HÌNH THỨC HỌC: 

Online và Offline: Ngoài hình thức học ngay tại trung tâm thì bạn còn được học trực tuyến các bài giảng có sẵn trên hệ thống website.
🔷 LỊCH HỌC:

Lớp M3 | Thứ 3 & 6 : 20h00 - 22h00 | Khai giảng ngày 30/6/2022
Lớp M4 | Thứ 2 & 5 : 20h00 - 22h00 | Khai giảng ngày 10/7/2022
Lớp M5 | Thứ 2 & 5 : 17h30 - 19h30 | Khai giảng ngày 17/8/2022
🔷 HOẠT ĐỘNG NGOẠI KHÓA: 

Được tham gia 01 buổi đào tạo hướng nghiệp; event chia sẻ kinh nghiệm viết CV, phỏng vấn, ứng tuyển vào các tập đoàn lớn.
🔷 QUÀ TẶNG ĐẶC BIỆT

Tặng khoá học TOEIC CHUYÊN SÂU ONLINE trọn đời khi đăng ký và hoàn thành học phí trước ngày khai giảng 1 tuần.
Tặng khóa GIẢI ĐỀ TOEIC CẤP TỐC trị giá 1.868.000 vnđ.', 0, CAST(9990000 AS Decimal(18, 0)), N'toeic-chuyensau.jpg', 1, 3, 34)
SET IDENTITY_INSERT [dbo].[Course] OFF
GO
SET IDENTITY_INSERT [dbo].[Decentralization] ON 

INSERT [dbo].[Decentralization] ([ID], [accountID], [functionID]) VALUES (1, 1, 1)
INSERT [dbo].[Decentralization] ([ID], [accountID], [functionID]) VALUES (2, 1, 2)
INSERT [dbo].[Decentralization] ([ID], [accountID], [functionID]) VALUES (3, 1, 3)
INSERT [dbo].[Decentralization] ([ID], [accountID], [functionID]) VALUES (4, 1, 4)
INSERT [dbo].[Decentralization] ([ID], [accountID], [functionID]) VALUES (5, 1, 5)
INSERT [dbo].[Decentralization] ([ID], [accountID], [functionID]) VALUES (6, 1, 6)
INSERT [dbo].[Decentralization] ([ID], [accountID], [functionID]) VALUES (7, 1, 7)
INSERT [dbo].[Decentralization] ([ID], [accountID], [functionID]) VALUES (8, 1, 8)
INSERT [dbo].[Decentralization] ([ID], [accountID], [functionID]) VALUES (9, 1, 9)
INSERT [dbo].[Decentralization] ([ID], [accountID], [functionID]) VALUES (10, 1, 10)
INSERT [dbo].[Decentralization] ([ID], [accountID], [functionID]) VALUES (11, 1, 11)
INSERT [dbo].[Decentralization] ([ID], [accountID], [functionID]) VALUES (12, 1, 12)
INSERT [dbo].[Decentralization] ([ID], [accountID], [functionID]) VALUES (13, 10, 5)
INSERT [dbo].[Decentralization] ([ID], [accountID], [functionID]) VALUES (14, 10, 6)
INSERT [dbo].[Decentralization] ([ID], [accountID], [functionID]) VALUES (15, 10, 7)
INSERT [dbo].[Decentralization] ([ID], [accountID], [functionID]) VALUES (27, 10, 8)
INSERT [dbo].[Decentralization] ([ID], [accountID], [functionID]) VALUES (41, 17, 5)
INSERT [dbo].[Decentralization] ([ID], [accountID], [functionID]) VALUES (42, 17, 6)
INSERT [dbo].[Decentralization] ([ID], [accountID], [functionID]) VALUES (43, 17, 7)
INSERT [dbo].[Decentralization] ([ID], [accountID], [functionID]) VALUES (44, 17, 8)
SET IDENTITY_INSERT [dbo].[Decentralization] OFF
GO
SET IDENTITY_INSERT [dbo].[FunctionT] ON 

INSERT [dbo].[FunctionT] ([ID], [functionName]) VALUES (1, N'Giảng viên: Danh sách')
INSERT [dbo].[FunctionT] ([ID], [functionName]) VALUES (2, N'Giảng viên: Thêm mới')
INSERT [dbo].[FunctionT] ([ID], [functionName]) VALUES (3, N'Giảng viên: Cập nhật')
INSERT [dbo].[FunctionT] ([ID], [functionName]) VALUES (4, N'Giảng viên: Xóa')
INSERT [dbo].[FunctionT] ([ID], [functionName]) VALUES (5, N'Khóa học: Danh sách')
INSERT [dbo].[FunctionT] ([ID], [functionName]) VALUES (6, N'Khóa học: Thêm mới')
INSERT [dbo].[FunctionT] ([ID], [functionName]) VALUES (7, N'Khóa học: Cập nhật')
INSERT [dbo].[FunctionT] ([ID], [functionName]) VALUES (8, N'Khóa học: Xóa')
INSERT [dbo].[FunctionT] ([ID], [functionName]) VALUES (9, N'Tài khoản: Danh sách')
INSERT [dbo].[FunctionT] ([ID], [functionName]) VALUES (10, N'Tài khoản: Thêm mới')
INSERT [dbo].[FunctionT] ([ID], [functionName]) VALUES (11, N'Tài khoản: Cập nhật')
INSERT [dbo].[FunctionT] ([ID], [functionName]) VALUES (12, N'Tài khoản: Xóa')
SET IDENTITY_INSERT [dbo].[FunctionT] OFF
GO
SET IDENTITY_INSERT [dbo].[Lecturer] ON 

INSERT [dbo].[Lecturer] ([ID], [lecturerName], [description], [email], [phone], [img], [accountID]) VALUES (1, N'Lê Thị Thanh', N'- Giám đốc trung tâm Anh ngữ IMAX.
- Giảng viên TOEIC được đào tạo trực tiếp bởi IIG Việt Nam.
- Đạt 980 / 990 điểm trong kỳ thi TOEIC tại IIG .
- Cựu đội trưởng đội sinh viên tình nguyện khoa Ngoại Ngữ-ĐH CNHN.
- Chủ biên 4 khoá học online giúp bạn chinh phục TOEIC từ 0-850 điểm.
- Tác giả cuốn sách " 30 ngày giỏi ngữ pháp tiếng Anh cơ bản " - Hơn 6 năm kinh nghiệm trong việc giảng dạy Tiếng Anh.
- Đào tạo hơn 2000 học viên tự tin giao tiếp tiếng Anh và đạt chứng chỉ TOEIC quốc tết với số điểm cao.', N'lethithanhtoeic@gmail.com', N'0911222444', N'le-thi-thanh.jpg', 10)
INSERT [dbo].[Lecturer] ([ID], [lecturerName], [description], [email], [phone], [img], [accountID]) VALUES (5, N'thai ngoc dung', NULL, N'tnd@gmail.com', N'012345688', NULL, 18)
SET IDENTITY_INSERT [dbo].[Lecturer] OFF
GO
SET IDENTITY_INSERT [dbo].[ShoppingSession] ON 

INSERT [dbo].[ShoppingSession] ([ID], [accountID], [total], [createdAt]) VALUES (5, 8, CAST(199000 AS Decimal(18, 0)), CAST(N'2024-01-02T16:50:12.857' AS DateTime))
INSERT [dbo].[ShoppingSession] ([ID], [accountID], [total], [createdAt]) VALUES (6, 8, CAST(999000 AS Decimal(18, 0)), CAST(N'2024-01-04T12:13:04.813' AS DateTime))
SET IDENTITY_INSERT [dbo].[ShoppingSession] OFF
GO
SET IDENTITY_INSERT [dbo].[Student] ON 

INSERT [dbo].[Student] ([ID], [name], [email], [phone], [img], [accountID]) VALUES (2, N'Trần Hoàng Nhật', N'nhat@gmail.com', N'0911576126', NULL, 8)
INSERT [dbo].[Student] ([ID], [name], [email], [phone], [img], [accountID]) VALUES (3, N'thaidui', N'thaidui@gmail.com', N'0123456789', NULL, 9)
SET IDENTITY_INSERT [dbo].[Student] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Account__F3DBC5729EAD97DB]    Script Date: 04-Jan-24 3:19:18 PM ******/
ALTER TABLE [dbo].[Account] ADD UNIQUE NONCLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Account] ADD  DEFAULT ((1)) FOR [role]
GO
ALTER TABLE [dbo].[Account] ADD  DEFAULT ((1)) FOR [userStatus]
GO
ALTER TABLE [dbo].[Course] ADD  CONSTRAINT [DF__Course__numberOf__76969D2E]  DEFAULT ((0)) FOR [numberOfLectures]
GO
ALTER TABLE [dbo].[Course] ADD  CONSTRAINT [DF__Course__discount__778AC167]  DEFAULT ((0)) FOR [discountPrice]
GO
ALTER TABLE [dbo].[Cart]  WITH CHECK ADD  CONSTRAINT [FK_Cart_Course] FOREIGN KEY([courseID])
REFERENCES [dbo].[Course] ([ID])
GO
ALTER TABLE [dbo].[Cart] CHECK CONSTRAINT [FK_Cart_Course]
GO
ALTER TABLE [dbo].[Cart]  WITH CHECK ADD  CONSTRAINT [FK_Cart_ShoppingSession] FOREIGN KEY([sessionID])
REFERENCES [dbo].[ShoppingSession] ([ID])
GO
ALTER TABLE [dbo].[Cart] CHECK CONSTRAINT [FK_Cart_ShoppingSession]
GO
ALTER TABLE [dbo].[Course]  WITH CHECK ADD  CONSTRAINT [FK__Course__category__797309D9] FOREIGN KEY([categoryID])
REFERENCES [dbo].[Category] ([ID])
GO
ALTER TABLE [dbo].[Course] CHECK CONSTRAINT [FK__Course__category__797309D9]
GO
ALTER TABLE [dbo].[Course]  WITH CHECK ADD  CONSTRAINT [FK__Course__lecturer__787EE5A0] FOREIGN KEY([lecturerID])
REFERENCES [dbo].[Lecturer] ([ID])
GO
ALTER TABLE [dbo].[Course] CHECK CONSTRAINT [FK__Course__lecturer__787EE5A0]
GO
ALTER TABLE [dbo].[Decentralization]  WITH CHECK ADD  CONSTRAINT [FK__Decentral__funct__0B91BA14] FOREIGN KEY([functionID])
REFERENCES [dbo].[FunctionT] ([ID])
GO
ALTER TABLE [dbo].[Decentralization] CHECK CONSTRAINT [FK__Decentral__funct__0B91BA14]
GO
ALTER TABLE [dbo].[Decentralization]  WITH CHECK ADD  CONSTRAINT [FK_Decentralization_Account] FOREIGN KEY([accountID])
REFERENCES [dbo].[Account] ([ID])
GO
ALTER TABLE [dbo].[Decentralization] CHECK CONSTRAINT [FK_Decentralization_Account]
GO
ALTER TABLE [dbo].[Lecturer]  WITH CHECK ADD  CONSTRAINT [FK_Lecturer_Account] FOREIGN KEY([accountID])
REFERENCES [dbo].[Account] ([ID])
GO
ALTER TABLE [dbo].[Lecturer] CHECK CONSTRAINT [FK_Lecturer_Account]
GO
ALTER TABLE [dbo].[Lecturer]  WITH CHECK ADD  CONSTRAINT [FK_Lecturer_Account1] FOREIGN KEY([accountID])
REFERENCES [dbo].[Account] ([ID])
GO
ALTER TABLE [dbo].[Lecturer] CHECK CONSTRAINT [FK_Lecturer_Account1]
GO
ALTER TABLE [dbo].[ShoppingSession]  WITH CHECK ADD  CONSTRAINT [FK_ShoppingSession_Account] FOREIGN KEY([accountID])
REFERENCES [dbo].[Account] ([ID])
GO
ALTER TABLE [dbo].[ShoppingSession] CHECK CONSTRAINT [FK_ShoppingSession_Account]
GO
ALTER TABLE [dbo].[Student]  WITH CHECK ADD  CONSTRAINT [FK_Student_Account] FOREIGN KEY([accountID])
REFERENCES [dbo].[Account] ([ID])
GO
ALTER TABLE [dbo].[Student] CHECK CONSTRAINT [FK_Student_Account]
GO
ALTER TABLE [dbo].[Video]  WITH CHECK ADD  CONSTRAINT [FK_Video_Course] FOREIGN KEY([courseID])
REFERENCES [dbo].[Course] ([ID])
GO
ALTER TABLE [dbo].[Video] CHECK CONSTRAINT [FK_Video_Course]
GO
/****** Object:  StoredProcedure [dbo].[GetUserByUsername]    Script Date: 04-Jan-24 3:19:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[GetUserByUsername]
@username NVARCHAR(50)
AS 
BEGIN
	SELECT id, username, password
	FROM [dbo].[Account]
	WHERE username = @username
END
GO
USE [master]
GO
ALTER DATABASE [ILearnDB] SET  READ_WRITE 
GO
