using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;
using System.Net;
using System.Net.Http;
using System.IO;
using System.Windows.Forms;
using SunSetRiseLib;

using System.Web.Script.Serialization;
public partial class _Default : System.Web.UI.Page
{

    public class WeatherInfo
    {
        public City city { get; set; }
        public List<List> list { get; set; }
    }

    public class City
    {
        public string name { get; set; }
        public string country { get; set; }
    }

    public class Temp
    {
        public double day { get; set; }
        public double min { get; set; }
        public double max { get; set; }
        public double night { get; set; }
    }

    public class Weather
    {
        public string description { get; set; }
        public string icon { get; set; }
    }

    public class List
    {
        public Temp temp { get; set; }
        public int humidity { get; set; }
        public List<Weather> weather { get; set; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
         double JD = 0;
         int zone = -8; // Seattle time Zone
         double latitude=27; // Seattle lat
         double longitude=28; // Seattle lon 
         bool dst = true; // Day Light Savings 
         DateTime date = DateTime.Today;

        JD = Util.calcJD(date);  //OR   JD = Util.calcJD(2014, 6, 1);
        double sunRise = Util.calcSunRiseUTC(JD, latitude, longitude);
        double sunSet = Util.calcSunSetUTC(JD, latitude, longitude);
        double sunrise = Util.calcSunRiseUTCWithFraction(JD, latitude, longitude);

        Label2.Text = latitude.ToString();
        Label4.Text = longitude.ToString();
        Label6.Text = Util.getDateTime(sunSet, zone, date, dst).Value.ToString();
        Label8.Text = Util.getDateTime(sunrise, zone, date, dst).Value.ToString();


        

      


    }






    protected void Button1_Click(object sender, EventArgs e)
    {
        string appId = "<App Id>";
        string url = string.Format("http://api.openweathermap.org/data/2.5/forecast/daily?q={0}&units=metric&cnt=1&APPID={1}", txtCity.Text.Trim(), appId);
        using (WebClient client = new WebClient())
        {
            client.UseDefaultCredentials = true;
            string json = client.DownloadString(url);

            WeatherInfo weatherInfo = (new JavaScriptSerializer()).Deserialize<WeatherInfo>(json);
            lblCity_Country.Text = weatherInfo.city.name + "," + weatherInfo.city.country;
            imgCountryFlag.ImageUrl = string.Format("http://openweathermap.org/images/flags/{0}.png", weatherInfo.city.country.ToLower());
            lblDescription.Text = weatherInfo.list[0].weather[0].description;
            imgWeatherIcon.ImageUrl = string.Format("http://openweathermap.org/img/w/{0}.png", weatherInfo.list[0].weather[0].icon);
            lblTempMin.Text = string.Format("{0}°С", Math.Round(weatherInfo.list[0].temp.min, 1));
            lblTempMax.Text = string.Format("{0}°С", Math.Round(weatherInfo.list[0].temp.max, 1));
            lblTempDay.Text = string.Format("{0}°С", Math.Round(weatherInfo.list[0].temp.day, 1));
            lblTempNight.Text = string.Format("{0}°С", Math.Round(weatherInfo.list[0].temp.night, 1));
            lblHumidity.Text = weatherInfo.list[0].humidity.ToString();
            tblWeather.Visible = true;

        }
    }
}