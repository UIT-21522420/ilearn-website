namespace ILEARN.Models
{
    public class DecentralizationViewModel
    {
        public int AccountID { get; set; }
        public string LecturerName { get; set; }
        public Dictionary<int, bool> FunctionPermissions { get; set; }

        public DecentralizationViewModel()
        {
            FunctionPermissions = new Dictionary<int, bool>();
        }
    }

}
