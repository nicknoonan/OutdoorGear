using System.Security.Cryptography;
using System.Text;

namespace OutdoorGearApi.Controllers
{
    static public class HashPassword
    {
        public static string Hash(string password)
        {
            byte[] passwordBytes = Encoding.UTF8.GetBytes(password);
            byte[] saltBytes = Encoding.UTF8.GetBytes("mysalt");
            HashAlgorithmName hashAlgorithm = HashAlgorithmName.SHA256;
            byte[] hashBytes = Rfc2898DeriveBytes.Pbkdf2(passwordBytes, saltBytes, 10000, hashAlgorithm, 64);
            string hash = Convert.ToBase64String(hashBytes);
            return hash;
        }
    }
}
