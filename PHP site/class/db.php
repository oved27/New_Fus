<?php

class db {

    private $affected_rows;
    private $mysqli;
    private $host, $user, $pass, $dbName;

    public function __construct($host, $dbName, $user, $pass) {
        $this->host = $host;
        $this->user = $user;
        $this->pass = $pass;
        $this->dbName = $dbName;
    }

    public function openConn() {
        $this->mysqli = new mysqli($this->host, $this->user, $this->pass, $this->dbName);
        if ($this->mysqli->connect_error) {
            die('Connect Error (' . $this->mysqli->connect_errno . ') '
                    . $this->mysqli->connect_error);
        }
    }

    public function closeConn() {
        $this->mysqli->close();
    }

    public function selectQeury($query) {
        $arrayResult = array();
        if ($result = $this->mysqli->query($query)) {
            /* printf("Select returned %d rows.\n", $result->num_rows); */
            while ($obj = $result->fetch_object()) {
                $arrayResult[] = $obj;
                //printf ("%s (%s)\n", $obj->CourierID, $obj->IsActive);
            }

            /* free result set */
            $result->close();
            $this->mysqli->next_result();
        } else {
            throw new Exception("Error select query", 1);
        }
        $this->mysqli->commit();
        return $arrayResult;
    }

    public function updateQeury($query) {
        //$arrayResult = array();
        $this->affected_rows = 0;
        if ($this->mysqli->query($query)) {
            $this->affected_rows = $this->mysqli->affected_rows;
        } else {
            throw new Exception("Error update query", 1);
        }
        /* free result set */
        //$result->close();
		if(mysqli_more_results($this->mysqli))//Catch 'OK'/'ERR'
		while(mysqli_next_result($this->mysqli));
        //mysqli_more_results($query	);
        $this->mysqli->commit();
        //return $arrayResult;
    }

    public function getAffectedRows() {
        return $this->affected_rows;
    }

    public function printf($arrObj) {
        echo "<pre>";
        print_r($arrObj);
        echo "</pre>";
    }


    public function selectQeury2($query) {
      $arrayResult = array();
        if ($result = $this->mysqli->query($query)) {
            /* printf("Select returned %d rows.\n", $result->num_rows); */
            while ($obj = $result->fetch_object()) {
                $arrayResult[] = $obj;
                //printf ("%s (%s)\n", $obj->AssignTime, $obj->AssignTime);
				$row= $obj->AssignTime;
				//echo $row;
				
            }

            /* free result set */
            $result->close();
            $this->mysqli->next_result();
        } else {
            throw new Exception("Error select query", 1);
        }
        $this->mysqli->commit();
        echo $row;
		if(is_null($row)){
			//echo "null 		";
			$row=0;
		}
		else{
			$row=1;
			//echo "Full 		";
		}
       return $row;
    }
	
	
	  public function insertQeury($query) {
        
 $res = $this->mysqli->query($query);
    
   if ($res) {
    $errTyp = "success";
    $errMSG = "Successfully registered, you may login now";
    unset($name);
    unset($email);
    unset($pass);
   } else {
    $errTyp = "danger";
    $errMSG = "Something went wrong, try again later..."; 
   } 
    }
	
}

?>