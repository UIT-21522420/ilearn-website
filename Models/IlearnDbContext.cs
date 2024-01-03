using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace ILEARN.Models;

public partial class IlearnDbContext : DbContext
{
    public IlearnDbContext()
    {
    }

    public IlearnDbContext(DbContextOptions<IlearnDbContext> options)
        : base(options)
    {
    }

    public virtual DbSet<Account> Accounts { get; set; }

    public virtual DbSet<Cart> Carts { get; set; }

    public virtual DbSet<Category> Categories { get; set; }

    public virtual DbSet<Course> Courses { get; set; }

    public virtual DbSet<Decentralization> Decentralizations { get; set; }

    public virtual DbSet<FunctionT> FunctionTs { get; set; }

    public virtual DbSet<Lecturer> Lecturers { get; set; }

    public virtual DbSet<ShoppingSession> ShoppingSessions { get; set; }

    public virtual DbSet<Student> Students { get; set; }

    public virtual DbSet<Video> Videos { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see http://go.microsoft.com/fwlink/?LinkId=723263.
        => optionsBuilder.UseSqlServer("Server=ASUS\\SQLSERVER;Database=ILearnDB;Integrated Security=True;Encrypt=True;TrustServerCertificate=True;");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Account>(entity =>
        {
            entity.ToTable("Account");

            entity.HasIndex(e => e.Username, "UQ__Account__F3DBC5729EAD97DB").IsUnique();

            entity.Property(e => e.Id).HasColumnName("ID");
            entity.Property(e => e.Password)
                .HasMaxLength(50)
                .HasColumnName("password");
            entity.Property(e => e.Role)
                .HasDefaultValueSql("((1))")
                .HasColumnName("role");
            entity.Property(e => e.UserStatus)
                .HasDefaultValueSql("((1))")
                .HasColumnName("userStatus");
            entity.Property(e => e.Username)
                .HasMaxLength(50)
                .HasColumnName("username");
        });

        modelBuilder.Entity<Cart>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Cart__3214EC27245EDFF6");

            entity.ToTable("Cart");

            entity.Property(e => e.Id).HasColumnName("ID");
            entity.Property(e => e.CourseId).HasColumnName("courseID");
            entity.Property(e => e.SessionId).HasColumnName("sessionID");

            entity.HasOne(d => d.Course).WithMany(p => p.Carts)
                .HasForeignKey(d => d.CourseId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Cart_Course");

            entity.HasOne(d => d.Session).WithMany(p => p.Carts)
                .HasForeignKey(d => d.SessionId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Cart_ShoppingSession");
        });

        modelBuilder.Entity<Category>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Category__3214EC2765015EF0");

            entity.ToTable("Category");

            entity.Property(e => e.Id).HasColumnName("ID");
            entity.Property(e => e.CategoryName)
                .HasMaxLength(50)
                .HasColumnName("categoryName");
        });

        modelBuilder.Entity<Course>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Course__3214EC271B8898BB");

            entity.ToTable("Course");

            entity.Property(e => e.Id).HasColumnName("ID");
            entity.Property(e => e.CategoryId).HasColumnName("categoryID");
            entity.Property(e => e.CourseName)
                .HasMaxLength(50)
                .HasColumnName("courseName");
            entity.Property(e => e.CoursePrice)
                .HasColumnType("decimal(18, 0)")
                .HasColumnName("coursePrice");
            entity.Property(e => e.Description)
                .HasMaxLength(4000)
                .HasColumnName("description");
            entity.Property(e => e.Discount).HasColumnName("discount");
            entity.Property(e => e.DiscountPrice)
                .HasDefaultValueSql("((0))")
                .HasColumnType("decimal(18, 0)")
                .HasColumnName("discountPrice");
            entity.Property(e => e.Img)
                .HasMaxLength(100)
                .HasColumnName("img");
            entity.Property(e => e.Introduction)
                .HasMaxLength(4000)
                .HasColumnName("introduction");
            entity.Property(e => e.LecturerId).HasColumnName("lecturerID");
            entity.Property(e => e.NumberOfLectures)
                .HasDefaultValueSql("((0))")
                .HasColumnName("numberOfLectures");

            entity.HasOne(d => d.Category).WithMany(p => p.Courses)
                .HasForeignKey(d => d.CategoryId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Course__category__797309D9");

            entity.HasOne(d => d.Lecturer).WithMany(p => p.Courses)
                .HasForeignKey(d => d.LecturerId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Course__lecturer__787EE5A0");
        });

        modelBuilder.Entity<Decentralization>(entity =>
        {
            entity.ToTable("Decentralization");

            entity.Property(e => e.Id).HasColumnName("ID");
            entity.Property(e => e.AccountId).HasColumnName("accountID");
            entity.Property(e => e.FunctionId).HasColumnName("functionID");

            entity.HasOne(d => d.Account).WithMany(p => p.Decentralizations)
                .HasForeignKey(d => d.AccountId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Decentralization_Account");

            entity.HasOne(d => d.Function).WithMany(p => p.Decentralizations)
                .HasForeignKey(d => d.FunctionId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Decentral__funct__0B91BA14");
        });

        modelBuilder.Entity<FunctionT>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Function__3214EC2792E30C1F");

            entity.ToTable("FunctionT");

            entity.Property(e => e.Id).HasColumnName("ID");
            entity.Property(e => e.FunctionName)
                .HasMaxLength(100)
                .HasColumnName("functionName");
        });

        modelBuilder.Entity<Lecturer>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Lecturer__3214EC270D53F97A");

            entity.ToTable("Lecturer");

            entity.Property(e => e.Id).HasColumnName("ID");
            entity.Property(e => e.AccountId).HasColumnName("accountID");
            entity.Property(e => e.Description)
                .HasMaxLength(4000)
                .HasColumnName("description");
            entity.Property(e => e.Email)
                .HasMaxLength(50)
                .HasColumnName("email");
            entity.Property(e => e.Img)
                .HasMaxLength(100)
                .HasColumnName("img");
            entity.Property(e => e.LecturerName)
                .HasMaxLength(100)
                .HasColumnName("lecturerName");
            entity.Property(e => e.Phone)
                .HasMaxLength(20)
                .HasColumnName("phone");

            entity.HasOne(d => d.Account).WithMany(p => p.Lecturers)
                .HasForeignKey(d => d.AccountId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Lecturer_Account");
        });

        modelBuilder.Entity<ShoppingSession>(entity =>
        {
            entity.ToTable("ShoppingSession");

            entity.Property(e => e.Id).HasColumnName("ID");
            entity.Property(e => e.AccountId).HasColumnName("accountID");
            entity.Property(e => e.CreatedAt)
                .HasColumnType("datetime")
                .HasColumnName("createdAt");
            entity.Property(e => e.Total)
                .HasColumnType("decimal(18, 0)")
                .HasColumnName("total");

            entity.HasOne(d => d.Account).WithMany(p => p.ShoppingSessions)
                .HasForeignKey(d => d.AccountId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_ShoppingSession_Account");
        });

        modelBuilder.Entity<Student>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Student__3214EC27C2D7F0BB");

            entity.ToTable("Student");

            entity.Property(e => e.Id).HasColumnName("ID");
            entity.Property(e => e.AccountId).HasColumnName("accountID");
            entity.Property(e => e.Email)
                .HasMaxLength(50)
                .HasColumnName("email");
            entity.Property(e => e.Img)
                .HasMaxLength(50)
                .HasColumnName("img");
            entity.Property(e => e.Name)
                .HasMaxLength(50)
                .HasColumnName("name");
            entity.Property(e => e.Phone)
                .HasMaxLength(20)
                .HasColumnName("phone");

            entity.HasOne(d => d.Account).WithMany(p => p.Students)
                .HasForeignKey(d => d.AccountId)
                .HasConstraintName("FK_Student_Account");
        });

        modelBuilder.Entity<Video>(entity =>
        {
            entity.ToTable("Video");

            entity.Property(e => e.Id)
                .ValueGeneratedNever()
                .HasColumnName("ID");
            entity.Property(e => e.CourseId).HasColumnName("courseID");
            entity.Property(e => e.CreatedAt)
                .HasColumnType("datetime")
                .HasColumnName("createdAt");
            entity.Property(e => e.Link)
                .HasMaxLength(50)
                .HasColumnName("link");
            entity.Property(e => e.ModifiedAt)
                .HasColumnType("datetime")
                .HasColumnName("modifiedAt");
            entity.Property(e => e.Subtitle)
                .HasMaxLength(4000)
                .HasColumnName("subtitle");
            entity.Property(e => e.Title)
                .HasMaxLength(50)
                .HasColumnName("title");

            entity.HasOne(d => d.Course).WithMany(p => p.Videos)
                .HasForeignKey(d => d.CourseId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Video_Course");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
