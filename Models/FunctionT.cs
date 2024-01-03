using System;
using System.Collections.Generic;

namespace ILEARN.Models;

public partial class FunctionT
{
    public int Id { get; set; }

    public string? FunctionName { get; set; }

    public virtual ICollection<Decentralization> Decentralizations { get; set; } = new List<Decentralization>();
}
