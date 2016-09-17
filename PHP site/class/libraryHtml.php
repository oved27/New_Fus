<?php
class libraryHtml{
	static function navBar(db $db,$UserName, $Password){
		$Code = <<<HTML
		<li><a href="AddUser.php">Add User</a></li>
		<li><a href="UserManagement.php">User Managment</a></li>
		<li><a href="DeliveryManagment.php">Delivery Managment</a></li>
HTML;
		$array=dalLibrary::CheckLinks($db,$UserName, $Password);
		if($array[0]->Role!=1)
		{
			$Code="";	
		}
		return $Code;
	}
}

?>