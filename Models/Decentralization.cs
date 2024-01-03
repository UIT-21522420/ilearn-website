using System;
using System.Collections.Generic;

namespace ILEARN.Models;

public partial class Decentralization
{
    public int AccountId { get; set; }

    public int FunctionId { get; set; }

    public int Id { get; set; }

    public virtual Account Account { get; set; } = null!;

    public virtual FunctionT Function { get; set; } = null!;
}
