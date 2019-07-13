//
//  QuoteTableViewController.swift
//  InspoQuotes
//
//  Created by Angela Yu on 18/08/2018.
//  Copyright © 2018 London App Brewery. All rights reserved.
//

import UIKit
import StoreKit
class QuoteTableViewController: UITableViewController, SKPaymentTransactionObserver {
   
    
    
    let productID = "com.dalatapp.test.preminum"
    
    var quotesToShow = [
        "Our greatest glory is not in never falling, but in rising every time we fall. — Confucius",
        "All our dreams can come true, if we have the courage to pursue them. – Walt Disney",
        "It does not matter how slowly you go as long as you do not stop. – Confucius",
        "Everything you’ve ever wanted is on the other side of fear. — George Addair",
        "Success is not final, failure is not fatal: it is the courage to continue that counts. – Winston Churchill",
        "Hardships often prepare ordinary people for an extraordinary destiny. – C.S. Lewis"
    ]
    
    let premiumQuotes = [
        "Believe in yourself. You are braver than you think, more talented than you know, and capable of more than you imagine. ― Roy T. Bennett",
        "I learned that courage was not the absence of fear, but the triumph over it. The brave man is not he who does not feel afraid, but he who conquers that fear. – Nelson Mandela",
        "There is only one thing that makes a dream impossible to achieve: the fear of failure. ― Paulo Coelho",
        "It’s not whether you get knocked down. It’s whether you get up. – Vince Lombardi",
        "Your true success in life begins only when you make the commitment to become excellent at what you do. — Brian Tracy",
        "Believe in yourself, take on your challenges, dig deep within yourself to conquer fears. Never let anyone bring you down. You got to keep going. – Chantal Sutherland",
        "Believe in yourself. You are braver than you think, more talented than you know, and capable of more than you imagine. ― Roy T. Bennett",
        "I learned that courage was not the absence of fear, but the triumph over it. The brave man is not he who does not feel afraid, but he who conquers that fear. – Nelson Mandela",
        "There is only one thing that makes a dream impossible to achieve: the fear of failure. ― Paulo Coelho",
        "It’s not whether you get knocked down. It’s whether you get up. – Vince Lombardi",
        "Your true success in life begins only when you make the commitment to become excellent at what you do. — Brian Tracy",
        "Believe in yourself, take on your challenges, dig deep within yourself to conquer fears. Never let anyone bring you down. You got to keep going. – Chantal Sutherland"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        SKPaymentQueue.default().add(self)
        if isPurchased()
        {
            showPremiumQuotes()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if isPurchased() {
         return quotesToShow.count
        }else
        {
        return quotesToShow.count + 1
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuoteCell", for: indexPath)
        if indexPath.row <  quotesToShow.count  {
            cell.textLabel?.text = quotesToShow[indexPath.row]
            cell.textLabel?.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            cell.accessoryType = .none
            // Configure the cell...
        }else
        {
            cell.textLabel?.text = "Get more quotes"
            cell.accessoryType =  .disclosureIndicator
            cell.textLabel?.textColor =  #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        }
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == quotesToShow.count
        {
            buyPremiumQuotes()
        }
    }
    
    //MARK: - Buy Premium Quotes
    func buyPremiumQuotes()
    {
        if SKPaymentQueue.canMakePayments()
        {
            let paymentRequest = SKMutablePayment()
            paymentRequest.productIdentifier = productID
            SKPaymentQueue.default().add(paymentRequest)
            
        } else
        {
            print("User can't make payment")
        }
        
    }
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
          
            if transaction.transactionState == .purchased
            {
                print("Transaction successful")
               
                showPremiumQuotes()
                SKPaymentQueue.default().finishTransaction(transaction)
            } else if transaction.transactionState  == .failed
            {
               
                if let error = transaction.error
                {
                     print("Transaction failed due to \(error.localizedDescription)")
                }
                
                 SKPaymentQueue.default().finishTransaction(transaction)
            } else if transaction.transactionState == .restored
            {
                print("restore purchased")
                showPremiumQuotes()
                 SKPaymentQueue.default().finishTransaction(transaction)
                navigationItem.setRightBarButton(nil, animated: true)
            }
        }
    }
    
    
    func showPremiumQuotes(){
         UserDefaults.standard.set(true,forKey: productID)
        quotesToShow.append(contentsOf: premiumQuotes)
        tableView.reloadData()
        
    }
    func isPurchased()->Bool
    {
        let purchaseStatus = UserDefaults.standard.bool(forKey: productID)
        if purchaseStatus {
            print("previous purchased")
            return true
        }else
        {
            print("Never purchased")
            return false
        }
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    
    
    @IBAction func restorePressed(_ sender: UIBarButtonItem) {
         SKPaymentQueue.default().restoreCompletedTransactions()
    }


}
