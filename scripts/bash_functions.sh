# These are saved locally in ~/.bashrc

######################
# phx_chat functions #
######################

function cd_chat() {
  cd ~/repos/phx_chat
}

function dbash() {
    case $1 in
    chat)
        cd_chat && docker exec -it phx_chat_web_1 bash
        ;;
    pg)
        cd_chat && docker exec -it phx_chat_postgres_1 bash
        ;;
    *)
        echo "Cannot bash into $1. Enter a container abbreviation like chat or pg"
        ;;
    esac
}

function dlog {
    cd_chat
    case $1 in
    chat)
        echo "Logging $1"
        cd_chat && docker-compose logs -f --tail 100 web
        ;;
    pg)
        echo "Logging $1"
        cd_chat && docker-compose logs -f --tail 100 postgres
        ;;
    *)
        echo "Cannot log $1. Enter a container abbreviation like chat or pg"
        ;;
    esac
}
