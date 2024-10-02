
filterProperty(data,yes) {
  List<Map<String, dynamic>> propertiesWithAvailableUnits = [];
  Set<String> propertyIds = {}; // To keep track of unique property IDs

  for (var property in data) {
    if (property['unitData'] != null) {
      List<dynamic> unitData = property['unitData'];
      bool hasAvailableUnit = false;

      for (var unit in unitData) {
        if (unit['isTaken']==yes) {
          hasAvailableUnit = true;
          break;
        }
      }

      if (hasAvailableUnit) {
        String propertyId = property['propertyID'];
        if (!propertyIds.contains(propertyId)) {
          propertiesWithAvailableUnits.add(property);
          propertyIds.add(propertyId);
        }
      }
    }
      }

  return propertiesWithAvailableUnits;
}

int propertyCount(data,yes) {
  int count = 0;

  for (var property in data) {
    if (property['unitData'] != null) {
      List<dynamic> unitData = property['unitData'];
      for (var unit in unitData) {
        if (unit['isTaken']==yes) {
          count++;
        }
      }
    }
  }

  return count;
}


List searchProperties(List properties, String searchTerm) {
  List matchedProperties = [];
  searchTerm = searchTerm
      .toLowerCase(); // Convert search term to lowercase for case-insensitive search

  for (var property in properties) {
    bool isMatch = false;

    // Check if the search term matches any of the property fields
    if (property['name'] != null &&
        property['name'].toString().toLowerCase().contains(searchTerm)) {
      isMatch = true;
    } else if (property['location'] != null &&
        property['location'].toString().toLowerCase().contains(searchTerm)) {
      isMatch = true;
    } else if (property['type'] != null &&
        property['type'].toString().toLowerCase().contains(searchTerm)) {
      isMatch = true;
    } else if (property['category'] != null &&
        property['category'].toString().toLowerCase().contains(searchTerm)) {
      isMatch = true;
    } else if (property['structure'] != null &&
        property['structure'].toString().toLowerCase().contains(searchTerm)) {
      isMatch = true;
    } else if (property['unitData'] != null) {
      List<dynamic> unitData = property['unitData'];
      for (var unit in unitData) {
        if (unit['unitID'] != null &&
            unit['unitID'].toString().toLowerCase().contains(searchTerm)) {
          isMatch = true;
          break;
        }
      }
    }

    if (isMatch) {
      matchedProperties.add(property);
    }
  }

  return matchedProperties;
}
