import json
from lib.log import logger

def handler(event, context):
    logger.info("hello world!")
    return {'statusCode': 200, 'body': json.dumps("OK")}


if __name__ == "__main__":
    handler(event={}, context={})
