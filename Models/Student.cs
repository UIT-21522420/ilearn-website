using System;
using System.Collections.Generic;

namespace ILEARN.Models;

public partial class Student
{
    public int Id { get; set; }

    public string Name { get; set; } = null!;

    public string Email { get; set; } = null!;

    public string? Phone { get; set; }

    public string? Img { get; set; }

    public int? AccountId { get; set; }

    public virtual Account? Account { get; set; }
}
