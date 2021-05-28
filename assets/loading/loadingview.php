<!DOCTYPE html>
<html lang="en">
<meta charset="UTF-8">
<title>Loading...</title>
<meta name="viewport" content="width=device-width,initial-scale=1">
<link rel="stylesheet" href="style.css">
<body>

    <?php
        $steamid = $_GET['steamid'];
        $map = $_GET['map'];
        $apiKey = '4C233D4A195FAB43BD3EA09AA8633A92';
        $json = file_get_contents('http://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key='.$apiKey.'&steamids='.$steamid);
        $parsed = json_decode($json);
        
        foreach($parsed->response->players as $player){

        }

        $sName = $player->personaname;
        $sAvatar = $player->avatarfull
    ?>

    <script>

        function SetFilesTotal( total ) {
            var totalFiles = total;
        }

        function SetFilesNeeded( needed ) {
            var tooltip = document.getElementById('progressInfo');
            var tooltipText = 'Downloading files... ' . needed . '/' . totalFiles;
            document.getElementById(tooltip).innerHTML = tooltipText;
        }


    </script>

    <div class="pdaContainer">
        <div class="container">
            <h1 class="name"><?php echo $sName; ?></h1>
            <h1 style="filter: blur(20px);"class="name"><?php echo $sName; ?></h1>
            <img class="pdaAvatarG" src = "<?php echo $player->avatarfull ?>">
            <img class="pdaAvatarB" src = "<?php echo $player->avatarfull ?>">
            <img class="pdaAvatarR" src = "<?php echo $player->avatarfull ?>">
            <img class="pdaAvatarP" src = "<?php echo $player->avatarfull ?>">
            <p id="progressInfo">Gathering information...</p>
            <div id="progressbar">
                <div></div>
            </div>
        </div>
    </div>

</body>
</html>