using System;
using System.Collections.Generic;

namespace ILEARN.Models;

public partial class Cart
{
    public int Id { get; set; }

    public int SessionId { get; set; }

    public int CourseId { get; set; }

    public virtual Course Course { get; set; } = null!;

    public virtual ShoppingSession Session { get; set; } = null!;
}
