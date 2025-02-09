# graphyx

Graphyx is a set of Neo4j connectors for Alteryx:

* Neo4j Input: Import cypher queries into Alteryx workflows
* Neo4j Output: Export Alteryx data as Neo4j nodes and relationships
* Neo4j Delete: Use Alteryx data to define how Neo4j nodes and relationships should be deleted

The engine for the connectors was built using the [Alteryx Go SDK](https://github.com/tlarsendataguy/goalteryx) and the [official Go driver for Neo4j](https://github.com/neo4j/neo4j-go-driver).

The user interfaces were built using [Flutter](https://github.com/flutter/flutter).

## Table of contents

1. [Installation](#Installation)
2. [Feedback](#Feedback)
3. [Neo4j Input](#Neo4j-Input)
4. [Neo4j Output](#Neo4j-Output)
5. [Neo4j Delete](#Neo4j-Delete)

## Installation

Download the installer from [tools.tlarsendataguy.com](https://tools.tlarsendataguy.com/l/tqebq). After running the installer, the new tools will be available in the Connectors tab in Designer.

Installation files are also available at [tools.tlarsendataguy.com](https://tools.tlarsendataguy.com/l/tqebq) if you are unable to use the installer, or run into issues with the installer.

[Back to top](#graphyx)

## Feedback

Submit any bugs or feature requests using [GitHub Issues](https://github.com/tlarsendataguy/graphyx/issues).

[Back to top](#graphyx)

## Neo4j Input

<img src="https://github.com/tlarsendataguy/graphyx/blob/main/go/input/Neo4jInput/icon.png" width="100" />

The Neo4j Input tool is used to import Cypher queries into Alteryx workflows. Cypher is the query language of Neo4j databases.

### Overview

The configuration screen of the input tool looks like this:

<img src="https://github.com/tlarsendataguy/graphyx/blob/main/readme_images/input_01.png" />

The top panel contains information needed to connect to the Neo4j database. It can be minimized by clicking the top of the panel.
* url: The Neo4j or Bolt endpoint for the Neo4j database.
* username: The username to run the query as.
* password: The password to authenticate the user with.
* database: If blank, the default database will be used. Database can be ignored for Community editions of Neo4j. Users connected to the Enterprise edition of Neo4j can use this database field to select which database to import from.

The bottom panel contains the query and defines how Alteryx should extract data from the returned objects. Because Neo4j is schema-less and Alteryx manipulates tabular data, this translation must be provided by the user. Each field needs to be explicitly defined from the returned objects of the query. The connector is smart enough to know what type of objects are returned from the query and will guide you toward extracting the data you want.

The username and password are required to validate the query in the configuration panel. However, they are optional for the engine. The engine will look for a generic Windows credential matching the provided url. If one is found, the engine ignores the username and password and uses the Windows credential to authenticate.

### Using the input tool for the first time

Drag the input tool onto the canvas.

In the configuration screen, enter the bolt endpoint url, username, password, and (optionally) database.

Enter a valid Cypher query into the query textfield. Cypher queries can be multi-line and the text field will expand up to 10 lines. After 10 lines, the text field will start scrolling.

Validate the query by clicking the 'Validate Query' button. This will test your connection to Neo4j and tell you whether the query is valid. It also saves the return value types so you can build out the field mapping.

Add a new field to the output by clicking the 'Add Field' button. A new, empty field will be appended to the field list. Provide a name for the field in the textbox. This is the Alteryx field name. Then, use the drop-down to define which data gets populated into the output field. You must keep selecting options from the drop-down until a basic data type is found (strings, numbers, dates, bools).

Field mappings can be deleted by clicking the 'X' icon in the pill. Deleting a pill in the middle will delete all downstream pills as well.

Fields can be deleted by clicking the trash can icon to the left of the field.

Fields can be re-arranged by clicking the drag handle on the right of the field and dragging up and down.

Sometimes, you don't want to spend a lot of time extracting information out of nodes, paths, and relationships. These return objects can be converted into a string representation by selecting 'To String' from the field mapping drop-down.

[Back to top](#graphyx)

## Neo4j Output

<img src="https://github.com/tlarsendataguy/graphyx/blob/main/go/output/Neo4jOutput/icon.png" width="100" />

The Neo4j Output tool is used to export nodes and relationships to a Neo4j database.

### Overview

There are two different screens for the output tool, depending on how it is configured. The default screen is for exporting nodes and looks like this:

<img src="https://github.com/tlarsendataguy/graphyx/blob/main/readme_images/output_01.png" />

The top panel contains information needed to connect to the Neo4j database. It can be minimized by clicking the top of the panel.
* url: The HTTP endpoint for the Neo4j database. By default, this will be port 7474. Do not use any endpoint other than the HTTP endpoint. The engine uses the bolt endpoint, but it obtains the exact address by first calling into the HTTP endpoint.
* username: The username to run the query as.
* password: The password to authenticate the user with.
* database: If blank, the default database will be used. Database can be ignored for Community editions of Neo4j. Users connected to the Enterprise edition of Neo4j can use this database field to select which database to import from.

Username and password are optional for the engine. The engine will look for a generic Windows credential matching the provided url. If one is found, the engine ignores the username and password and uses the Windows credential to authenticate.

The middle panel defines the batch size and the type of object to export (nodes or relationships).

The bottom panel is used to define how nodes are exported to Neo4j. By default, the export tool is an upsert tool. Nodes that already exist in the database are updated and nodes that do not exist are created. The 'node ID fields' section contains the properties the output tool will use to identify whether a node already exists in the database. If no ID fields are provided, the tool will only create new nodes.

The 'update the following properties' section determines which properties of nodes are created/updated.

The screen for exporting relationships looks like this:

<img src="https://github.com/tlarsendataguy/graphyx/blob/main/readme_images/output_02.png" />

The top two panels are the same as the export node screen. The third panel defines the relationship type and any properties that should be created/updated on the relationship.

The fourth panel tells the output tool how to match the left node in the relationship. The bottom panel tells the output tool how to match the right node in the relationship.

Just as with the export node screen, exporting relationships is an upsert operation by default.

[Back to top](#graphyx)

## Neo4j Delete

<img src="https://github.com/tlarsendataguy/graphyx/blob/main/go/delete/Neo4jDelete/icon.png" width="100" />

The Neo4j Delete tool is used to delete nodes and relationships from a Neo4j database.

### Overview

There are two different screens for the delete tool, depending on how it is configured. The default screen is for deleting nodes and looks like this:

<img src="https://github.com/tlarsendataguy/graphyx/blob/main/readme_images/delete_01.png" />

The top panel contains information needed to connect to the Neo4j database. It can be minimized by clicking the top of the panel.
* url: The HTTP endpoint for the Neo4j database. By default, this will be port 7474. Do not use any endpoint other than the HTTP endpoint. The engine uses the bolt endpoint, but it obtains the exact address by first calling into the HTTP endpoint.
* username: The username to run the query as.
* password: The password to authenticate the user with.
* database: If blank, the default database will be used. Database can be ignored for Community editions of Neo4j. Users connected to the Enterprise edition of Neo4j can use this database field to select which database to import from.

Username and password are optional for the engine. The engine will look for a generic Windows credential matching the provided url. If one is found, the engine ignores the username and password and uses the Windows credential to authenticate.

The middle panel defines the batch size and the type of object to delete (nodes or relationships).

The bottom panel is used to define how nodes are deleted from Neo4j. Neither the label nor the ID fields are required. Providing a label and no ID fields will delete all nodes with that label. Providing ID fields but no label will delete any type of node with matching properties. Providing neither will delete all nodes from the database. When the tool deletes nodes, it will also delete any relationships attached to those nodes.

The screen for deleting relationships looks like this:

<img src="https://github.com/tlarsendataguy/graphyx/blob/main/readme_images/delete_02.png" />

The top two panels are the same as the delete node screen. The third panel defines the relationship type and any properties that should be matched when deleting relationships.

The fourth panel tells the output tool how to match the left node in the relationship. The bottom panel tells the output tool how to match the right node in the relationship.

As with the delete node screen, the labels, types, and properties are all optional. This provides a lot of flexibility to precisely define how relationships should be deleted, but also makes it easier to mistaklenly delete relationships. Use with caution.

[Back to top](#graphyx)
