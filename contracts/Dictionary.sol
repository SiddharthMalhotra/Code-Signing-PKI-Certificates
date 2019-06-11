pragma solidity ^0.4.17;


library Dictionary {
    uint constant private NULL = 0;

   

    struct val {
        mapping(uint => Node) array;
        uint firstNodeId;
        uint lastNodeId;
        uint len;
    }


     struct Node {
        uint previous;
        uint next;
        bytes val;
        bool ini;
    }

    
    function insertAfter(val storage self, uint afterId, uint id, bytes val) internal {
        if (self.array[id].ini) {
            self.array[id].val = val;
            return;
        }
        self.array[id].previous = afterId;
        if (self.array[afterId].next == NULL) {
            self.array[id].next =  NULL;
            self.lastNodeId = id;
        } else {
            self.array[id].next = self.array[afterId].next;
            self.array[self.array[afterId].next].previous = id;
        }
        self.array[id].val = val;
        self.array[id].ini = true;
        self.array[afterId].next = id;
        self.len++;
    }

    function insertBefore(val storage self, uint beforeId, uint id, bytes val) internal {
        if (self.array[id].ini) {
            self.array[id].val = val;
            return;
        }
        self.array[id].next = beforeId;
        if (self.array[beforeId].previous == NULL) {
            self.array[id].previous = NULL;
            self.firstNodeId = id;
        } else {
            self.array[id].previous = self.array[beforeId].previous;
            self.array[self.array[beforeId].previous].next = id;
        }
        self.array[id].val = val;
        self.array[id].ini = true;
        self.array[beforeId].previous = id;
        self.len++;
    }

    function insertBeginning(val storage self, uint id, bytes val) internal {
        if (self.array[id].ini) {
            self.array[id].val = val;
            return;
        }
        if (self.firstNodeId == NULL) {
            self.firstNodeId = id;
            self.lastNodeId = id;
            self.array[id] = Node({ previous: 0, next: 0, val: val, ini: true });
            self.len++;
        } else
            insertBefore(self, self.firstNodeId, id, val);
    }

    function insertEnd(val storage self, uint id, bytes val) internal {
        if (self.lastNodeId == NULL) insertBeginning(self, id, val);
        else
            insertAfter(self, self.lastNodeId, id, val);
    }

    function set(val storage self, uint id, bytes val) internal {
        insertEnd(self, id, val);
    }

    function get(val storage self, uint id) internal view returns (bytes) {
        return self.array[id].val;
    }

    function getSize(val storage self) internal view returns (uint) {
        return self.len;
    }

    function next(val storage self, uint id) internal view returns (uint) {
        return self.array[id].next;
    }

    function previous(val storage self, uint id) internal view returns (uint) {
        return self.array[id].previous;
    }

    function keys(val storage self) internal constant returns (uint[]) {
        uint[] memory arr = new uint[](self.len);
        uint node = self.firstNodeId;
        for (uint i=0; i < self.len; i++) {
            arr[i] = node;
            node = next(self, node);
        }
        return arr;
    }
}
