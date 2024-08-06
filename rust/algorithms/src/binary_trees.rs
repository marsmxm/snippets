use std::fmt::Display;
use ascii_tree::{Tree, write_tree};
use std::ptr::NonNull;

pub struct BinaryTree<T> {
    root: Link<T>,
}

type Link<T> = Option<NonNull<Node<T>>>;

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
                root: Some(
                    NonNull::new_unchecked(Box::into_raw(Box::new(root)))
                )
            }
        }
    }

    pub fn print(&self) {
        let none_node = Tree::Leaf(vec![String::from("none")]);
        let ascii_tree = self.root.as_ref().map_or(none_node, |node| node.to_ascii_tree());
        let mut output = String::new();
        write_tree(&mut output, &ascii_tree);
        println!("{}", output);
    }

    pub fn insert(&mut self, k: T) {
        let mut new_node = Box::new(Node::new(k));

        let mut cursor: Option<&mut Box<Node<T>>> = self.root.as_mut();
        let mut parent: Option<&mut Box<Node<T>>> = None;

        while let Some(cursor_node) = cursor {
            parent = cursor;

            if new_node.key < cursor_node.key {
                cursor = cursor_node.left.as_mut();
            } else {
                cursor = cursor_node.right.as_mut();
            }
        }

        if let Some(parent_node) = parent {
            new_node.parent = Some(&*parent_node);
            if new_node.key < parent_node.key {
                parent_node.left = Some(new_node);
            } else {
                parent_node.right = Some(new_node);
            }
        } else {
            self.root  = Some(new_node);
        }
    
    }

    pub fn walk(&self) {
        fn link_walk<T: Display + PartialOrd>(link: &Link<T>) {
            if let Some(node) = link.as_ref() {
                link_walk(&node.left);
                println!("{}", node.key);
                link_walk(&node.right);
            }
        }

        link_walk(&self.root);
    }

    // pub fn search(&self, k: T) -> Option<Ref<Node<T>>> {
    //     fn search_link<T: Display + PartialOrd>(link: Option<Ref<Node<T>>>, k: T) -> Option<Ref<Node<T>>> {
    //         if let Some(node) = link.as_ref() {
    //             if k == node.borrow().key {
    //                 return Some(node.borrow());
    //             } else if k < node.borrow().key {
    //                 return search_link(node.borrow().map(|link| link.left, k);
    //             } else {
    //                 return search_link(node.borrow().right, k);
    //             }
    //         } else {
    //             return None;
    //         }
    //     }

    //     search_link(self.root.map(|link| link.borrow(), k)
    // }

    // pub fn search_iter(&self, k: T) -> Option<Ref<Node<T>>> {
    //     let mut cursor = &self.root;
    //     while let Some(node) = cursor.as_ref() {
    //         if k == node.borrow().key {
    //             return Some(node.borrow());
    //         } else if k < node.borrow().key {
    //             cursor = &node.borrow().left;
    //         } else {
    //             cursor = &node.borrow().right;
    //         }
    //     }

    //     return None;
    // }

    // pub fn minimum(&self) -> Option<Ref<Node<T>>> {
    //     let mut cursor = &self.root;

    //     while let Some(node) = cursor.as_ref() {
    //         cursor = &node.borrow().left;
    //     }

    //     cursor.as_ref().map(|node| node.borrow())
    // }

    // pub fn maximum(&self) -> Option<Ref<Node<T>>>  {
    //     let mut cursor = &self.root;

    //     while let Some(node) = cursor.as_ref() {
    //         cursor = &node.borrow().right;
    //     }

    //     cursor.as_ref().map(|node| node.borrow())
    // }
}
