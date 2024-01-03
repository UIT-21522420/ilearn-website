using System;
using System.Collections.Generic;

namespace ILEARN.Models;

public partial class Account
{
    public int Id { get; set; }

    public string Username { get; set; } = null!;

    public string Password { get; set; } = null!;

    public int Role { get; set; }

    public int UserStatus { get; set; }

    public virtual ICollection<Decentralization> Decentralizations { get; set; } = new List<Decentralization>();

    public virtual ICollection<Lecturer> Lecturers { get; set; } = new List<Lecturer>();

    public virtual ICollection<ShoppingSession> ShoppingSessions { get; set; } = new List<ShoppingSession>();

    public virtual ICollection<Student> Students { get; set; } = new List<Student>();
}
