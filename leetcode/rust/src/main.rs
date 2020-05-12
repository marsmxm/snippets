// Definition for singly-linked list.
#[derive(PartialEq, Eq, Clone, Debug)]
pub struct ListNode {
  pub val: i32,
  pub next: Option<Box<ListNode>>
}

impl ListNode {
  #[inline]
  fn new(val: i32) -> Self {
    ListNode {
      next: None,
      val
    }
  }
}

fn add_two_numbers(l1: Option<Box<ListNode>>, l2: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
    add_two_numbers_with_carry(l1, l2, 0)
}

fn add_two_numbers_with_carry(l1: Option<Box<ListNode>>, l2: Option<Box<ListNode>>, carry: i32) -> Option<Box<ListNode>> {
    if l1.is_none() {
        add_number_carry(l2, carry)
    } else {
        if l2.is_none() {
            add_number_carry(l1, carry)
        } else {
            let b1 = l1.unwrap();
            let b2 = l2.unwrap();
            let sum = (*b1).val + (*b2).val;
            let node = if sum >= 10 {
                let new_val = sum - 10;
                ListNode {
                    val: new_val,
                    next: add_two_numbers_with_carry((*b1).next, (*b2).next, 1)
                }
            } else {
                ListNode {
                    val: sum,
                    next: add_two_numbers_with_carry((*b1).next, (*b2).next, 0)
                }
            };
            Some(Box::new(node))
        }
    }
}

fn add_number_carry(node_option: Option<Box<ListNode>>, carry: i32) -> Option<Box<ListNode>> {
    if let Some(b1) = node_option {
        let sum = (*b1).val + carry;
        let node = if sum == 10 {
            ListNode {
                val: 0,
                next: add_number_carry((*b1).next, 1)
            }
        } else {
            ListNode {
                val: sum,
                next: (*b1).next
            }
        };
        Some(Box::new(node))
    } else {
        if carry > 0 {
            return Some(Box::new(ListNode::new(carry)))
        } else {
            None
        }
    }
}

fn main() {
    println!("Hello, world!");
}
