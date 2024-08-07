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

    pub fn search(&self, k: T) -> Option<&Node<T>> {
        fn search_link<'a, T: Display + PartialOrd>(link: Link<T>, k: T) -> Option<&'a Node<T>> {
            if let Some(node) = link {
                unsafe {
                    if k == (*node.as_ptr()).key {
                        return Some(node.as_ref());
                    } else if k < (*node.as_ptr()).key {
                        return search_link((*node.as_ptr()).left, k);
                    } else {
                        return search_link((*node.as_ptr()).right, k);
                    }
                }
            } else {
                return None;
            }
        }

        search_link(self.root, k)
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
        unsafe {
            let mut cursor = self.root;
            let mut parent = None;

            while let Some(node) = cursor {
                parent = cursor;
                cursor = (*node.as_ptr()).left;
            }

            return parent.map(|node| node.as_ref());
        }
    }

    pub fn maximum(&self) -> Option<&Node<T>>  {
        unsafe {
            let mut cursor = self.root;
            let mut parent = None;

            while let Some(node) = cursor {
                parent = cursor;
                cursor = (*node.as_ptr()).right;
            }

            return parent.map(|node| node.as_ref());
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
}