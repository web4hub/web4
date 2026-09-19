class Node:
    """Binary search tree node."""
    def __init__(self, v, l=None, r=None):
        self.v = v   # node value
        self.l = l   # left child
        self.r = r   # right child

def kth_smallest_in_bst(root, k):
    """
    Returns the k-th smallest value (1-indexed) in the BST rooted at `root`.
    Uses iterative in-order traversal, achieving O(h) space (O(h) for the stack)
    and O(h + k) time.
    """
    stack = []
    current = root
    count = 0

    while True:
        # Go as far left as possible
        while current is not None:
            stack.append(current)
            current = current.l

        # If the stack is empty, the traversal is finished
        if not stack:
            break

        # Process the node (in-order visit)
        node = stack.pop()
        count += 1
        if count == k:
            return node.v

        # Move to the right subtree
        current = node.r

    # k exceeds the number of nodes (invalid input)
    return None
