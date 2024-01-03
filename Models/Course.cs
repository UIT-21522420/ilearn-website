using System;
using System.Collections.Generic;

namespace ILEARN.Models;

public partial class Course
{
    public int Id { get; set; }

    public string CourseName { get; set; } = null!;

    public decimal CoursePrice { get; set; }

    public string? Introduction { get; set; }

    public string? Description { get; set; }

    public int? NumberOfLectures { get; set; }

    public decimal? DiscountPrice { get; set; }

    public string? Img { get; set; }

    public int LecturerId { get; set; }

    public int CategoryId { get; set; }

    public int? Discount { get; set; }

    public virtual ICollection<Cart> Carts { get; set; } = new List<Cart>();

    public virtual Category Category { get; set; } = null!;

    public virtual Lecturer Lecturer { get; set; } = null!;

    public virtual ICollection<Video> Videos { get; set; } = new List<Video>();
}
