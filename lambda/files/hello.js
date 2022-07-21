"use strict"
const AWS = require("aws-sdk");
AWS.config.update({ region: "us-east-1" });
const documentClient = new AWS.DynamoDB.DocumentClient({ region: "us-east-1" });

async function getItem(params){
  try {
    const data = await documentClient.get(params).promise()
    return data
  } catch (err) {
    return err
  }
}

async function createItem(params){
  try {
    await documentClient.put(params).promise();
  } catch (err) {
    return err;
  }
}

exports.handler = async (event) => {
    if (event.httpMethod == "OPTIONS"){
      return {
        statusCode: 200,
        headers: {
          "Access-Control-Allow-Headers" : "*",
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Methods": "*"
        },
        body: JSON.stringify('Allowed Options'),
      }
    }
    if (event.path.includes("/users") && event.httpMethod == "POST"){
      console.log(event.body);
      let body = JSON.parse(event.body);
    
      const params = {
        TableName: "user_data",
        Item: {
          userID: body.userID,
          name: body.name,
          email: body.email,
          career: body.career,
          description: body.description,
          skills: body.skills,
          passions: body.passions
        }
      };
    
      try {
        await createItem(params)
        return { headers: {"Access-Control-Allow-Origin" : "*"}, body: 'Successfully created item' }
      } catch (err) {
        return { error: err }
      }
    }
    
    else if(event.path.includes("users") && event.httpMethod == "GET"){
      const params = {
        TableName: "user_data",
        Key: {
          userID: Number(event.path.split("/")[2])
        }
      };
    
     try {
        const data = await getItem(params)
        return { headers: {"Access-Control-Allow-Origin" : "*"}, body: JSON.stringify(data) }
      } catch (err) {
        return { error: err }
      }
    } 
    
  }