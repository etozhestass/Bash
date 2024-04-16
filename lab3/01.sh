function get_time() {
 date +%d.%m.%Y_%H:%M:%S
}

mkdir ~/test && {
echo "catalog test was created successfully" >> ~/report
touch ~/test/$(get_time)
}
ping -c 1 www.net_nikogo.ru || echo "$(get_time) host is unavailable" >> ~/report
