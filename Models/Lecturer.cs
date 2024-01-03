using System;
using System.Collections.Generic;

namespace ILEARN.Models;

public partial class Lecturer
{
    public int Id { get; set; }

    public string LecturerName { get; set; } = null!;

    public string? Description { get; set; }

    public string Email { get; set; } = null!;

    public string Phone { get; set; } = null!;

    public string? Img { get; set; }

    public int AccountId { get; set; }

    public virtual Account Account { get; set; } = null!;

    public virtual ICollection<Course> Courses { get; set; } = new List<Course>();
}
