using System;
using System.Collections.Generic;

namespace ILEARN.Models;

public partial class ShoppingSession
{
    public int Id { get; set; }

    public int AccountId { get; set; }

    public decimal? Total { get; set; }

    public DateTime CreatedAt { get; set; }

    public virtual Account Account { get; set; } = null!;

    public virtual ICollection<Cart> Carts { get; set; } = new List<Cart>();
}
