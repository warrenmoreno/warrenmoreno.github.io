<!-- 

Original Author: Warren Moreno
Date Created: August 20th, 2019
Version: LiveVersion0.1
Date Last Modified: April 17th, 2020
Modified by: Warren Moreno
Modification log: added aspx functions, updated nav link
Filename: feedback.aspx

-->

<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<!DOCTYPE html>

<html lang="en"/>

	<script runat="server">
        protected void submitButton_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                // Code that uses the data entered by the user
                // Define data objects
                SqlConnection conn;
                SqlCommand comm;
                // Read the connection string from Web.config
                string connectionString =
                    ConfigurationManager.ConnectionStrings[
                    "evajones"].ConnectionString;
                // Initialize connection
                conn = new SqlConnection(connectionString);

                // Create command 
                comm = new SqlCommand("EXEC InsertCustomer @nameTextBox, @emailTextBox," +
                                          " @msgTextBox, @gamerPhone, @serviceRate, @CheckBox, 1", conn);
                

                //Gamer Name
                comm.Parameters.Add("@nameTextBox", System.Data.SqlDbType.NChar, 50);
                comm.Parameters["@nameTextBox"].Value = gamerName.Text;


                //Gamer Email
                comm.Parameters.Add("@emailTextBox", System.Data.SqlDbType.NChar, 50);
                comm.Parameters["@emailTextBox"].Value = gamerEmail.Text;

				
				//Gamer Message
                comm.Parameters.Add("@msgTextBox", System.Data.SqlDbType.NChar, 200);
                comm.Parameters["@msgTextBox"].Value = custExp.Text;


				//Gamer Phone
                comm.Parameters.Add("@gamerPhone", System.Data.SqlDbType.NChar, 200);
                comm.Parameters["@gamerPhone"].Value = gamerPhone.Text;

                
                //serviceRate
                comm.Parameters.Add("@serviceRate", System.Data.SqlDbType.NChar, 200);
                comm.Parameters["@serviceRate"].Value = serviceRate.SelectedValue;


                //checkbox for Email contact
                comm.Parameters.Add("@CheckBox", System.Data.SqlDbType.Bit);
                comm.Parameters["@CheckBox"].Value = mailCB.Checked;


                // Enclose database code in Try-Catch-Finally
                try
                {
                    // Open the connection
                    conn.Open();
                    // Execute the command
                    comm.ExecuteNonQuery();
                    // Reload page if the query executed successfully
                    Response.Redirect("feedback_sent.html");
                }
                catch (SqlException ex)
                {
                    // Display error message
                    dbErrorMessage.Text =
                       "Error submitting the data!" + ex.Message.ToString();

                }
                finally
                {
                    // Close the connection
                    conn.Close();
                }
            }
        }

</script>

<html xmlns="http://www.w3.org/1999/xhtml">


<head runat="server">
	
	<meta charset="utf-8">		
	<title>Project#04</title>
		
	<meta name="viewport" content="width=device-width, initial-scale=1" />
	<meta name="description" content="Demented Games, Let Your Imagination Run Wild" />
	<meta name="keywords" content="video games, computer games, LARP">
	
	<link href="css/visual_feedback.css" rel="stylesheet" media="all"/>
	<link href="css/visual_style2.css" rel="stylesheet" media="screen"/>
	<link href="css/print_style.css" rel="stylesheet" media="print"/>
	
	<link rel="apple-touch-icon" sizes="180x180" href="images/favicon_io/apple-touch-icon.png"/>
	<link rel="icon" type="image/png" sizes="32x32" href="images/favicon_io/favicon-32x32.png"/>
	<link rel="icon" type="image/png" sizes="16x16" href="images/favicon_io/favicon-16x16.png"/>
	<link rel="manifest" href="images/favicon_io/site.webmanifest"/>

	
</head>

<body>
	<header>
	
		<audio autoplay loop controls >
			<source src="audio/darren-curtis-the-old-pumpkin-patch.mp3" autoplay="true" type="audio/mp3" />
			
			<p><em>To play this audio clip, your browser needs to support HTML5.</em></p>
		</audio>
		 
		<!-- The Old Pumpkin Patch by Darren-Curtis | https://soundcloud.com/desperate-measurez
		Music promoted by https://www.free-stock-music.com
		Creative Commons Attribution 3.0 Unported License
		https://creativecommons.org/licenses/by/3.0/deed.en_US -->
	
		<h1>Demented Games, <br/>play for fun, stay to broaden your horizons...</h1>
		
    <nav class="horizontal">
	 <a id="navicon" href="#"><img src="images/navicon.png" alt="" /></a>
		<ul>
            <li><a href="index.html">Home</a></li>
            <li><a href="events.html">Events</a></li>
            <li><a href="about_us.html">About Us</a></li>
            <li><a class="active" href="feedback.aspx">Feedback</a></li>
            <li><a href="login.php">Login</a></li>
        </ul>
    </nav>
		
	</header>
	
	<section>
		<!-- Info gathering -->
		<form id="feedBack" runat="server" >
			<fieldset id="custIdea">
			
				<legend>Gamer Data</legend>
				
				<div class="formRow">
					<label for="gamerName">GamerTag*</label>
                    <%--<input type="text" name="name" id="name"/>--%>

						<asp:TextBox ID="gamerName" runat="server" >first and last name</asp:TextBox>

				</div>
				
				<div class="formRow">
					<label for="gamerPhone">What's your Communicator Link?</label>
					<!--<placeholder="(nnn) nnn-nnnn" pattern="^\d{10}$|^(\(\d{3}\)\s*)?\d{3}[\s-]?\d{4}$" />-->

                    <%--<input type="text" name="name" id="name"/>--%>
						<asp:TextBox ID="gamerPhone" runat="server" >(nnn) nnn-nnnn</asp:TextBox>


				</div>
				
				<div class="formRow">
					<label for="gamerEmail">Data Processor*</label>
					<!--< placeholder="someoneX5@link.com" required />-->

                    <%--<input type="text" name="email" id="email"/>--%>
				       <asp:TextBox ID="gamerEmail" runat="server" >someoneX5@link.com</asp:TextBox>

				</div>
				
				<asp:CheckBox ID="mailCB" runat="server" 
					Text="Add me to your mailing list for upcoming events and sales!" />
					

				<p>*Data Required</p>
				
			</fieldset>
			
			<!-- Customer  gathering -->
			<fieldset id="expInfo">
				<legend>How was the Action at Demented Games?</legend>
				
				<div class="formRow">
					<label for="rangeBox">Rate our Operatives<br />
						(0 = Red-Shirt to <br />10 = It's over 9000!!!)</label>
                    
				    <asp:DropDownList ID="serviceRate" runat="server">
                        <asp:ListItem Value="0">0 - Red Shirt</asp:ListItem>
                        <asp:ListItem Value="1">1 - Wow..you&#39;re not dead?</asp:ListItem>
                        <asp:ListItem Value="2">2 - Lone Suvivor</asp:ListItem>
                        <asp:ListItem Value="3">3 - Leroy Jenkins!!</asp:ListItem>
                        <asp:ListItem Value="4">4 - oh..COME.ON!!</asp:ListItem>
                        <asp:ListItem Value="5">5 - Well..that happened.</asp:ListItem>
                        <asp:ListItem Value="6">6 - You want S.T.A.R.S.? You got S.T.A.R.S.!</asp:ListItem>
                        <asp:ListItem Value="7">7 - The Force is With You</asp:ListItem>
                        <asp:ListItem Value="8">8 - It&#39;s SUPER EFFECTIVE</asp:ListItem>
                        <asp:ListItem Value="9">9 - Critical Hit!</asp:ListItem>
                        <asp:ListItem Value="10">10 - It&#39;s over 9000!!</asp:ListItem>
                    </asp:DropDownList>
                    
				</div>
				
				<label for="commBox">Do you have an Event for us to try or games to add?</label>
                <%--<textarea name="message" id="message" cols="45" rows="5"></textarea>--%>
					<asp:TextBox ID="custExp" runat="server" Height="100px" Width="300px" />

				
			</fieldset>
			
			<!-- Buttons -->
			<div id="buttons">
				<asp:Button ID="submitButton" runat="server"
                Text="Send to DM" onclick="submitButton_Click" />
				<br />
				<asp:Label ID="dbErrorMessage" runat="server"></asp:Label>

			</div>
			
	  </form>
	  
	</section>
	
	<!--contact number-->
	<footer>
		Call <a href="tel:+12086250197">(208) 625-0197</a> for any questions about upcoming events,
		or check us out on Facebook or Twitich.<br /><br />
			
		<a href="https://twitch.tv/" target="_blank">
			<img src="images/iconmonstr-twitch-3-64.png" alt="social icon for GitHub"></a>
			
		<a href="https://www.facebook.com/" target="_blank">
			<img src="images/iconmonstr-facebook-3-64.png" alt="social icon for Linkedin"></a>
			
	</footer>
	
</body>


</html>