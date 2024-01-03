using ILEARN.Models;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using ILEARN.Controllers;
using System.Net;
using System.Text;
using Microsoft.Identity.Client;

namespace ILEARN.Controllers
{
    public class CartController : Controller
    {
        public IActionResult Index()
        {
            List<int> cart;

            // Retrieve existing cart from session
            if (HttpContext.Session.TryGetValue("Cart", out var cartData))
            {
                cart = JsonConvert.DeserializeObject<List<int>>(Encoding.UTF8.GetString(cartData));
            }
            else
            {
                // If the key "Cart" doesn't exist, initialize a new cart
                cart = new List<int>();
            }

            return View(cart.Distinct().ToList());
        }
        public IActionResult GetCourse(int ID)
        {
            using IlearnDbContext db = new();
            var course = db.Courses.FirstOrDefault(m => m.Id == ID);
            return View(course);
        }

        public IActionResult AddToCart(int courseID, int accountID)
        {
            try
            {
                List<int> cart;

                if (HttpContext.Session.TryGetValue("Cart", out var cartData))
                {
                    cart = JsonConvert.DeserializeObject<List<int>>(Encoding.UTF8.GetString(cartData));
                }
                else
                {
                    cart = new List<int>();
                }

                var registeredCourse = Common.GetRegisteredCourses(accountID);
        
                if (registeredCourse.Contains(courseID)) 
                {
                    TempData["error"] = "Khóa học này đã được mua. Vui lòng thử lại.";
                    return RedirectToAction("Index", "Course");
                }

                cart.Add(courseID);

                HttpContext.Session.SetString("Cart", JsonConvert.SerializeObject(cart));

                TempData["message"] = "Đã thêm khóa học vào giỏ hàng.";

                return RedirectToAction("Index", "Course");
            }
            catch (Exception)
            {
                return RedirectToAction("Error", "Home");
            }
        }

        public IActionResult RemoveFromCart(int courseID)
        {
            try
            {
                List<int> cart;

                if (HttpContext.Session.TryGetValue("Cart", out var cartData))
                {
                    cart = JsonConvert.DeserializeObject<List<int>>(Encoding.UTF8.GetString(cartData));

                    // Remove the new number to the cart
                    cart.Remove(courseID);

                    // Save the updated cart back to session
                    HttpContext.Session.SetString("Cart", JsonConvert.SerializeObject(cart));

                    TempData["message"] = "Xóa thành công.";

                    return RedirectToAction("Index", "Cart");
                }
                else
                {
                    return RedirectToAction("Index", "Cart");
                }
            }
            catch (Exception)
            {
                // Log the exception or provide feedback to the user
                return RedirectToAction("Error", "Home");
            }
        }

        public IActionResult Pay(List<int> cartList, int accountID)
        {
            using IlearnDbContext db = new();
            var total = Common.GetTotal(cartList);
            var createAt = DateTime.Now;
            ShoppingSession shoppingSession = new() { AccountId = accountID, Total = total, CreatedAt = createAt };
            db.ShoppingSessions.Add(shoppingSession);
            db.SaveChanges();
            var sessionID = db.ShoppingSessions.Max(x => x.Id);
            foreach (var item in cartList)
            {
                Cart course = new() { SessionId = sessionID, CourseId = item };
                db.Carts.Add(course);
                db.SaveChanges();

                TempData["message"] = "Thanh toán thành công.";
            }
            return RedirectToAction("Index", "Home");
        }
    }
}
