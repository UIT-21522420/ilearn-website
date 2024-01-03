using ILEARN.Models;
using Microsoft.AspNetCore.Mvc;
using System.Diagnostics;

namespace ILEARN.Controllers
{
    public class ErrorController : Controller
    {
        public IActionResult NoPrivilege()
        {
            return View();
        }

        public IActionResult NullPage() 
        { 
            return View();
        }

        public IActionResult Error()
        {
            return View();
        }
    }
}