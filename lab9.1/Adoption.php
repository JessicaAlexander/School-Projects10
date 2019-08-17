<?php 
// --------------
// -- Programmer:  [Jessica Alexander]
// -- Course:      ITSE-1306 (Intro to PHP)
// -- Instructor:  Cesar "Coach" Marrero
// -- Assignment:  [Week9]
// -- Description: [Web Application]

define('TITLE', 'Adoption');
include('template/header.html');

print '<h2>Adoption Form</h2>
	<p>Fill out this adoption form so that you are one step closer to giving one of these furbabies a forever home! Be sure to state the dogs age and the number of the dog you want to adopt!</p>';
	

	if ($_SERVER['REQUEST_METHOD'] == 'POST') {
	$problem = false; 
	

	if (empty($_POST['first_name'])) {
		$problem = true;
		print '<p class="text--error">Please enter your first name!</p>';
	}
	
	if (empty($_POST['last_name'])) {
		$problem = true;
		print '<p class="text--error">Please enter your last name!</p>';

        	}

	if (empty($_POST['address'])) {
		$problem = true;
		print '<p class="text--error">Please enter a address!</p>';
	}

	if (empty($_POST['Zipcode'])) {
		$problem = true;
		print '<p class="text--error">Please enter a zipcode!</p>';
	}

	if (empty($_POST['email'])) {
		$problem = true;
		print '<p class="text--error">Please enter your email address!</p>';

	} 
		if (empty($_POST['Phone_Number'])) {
		$problem = true;
		print '<p class="text--error">Please enter your Phone Number!</p>';

	} 
    if (empty($_POST['Dog_Description'])) {
		$problem = true;
		print '<p class="text--error">Please enter the dog description!</p>';

    } 
    
	if (!$problem) { 
		
		print '<p class="text--success">You are now registered to adopt a new furbaby!<br>Okay, you are not really registered but... Thanks for the thought though</p>';

		$_POST = [];
	
	} else { 
	
		print '<p class="text--error">Please try again!</p>';
		
	}
} 

?>
<form action="Adoption.php" method="post" class="form--inline">

	<p><label for="first_name">First Name:</label><input type="text" name="first_name" size="20" value="<?php if (isset($_POST['first_name'])) { print htmlspecialchars($_POST['first_name']); } ?>"></p>

	<p><label for="last_name">Last Name:</label><input type="text" name="last_name" size="20" value="<?php if (isset($_POST['last_name'])) { print htmlspecialchars($_POST['last_name']); } ?>"></p>


    <p><label for="address">Address:</label><input type="text" name="address" size="20" value="<?php if (isset($_POST['address'])) { print htmlspecialchars($_POST['address']); } ?>"></p>

    <p><label for="Zipcode">Zipcode:</label><input type="text" name="Zipcode" size="20" value="<?php if (isset($_POST['Zipcode'])) { print htmlspecialchars($_POST['Zipcode']); } ?>"></p>

    <p><label for="email">Email Address:</label><input type="email" name="email" size="20" value="<?php if (isset($_POST['email'])) { print htmlspecialchars($_POST['email']); } ?>"></p>

    <p><label for="Phone_Number">Phone Number:</label><input type="text" name="Phone_Number" size="20" value="<?php if (isset($_POST['Phone_Number'])) { print htmlspecialchars($_POST['Zipcode']); } ?>"></p>

    <p><label for="Dog_Description">Dog Age and Number:</label><input type="text" name="Dog_Description" size="20" value="<?php if (isset($_POST['Dog_Description'])) { print htmlspecialchars($_POST['Zipcode']); } ?>"></p>

	<p><input type="submit" name="submit" value="Adopt!" class="button--pill"></p>

</form>

<?php include('template/footer.html');  ?>