<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
 <script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?sensor=false"></script>
<script type="text/javascript">
if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function (p) {
        var LatLng = new google.maps.LatLng(p.coords.latitude, p.coords.longitude);
        var mapOptions = {
            center: LatLng,
            zoom: 13,
            mapTypeId: google.maps.MapTypeId.ROADMAP
        };
        var map = new google.maps.Map(document.getElementById("dvMap"), mapOptions);
        var marker = new google.maps.Marker({
            position: LatLng,
            map: map,
            title: "<div style = 'height:60px;width:200px'><b>Your location:</b><br />Latitude: " + p.coords.latitude + "<br />Longitude: " + p.coords.longitude
        });
        google.maps.event.addListener(marker, "click", function (e) {
            var infoWindow = new google.maps.InfoWindow();
            infoWindow.setContent(marker.title);
            infoWindow.open(map, marker);
        });
    });
} else {
    alert('Geo Location feature is not supported in this browser.');
}

var lat1 = p.coords.latitude;
var long1 = p.coords.longitude;

</script>
     <script async="async" defer="defer"
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAKTOkvvzMEIC2kTsPtcIyBNAuSGvmkCo4&callback=initMap">
    </script>
    </head>
<body >

    <form id="form1" runat="server">

   <div id="dvMap" style="width: 250px; height: 250px">
</div>
   



    <p>
        &nbsp;</p>




    <p>




        <asp:Label ID="Label1" runat="server" Text="Latitude : "></asp:Label>
        <asp:Label ID="Label2" runat="server" Text="<%=lat1 %>"></asp:Label>
        </p>
        <p>
            <asp:Label ID="Label3" runat="server" Text="Longitude : "></asp:Label>
            <asp:Label ID="Label4" runat="server" Text="<%=long1 %>"></asp:Label>
        </p>
        <p>
            <asp:Label ID="Label5" runat="server" Text="Sunset : "></asp:Label>
            <asp:Label ID="Label6" runat="server" Text="Label"></asp:Label>
        </p>
        <p>
            <asp:Label ID="Label7" runat="server" Text="Sunrise : "></asp:Label>
            <asp:Label ID="Label8" runat="server" Text="Label"></asp:Label>
        </p>
    
   <asp:Button ID="Button1" runat="server" Text="Show Temperature" OnClick="Button1_Click" />
   
        <asp:TextBox ID="txtCity" runat="server"></asp:TextBox>
   
        <table id="tblWeather" runat="server" border="0" cellpadding="0" cellspacing="0"
    visible="true">
    <tr>
        <th colspan="2">
            Weather Information
        </th>
    </tr>
    <tr>
        <td rowspan="3">
            <asp:Image ID="imgWeatherIcon" runat="server" />
            <br />
        </td>
    </tr>
    <tr>
        <td>
            <asp:Label ID="lblCity_Country" runat="server" />
            <asp:Image ID="imgCountryFlag" runat="server" />
            <asp:Label ID="lblDescription" runat="server" />
            Humidity:
            <asp:Label ID="lblHumidity" runat="server" />
        </td>
    </tr>
    <tr>
        <td>
            Temperature:
            (Min:
            <asp:Label ID="lblTempMin" runat="server" />
            Max:
            <asp:Label ID="lblTempMax" runat="server" />
                Day:
            <asp:Label ID="lblTempDay" runat="server" />
                Night:
            <asp:Label ID="lblTempNight" runat="server" />)
        </td>
    </tr>
</table>


        <p></p>
        <p></p>

    </form>
   



</body>
</html>
