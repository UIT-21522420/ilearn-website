using System;
using System.Collections.Generic;

namespace ILEARN.Models;

public partial class Video
{
    public int Id { get; set; }

    public string Title { get; set; } = null!;

    public string Link { get; set; } = null!;

    public DateTime CreatedAt { get; set; }

    public DateTime? ModifiedAt { get; set; }

    public int CourseId { get; set; }

    public string? Subtitle { get; set; }

    public virtual Course Course { get; set; } = null!;
}
