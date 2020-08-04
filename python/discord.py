"""
https://pypi.org/project/discord-webhook/

Send notify to discord hook
Requirements:

discord-webhook==0.8.0

"""

from discord_webhook import DiscordWebhook, DiscordEmbed

class Discord:
    COLOR_RED = 15553848
    COLOR_BLUE = 2122651
    COLOR_GREEN = 3976867
    COLOR_YELLOW = 16776961

    def __init__(self, webhook):
        self.WEBHOOK = webhook

    def send_message(self, content):
        webhook = DiscordWebhook(url=self.WEBHOOK, content=content)
        return webhook.execute()


    def send_embed(self, color, title, **kwargs):
        webhook = DiscordWebhook(url=self.WEBHOOK)
        embed = DiscordEmbed(title=title, color=color)
        embed.set_timestamp()
        for key in kwargs:
            embed.add_embed_field(name=key.upper(), value=str(kwargs[key]))
        webhook.add_embed(embed)
        return webhook.execute()