$app_version = "1.2.2"
$min_version = "1.2.10"
if versioncmp($app_version,$min_version)>=0 {
        notify {"OK":}
}else{
        notify {"need update":}
}
