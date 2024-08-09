use std::fmt::Display;
use ascii_tree::{Tree, write_tree};
use std::ptr::NonNull;

pub struct BinaryTree<T> {
    root: Link<T>,
}

type Link<T> = Option<NonNull<Node<T>>>;

#[derive(Debug)]
pub struct Node<T> {
    key: T,
    parent: Link<T>,
    left: Link<T>,
    right: Link<T>,
}

impl<T: Display> Node<T> {
    fn new(key: T) -> Self {
        Node {
            key,
            parent: None,
            left: None,
            right: None,
        }
    }

    unsafe fn new_ptr(node: Node<T>) -> NonNull<Node<T>> {
        NonNull::new_unchecked(
                Box::into_raw(Box::new(node)))
    }

    fn to_ascii_tree(&self) -> Tree {
        let mut children = Vec::new();

        unsafe {
            let left_tree = self.left.as_ref().map(|node| (*node.as_ptr()).to_ascii_tree());
            let right_tree = self.right.as_ref().map(|node| (*node.as_ptr()).to_ascii_tree());
            
            if left_tree.is_some() {
                children.push(left_tree.unwrap());
            }
            if right_tree.is_some() {
                children.push(right_tree.unwrap());
            }
        }
        
        Tree::Node(self.key.to_string(), children)
    }
}

impl<T: Display + PartialOrd> BinaryTree<T> {
    pub fn empty() -> Self {
        BinaryTree {
            root: None,
        }
    }

    pub fn new(root: Node<T>) -> Self {
        unsafe {
            BinaryTree {
                root: Some(Node::new_ptr(root))
            }
        }
    }

    pub fn print(&self) {
        let none_node = Tree::Leaf(vec![String::from("none")]);
        unsafe {
            let ascii_tree = self.root.as_ref().map_or(none_node, |node| (*node.as_ptr()).to_ascii_tree());
            let mut output = String::new();
            write_tree(&mut output, &ascii_tree);
            println!("{}", output);
        }
        
    }

    pub fn insert(&mut self, k: T) {
        unsafe {
            let mut new_node = Node::new(k);

            let mut cursor = self.root;
            let mut parent = None;

            while let Some(cursor_ptr) = cursor {
                parent = cursor;

                if new_node.key < (*cursor_ptr.as_ptr()).key {
                    cursor = (*cursor_ptr.as_ptr()).left;
                } else {
                    cursor = (*cursor_ptr.as_ptr()).right;
                }
            }

            if let Some(parent_ptr) = parent {
                new_node.parent = parent;

                if new_node.key < (*parent_ptr.as_ptr()).key {
                    (*parent_ptr.as_ptr()).left = Some(Node::new_ptr(new_node));
                } else {
                    (*parent_ptr.as_ptr()).right = Some(Node::new_ptr(new_node));
                }
            } else {
                self.root  = Some(Node::new_ptr(new_node));
            }
        }
    }

    pub fn walk(&self) {
        fn link_walk<T: Display + PartialOrd>(link: Link<T>) {
            if let Some(node) = link {
                unsafe {
                    link_walk((*node.as_ptr()).left);
                    println!("{}", (*node.as_ptr()).key);
                    link_walk((*node.as_ptr()).right);
                }
                
            }
        }

        link_walk(self.root);
    }

    // pub fn delete(&mut self, key: T) -> u32 {
    //
    // }
    //
    // fn delete_link(&mut self, link: Link<T>) {
    //
    // }

    fn transplant(&mut self, old: NonNull<Node<T>>, new: Link<T>) -> Box<Node<T>> {
        unsafe {
            let boxed_old = Box::from_raw(old.as_ptr());

            if let Some(old_parent) = boxed_old.parent {
                if (*old_parent.as_ptr()).left == Some(old) {
                    (*old_parent.as_ptr()).left = new;
                } else {
                    (*old_parent.as_ptr()).right = new;
                }
            } else {
                self.root = new;
            }

            if let Some(new_node) = new {
                (*new_node.as_ptr()).parent = boxed_old.parent;
            }

            boxed_old
        }
    }

    pub fn search(&self, k: T) -> Option<&Node<T>> {
        unsafe {
            self.search_link(self.root, k).map(|node| node.as_ref())
        }
    }

    fn search_link(&self, link: Link<T>, k: T) -> Link<T> {
        if let Some(node) = link {
            unsafe {
                return if k == (*node.as_ptr()).key {
                    link
                } else if k < (*node.as_ptr()).key {
                    self.search_link((*node.as_ptr()).left, k)
                } else {
                    self.search_link((*node.as_ptr()).right, k)
                }
            }
        } else {
            return None;
        }
    }

    pub fn search_iter(&self, k: T) -> Option<&Node<T>> {
        let mut cursor = self.root;
        while let Some(node) = cursor {
            unsafe {
                if k == (*node.as_ptr()).key {
                    return Some(node.as_ref());
                } else if k < (*node.as_ptr()).key {
                    cursor = (*node.as_ptr()).left;
                } else {
                    cursor = (*node.as_ptr()).right;
                }
            }
        }

        return None;
    }

    pub fn minimum(&self) -> Option<&Node<T>> {
        return self.minimum_from(self.root);
    }

    fn minimum_from(&self, link: Link<T>) -> Option<&Node<T>> {
        unsafe {
            let mut cursor = link;
            let mut parent = None;

            while let Some(node) = cursor {
                parent = cursor;
                cursor = (*node.as_ptr()).left;
            }

            return parent.map(|node| node.as_ref());
        }
    }

    pub fn maximum(&self) -> Option<&Node<T>> {
        return self.maximum_from(self.root);
    }

    pub fn maximum_from(&self, link: Link<T>) -> Option<&Node<T>>  {
        unsafe {
            let mut cursor = link;
            let mut parent = None;

            while let Some(node) = cursor {
                parent = cursor;
                cursor = (*node.as_ptr()).right;
            }

            return parent.map(|node| node.as_ref());
        }
    }

    pub fn successor(&self, key: T) -> Option<&Node<T>> {
        unsafe {
            if let Some(node) = self.search_link(self.root, key) {
                if (*node.as_ptr()).right.is_some() {
                    return self.minimum_from((*node.as_ptr()).right);
                } else {
                    let mut current = node;
                    let mut parent = (*node.as_ptr()).parent;

                    while let Some(parent_node) = parent {
                        if let Some(left_of_parent) = (*parent_node.as_ptr()).left {
                            if left_of_parent == current {
                                return Some(parent_node.as_ref());
                            }
                        }
                        current = parent_node;
                        parent = (*parent_node.as_ptr()).parent;
                    }

                    return None;
                }
            } else {
                return None;
            }
        }
    }

    pub fn predecessor(&self, key: T) -> Option<&Node<T>> {
        unsafe {
            if let Some(node) = self.search_link(self.root, key) {
                if (*node.as_ptr()).left.is_some() {
                    return self.maximum_from((*node.as_ptr()).left);
                } else {
                    let mut current = node;
                    let mut parent = (*node.as_ptr()).parent;

                    while let Some(parent_node) = parent {
                        if let Some(right_of_parent) = (*parent_node.as_ptr()).right {
                            if right_of_parent == current {
                                return Some(parent_node.as_ref());
                            }
                        }
                        current = parent_node;
                        parent = (*parent_node.as_ptr()).parent;
                    }

                    return None;
                }
            } else {
                return None;
            }
        }
    }
}

#[cfg(test)]
mod test {
    use super::BinaryTree;

    #[test]
    fn test_print_tree() {
        let mut tree = BinaryTree::empty();

        tree.insert(2);
        tree.insert(6);
        tree.insert(6);
        tree.insert(4);
        tree.insert(1);

        tree.print();
    }

    #[test]
    fn test_search() {
        let mut tree = BinaryTree::empty();

        tree.insert(2);
        tree.insert(6);
        tree.insert(4);
        tree.insert(1);

        assert_eq!(6, tree.search(6).unwrap().key);
        assert!(tree.search(16).is_none());
    }

    #[test]
    fn test_search_iter() {
        let mut tree = BinaryTree::empty();

        tree.insert(2);
        tree.insert(6);
        tree.insert(4);
        tree.insert(1);

        assert_eq!(6, tree.search_iter(6).unwrap().key);
        assert!(tree.search_iter(16).is_none());
    }

    #[test]
    fn test_minimum() {
        let mut tree = BinaryTree::empty();

        tree.insert(2);
        tree.insert(6);
        tree.insert(4);
        tree.insert(1);

        let op = tree.minimum();
        assert_eq!(1, op.unwrap().key);
    }

    #[test]
    fn test_maximum() {
        let mut tree = BinaryTree::empty();

        tree.insert(2);
        tree.insert(6);
        tree.insert(4);
        tree.insert(1);

        let op = tree.maximum();
        assert_eq!(6, op.unwrap().key);
    }

    #[test]
    fn test_successor() {
        let mut tree = BinaryTree::empty();

        tree.insert(5);
        tree.insert(2);
        tree.insert(2);
        tree.insert(6);
        tree.insert(3);
        tree.insert(4);
        tree.insert(1);
        tree.insert(7);

        tree.print();

        assert_eq!(2, tree.successor(1).unwrap().key);
        assert_eq!(2, tree.successor(2).unwrap().key);
        assert_eq!(7, tree.successor(6).unwrap().key);
        assert!(tree.successor(7).is_none());
    }

    #[test]
    fn test_predecessor() {
        let mut tree = BinaryTree::empty();

        tree.insert(5);
        tree.insert(2);
        tree.insert(2);
        tree.insert(6);
        tree.insert(3);
        tree.insert(4);
        tree.insert(1);
        tree.insert(7);

        tree.print();

        assert_eq!(6, tree.predecessor(7).unwrap().key);
        assert_eq!(1, tree.predecessor(2).unwrap().key);
        assert_eq!(5, tree.predecessor(6).unwrap().key);
        assert!(tree.predecessor(1).is_none());
    }
}