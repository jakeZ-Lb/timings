<?php
use Starlis\Timings\Json\TimingsMaster;
use Starlis\Timings\Template;
use Starlis\Timings\util;

$timingsData = TimingsMaster::getInstance();
$tpl = Template::getInstance();
$system = $timingsData->system;
?>
<div id="header-right" class=" ui-widget ui-widget-content ui-corner-all">
	<?php if ($timingsData->icon): ?>
		<img class="server-icon" style="float:left" src="image.php?id=<?=util::esc($timingsData->icon)?>" width="64" height="64" />
	<?php endif; ?>

	<span class="server-name">Server: <b class="<?=($timingsData->onlinemode === true ? "online-server" : "offline-server")?>"
			><?=util::esc($timingsData->server)?></b> (max: <?=util::esc($timingsData->maxplayers)?>)</span><br />
	<span>MOTD: <b><?=util::mccolor(util::esc($timingsData->motd))?></b></span><br />
	<span>Version: <b><?=util::esc($timingsData->version)?></b></span><br />
	<span title="OS: <?=util::esc("{$system->name} {$system->version} {$system->arch} CPU: {$system->cpu}")?>">
		Uptime: <b><?=util::esc(round($system->runtime / 60 / 60, 2))?>hr</b> -
		Memory: <b><?=util::esc($system->maxmem / 1024 / 1024)?>MB</b>
	</span>
</div>
